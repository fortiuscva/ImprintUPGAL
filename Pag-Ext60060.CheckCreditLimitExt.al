pageextension 60060 "CheckCreditLimitExt" extends "Check Credit Limit"
{
    // version NAVW114.03,IMP1.01
    var
        DueDateRangeVarLcl: Date;
        DueDateExpVarLcl: Text;
        CustNo: Code[20];
        SalesSetupRecLcl: Record "Sales & Receivables Setup";
        MaxDateVarGbl: Date;
        Cust2: Record Customer;
        CrLimitOnHoldCodeVarGbl: Code[3];
        ExecutedFromWarningVarGbl: Boolean;
        NewOrderAmountLCY: Decimal;
        OldOrderAmountLCY: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        SalesHeader: Record "Sales Header";
        SalesSetup: Record "Sales & Receivables Setup";
        CheckCreditLimit: Page "Check Credit Limit";

    procedure ReturnCreditLimitOnHoldCode(): Code[3];
    begin
        exit(CrLimitOnHoldCodeVarGbl);
    end;

    procedure SalesHeaderCheckWarning(SalesHeader: Record "Sales Header");
    begin
        // Used when additional lines are inserted
        if SalesHeader."Currency Code" = '' then
            NewOrderAmountLCY := SalesHeader."Amount Including VAT"
        else
            NewOrderAmountLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate, SalesHeader."Currency Code", SalesHeader."Amount Including VAT", SalesHeader."Currency Factor"));
        if not (SalesHeader."Document Type" in [SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Return Order"]) then NewOrderAmountLCY := NewOrderAmountLCY + SalesLineAmount1(SalesHeader."Document Type", SalesHeader."No.");
        CheckWarning(SalesHeader."Bill-to Customer No.", NewOrderAmountLCY, 0, true);
    end;

    procedure SalesLineCheckWarning(SalesLine: Record "Sales Line");
    begin
        SalesSetup.Get;
        if (SalesHeader."Document Type" <> SalesLine."Document Type") or (SalesHeader."No." <> SalesLine."Document No.") then SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        NewOrderAmountLCY := SalesLine."Outstanding Amount (LCY)" + SalesLine."Shipped Not Invoiced (LCY)";
        if SalesLine.Find then
            OldOrderAmountLCY := SalesLine."Outstanding Amount (LCY)" + SalesLine."Shipped Not Invoiced (LCY)"
        else
            OldOrderAmountLCY := 0;
        if SalesLine."Document Type" <> SalesLine."Document Type"::Order then begin
            NewOrderAmountLCY := NewOrderAmountLCY - OldOrderAmountLCY + SalesLineAmount1(SalesLine."Document Type", SalesLine."Document No.");
            OldOrderAmountLCY := 0;
        end;
        CheckWarning(SalesHeader."Bill-to Customer No.", NewOrderAmountLCY, OldOrderAmountLCY, true)
    end;

    local procedure CheckWarning(NewCustNo: Code[20]; NewOrderAmountLCY2: Decimal; OldOrderAmountLCY2: Decimal; CheckOverDueBalance: Boolean): Boolean;
    var
        ExitValue: Integer;
    begin
        if NewCustNo = '' then exit;
        CustNo := NewCustNo;
        NewOrderAmountLCY := NewOrderAmountLCY2;
        OldOrderAmountLCY := OldOrderAmountLCY2;
        Rec.Get(CustNo);
        Rec.SetRange("No.", Rec."No.");
        Cust2.Copy(Rec);
        CalcCreditLimitLCY1;
        if (CustCreditAmountLCY > Rec."Credit Limit (LCY)") and (Rec."Credit Limit (LCY)" <> 0) then ExitValue := 1;
        ExecutedFromWarningVarGbl := true;
        CalcOverdueBalanceLCY1;
        ExecutedFromWarningVarGbl := false;
        if Rec."Balance Due (LCY)" > 0 then ExitValue := ExitValue + 2;
        if ExitValue > 0 then begin
            case ExitValue of
                1:
                    CrLimitOnHoldCodeVarGbl := 'CLE'; //Credit Limit Exceeded
                2:
                    CrLimitOnHoldCodeVarGbl := 'OVD'; //Over Due
                3:
                    CrLimitOnHoldCodeVarGbl := 'CLD'; // Credit Limit and Overdue
            end;
        end
        else
            CrLimitOnHoldCodeVarGbl := '';
    end;

    local procedure SalesLineAmount1(DocType: Integer; DocNo: Code[20]): Decimal
    var
        SalesLine: Record 37;
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", DocType);
        SalesLine.SETRANGE("Document No.", DocNo);
        SalesLine.CALCSUMS("Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)");
        EXIT(SalesLine."Outstanding Amount (LCY)" + SalesLine."Shipped Not Invoiced (LCY)");
    end;

    local procedure CalcCreditLimitLCY1()
    var
    begin
        IF Rec.GETFILTER("Date Filter") = '' THEN Rec.SETFILTER("Date Filter", '..%1', WORKDATE);
        Rec.CALCFIELDS("Balance (LCY)", "Shipped Not Invoiced (LCY)", "Serv Shipped Not Invoiced(LCY)");
        CalcReturnAmounts1(OutstandingRetOrdersLCY, RcdNotInvdRetOrdersLCY);
        OrderAmountTotalLCY := CalcTotalOutstandingAmt1 - OutstandingRetOrdersLCY + DeltaAmount;
        ShippedRetRcdNotIndLCY := Rec."Shipped Not Invoiced (LCY)" + Rec."Serv Shipped Not Invoiced(LCY)" - RcdNotInvdRetOrdersLCY;
        IF Rec."No." = CustNo THEN
            OrderAmountThisOrderLCY := NewOrderAmountLCY
        ELSE
            OrderAmountThisOrderLCY := 0;
        CustCreditAmountLCY := Rec."Balance (LCY)" + Rec."Shipped Not Invoiced (LCY)" + Rec."Serv Shipped Not Invoiced(LCY)" - RcdNotInvdRetOrdersLCY + OrderAmountTotalLCY - Rec.GetInvoicedPrepmtAmountLCY;
    end;

    local procedure CalcReturnAmounts1(VAR OutstandingRetOrdersLCY2: Decimal; VAR RcdNotInvdRetOrdersLCY2: Decimal)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", "Currency Code");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order");
        SalesLine.SETRANGE("Bill-to Customer No.", Rec."No.");
        SalesLine.CALCSUMS("Outstanding Amount (LCY)", "Return Rcd. Not Invd. (LCY)");
        OutstandingRetOrdersLCY2 := SalesLine."Outstanding Amount (LCY)";
        RcdNotInvdRetOrdersLCY2 := SalesLine."Return Rcd. Not Invd. (LCY)";
    end;

    local procedure CalcTotalOutstandingAmt1(): Decimal
    var
        SalesLine: Record 37;
        SalesOutstandingAmountFromShipment: Decimal;
        ServOutstandingAmountFromShipment: Decimal;
    begin
        Rec.CALCFIELDS("Outstanding Invoices (LCY)", "Outstanding Orders (LCY)", "Outstanding Serv.Invoices(LCY)", "Outstanding Serv. Orders (LCY)");
        SalesOutstandingAmountFromShipment := SalesLine.OutstandingInvoiceAmountFromShipment(Rec."No.");
        ServOutstandingAmountFromShipment := ServLine.OutstandingInvoiceAmountFromShipment(Rec."No.");
        EXIT(Rec."Outstanding Orders (LCY)" + Rec."Outstanding Invoices (LCY)" + Rec."Outstanding Serv. Orders (LCY)" + Rec."Outstanding Serv.Invoices(LCY)" - SalesOutstandingAmountFromShipment - ServOutstandingAmountFromShipment);
    end;

    local procedure CalcOverdueBalanceLCY1()
    var
        myInt: Integer;
    begin
        IF Rec.GETFILTER("Date Filter") = '' THEN Rec.SETFILTER("Date Filter", '..%1', WORKDATE);
        Rec.CALCFIELDS("Balance Due (LCY)");
    end;

    var
        ServLine: Record "Service Line";
        OrderAmountTotalLCY: Decimal;
        ShippedRetRcdNotIndLCY: Decimal;
        OutstandingRetOrdersLCY: Decimal;
        RcdNotInvdRetOrdersLCY: Decimal;
        DeltaAmount: Decimal;
        OrderAmountThisOrderLCY: Decimal;
        CustCreditAmountLCY: Decimal;
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
}
