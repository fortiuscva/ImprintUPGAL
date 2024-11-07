codeunit 90000 "UpdateCode"
{
    Permissions = tabledata "Sales Invoice Line" = RM,
        tabledata "Purch. Inv. Line" = RM;

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeVerifyInvoicedQty', '', false, false)]
    procedure OnbeforeVerifyInvoiceQtyDropShipment(ItemLedgerEntry: Record "Item Ledger Entry"; VAR IsHandled: Boolean; ValueEntry: Record "Value Entry")
    begin
        //IMP1.01 Start
        IF (ItemLedgerEntry."Drop Shipment" AND (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Purchase)) THEN IsHandled := true;
        //IMP1.01 End
    end;
    //IMP1.17 >>
    [EventSubscriber(ObjectType::Page, page::"Purchase Order", 'OnDeleteRecordEvent', '', false, false)]
    procedure OnBeforeDeletePurchOrder(var Rec: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", Rec."Document Type");
        PurchaseLine.SetRange("Document No.", Rec."No.");
        if PurchaseLine.FindSet() then
            repeat
                if PurchaseLine."Quantity Received" <> 0 then if PurchaseLine.Quantity <> PurchaseLine."Quantity Received" then Error('%1 should be 0', PurchaseLine.FieldCaption("Quantity Received"));
                if PurchaseLine."Quantity Invoiced" <> 0 then if PurchaseLine.Quantity <> PurchaseLine."Quantity Invoiced" then Error('%1 should be 0', PurchaseLine.FieldCaption("Quantity Invoiced"));
            until PurchaseLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Page, page::"Purchase Order Subform", 'OnDeleteRecordEvent', '', false, false)]
    procedure OnBeforeDeletePurchLine(var Rec: Record "Purchase Line")
    begin
        if Rec."Quantity Received" <> 0 then if Rec.Quantity <> Rec."Quantity Received" then Error('%1 should be 0', Rec.FieldCaption("Quantity Received"));
        if Rec."Quantity Invoiced" <> 0 then if Rec.Quantity <> Rec."Quantity Invoiced" then Error('%1 should be 0', Rec.FieldCaption("Quantity Invoiced"));
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Order", 'OnDeleteRecordEvent', '', false, false)]
    procedure OnBeforeDeleteSalesOrder(var Rec: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        if SalesLine.FindSet() then
            repeat
                if SalesLine."Quantity Shipped" <> 0 then if SalesLine.Quantity <> SalesLine."Quantity Shipped" then Error('%1 should be 0', SalesLine.FieldCaption("Quantity Shipped"));
                if SalesLine."Quantity Invoiced" <> 0 then if SalesLine.Quantity <> SalesLine."Quantity Invoiced" then Error('%1 should be 0', SalesLine.FieldCaption("Quantity Invoiced"));
            until SalesLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Order Subform", 'OnDeleteRecordEvent', '', false, false)]
    procedure OnBeforeDeleteSalesLine(var Rec: Record "Sales Line")
    begin
        if Rec."Quantity Shipped" <> 0 then if Rec.Quantity <> Rec."Quantity Shipped" then Error('%1 should be 0', Rec.FieldCaption("Quantity Shipped"));
        if Rec."Quantity Invoiced" <> 0 then if Rec.Quantity <> Rec."Quantity Invoiced" then Error('%1 should be 0', Rec.FieldCaption("Quantity Invoiced"));
    end;
    //IMP1.17 <<   
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Explode BOM", 'OnBeforeConfirmExplosion', '', false, false)]
    procedure UpdateAutoConfirm(VAR SalesLine: Record "Sales Line"; VAR Selection: Integer; VAR HideDialog: Boolean)
    begin
        IF AutoConfirm THEN //IMP1.01
            HideDialog := false;
    end;

    PROCEDURE SetAutoConfirm(AutoConfirmPar: Boolean);
    BEGIN
        AutoConfirm := AutoConfirmPar;
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Explode BOM", 'OnBeforeToSalesLineModify', '', false, false)]
    procedure OnBeforeToSalesLineModifyAutoCinfirm(VAR ToSalesLine: Record "Sales Line"; FromSalesLine: Record "Sales Line")
    begin
        //IMP1.01 Start
        IF AutoConfirm THEN ToSalesLine := FromSalesLine //IMP1.01 End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', false, false)]
    procedure OnbeforeConfirmSalesPOstSelection(VAR SalesHeader: Record "Sales Header"; VAR HideDialog: Boolean; VAR IsHandled: Boolean; VAR DefaultOption: Integer; VAR PostAndSend: Boolean)
    begin
        CASE SalesHeader."Document Type" OF
            SalesHeader."Document Type"::Order:
                BEGIN
                    DefaultOption := 1;
                END;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeConfirmPost', '', false, false)]
    procedure OnBeforeConfirmPostSelection(VAR SalesHeader: Record "Sales Header"; VAR HideDialog: Boolean; VAR IsHandled: Boolean; VAR SendReportAsEmail: Boolean; VAR DefaultOption: Integer)
    begin
        CASE SalesHeader."Document Type" OF
            SalesHeader."Document Type"::Order:
                BEGIN
                    DefaultOption := 1;
                END;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    procedure OnAfterInitCustLedgEntryExtDocNo(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        ServHeadRecGbl: Record 5900;
    begin
        //IMP1.02 Start
        if GenJournalLine."Source Code" = 'SERVICE' then begin
            if GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice THEN BEGIN
                if ServHeadRecGbl.get(ServHeadRecGbl."Document Type"::Order, COPYSTR(GenJournalLine.Description, 7)) then begin
                    CustLedgerEntry."External Document No." := ServHeadRecGbl."Customer PO No.";
                end
                else
                    CustLedgerEntry."External Document No." := GenJournalLine."External Document No.";
            end;
        end
        else begin
            if GenJournalLine."External Document No." = '' then begin
                if GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice THEN BEGIN
                    IF ServHeadRecGbl.GET(ServHeadRecGbl."Document Type"::Order, COPYSTR(GenJournalLine.Description, 7)) THEN BEGIN
                        CustLedgerEntry."External Document No." := ServHeadRecGbl."Customer PO No.";
                    END
                    ELSE
                        CustLedgerEntry."External Document No." := GenJournalLine."External Document No.";
                end
                else
                    CustLedgerEntry."External Document No." := GenJournalLine."External Document No.";
            end
            else //IMP1.02 End
                CustLedgerEntry."External Document No." := GenJournalLine."External Document No.";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    procedure OnAfterInitGLEntryCreateDat(VAR GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //IMP1.01 Start
        GLEntry."Created Date" := TODAY;
        GLEntry."Created Time" := TIME;
        //IMP1.01 End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeModifySalesOrderHeader', '', false, false)]
    procedure OnBeforeModifySalesOrderHeaderOrderDate(VAR SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
        //IMP1.01 Start
        SalesOrderHeader."Order Date" := WORKDATE;
        SalesOrderHeader."Document Date" := WORKDATE;
        SalesOrderHeader."Shipment Date" := WORKDATE;
        //IMP1.01 End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", 'OnBeforeCustLedgEntryModify', '', false, false)]
    procedure OnBeforeCustLedgEntryModifyCustComment(VAR CustLedgEntry: Record "Cust. Ledger Entry"; FromCustLedgEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgEntry."Cust. Comments" := FromCustLedgEntry."Cust. Comments"; //IMP1.01
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Service Document", 'OnBeforeReleaseServiceDoc', '', false, false)]
    procedure OnBeforeReleaseServiceDocShipCode(VAR ServiceHeader: Record "Service Header")
    begin
        ServiceHeader.TESTFIELD("Ship-to Code"); //IMP1.01
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvLineInsert', '', false, false)]
    local procedure UpdateInvLines(var SalesHeader: Record "Sales Header"; var SalesInvLine: Record "Sales Invoice Line"; SalesLine: Record "Sales Line"; SalesInvHeader: Record "Sales Invoice Header")
    begin
        //DP
        SalesInvLine."Special Order" := SalesLine."Special Order";
        SalesInvLine."Purchase Order No." := SalesLine."Purchase Order No.";
        IF SalesLine."Sales Order No." = '' THEN IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN SalesInvLine."Sales Order No." := SalesHeader."No.";
        SalesInvLine."Ship-to Code" := SalesHeader."Ship-to Code";
        SalesInvLine.Modify();
        //end DP
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesCrMemoLineInsert', '', false, false)]
    local procedure UpdateCrdLines(var SalesHeader: Record "Sales Header"; var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesLine: Record "Sales Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        IF SalesHeader."Applies-to Doc. Type" = SalesHeader."Applies-to Doc. Type"::Invoice THEN SalesCrMemoLine."Sales Invoice No." := SalesHeader."Applies-to Doc. No.";
        IF SalesCrMemoLine."Ship-to Code" = '' THEN SalesCrMemoLine."Ship-to Code" := SalesCrMemoHeader."Ship-to Code";
        //end DP
    end;

    PROCEDURE CheckEditAccountPay(): Boolean;
    var
        UserRecGbl: Record 2000000120;
        UserSetupRecGbl: Record 91;
    BEGIN
        UserSetupRecGbl.RESET;
        UserSetupRecGbl.SETRANGE("User ID", USERID);
        UserSetupRecGbl.SETRANGE("Edit Accounts Payable Contacts", TRUE);
        IF UserSetupRecGbl.FINDFIRST THEN EXIT(TRUE);
        EXIT(FALSE);
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    procedure OnBeforeReleaseSalesDocFun(VAR SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServLedgEntries-Post", 'OnBeforeServLedgerEntryInsert', '', false, false)]
    procedure OnBeforeServLedgerEntryInsertResource(VAR ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceLine: Record "Service Line"; ServiceItemLine: Record "Service Item Line"; ServiceHeader: Record "Service Header")
    begin
        //IMP1.01 Start
        ServiceLedgerEntry."Resource 1" := ServiceLine."Resource 1";
        ServiceLedgerEntry."Resource 2" := ServiceLine."Resource 2";
        //IMP1.01 End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServLedgEntries-Post", 'OnBeforeServLedgerEntrySaleInsert', '', false, false)]
    procedure OnBeforeServLedgerEntrySaleInsertResource(VAR ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceLine: Record "Service Line"; ServiceItemLine: Record "Service Item Line"; ServiceHeader: Record "Service Header")
    begin
        //IMP1.01 Start
        ServiceLedgerEntry."Resource 1" := ServiceLine."Resource 1";
        ServiceLedgerEntry."Resource 2" := ServiceLine."Resource 2";
        //IMP1.01 End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServLedgEntries-Post", 'OnInsertServLedgEntryCrMemoOnBeforeServLedgEntryInsert', '', false, false)]
    procedure OnInsertServLedgEntryCrMemoOnBeforeServLedgEntryInsertResource(VAR ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceHeader: Record "Service Header"; ServiceLine: Record "Service Line")
    begin
        //IMP1.01 Start
        ServiceLedgerEntry."Resource 1" := ServiceLine."Resource 1";
        ServiceLedgerEntry."Resource 2" := ServiceLine."Resource 2";
        //IMP1.01 End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ServItemManagement, 'OnCreateServItemOnSalesLineShpt', '', false, false)]
    procedure OnCreateServItemOnSalesLineShptDesc2(VAR ServiceItem: Record "Service Item"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line")
    begin
        ServiceItem.VALIDATE("Description 2", COPYSTR(SalesLine."Description 2", 1, MAXSTRLEN(ServiceItem."Description 2")));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnBeforeServShptHeaderInsert', '', false, false)]
    procedure OnBeforeServShptHeaderInsertTaxExp(VAR ServiceShipmentHeader: Record "Service Shipment Header"; ServiceHeader: Record "Service Header")
    begin
        //IMP1.02 Start
        ServiceShipmentHeader."Tax Exemption No." := ServiceHeader."Tax Exemption No.";
        ServiceShipmentHeader."Tax Exempt Categories" := ServiceHeader."Tax Exempt Categories";
        //IMP1.02 End    
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnBeforeServInvHeaderInsert', '', false, false)]
    procedure OnBeforeServInvHeaderInsertTaxExpt(VAR ServiceInvoiceHeader: Record "Service Invoice Header"; ServiceHeader: Record "Service Header")
    var
        ServShptHeadLRec: Record 5990;
    begin
        //IMP1.02 Start
        ServiceInvoiceHeader."Tax Exemption No." := ServiceHeader."Tax Exemption No.";
        ServiceInvoiceHeader."Tax Exempt Categories" := ServiceHeader."Tax Exempt Categories";
        //IMP1.02 End
        //IMP1.03 Start
        ServShptHeadLRec.RESET;
        ServShptHeadLRec.SETRANGE("Order No.", ServiceHeader."No.");
        IF ServShptHeadLRec.FINDFIRST THEN
            ServiceInvoiceHeader."Service Date" := ServShptHeadLRec."Posting Date"
        ELSE
            ServiceInvoiceHeader."Service Date" := ServiceHeader."Posting Date";
        //IMP1.03 End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeModifySalesHeader', '', false, false)]
    procedure OnBeforeModifySalesHeaderWorkDate(VAR ToSalesHeader: Record "Sales Header"; FromDocType: Option; FromDocNo: Code[20]; IncludeHeader: Boolean; FromDocOccurenceNo: Integer; FromDocVersionNo: Integer)
    begin
        IF workdateuse THEN BEGIN //IMPRINT1.01
            ToSalesHeader.VALIDATE("Document Date", WORKDATE);
            ToSalesHeader.VALIDATE("Shipment Date", WORKDATE);
            ToSalesHeader.VALIDATE("Posting Date", WORKDATE);
            ToSalesHeader.VALIDATE("Order Date", WORKDATE);
        END;
    end;

    PROCEDURE setdocdate(useworkdate: Boolean);
    BEGIN
        workdateuse := useworkdate; //IMPRINT1.01 new function added
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Drop Shpt.", 'OnAfterSalesLineModify', '', false, false)]
    procedure commentLineSoInsert(VAR SalesLine: Record "Sales Line"; VAR PurchaseLine: Record "Purchase Line")
    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        NextLineNoLvar: Integer;
        PurchLine2: Record "Purchase Line";
        commentlinesoline: Record 37;
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(PurchaseLine, TRUE) THEN BEGIN
            PurchLine2.SETRANGE("Document Type", PurchaseLine."Document Type");
            PurchLine2.SETRANGE("Document No.", PurchaseLine."Document No.");
            IF PurchLine2.FINDLAST THEN NextLineNoLvar := PurchLine2."Line No.";
            NextLineNoLvar := NextLineNoLvar + 10000;
        END;
        //IMPRINT1.01 start
        commentlinesoline.RESET;
        commentlinesoline.SETRANGE("Document Type", SalesLine."Document Type");
        commentlinesoline.SETRANGE("Document No.", SalesLine."Document No.");
        commentlinesoline.SETFILTER("Line No.", '>%1', SalesLine."Line No.");
        IF commentlinesoline.FINDSET THEN BEGIN
            REPEAT
                IF commentlinesoline.Type = commentlinesoline.Type::" " THEN BEGIN
                    PurchaseLine.INIT;
                    PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                    PurchaseLine."Document No." := PurchaseLine."Document No.";
                    PurchaseLine."Line No." := NextLineNoLvar;
                    PurchaseLine.Description := commentlinesoline.Description;
                    PurchaseLine."Description 2" := commentlinesoline."Description 2";
                    PurchaseLine.INSERT;
                    NextLineNoLvar := NextLineNoLvar + 10000;
                END;
            UNTIL (commentlinesoline.NEXT = 0) OR (commentlinesoline.Type <> commentlinesoline.Type::" ");
        END;
        //IMPRINT1.01 end
    end;

    procedure AddLineToAddress(VAR AddrArray: ARRAY[8] OF Text[50]; VAR AddLine: Text[50])
    var
        i: Integer;
    begin
        // ISS2.00 11.26.13 DFP =======================================================\
        // This function can be called after formatting an address to add an
        //   additional line of information (like a Phone No)
        FOR i := 1 TO 8 DO BEGIN
            IF AddrArray[i] = '' THEN BEGIN
                AddrArray[i] := AddLine;
                EXIT;
            END;
        END;
        // End ========================================================================/
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    procedure OnBeforePostSalesDocCheckForReason(VAR SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; VAR HideProgressWindow: Boolean)
    begin
        //IMP1.01 Start
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order") OR (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo") THEN SalesHeader.CheckForReasonCode;
        //IMP1.01 End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterCheckSalesDoc', '', false, false)]
    procedure OnAfterCheckSalesDocResSetup(VAR SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean)
    var
        ResSetup: Record "Resources Setup";
        Resource: Record Resource;
        SalesLine: Record "Sales Line";
        ISSText001: label 'Resource Lines must be attached to a Purchase Order.\\Resource %1 on Line No. %2 has no Purchase Order No.';
    begin
        // ISS2.00 01.07.14 
        ResSetup.GET;
        IF ResSetup."Require Sales Purch. Doc. Link" AND (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) THEN BEGIN
            // Require Resources to be linked to a PO
            IF SalesHeader.Invoice OR SalesHeader.Ship OR SalesHeader.Receive THEN BEGIN
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                SalesLine.SETFILTER(Quantity, '<>0');
                SalesLine.SETRANGE(Type, SalesLine.Type::Resource);
                SalesLine.SETFILTER("Purchase Order No.", '%1', '');
                IF SalesLine.FINDSET(FALSE) THEN
                    REPEAT
                        Resource.GET(SalesLine."No.");
                        IF Resource.Type = Resource.Type::"Item (Custom)" THEN // Resource Lines must be attached to a Purchase Order.\\Resource %1 on Line No. %2 has no Purchase Order No.
                            ERROR(ISSText001, SalesLine."No.", SalesLine."Line No.");
                    UNTIL SalesLine.NEXT = 0;
            END;
        END;
        // End ==========
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntryBuffer', '', false, false)]
    procedure OnBeforeInsertGLEntryBufferSingleinstance(VAR TempGLEntryBuf: Record "G/L Entry" temporary; VAR GenJournalLine: Record "Gen. Journal Line"; VAR BalanceCheckAmount: Decimal; VAR BalanceCheckAmount2: Decimal; VAR BalanceCheckAddCurrAmount: Decimal; VAR BalanceCheckAddCurrAmount2: Decimal; VAR NextEntryNo: Integer)
    var
        SingleCU: Codeunit 50016;
    begin
        SingleCU.InsertGL(TempGLEntryBuf);
    end;

    procedure CompanyRemit(VAR AddrArray: ARRAY[8] OF Text[50]; VAR CompanyInfo: Record "Company Information")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        // ISS2.00 06.13.14 DFP =======================================================\
        FormatAddress.FormatAddr(AddrArray, CompanyInfo."Remit-to Name", CompanyInfo."Remit-to Name 2", '', CompanyInfo."Remit-to Address", CompanyInfo."Remit-to Address 2", CompanyInfo."Remit-to City", CompanyInfo."Remit-to Post Code", CompanyInfo."Remit-to County", CompanyInfo."Remit-to Country/Region Code");
        // End ========================================================================/
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeReturnRcptHeaderInsert', '', false, false)]
    procedure OnBeforeReturnRcptHeaderInsertRcptHead(VAR ReturnRcptHeader: Record "Return Receipt Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        //IMP1.06 Start
        ReturnRcptHeader."Tax Exempt Categories" := SalesHeader."Tax Exempt Categories";
        ReturnRcptHeader."Tax Exemption No." := SalesHeader."Tax Exemption No.";
        //IMP1.06 End 
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptHeaderInsert', '', false, false)]
    procedure OnBeforeSalesShptHeaderInsertTaxExpNo(VAR SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        SalesShptHeader."Tax Exemption No." := SalesHeader."Tax Exemption No."; //IMP1.05  
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesShptHeaderInsert', '', false, false)]
    procedure OnAfterSalesShptHeaderInsertShiping(VAR SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; SuppressCommit: Boolean)
    var
        boolvar: Boolean;
        shipments: Record SHIPMENTS_ALL;
        Postedshipments: Record "Posted Shipments";
    begin
        //SSI01.00 start.
        shipments.RESET;
        shipments.SETRANGE("Sales Order Number", SalesHeader."No.");
        IF shipments.FIND('-') THEN
            REPEAT
                IF (shipments.Void = '') AND NOT shipments.Processed THEN BEGIN
                    boolvar := DIALOG.CONFIRM('There are unprocessed UPS shipping entries. Do you want to continue', TRUE);
                    IF NOT boolvar THEN ERROR('Stopping Posting Process');
                END;
            UNTIL (shipments.NEXT = 0) OR boolvar;
        shipments.RESET;
        shipments.SETRANGE("Sales Order Number", SalesHeader."No.");
        IF shipments.FIND('-') THEN
            REPEAT
                IF boolvar THEN BEGIN
                    Postedshipments.TRANSFERFIELDS(shipments);
                    Postedshipments."Shipment No." := SalesShipmentHeader."No.";
                    Postedshipments.INSERT;
                END
                ELSE BEGIN
                    //IF (shipments.Processed) OR (shipments.Void = '') THEN BEGIN
                    Postedshipments.TRANSFERFIELDS(shipments);
                    Postedshipments."Shipment No." := SalesShipmentHeader."No.";
                    Postedshipments.INSERT;
                END;
            //END;
            UNTIL shipments.NEXT = 0;
        Postedshipments.RESET;
        Postedshipments.SETRANGE("Sales Order Number", SalesHeader."No.");
        IF Postedshipments.FIND('-') THEN
            REPEAT
                IF shipments.GET(Postedshipments."Sales Order Number", Postedshipments."Tracking Number", Postedshipments.Void) THEN shipments.DELETE;
            UNTIL Postedshipments.NEXT = 0;
        //SSI01.00 end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePurchRcptLineInsert', '', false, false)]
    procedure OnBeforePurchRcptLineInsertPurRcpttype(VAR PurchRcptLine: Record "Purch. Rcpt. Line"; PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchOrderLine: Record "Purchase Line"; DropShptPostBuffer: Record "Drop Shpt. Post. Buffer"; CommitIsSuppressed: Boolean)
    begin
        // ISS2.00 11.26.13 DFP ==========================================================\
        IF PurchRcptLine.Quantity <> 0 THEN BEGIN
            IF PurchRcptLine.Type = PurchRcptLine.Type::Item THEN
                PurchRcptLine."Item Charge Base Amount" := PurchOrderLine."Line Amount"
            else
                PurchRcptLine."Item Charge Base Amount" := 0;
        end;
        // End ===========================================================================/
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostCustomerEntry', '', false, false)]
    procedure OnBeforePostCustomerEntryLeadSource(VAR GenJnlLine: Record "Gen. Journal Line"; VAR SalesHeader: Record "Sales Header"; VAR TotalSalesLine: Record "Sales Line"; VAR TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    begin
        // ISS2.00 DFP 07.25.13 ==================================================\
        GenJnlLine."Lead Source Code" := SalesHeader."Lead Source Code";
        // End ===================================================================/
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostBalancingEntry', '', false, false)]
    procedure OnBeforePostBalancingEntry(VAR GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; VAR TotalSalesLine: Record "Sales Line"; VAR TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    begin
        // ISS2.00 DFP 07.25.13 ==================================================\
        GenJnlLine."Lead Source Code" := SalesHeader."Lead Source Code";
        // End ===================================================================/
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeUpdateAssocLines', '', false, false)]
    procedure OnBeforeUpdateAssocLines(VAR SalesOrderLine: Record "Sales Line"; VAR IsHandled: Boolean)
    var
        PurchOrderLine: Record "Purchase Line";
    begin
        IF PurchOrderLine.GET(PurchOrderLine."Document Type"::Order, SalesOrderLine."Purchase Order No.", SalesOrderLine."Purch. Order Line No.") THEN BEGIN
            PurchOrderLine."Sales Order Line No." := 0;
            PurchOrderLine.MODIFY;
            SalesOrderLine."Purch. Order Line No." := 0;
            IsHandled := true;
        END;
    end;

    procedure CheckCustomerIfNotDropShip(PurchHeader: Record "Purchase Header")
    var
        PurchLineRecLcl: Record 39;
        PurchasingRecLcl: Record 5721;
        DropShipLineExistsLcl: Boolean;
        NoCustomerNoLcl: Boolean;
        Text50000: label 'ENU=%1 cannot be empty.';
    begin
        CLEAR(DropShipLineExistsLcl);
        CLEAR(NoCustomerNoLcl);
        PurchLineRecLcl.RESET;
        PurchLineRecLcl.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLineRecLcl.SETRANGE("Document No.", PurchHeader."No.");
        PurchLineRecLcl.SETFILTER("Purchasing Code", '<>%1');
        IF PurchLineRecLcl.FINDSET THEN
            REPEAT
                IF PurchasingRecLcl.GET(PurchLineRecLcl."Purchasing Code") THEN BEGIN
                    IF PurchasingRecLcl."Drop Shipment" THEN BEGIN
                        DropShipLineExistsLcl := TRUE;
                    END;
                END;
            UNTIL PurchLineRecLcl.NEXT = 0;
        IF NOT DropShipLineExistsLcl THEN BEGIN
            PurchLineRecLcl.RESET;
            PurchLineRecLcl.SETRANGE("Document Type", PurchHeader."Document Type");
            PurchLineRecLcl.SETRANGE("Document No.", PurchHeader."No.");
            PurchLineRecLcl.SETRANGE(Type, PurchLineRecLcl.Type::Item);
            IF PurchLineRecLcl.FINDSET THEN
                REPEAT
                    IF (PurchLineRecLcl."Customer No." = '') THEN ERROR(Text50000, PurchLineRecLcl.FIELDCAPTION("Customer No."));
                    IF PurchLineRecLcl."Salesperson Code" = '' THEN ERROR(Text50000, PurchLineRecLcl.FIELDCAPTION("Salesperson Code"));
                UNTIL PurchLineRecLcl.NEXT = 0;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostCommitPurchaseDoc', '', false, false)]
    procedure OnBeforePostCommitPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; ModifyHeader: Boolean; var CommitIsSupressed: Boolean; var TempPurchLineGlobal: Record "Purchase Line" temporary)
    var
        Receive: Boolean; //UPG Check 
    begin
        //IMP1.02 Start
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order THEN IF Receive THEN CheckCustomerIfNotDropShip(PurchaseHeader);
        //IMP1.02 End
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnCopySelltoCustomerAddressFieldsFromCustomerOnAfterAssignRespCenter', '', false, false)]
    procedure OnCopySelltoCustomerAddressFieldsFromCustomerOnAfterAssignRespCenter(var SalesHeader: Record "Sales Header"; Customer: Record Customer; CallingFieldNo: Integer)
    begin
        //IMP1.05 Start
        SalesHeader."E-Mail Address" := Customer."Order Confirmation Email";
        //IMP1.05 End
        SalesHeader."Tax Exemption No." := Customer."Tax Exemption No.";
        SalesHeader."Tax Exempt Categories" := Customer."Tax Exempt Categories"; //IMP1.12
        SalesHeader."CertCapture Exemption No." := Customer."CertCapture Exemption No."; //IMP1.13
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification', '', false, false)]
    procedure OnValidateSellToCustomerNoOnBeforeRecallModifyAddressNotification(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    begin
        // ISS2.00 03.02.14 DFP ==================================================================\
        IF SalesHeader."Sell-to Customer No." <> xSalesHeader."Sell-to Customer No." THEN SalesHeader.DefaultTPShipAccount;
        // End ===================================================================================/
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr', '', false, false)]
    procedure OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr(var SalesHeader: Record "Sales Header"; ShipToAddress: Record "Ship-to Address")
    begin
        //IMP1.01 Start
        SalesHeader."E-Mail Address" := ShipToAddress."E-Mail";
        //IMP1.01 End
        SalesHeader."Expiration Date" := ShipToAddress."Tax Exempt Expiration Date"; //IMP1.14
    end;

    [EventSubscriber(ObjectType::Table, database::"sales header", 'OnAfterCopyShipToCustomerAddressFieldsFromCustomer', '', false, false)]
    local procedure OnAfterCopyShipToCustomerAddressFieldsFromCustomer(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer)
    begin
        SalesHeader."Ship-to Name" := '';
        SalesHeader."Ship-to Name 2" := '';
        SalesHeader."Ship-to Address" := '';
        SalesHeader."Ship-to Address 2" := '';
        SalesHeader."Ship-to City" := '';
        SalesHeader."Ship-to Post Code" := '';
        SalesHeader."Ship-to County" := '';
        SalesHeader."Ship-to Country/Region Code" := '';
        SalesHeader."Ship-to Contact" := '';
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnAfterTestNoSeries', '', false, false)]
    procedure OnAfterTestNoSeries(var SalesHeader: Record "Sales Header"; var SalesReceivablesSetup: Record "Sales & Receivables Setup")
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then BEGIN
            IF NOT SalesHeader."Repair Order" THEN
                SalesReceivablesSetup.TESTFIELD("Return Order Nos.")
            ELSE
                SalesReceivablesSetup.TESTFIELD("Repair Return Order Nos.");
        END;
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnAfterGetNoSeriesCode', '', false, false)]
    procedure OnAfterGetNoSeriesCode(var SalesHeader: Record "Sales Header"; SalesReceivablesSetup: Record "Sales & Receivables Setup"; var NoSeriesCode: Code[20])
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then begin
            IF NOT SalesHeader."Repair Order" THEN
                NoSeriesCode := SalesReceivablesSetup."Return Order Nos."
            ELSE
                NoSeriesCode := SalesReceivablesSetup."Repair Return Order Nos.";
        END;
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnAfterUpdateSellToCont', '', false, false)]
    procedure OnAfterUpdateSellToCont(var SalesHeader: Record "Sales Header"; Customer: Record Customer; Contact: Record Contact; HideValidationDialog: Boolean)
    begin
        SalesHeader.UpdateContactLastMod(SalesHeader."Document Type", SalesHeader."Sell-to Contact No."); //IMP1.06
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterInitHeaderDefaults', '', false, false)]
    procedure OnAfterInitHeaderDefaults(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; xSalesLine: Record "Sales Line")
    begin
        //DP
        SalesLine."Sales Order No." := SalesHeader."No.";
        //
        // ISS2.00 11.13.13 DFP =========================================================\
        SalesLine."Salesperson Code" := SalesHeader."Salesperson Code";
        // End ==========================================================================/
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterAssignStdTxtValues', '', false, false)]
    procedure OnAfterAssignStdTxtValues(var SalesLine: Record "Sales Line"; StandardText: Record "Standard Text")
    begin
        SalesLine."Description 2" := StandardText."Description 2"; //IMP1.04
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure OnAfterCopyFromItem(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer)
    begin
        //DP
        SalesLine."Vendor No." := Item."Vendor No.";
        //DP
        //IMP1.01 Start
        SalesLine."Last Direct Cost" := Item."Last Direct Cost";
        //IMP1.01 End
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterAssignResourceValues', '', false, false)]
    local procedure OnAfterAssignResourceValues(var SalesLine: Record "Sales Line"; Resource: Record Resource)
    begin
        //DP
        SalesLine."Vendor No." := Resource."Vendor No.";
        //
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnFindResUnitCostOnAfterInitResCost', '', false, false)]
    local procedure OnFindResUnitCostOnAfterInitResCost(var SalesLine: Record "Sales Line"; var ResourceCost: Record "Resource Cost")
    begin
        // ISS2.00 09.06.13 DFP ===========================================================================\
        ResourceCost."Minimum Quantity" := SalesLine."Quantity (Base)";
        // End ============================================================================================/
    end;

    [EventSubscriber(ObjectType::table, database::"Sales Line", 'OnAfterUpdateAmountsDone', '', false, false)]
    local procedure OnAfterUpdateAmountsDone(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin
        // ISS2.00 01.08.14 DFP ========================================\
        SalesLine.UpdateProfit;
        // End =========================================================/
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterFindResUnitCost', '', false, false)]
    procedure OnAfterFindResUnitCost(var SalesLine: Record "Sales Line"; var ResourceCost: Record "Resource Cost")
    begin
        // ISS2.00 09.06.13 DFP ===========================================================================\
        ResourceCost."Minimum Quantity" := SalesLine."Quantity (Base)";
        // End ============================================================================================/
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnBeforeCheckAssocPurchOrder', '', false, false)]
    procedure OnBeforeCheckAssocPurchOrder(var SalesLine: Record "Sales Line"; TheFieldCaption: Text[250]; var IsHandled: Boolean; xSalesLine: Record "Sales Line")
    begin
        //IMP1.02 Start
        //Custoized Code Commented
        // ISS2.00 01.24.14 DFP ===========================================================\
        IF NOT QtyValidateSuspend THEN SalesLine.ChangePOQtyStart;
        IsHandled := true;
    end;

    PROCEDURE SuspendQuantiyValidate(Suspend: Boolean);
    BEGIN
        QtyValidateSuspend := Suspend;
    END;

    [EventSubscriber(ObjectType::Table, database::"Purchase Header", 'OnAfterTestNoSeries', '', false, false)]
    procedure OnAfterTestNoSeriesPurch(var PurchHeader: Record "Purchase Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then BEGIN
            PurchSetup.Get();
            IF PurchHeader."PO Sample" THEN
                PurchSetup.TESTFIELD("Sample Order Nos.")
            ELSE
                IF PurchHeader."Demo Order" THEN
                    PurchSetup.TESTFIELD("Demo Order Nos.")
                ELSE
                    IF PurchHeader."Project Order" THEN
                        PurchSetup.TESTFIELD("Project Order Nos.")
                    ELSE
                        PurchSetup.TESTFIELD("Order Nos.");
        END;
    end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Header", 'OnAfterGetNoSeriesCode', '', false, false)]
    procedure OnAfterGetNoSeriesCodePurch(var PurchHeader: Record "Purchase Header"; PurchSetup: Record "Purchases & Payables Setup"; var NoSeriesCode: Code[20])
    var
    begin
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then BEGIN
            IF PurchHeader."PO Sample" THEN
                NoSeriesCode := PurchSetup."Sample Order Nos."
            ELSE
                IF PurchHeader."Demo Order" THEN
                    NoSeriesCode := PurchSetup."Demo Order Nos."
                ELSE
                    IF PurchHeader."Project Order" THEN
                        NoSeriesCode := PurchSetup."Project Order Nos."
                    ELSE
                        NoSeriesCode := PurchSetup."Order Nos.";
        END;
    end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Line", 'OnAfterAssignStdTxtValues', '', false, false)]
    local procedure OnAfterAssignStdTxtValuesPurc(var PurchLine: Record "Purchase Line"; StandardText: Record "Standard Text")
    begin
        PurchLine."Description 2" := StandardText."Description 2"; //IMP1.04
    end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Line", 'OnValidateQuantityOnBeforeDropShptCheck', '', false, false)]
    procedure OnValidateQuantityOnBeforeDropShptCheck(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        SalesLineGRec: Record "Sales Line";
        Text50000: label 'Update interrupted to respect the warning.';
        Text50001: label 'This is a drop shipment line and quantity on sales order line will also be changed. Do you want to proceed?';
        Text50002: label 'you cannot change to the quantity which is less than the shipped quantity on sales line.';
    begin
        IF PurchaseLine."Drop Shipment" AND (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Invoice) THEN BEGIN
            IF NOT CONFIRM(Text50001, FALSE) THEN
                ERROR(Text50000)
            ELSE BEGIN
                if SalesLineGRec.GET(SalesLine."Document Type"::Order, PurchaseLine."Sales Order No.", PurchaseLine."Sales Order Line No.") then begin //IMP1.19
                    SalesLineGRec.SuspendStatusCheck(TRUE);
                    SuspendQuantiyValidate(TRUE);
                    IF ((PurchaseLine.Quantity < SalesLineGRec.Quantity) AND (PurchaseLine.Quantity < SalesLineGRec."Quantity Shipped")) THEN ERROR(Text50002);
                    SalesLineGRec.VALIDATE(Quantity, PurchaseLine.Quantity);
                    SalesLineGRec.MODIFY;
                end;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, database::"Segment Line", 'OnAfterInitLine', '', false, false)]
    procedure OnAfterInitLineInitiated(var SegmentLine: Record "Segment Line"; SegmentHeader: Record "Segment Header")
    begin
        SegmentLine."Initiated By" := SegmentLine."Initiated By"::Us; //IMP1.01
    end;

    [EventSubscriber(ObjectType::Table, database::"Segment Line", 'OnBeforeStartWizard', '', false, false)]
    procedure OnBeforeStartWizard(var SegmentLine: Record "Segment Line"; var IsHandled: Boolean)
    begin
        //IMP1.01 Start
        SegmentLine."Initiated By" := SegmentLine."Initiated By"::Us;
        //IMP1.01 End
    end;

    [EventSubscriber(ObjectType::Table, database::"Service Header", 'OnAfterCopyCustomerFields', '', false, false)]
    procedure OnAfterCopyCustomerFieldsTax(var ServiceHeader: Record "Service Header"; Customer: Record Customer)
    var
        ShiptoAddr: Record 222;
    begin
        if Customer."Ship-to Code" <> '' then begin //B2BUPG1.0
            ShiptoAddr.GET(ServiceHeader."Customer No.", Customer."Ship-to Code");
            ServiceHeader."Tax Exempt Categories" := ShiptoAddr."Tax Exempt Categories"; //IMP1.03
            ServiceHeader."CertCapture Exemption No." := ShiptoAddr."CertCapture Exemption No."; //IMP1.04
            ServiceHeader."Customer Payment Terms Code" := Customer."Payment Terms Code"; //IMP1.02
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Service Item", 'OnAfterAssignItemValues', '', false, false)]
    procedure OnAfterAssignItemValues(var ServiceItem: Record "Service Item"; var xServiceItem: Record "Service Item"; Item: Record Item; CurrFieldNo: Integer)
    begin
        ServiceItem."Description 2" := Item."Description 2"; //IMP1.01
    end;

    [EventSubscriber(ObjectType::Table, database::Customer, 'OnBeforeCheckBlockedCust', '', false, false)]
    procedure OnBeforeCheckBlockedCust(Customer: Record Customer; Source: Option Journal,Document; DocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order"; Shipment: Boolean; Transaction: Boolean; var IsHandled: Boolean)
    begin
        if Source = Source::Document then begin
            IF ((Customer.Blocked = Customer.Blocked::All) OR ((Customer.Blocked = Customer.Blocked::Invoice) AND (DocType IN [DocType::Quote, DocType::Order, DocType::Invoice, DocType::"Blanket Order"])) OR // ISS2.00 12.06.13 DFP ====================================================================================\
                                                                                                                                                                                                                //((Blocked = Blocked::Ship) AND (DocType IN [DocType::Quote,DocType::Order,DocType::"Blanket Order"]) AND
                                                                                                                                                                                                                // (NOT Transaction)) OR
                                                                                                                                                                                                                //((Blocked = Blocked::Ship) AND (DocType IN [DocType::Quote,DocType::Order,DocType::Invoice,DocType::"Blanket Order"]) AND
                                                                                                                                                                                                                // Allow Quotes on Ship Block
            ((Customer.Blocked = Customer.Blocked::Ship) AND (DocType IN [DocType::Order, DocType::"Blanket Order"]) AND (NOT Transaction)) OR ((Customer.Blocked = Customer.Blocked::Ship) AND (DocType IN [DocType::Order, DocType::Invoice, DocType::"Blanket Order"]) AND // End =====================================================================================================/
 Shipment AND Transaction)) THEN
                Customer.CustBlockedErrorMessage(Customer, Transaction);
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterValidateLineDiscountPercent', '', false, false)]
    procedure OnAfterValidateLineDiscountPercentSal(var SalesLine: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        // ISS2.00 01.24.14 DFP ========================================\
        SalesLine.UpdateProfit;
        // End ==
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnBeforeUpdateQuantityFromUOMCode', '', false, false)]
    procedure OnBeforeUpdateQuantityFromUOMCode(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        // ISS2.00 09.06.13 DFP ===========================================================================\
        SalesLine.GetBestUnitCost;
        // End ============================================================================================/
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnValidateQuantityOnBeforeResetAmounts', '', false, false)]
    procedure OnValidateQuantityOnBeforeResetAmounts(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        // ISS2.00 09.06.13 DFP ===========================================================================\
        IF SalesLine.Type = SalesLine.Type::Resource THEN BEGIN
            SalesLine.UpdateUnitPrice(SalesLine.FIELDNO(Quantity));
            SalesLine.FindResUnitCost;
        END;
        // End ============================================================================================/
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnCheckAssocOrderLinesOnBeforeCheckOrderLine', '', false, false)]
    procedure OnCheckAssocOrderLinesOnBeforeCheckOrderLine(PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; SalesOrderLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeInsertPostedHeaders', '', false, false)]
    procedure OnBeforeInsertPostedHeaders(var PurchaseHeader: Record "Purchase Header"; var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        Resource: Record Resource;
        ResSetup: Record "Resources Setup";
        PurchLine: Record "Purchase Line";
        ISSText001: label 'Resource Lines must be attached to a Sales Order.\\Resource %1 on Line No. %2 has no Sales Order No.';
    begin
        // ISS2.00 01.07.14 DFP ======================================================\
        ResSetup.GET;
        IF ResSetup."Require Sales Purch. Doc. Link" AND (PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice]) THEN BEGIN
            // Require Resources to be linked to a SO
            IF PurchaseHeader.Invoice OR PurchaseHeader.Ship OR PurchaseHeader.Receive THEN BEGIN
                PurchLine.RESET;
                PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchLine.SETFILTER(Quantity, '<>0');
                PurchLine.SETRANGE(Type, PurchLine.Type::Resource);
                PurchLine.SETFILTER("Sales Order No.", '%1', '');
                IF PurchLine.FINDSET(FALSE) THEN
                    REPEAT
                        Resource.GET(PurchLine."No.");
                        IF Resource.Type = Resource.Type::"Item (Custom)" THEN // Resource Lines must be attached to a Sales Order.\\Resource %1 on Line No. %2 has no Sales Order No.
                            ERROR(ISSText001, PurchLine."No.", PurchLine."Line No.");
                    UNTIL PurchLine.NEXT = 0;
            END;
        END;
        // End =======================================================================/
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Resource-Find Cost", 'OnBeforeFindResUnitCost', '', false, false)]
    procedure OnBeforeFindResUnitCost(var ResourceCost: Record "Resource Cost"; var IsHandled: Boolean)
    var
        Res: record resource;
    begin
        IsHandled := true;
        //IF GET(Type::Resource,Code,"Work Type Code") THEN
        //  EXIT;
        ResourceCost.SETRANGE(Type, ResourceCost.Type::Resource);
        ResourceCost.SETFILTER(Code, '%1', ResourceCost.Code);
        ResourceCost.SETFILTER("Work Type Code", '%1', ResourceCost."Work Type Code");
        ResourceCost.SETFILTER("Minimum Quantity", '<=' + FORMAT(ResourceCost."Minimum Quantity"));
        IF ResourceCost.FINDLAST THEN EXIT;
        Res.GET(ResourceCost.Code);
        //IF GET(Type::"Group(Resource)",Res."Resource Group No.","Work Type Code") THEN
        //  EXIT;
        ResourceCost.SETRANGE(Type, ResourceCost.Type::"Group(Resource)");
        ResourceCost.SETFILTER(Code, '%1', Res."Resource Group No.");
        IF ResourceCost.FINDLAST THEN EXIT;
        //IF GET(Type::All,'',"Work Type Code") THEN
        //  EXIT;
        ResourceCost.SETRANGE(Type, ResourceCost.Type::All);
        ResourceCost.SETFILTER(Code, '%1', '');
        IF ResourceCost.FINDLAST THEN EXIT;
        ResourceCost.INIT;
        ResourceCost.Code := Res."No.";
        ResourceCost."Direct Unit Cost" := Res."Direct Unit Cost";
        ResourceCost."Unit Cost" := Res."Unit Cost";
        // End ============================================================================================/
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Resource-Find Price", 'OnBeforeFindResPrice', '', false, false)]
    procedure OnBeforeFindResPrice(var ResourcePrice: Record "Resource Price"; var IsHandled: Boolean; var Result: Boolean; var ResourcePrice2: Record "Resource Price")
    var
        ResPrice: Record 201;
        ResPrice2: Record 201;
        Res: Record 156;
    begin
        IsHandled := true;
        Result := true;
        //IF ResPrice2.GET(Type::Resource,Code,"Work Type Code","Currency Code") THEN
        //  EXIT(TRUE);
        ResPrice2.SETRANGE(Type, ResPrice2.Type::Resource);
        ResPrice2.SETFILTER(Code, '%1', ResourcePrice.Code);
        ResPrice2.SETFILTER("Work Type Code", '%1', ResourcePrice."Work Type Code");
        ResPrice2.SETFILTER("Currency Code", '%1', ResourcePrice."Currency Code");
        ResPrice2.SETFILTER("Minimum Quantity", '<=' + FORMAT(ResourcePrice."Minimum Quantity"));
        //IF ResPrice2.FINDLAST THEN
        // EXIT(true);//UPG No EventReturnValue
        //IF ResPrice2.GET(Type::Resource,Code,"Work Type Code",'') THEN
        //  EXIT(TRUE);
        ResPrice2.SETFILTER("Currency Code", '%1', '');
        IF ResPrice2.FINDLAST THEN //EXIT(true);//UPG No EventReturnValue
            Res.GET(ResourcePrice.Code);
        //IF ResPrice2.GET(Type::"Group(Resource)",Res."Resource Group No.","Work Type Code","Currency Code") THEN
        //  EXIT(TRUE);
        ResPrice2.SETRANGE(Type, ResPrice2.Type::"Group(Resource)");
        ResPrice2.SETFILTER(Code, '%1', Res."Resource Group No.");
        ResPrice2.SETFILTER("Currency Code", '%1', ResourcePrice."Currency Code");
        //IF ResPrice2.FINDLAST THEN
        //EXIT(true);//UPG No EventReturnValue
        //IF ResPrice2.GET(Type::"Group(Resource)",Res."Resource Group No.","Work Type Code",'') THEN
        //  EXIT(TRUE);
        ResPrice2.SETFILTER("Currency Code", '%1', '');
        //IF ResPrice2.FINDLAST THEN
        //EXIT(true);//UPG No EventReturnValue
        //IF ResPrice2.GET(Type::All,'',"Work Type Code","Currency Code") THEN
        //  EXIT(TRUE);
        ResPrice2.SETRANGE(Type, ResPrice2.Type::All);
        ResPrice2.SETFILTER(Code, '%1', '');
        ResPrice2.SETFILTER("Currency Code", '%1', ResourcePrice."Currency Code");
        //IF ResPrice2.FINDLAST THEN
        //EXIT(true);//UPG No EventReturnValue
        //IF ResPrice2.GET(Type::All,'',"Work Type Code",'') THEN
        //  EXIT(TRUE);
        ResPrice2.SETFILTER("Currency Code", '%1', '');
        //IF ResPrice2.FINDLAST THEN
        //EXIT(true);//UPG No EventReturnValue
        // End ============================================================================================/
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeCheckCustomerCreated', '', false, false)]
    procedure OnBeforeCheckCustomerCreated(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        SalesHeader.CheckForCrLimitWarning;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnCodeOnAfterCheckCustomerCreated', '', false, false)]
    procedure OnCodeOnAfterCheckCustomerCreated(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    begin
        SalesHeader.TESTFIELD("Ship-to Code"); //IMP1.02
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReopenSalesDoc', '', false, false)]
    procedure OnAfterReopenSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        SalesStatMgt: Codeunit 50001;
    begin
        // ISS2.00 06.22.13 DFP ============================================================\
        // Remove Sales Statistic Entries
        SalesStatMgt.UpdateStatSalesDoc(SalesHeader, TRUE);
        // End =============================================================================/
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', false, false)]
    procedure OnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    begin
        //IMP1.01 Start
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order THEN CheckCustomerIfNotDropShip(PurchaseHeader);
        //IMP1.01 End
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnBeforeGetUnitCost', '', false, false)]
    procedure OnBeforeGetUnitCost(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        SavePONo: code[20];
        item: Record Item;
        SKU: Record "Stockkeeping Unit";
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        IF NOT QtyValidateSuspend THEN //IMP1.03
            IF SavePONo = '' THEN IsHandled := true;
        if IsHandled then begin
            SalesLine.TESTFIELD(Type, SalesLine.Type::Item);
            SalesLine.TESTFIELD("No.");
            SalesLine.GetItem(item);
            SalesLine."Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item, SalesLine."Unit of Measure Code");
            IF NOT QtyValidateSuspend THEN BEGIN //IMP1.03
                IF SavePONo = '' THEN BEGIN
                    IF SalesLine.GetSKU THEN
                        SalesLine.VALIDATE("Unit Cost (LCY)", SKU."Unit Cost" * SalesLine."Qty. per Unit of Measure")
                    ELSE
                        SalesLine.VALIDATE("Unit Cost (LCY)", Item."Unit Cost" * SalesLine."Qty. per Unit of Measure");
                END; //IMP1.03
            END; //IMP1.03
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    procedure OnAfterInitCustLedgEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        // ISS2.00 DFP 07.25.13 ===========================================================\
        CustLedgerEntry."Lead Source Code" := GenJournalLine."Lead Source Code";
        // End ============================================================================/
    end;

    [EventSubscriber(ObjectType::Page, 46, 'OnBeforeOpenPurchOrderForm', '', false, false)]
    local procedure OnBeforeOpenPurchOrderForm(SalesOrderLine: Record "Sales Line"; var PageEditable: Boolean; var IsHandled: Boolean)
    begin
        PageEditable := true;
    end;
    //IMP1.19 >>
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeCheckMandatoryHeaderFields', '', false, false)]
    local procedure OverrideOnHoldOnPost(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
        if (SalesHeader."On Hold" <> '') and (SalesHeader."Override Credit") then begin
            SalesHeader.TestField("Document Type");
            SalesHeader.TestField("Sell-to Customer No.");
            SalesHeader.TestField("Bill-to Customer No.");
            SalesHeader.TestField("Posting Date");
            SalesHeader.TestField("Document Date");
        end;
    end;
    //IMP1.19 <<
    //IMP1.10 >>
    [EventSubscriber(ObjectType::Page, 54, 'OnBeforeOpenSalesOrderForm', '', false, false)]
    local procedure OnBeforeOpenSalesOrderForm(var PurchaseLine: Record "Purchase Line"; var SalesHeader: Record "Sales Header"; var SalesOrder: Page "Sales Order"; var IsHandled: Boolean)
    begin
        PurchaseLine.TestField("Sales Order No.");
        SalesHeader.SetRange("No.", PurchaseLine."Sales Order No.");
        SalesOrder.SetTableView(SalesHeader);
        SalesOrder.Editable := true;
        SalesOrder.Run;
        IsHandled := true;
    end;
    //IMP1.10 <<
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust-Check Cr. Limit", 'OnBeforeSalesHeaderCheck', '', false, false)]
    procedure OnBeforeSalesHeaderCheck(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean);
    var
        CustCheckCreditLimit: Page "Check Credit Limit";
        AdditionalContextId: Guid;
        InstructionMgt: Codeunit "Instruction Mgt.";
    //IsHandled: Boolean;
    begin
        //if CustCheckCreditLimit.SalesHeaderShowWarningAndGetCause(SalesHeader, AdditionalContextId) then begin
        //IMP1.01 Start
        CustCheckCreditLimit.SalesHeaderCheckWarning(SalesHeader);
        SalesHeader."On Hold" := CustCheckCreditLimit.ReturnCreditLimitOnHoldCode; //IMP1.01
                                                                                   //IMP1.01 End
                                                                                   //End;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidatePurchasingCode', '', false, false)]
    local procedure SkipResourceValidation(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        PurchasingCode: Record Purchasing;
        ShippingAgentServices: Record "Shipping Agent Services";
        InvtSetup: Record "Inventory Setup";
        Location: Record Location;
        SalesHeader: Record "Sales Header";
        SalesLineReserve: Codeunit "Sales Line-Reserve";
        SalesLineCompletelyShippedErr: Label 'You cannot change the purchasing code for a sales line that has been completely shipped.';
    begin
        if (SalesLine."Document Type" <> SalesLine."Document Type"::Order) or (SalesLine.Type = SalesLine.Type::Item) then exit;
        IsHandled := true;
        SalesLine.TestStatusOpen();
        SalesLine.CheckAssocPurchOrder(SalesLine.FieldCaption("Purchasing Code"));
        if PurchasingCode.Get(SalesLine."Purchasing Code") then begin
            SalesLine."Drop Shipment" := PurchasingCode."Drop Shipment";
            SalesLine."Special Order" := PurchasingCode."Special Order";
            IsHandled := false;
            if not IsHandled then
                if SalesLine."Drop Shipment" or SalesLine."Special Order" then begin
                    SalesLine.TestField("Qty. to Asm. to Order (Base)", 0);
                    SalesLine.CalcFields("Reserved Qty. (Base)");
                    SalesLine.TestField("Reserved Qty. (Base)", 0);
                    SalesLineReserve.VerifyChange(SalesLine, SalesLine);
                    if (SalesLine.Quantity <> 0) and (SalesLine.Quantity = SalesLine."Quantity Shipped") then Error(SalesLineCompletelyShippedErr);
                    SalesLine.Reserve := SalesLine.Reserve::Never;
                    if SalesLine."Drop Shipment" then begin
                        Evaluate(SalesLine."Outbound Whse. Handling Time", '<0D>');
                        Evaluate(SalesLine."Shipping Time", '<0D>');
                        SalesLine.UpdateDates();
                        SalesLine."Bin Code" := '';
                    end;
                end; //else
                     //SetReserveWithoutPurchasingCode(SalesLine);
        end
        else begin
            SalesLine."Drop Shipment" := false;
            SalesLine."Special Order" := false;
            //SetReserveWithoutPurchasingCode(SalesLine);
        end;
        if (SalesLine."Purchasing Code" <> SalesLine."Purchasing Code") and (not SalesLine."Drop Shipment") and (SalesLine."Drop Shipment" <> SalesLine."Drop Shipment") then begin
            if SalesLine."Location Code" = '' then begin
                if InvtSetup.Get() then SalesLine."Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
            end
            else
                if Location.Get(SalesLine."Location Code") then SalesLine."Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
            if ShippingAgentServices.Get(SalesLine."Shipping Agent Code", SalesLine."Shipping Agent Service Code") then
                SalesLine."Shipping Time" := ShippingAgentServices."Shipping Time"
            else begin
                SalesLine.GetSalesHeader();
                SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
                SalesLine."Shipping Time" := SalesHeader."Shipping Time";
            end;
            SalesLine.UpdateDates();
        end;
        IsHandled := true;
    end;

    procedure SetReserveWithoutPurchasingCode(var SalesLine: Record "Sales Line")
    var
        Item: Record Item;
        SalesHeader: Record "Sales Header";
    begin
        SalesLine.GetItem(Item);
        if Item.Reserve = Item.Reserve::Optional then begin
            SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
            SalesLine.Reserve := SalesHeader.Reserve;
        end
        else
            SalesLine.Reserve := Item.Reserve;
    end;

    procedure UpdateSalesInvLineShipToCode()
    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvHead: Record "Sales Invoice Header";
    begin
        SalesInvLine.Reset();
        SalesInvLine.SetFilter("Document No.", '<>%1', '');
        SalesInvLine.SetRange("Ship-to Code", '');
        if SalesInvLine.FindSet() then begin
            repeat
                SalesInvLine.SecurityFiltering := SalesInvLine.SecurityFiltering::Ignored;
                if SalesInvHead.Get(SalesInvLine."Document No.") then begin
                    SalesInvHead.SecurityFiltering := SalesInvHead.SecurityFiltering::Ignored;
                    SalesInvLine."Ship-to Code" := SalesInvHead."Ship-to Code";
                    SalesInvLine.Modify();
                end;
            until SalesInvLine.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust-Check Cr. Limit", 'OnBeforeSalesLineCheck', '', false, false)]
    procedure OnBeforeSalesLineCheck(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        AdditionalContextId: Guid;
        custcheCreditLimt: Codeunit "Cust-Check Cr. Limit";
        CustCheckCreditLimit: Page "Check Credit Limit";
        InstructionMgt: Codeunit "Instruction Mgt.";
        SalesHeadRecGbl: Record "Sales Header";
        CrLimitOnHoldCodeVarGbl: Code[3];
    begin
        //if CustCheckCreditLimit.SalesLineShowWarningAndGetCause(SalesLine, AdditionalContextId) then begin
        //IMP1.01 Start
        CustCheckCreditLimit.SalesLineCheckWarning(SalesLine);
        CrLimitOnHoldCodeVarGbl := CustCheckCreditLimit.ReturnCreditLimitOnHoldCode;
        SalesHeadRecGbl.RESET;
        IF SalesHeadRecGbl.GET(SalesLine."Document Type", SalesLine."Document No.") THEN BEGIN
            SalesHeadRecGbl."On Hold" := CrLimitOnHoldCodeVarGbl;
            SalesHeadRecGbl.MODIFY;
        END;
        //IMP1.01 End
        //end;
    end;
    /*
        
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnBeforeFindSalesLinePrice', '', false, false)]
    procedure OnBeforeFindSalesLinePrice(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; CalledByFieldNo: Integer; var IsHandled: Boolean)
    var
        SalesPriceCalMgt: Codeunit "Sales Price Calc. Mgt.";
        PricesInCurrency: Boolean;
        Item: Record Item;
        TempSalesPrice: Record "Sales Price" temporary;
        ResPrice: Record "Resource Price";
    begin
        WITH SalesLine DO BEGIN
            SalesPriceCalMgt.SetCurrency(
              SalesHeader."Currency Code", SalesHeader."Currency Factor", SalesPriceCalMgt.SalesHeaderExchDate(SalesHeader));
            SalesPriceCalMgt.SetVAT(SalesHeader."Prices Including VAT", "VAT %", "VAT Calculation Type", "VAT Bus. Posting Group");
            SalesPriceCalMgt.SetUoM(ABS(Quantity), "Qty. per Unit of Measure");
            SalesPriceCalMgt.SetLineDisc("Line Discount %", "Allow Line Disc.", "Allow Invoice Disc.");

            TESTFIELD("Qty. per Unit of Measure");
            IF PricesInCurrency THEN
                SalesHeader.TESTFIELD("Currency Factor");

            CASE Type OF
                Type::Item:
                    BEGIN
                        Item.GET("No.");
                        SalesPriceCalMgt.SalesLinePriceExists(SalesHeader, SalesLine, FALSE);
                        CalcBestUnitPrice(TempSalesPrice);
                        OnAfterFindSalesLineItemPrice(SalesLine, TempSalesPrice, FoundSalesPrice);
                        IF FoundSalesPrice OR
                           NOT ((CalledByFieldNo = FIELDNO(Quantity)) OR
                                (CalledByFieldNo = FIELDNO("Variant Code")))
                        THEN BEGIN
                            "Allow Line Disc." := TempSalesPrice."Allow Line Disc.";
                            "Allow Invoice Disc." := TempSalesPrice."Allow Invoice Disc.";
                            "Unit Price" := TempSalesPrice."Unit Price";
                        END;
                        IF NOT "Allow Line Disc." THEN
                            "Line Discount %" := 0;
                    END;
                Type::Resource:
                    BEGIN
                        SalesPriceCalMgt.SetResPrice("No.", "Work Type Code", "Currency Code");
                        CODEUNIT.RUN(CODEUNIT::"Resource-Find Price", ResPrice);
                        OnAfterFindSalesLineResPrice(SalesLine, ResPrice);
                        SalesPriceCalMgt.ConvertPriceToVAT(FALSE, '', '', ResPrice."Unit Price");
                        SalesPriceCalMgt.ConvertPriceLCYToFCY(ResPrice."Currency Code", ResPrice."Unit Price");
                        "Unit Price" := ResPrice."Unit Price" * "Qty. per Unit of Measure";
                    END;
            END;
            OnAfterFindSalesLinePrice(SalesLine, SalesHeader, TempSalesPrice, ResPrice, CalledByFieldNo);
        END;

    end;
*/
    //B2BUPG>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchInvLineInsert', '', false, false)]
    local procedure OnAfterPurchInvLineInsert(var PurchInvLine: Record "Purch. Inv. Line"; PurchLine: Record "Purchase Line")
    begin
        PurchInvLine."Sales Order No." := PurchLine."Sales Order No.";
        PurchInvLine.Modify();
    end;
    //B2BUPG<<
    [EventSubscriber(ObjectType::Report, Report::"Sales Order", 'OnAfterCalculateSalesTax', '', true, true)]
    local procedure "Sales Order_OnAfterCalculateSalesTax"(var SalesHeaderParm: Record "Sales Header"; var SalesLineParm: Record "Sales Line"; var TaxAmount: Decimal; var TaxLiable: Decimal)
    begin
        if (SalesLineParm.Type = SalesLineParm.Type::Item) and (SalesLineParm."Item Reference No." <> '') then SalesLineParm."No." := SalesLineParm."Item Reference No.";
    end;

    var
        AutoConfirm: Boolean;
        workdateuse: Boolean;
        SalesLine: Record "Sales Line";
        QtyValidateSuspend: Boolean;
}
