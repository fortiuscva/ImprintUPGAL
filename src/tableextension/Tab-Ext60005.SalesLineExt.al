tableextension 60005 "SalesLineExt" extends "Sales Line"
{
    fields
    {
        field(50000; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            Description = 'ISS2.00';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(50010; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Profit ($)';
            DecimalPlaces = 2 : 2;
            Description = 'ISS2.00';
        }
        field(50030; "Last Direct Cost"; Decimal)
        {
            Description = 'IMP1.01';
            Editable = false;
        }
        field(60030; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;

            trigger OnLookup()
            var
                PurchasePrice: Record "Purchase Price";
                ResourceCost: Record "Resource Cost";
                Vendor: Record Vendor;
                PurchasePrices: Page "Purchase Prices";
                ResourceCosts: Page "Resource Costs";
                VendorList: Page "Vendor List";
                SalesHeader: Record "Sales Header";
                PricingDate: Date;
                ISSText001: Label '%1 can only be specified for Item or Resource Lines.';
            begin
                // ISS2.00 09.06.13 DFP ===========================================================================\
                IF NOT (Type IN [Type::Item, Type::Resource]) THEN // %1 can only be specified for Item or Resource Lines.
                    ERROR(ISSText001, FIELDCAPTION("Vendor No."));
                TESTFIELD("No.");
                GetSalesHeader;
                SalesHeader.Get(Rec."Document Type", Rec."Document No.");
                IF SalesHeader."Posting Date" <> 0D THEN
                    PricingDate := SalesHeader."Posting Date"
                ELSE
                    PricingDate := SalesHeader."Order Date";
                CASE Type OF
                    Type::Item:
                        BEGIN
                            WITH PurchasePrice DO BEGIN
                                RESET;
                                SETRANGE("Item No.", Rec."No.");
                                SETFILTER("Starting Date", '<=' + FORMAT(PricingDate));
                                SETFILTER("Ending Date", '''''|>=' + FORMAT(PricingDate));
                            END;
                            WITH PurchasePrices DO BEGIN
                                CLEAR(PurchasePrices);
                                EDITABLE(FALSE);
                                LOOKUPMODE(TRUE);
                                SETTABLEVIEW(PurchasePrice);
                                IF RUNMODAL = ACTION::LookupOK THEN BEGIN
                                    GETRECORD(PurchasePrice);
                                    Rec.VALIDATE("Vendor No.", PurchasePrice."Vendor No.");
                                END;
                            END;
                        END;
                    Type::Resource:
                        BEGIN
                            IF NOT Vendor.GET("Vendor No.") THEN CLEAR(Vendor);
                            WITH VendorList DO BEGIN
                                CLEAR(VendorList);
                                EDITABLE(FALSE);
                                LOOKUPMODE(TRUE);
                                SETTABLEVIEW(Vendor);
                                IF RUNMODAL = ACTION::LookupOK THEN BEGIN
                                    GETRECORD(Vendor);
                                    Rec.VALIDATE("Vendor No.", Vendor."No.");
                                END;
                            END;
                        END;
                END;
                // End ============================================================================================/
            end;

            trigger OnValidate()
            var
                Vend: Record Vendor;
                UnitCost: Decimal;
                QtyDiscPercent: Decimal;
                ISSText001: Label '%1 can only be specified for Item or Resource Lines.';
                DPText048: Label 'The Vendor No. %1 is blocked for ALL transactions.';
                DPText041: Label 'Vendor No. %1 was not found.';
                DPText043: Label 'A %1 percent qty. discount is available from Vendor No. %2 when the Qty is %3.';
            begin
                //DP
                IF "Vendor No." <> '' THEN
                    IF Vend.GET("Vendor No.") THEN BEGIN
                        //DP37.04
                        //Vend.TESTFIELD(Blocked,Vend.Blocked::" ");
                        IF Vend.Blocked = Vend.Blocked::All THEN ERROR(DPText048, "Vendor No.");
                        //end DP37.04
                    END
                    ELSE
                        IF CurrFieldNo <> 0 THEN
                            ERROR(DPText041, "Vendor No.")
                        ELSE
                            "Vendor No." := '';
                IF (Type = Type::Item) AND ("No." <> '') THEN BEGIN
                    // DFP Comment out next line
                    //FindPurchaseCost(FIELDNO("No."));
                    // ISS2.00 09.06.13 DFP ===========================================================================\
                    IF ("Vendor No." <> '') AND (NOT (Type IN [Type::Item, Type::Resource])) THEN // %1 can only be specified for Item or Resource Lines.
                        ERROR(ISSText001, FIELDCAPTION("Vendor No."));
                    GetBestUnitCost;
                    // End ============================================================================================/
                    IF ("Allow Line Disc.") AND ("Vendor No." <> '') THEN
                        IF ("No." <> '') AND (CurrFieldNo <> 0) THEN BEGIN
                            //PurchPriceCalcMgt.FindPurchDiscFromSalesLine(Rec);
                            QtyDiscPercent := "Purch. Line Discount %";
                            IF QtyDiscPercent <> 0 THEN MESSAGE(DPText043, QtyDiscPercent, "Vendor No.", "Quantity (Base)");
                        END;
                END;
                //end DP
            end;
        }
        field(60031; "Direct Purchase"; Boolean)
        {
            Editable = false;
        }
        field(60032; "Ship-to Option"; Option)
        {
            Description = 'Location Code,Ship-to Code,Job Site';
            InitValue = "Ship-to Code";
            OptionCaption = 'Location Code,Ship-to Code,Job Site';
            OptionMembers = "Location Code","Ship-to Code","Job Site";
        }
        field(60033; "Ship-to Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(60036; "Sales Order No."; Code[20])
        {
        }
        field(60037; "Purch. Line Discount %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                res: Record Resource;
            begin
                // ISS2.00 ================================================================\
                IF (Type = Type::Item) then Item.Get("No.");
                IF (Type = Type::Item) AND (Item."Vendor No." <> '') THEN VALIDATE("Vendor No.", Item."Vendor No.");
                IF (Type = Type::Resource) then res.Get("No.");
                IF (Type = Type::Resource) AND (Res."Vendor No." <> '') THEN VALIDATE("Vendor No.", Res."Vendor No.");
                // End ====================================================================/
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                // ISS2.00 09.06.13 DFP ===========================================================================\
                //IMP1.03 Start
                IF NOT QtyValidateSuspend THEN
                    IF SavePONo = '' THEN //IMP1.03 End
                        GetBestUnitCost;
                // End ============================================================================================/
                // ISS2.00 01.24.14 DFP ===========================================================\
                IF NOT QtyValidateSuspend THEN ChangePOQtyFinish;
                // End ============================================================================/
                // ISS2.00 01.24.14 DFP ========================================\
                UpdateProfit;
                // End =========================================================/
            end;
        }
        modify("Unit Cost (LCY)")
        {
            trigger OnAfterValidate()
            begin
                // ISS2.00 01.08.14 DFP ========================================\
                UpdateProfit;
                // End =========================================================/
            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                // ISS2.00 09.06.13 DFP ===========================================================================\
                GetBestUnitCost;
                // End ============================================================================================/
            end;
        }
        modify("Purchasing Code")
        {
            trigger OnAfterValidate()
            begin
                // ISS2.00 09.06.13 DFP ===========================================================================\
                GetBestUnitCost;
                // End ============================================================================================/
            end;
        }
    }
    PROCEDURE ChangePOQtyStart();
    VAR
        PurchHeader: Record 38;
        ReleasePurchDoc: Codeunit 415;
    BEGIN
        // ISS2.00 01.24.14 DFP ===========================================================\
        POSaved := FALSE;
        CLEAR(SavePONo);
        CLEAR(SavePOLineNo);
        IF "Purch. Order Line No." = 0 THEN EXIT;
        PurchHeader.GET(PurchHeader."Document Type"::Order, Rec."Purchase Order No.");
        IF PurchHeader.Status <> PurchHeader.Status::Open THEN ReleasePurchDoc.Reopen(PurchHeader);
        POSaved := TRUE;
        SavePONo := "Purchase Order No.";
        SavePOLineNo := "Purch. Order Line No.";
        "Purchase Order No." := '';
        "Purch. Order Line No." := 0;
        // End ============================================================================/
    END;

    PROCEDURE ChangePOQtyFinish();
    VAR
        PurchLine: Record 39;
        DropShipSave: Boolean;
        SaveDirectUnitCost: Decimal;
    BEGIN
        // ISS2.00 01.24.14 DFP ===========================================================\
        IF NOT POSaved THEN EXIT;
        PurchLine.GET(PurchLine."Document Type"::Order, SavePONo, SavePOLineNo);
        PurchLine.TESTFIELD("Sales Order No.", Rec."Document No.");
        PurchLine.TESTFIELD("Sales Order Line No.", Rec."Line No.");
        PurchLine.TESTFIELD("Unit of Measure Code", Rec."Unit of Measure Code");
        CLEAR(PurchLine."Sales Order No.");
        CLEAR(PurchLine."Sales Order Line No.");
        DropShipSave := PurchLine."Drop Shipment";
        PurchLine."Drop Shipment" := FALSE;
        SaveDirectUnitCost := PurchLine."Direct Unit Cost";
        PurchLine.VALIDATE(Quantity, Rec.Quantity);
        PurchLine.VALIDATE("Direct Unit Cost", SaveDirectUnitCost);
        PurchLine."Sales Order No." := Rec."Document No.";
        PurchLine."Sales Order Line No." := Rec."Line No.";
        PurchLine."Drop Shipment" := DropShipSave;
        PurchLine.MODIFY(TRUE);
        "Purchase Order No." := SavePONo;
        "Purch. Order Line No." := SavePOLineNo;
        // End ============================================================================/
    END;

    PROCEDURE UpdateProfit();
    VAR
        ReqLine: Record 246;
        Vendor: Record 23;
        PurchPriceCalcMgt: Codeunit 7010;
    BEGIN
        // ISS2.00 01.08.14 DFP ===========================================================================\
        CLEAR("Profit (LCY)");
        CLEAR("Profit %");
        IF "Unit Price" <> 0 THEN "Profit %" := 100 * (("Unit Price" - "Unit Cost (LCY)") / "Unit Price");
        "Profit (LCY)" := ROUND("Line Amount" - ("Unit Cost (LCY)" * Quantity));
        // End ============================================================================================/
    END;

    PROCEDURE GetBestUnitCost();
    VAR
        ReqLine: Record 246;
        Vendor: Record 23;
        PurchPriceCalcMgt: Codeunit 7010;
        SalesHeader: Record 36;
        IsHandled: Boolean;
    BEGIN
        IsHandled := false;
        OnBeforeGetBestCost(Rec, IsHandled, CurrFieldNo);
        if IsHandled then
            exit;

        // ISS2.00 09.06.13 DFP ===========================================================================\
        IF "No." = '' THEN EXIT;
        IF NOT Vendor.GET("Vendor No.") THEN CLEAR(Vendor);
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        CASE Type OF
            Type::Item:
                BEGIN
                    //IF NOT ("Drop Shipment" OR "Direct Purchase" OR "Special Order") THEN BEGIN
                    //  GetUnitCost;
                    //  EXIT;
                    //END;
                    ReqLine.INIT;
                    ReqLine.Type := ReqLine.Type::Item;
                    ReqLine."No." := Rec."No.";
                    ReqLine."Variant Code" := Rec."Variant Code";
                    ReqLine."Vendor No." := Rec."Vendor No.";
                    ReqLine."Location Code" := Rec."Location Code";
                    ReqLine.Quantity := Rec.Quantity;
                    ReqLine."Unit of Measure Code" := Rec."Unit of Measure Code";
                    ReqLine."Qty. per Unit of Measure" := Rec."Qty. per Unit of Measure";
                    ReqLine."Currency Code" := Vendor."Currency Code";
                    //"Currency Factor"
                    IF SalesHeader."Posting Date" <> 0D THEN
                        ReqLine."Order Date" := SalesHeader."Posting Date"
                    ELSE
                        ReqLine."Order Date" := SalesHeader."Order Date";
                    PurchPriceCalcMgt.FindReqLinePrice(ReqLine, 0);
                    IF ReqLine."Direct Unit Cost" <> 0 THEN
                        Rec.VALIDATE("Unit Cost (LCY)", ReqLine."Direct Unit Cost")
                    ELSE
                        GetUnitCost;
                END;
        END;
        // End ============================================================================================/
    end;

    PROCEDURE GetUserSetup();
    BEGIN
        // ISS2.00 DFP =================================================\
        IF UserSetupFound THEN EXIT;
        IF NOT UserSetup.GET(USERID) THEN CLEAR(UserSetup);
        UserSetupFound := TRUE;
        // End =========================================================/
    END;

    PROCEDURE CheckSupervisor() SupervisorOut: Boolean;
    BEGIN
        // ISS2.00 DFP =================================================\
        GetUserSetup;
        EXIT(UserSetup."Sales Supervisor");
        // End =========================================================/
    END;

    PROCEDURE FilterSalesperson();
    BEGIN
        // ISS2.00 DFP =================================================\
        // Filters recordset to the User's Salesperson Filter
        GetUserSetup;
        IF (UserSetup."Salesperson Filter" = '') OR (UserSetup."Sales Supervisor") THEN EXIT;
        FILTERGROUP(2);
        SETFILTER("Salesperson Code", UserSetup."Salesperson Filter");
        FILTERGROUP(0);
        // End =========================================================/
    END;

    PROCEDURE DefaultSalesperson(ValidateField: Boolean);
    BEGIN
        // ISS2.00 DFP =================================================\
        GetUserSetup;
        IF ValidateField THEN
            VALIDATE("Salesperson Code", UserSetup."Salespers./Purch. Code")
        ELSE
            "Salesperson Code" := UserSetup."Salespers./Purch. Code";
        // End =========================================================/
    END;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeGetBestCost(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; CurrFieldNo: Integer)
    begin
    end;



    var
        SavePONo: Code[20];
        SavePOLineNo: Integer;
        POSaved: Boolean;
        SalesSetup: Record 311;
        UserSetup: Record 91;
        UserSetupFound: Boolean;
        QtyValidateSuspend: Boolean;
}
