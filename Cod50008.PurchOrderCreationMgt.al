codeunit 50008 "Purch. Order Creation Mgt."
{
    // ISS2.00 03.03.14 DFP - Added code to carry through "Third Party Shipping Acc. No."
    // 
    // IMPRINT1.01,SP4080,3/20/15,Ak: Added code to copy Comment Lines from  the Sales order
    // IM1.02,15-Oct-15,ST: Added code to CreatePurchLine().
    // IMP1.03,SP591,06/21/17,ST: Added code to CreatePurchOrders to check fo credit limit validations.
    trigger OnRun()
    begin
    end;

    var
        Text001: Label 'No unprocessed Drop Ship Sales Order Lines found.';
        Text002: Label 'The process has been cancelled.';
        Text003: Label 'The process has been completed.\\%1 Purchase Order created.';
        Text004: Label 'The process has been completed.\\Purchase Order %1 created.';
        Text005: Label 'Are you sure you wish to create Purchase Orders for Sales Order %1?';
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        VendorTemp: Record Vendor temporary;
        Item: Record Item;
        NextLineNo: Integer;
        POCount: Integer;
        OverridePONo: Boolean;
        PONo: Code[20];
        Text006: Label 'Purchase Order No. cannot be manually specified when creating multiple Purchase Orders.';
        Text007: Label 'The process has been cancelled.';
        commentlinesoline: Record "Sales Line";
        storePOItemLineno: Integer;

    procedure CreatePurchOrders(SalesOrderNo: Code[20]; OverridePONoIn: Boolean; QuietMode: Boolean)
    var
        EnterPONo: Page "Enter Purchase Order No.";
        LinesFound: Boolean;
    begin
        /*//IMP1.01 Start
        IF SalesHeader.GET(SalesHeader."Document Type"::Order,SalesOrderNo) THEN
          SalesHeader.CheckForCrLimitWarning;
        //IMP1.01 End
        */
        //IMPUPG
        if not QuietMode then // Are you sure you wish to create Purchase Orders for Sales Order %1?
            if not Confirm(Text005, false, SalesOrderNo) then // The process has been cancelled.
                Error(Text002);
        OverridePONo := OverridePONoIn;
        if OverridePONo then begin
            // User will supply PO No
            Clear(EnterPONo);
            EnterPONo.LookupMode(true);
            if EnterPONo.RunModal <> ACTION::LookupOK then // The process has been cancelled.
                Error(Text007);
            PONo := EnterPONo.GetPONo;
            if PONo = '' then // The process has been cancelled.
                Error(Text007);
        end;
        Clear(LinesFound);
        SalesHeader.Get(SalesHeader."Document Type"::Order, SalesOrderNo);
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", SalesOrderNo);
        SalesLine.SetFilter(Type, 'Item|Resource');
        SalesLine.SetFilter("No.", '<>%1', '');
        //SETRANGE("Drop Shipment",TRUE);
        SalesLine.SetFilter("Purchase Order No.", '%1', '');
        SalesLine.SetRange("Quantity Shipped", 0);
        if not SalesLine.FindSet(false) then // No unprocessed Drop Ship Sales Order Lines found.
            Error(Text001);
        // Check for missing Vendors and build List
        repeat
            if SalesLine."Drop Shipment" or SalesLine."Direct Purchase" then begin
                SalesLine.TestField("Vendor No.");
                if not VendorTemp.Get(SalesLine."Vendor No.") then begin
                    VendorTemp.Init;
                    VendorTemp."No." := SalesLine."Vendor No.";
                    VendorTemp.Insert;
                end;
                LinesFound := true;
            end;
        until SalesLine.Next = 0;
        // Make sure lines were found
        if not LinesFound then // No unprocessed Drop Ship Sales Order Lines found.
            Error(Text001);
        // Loop through Vendors and create Purchase Orders
        VendorTemp.Reset;
        VendorTemp.FindSet(true);
        repeat
            if (POCount >= 1) and OverridePONo then // Purchase Order No. cannot be manually specified when creating multiple Purchase Orders.
                Error(Text006);
            CreatePurchHeader;
            SalesLine.SetRange("Vendor No.", VendorTemp."No.");
            SalesLine.FindSet(false);
            repeat
                if SalesLine."Drop Shipment" or SalesLine."Direct Purchase" then begin
                    CreatePurchLine;
                    SalesLine."Purchase Order No." := PurchLine."Document No.";
                    SalesLine."Purch. Order Line No." := storePOItemLineno; //PurchLine."Line No.";
                    SalesLine.Modify;
                end;
            until SalesLine.Next = 0;
        until VendorTemp.Next = 0;
        if POCount = 1 then // The process has been completed.\\Purchase Order %1 created.
            Message(Text004, PurchHeader."No.")
        else
            // The process has been completed.\\%1 Purchase Order(s) created.
            Message(Text003, POCount);
    end;

    procedure CreatePurchHeader()
    begin
        PurchHeader.Init;
        PurchHeader.SetHideValidationDialog(true);
        PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
        PurchHeader."No." := '';
        if OverridePONo then PurchHeader."No." := PONo;
        PurchHeader.Insert(true);
        PurchHeader.Validate("Buy-from Vendor No.", VendorTemp."No.");
        PurchHeader.Validate("Posting Date", SalesHeader."Posting Date");
        PurchHeader.Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        if SalesHeader."Ship-to Code" <> '' then begin
            PurchHeader.Validate("Ship-to Option", PurchHeader."Ship-to Option"::"Ship-to Code");
            PurchHeader.Validate("Ship-to Code", SalesHeader."Ship-to Code");
        end;
        PurchHeader.Validate("Ship-to Name", SalesHeader."Ship-to Name");
        PurchHeader.Validate("Ship-to Name 2", SalesHeader."Ship-to Name 2");
        PurchHeader.Validate("Ship-to Contact", SalesHeader."Ship-to Contact");
        PurchHeader.Validate("Ship-to Address", SalesHeader."Ship-to Address");
        PurchHeader.Validate("Ship-to Address 2", SalesHeader."Ship-to Address 2");
        PurchHeader."Ship-to City" := SalesHeader."Ship-to City";
        PurchHeader."Ship-to County" := SalesHeader."Ship-to County";
        PurchHeader."Ship-to Post Code" := SalesHeader."Ship-to Post Code";
        PurchHeader."Ship-to Country/Region Code" := SalesHeader."Ship-to Country/Region Code";
        PurchHeader.Validate("Your Reference", SalesHeader."External Document No.");
        PurchHeader.Validate("Shipping Agent Code", SalesHeader."Shipping Agent Code");
        PurchHeader.Validate("Third Party Shipping Acc. No.", SalesHeader."Third Party Shipping Acc. No.");
        //DefaultSalesperson(TRUE);//IMPUPG
        PurchHeader."Customer PO No." := SalesHeader."External Document No.";
        PurchHeader.Modify(true);
        CopyCommentsToPO(SalesHeader."No.", 0, PurchHeader."No.", 0);
        NextLineNo := 10000;
        POCount += 1;
    end;

    procedure CreatePurchLine()
    begin
        PurchLine.Init;
        //sethidevalidationdialog(true);
        PurchLine.Validate("Document Type", PurchHeader."Document Type");
        PurchLine.Validate("Document No.", PurchHeader."No.");
        PurchLine."Line No." := NextLineNo;
        NextLineNo += 10000;
        PurchLine.Insert(true);
        PurchLine.Validate(Type, SalesLine.Type);
        PurchLine.Validate("No.", SalesLine."No.");
        PurchLine.Validate("Variant Code", SalesLine."Variant Code");
        //IM1.02 Start
        PurchLine.Description := SalesLine.Description;
        PurchLine."Description 2" := SalesLine."Description 2";
        //IM1.02 End
        // Imprint always wants same UoM
        /*
        IF Type = Type::Item THEN BEGIN
          Item.GET("No.");
          Item.TESTFIELD("Purch. Unit of Measure");
          VALIDATE("Unit of Measure Code",Item."Purch. Unit of Measure");
        END ELSE BEGIN
          VALIDATE("Unit of Measure Code",SalesLine."Unit of Measure Code");
        END;
        */
        PurchLine.Validate("Unit of Measure Code", SalesLine."Unit of Measure Code");
        PurchLine.Validate("Location Code", SalesLine."Location Code");
        // No Bins for Drop Shipments
        //VALIDATE("Bin Code",SalesLine."Bin Code");
        PurchLine.Validate("Expected Receipt Date", SalesLine."Shipment Date");
        // Imprint always wants same UoM
        /*
        IF Type = Type::Item THEN BEGIN
          IF SalesLine."Qty. per Unit of Measure" <> PurchLine."Qty. per Unit of Measure" THEN
            // Convert UoM
            VALIDATE(Quantity,ROUND(SalesLine."Quantity (Base)" / "Qty. per Unit of Measure",0.00001,'='))
          ELSE
            // Same UoM; no conversion necessary
            VALIDATE(Quantity,SalesLine.Quantity);
        END ELSE BEGIN
          VALIDATE(Quantity,SalesLine.Quantity);
        END;
        */
        PurchLine.Validate(Quantity, SalesLine.Quantity);
        PurchLine.Validate("Direct Unit Cost", SalesLine."Unit Cost (LCY)");
        PurchLine.Validate("Purchasing Code", SalesLine."Purchasing Code");
        PurchLine."Sales Order No." := SalesLine."Document No.";
        PurchLine."Sales Order Line No." := SalesLine."Line No.";
        PurchLine.Modify(true);
        storePOItemLineno := PurchLine."Line No.";
        CopyCommentsToPO(SalesLine."Document No.", SalesLine."Line No.", PurchLine."Document No.", PurchLine."Line No.");
        //IMPRINT1.01 start
        commentlinesoline.Reset;
        commentlinesoline.SetRange("Document Type", SalesLine."Document Type");
        commentlinesoline.SetRange("Document No.", SalesLine."Document No.");
        commentlinesoline.SetFilter("Line No.", '>%1', SalesLine."Line No.");
        if commentlinesoline.FindSet then begin
            repeat
                if commentlinesoline.Type = commentlinesoline.Type::" " then begin
                    PurchLine.Init;
                    PurchLine."Document Type" := PurchLine."Document Type"::Order;
                    PurchLine."Document No." := PurchLine."Document No.";
                    NextLineNo := NextLineNo + 10000;
                    PurchLine."Line No." := NextLineNo;
                    PurchLine.Description := commentlinesoline.Description;
                    PurchLine."Description 2" := commentlinesoline."Description 2";
                    PurchLine.Insert;
                end;
            until (commentlinesoline.Next = 0) or (commentlinesoline.Type <> commentlinesoline.Type::" ");
            NextLineNo := NextLineNo + 10000;
        end; //IMPRINT1.01 end
    end;

    procedure CopyCommentsToPO(SalesDocNo: Code[20]; SalesLineNo: Integer; PurchDocNo: Code[20]; PurchLineNo: Integer)
    var
        SalesCommentLine: Record "Sales Comment Line";
        PurchCommentLine: Record "Purch. Comment Line";
        NextLineNo: Integer;
    begin
        // Get next Purch Comment Line No
        // Shouldn't be any, but just in case they are created from Item or some automated method
        PurchCommentLine.Reset;
        PurchCommentLine.SetRange("Document Type", PurchCommentLine."Document Type"::Order);
        PurchCommentLine.SetRange("No.", PurchDocNo);
        PurchCommentLine.SetRange("Document Line No.", PurchLineNo);
        if PurchCommentLine.FindLast then
            NextLineNo := PurchCommentLine."Line No." + 10000
        else
            NextLineNo := 10000;
        SalesCommentLine.Reset;
        SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::Order);
        SalesCommentLine.SetRange("No.", SalesDocNo);
        SalesCommentLine.SetRange("Document Line No.", SalesLineNo);
        SalesCommentLine.SetRange("Copy to Purch. Order", true);
        if SalesCommentLine.FindSet(false) then
            repeat
                PurchCommentLine.Init;
                PurchCommentLine."Document Type" := PurchCommentLine."Document Type"::Order;
                PurchCommentLine."No." := PurchDocNo;
                PurchCommentLine."Document Line No." := PurchLineNo;
                PurchCommentLine."Line No." := NextLineNo;
                NextLineNo += 10000;
                PurchCommentLine.Comment := SalesCommentLine.Comment;
                PurchCommentLine.Insert;
            until SalesCommentLine.Next = 0;
    end;
}
