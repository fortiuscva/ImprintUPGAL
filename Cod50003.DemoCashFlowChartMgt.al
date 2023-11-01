codeunit 50003 "Demo Cash Flow Chart Mgt."
{
    trigger OnRun()
    begin
    end;
    var TextCust: Label 'Accounts Receivable';
    TextVend: Label 'Accounts Payable';
    TextBank: Label 'Bank Balances';
    TextTotal: Label 'Forecasted Balance';
    TextCredit: Label 'Credit Limit in Banks';
    TextDate: Label 'Date';
    procedure OnInitPage(var BusChartBuf: Record "Business Chart Buffer")
    begin
    end;
    procedure GenerateData(var BusChartBuf: Record "Business Chart Buffer")
    var
        i: Integer;
        BankBalance: Decimal;
        CustNetChange: Decimal;
        VendNetChange: Decimal;
        TotalBalance: Decimal;
        BalanceDate: Date;
        BankCreditLimit: Decimal;
    begin
        BusChartBuf.Initialize;
        BusChartBuf.AddMeasure(TextCust, 1, BusChartBuf."Data Type"::Decimal, BusChartBuf."Chart Type"::StackedColumn);
        BusChartBuf.AddMeasure(TextVend, 2, BusChartBuf."Data Type"::Decimal, BusChartBuf."Chart Type"::StackedColumn);
        BusChartBuf.AddMeasure(TextTotal, 3, BusChartBuf."Data Type"::Decimal, BusChartBuf."Chart Type"::Line);
        BusChartBuf.AddMeasure(TextCredit, 4, BusChartBuf."Data Type"::Decimal, BusChartBuf."Chart Type"::StepLine);
        BusChartBuf.SetXAxis(TextDate, BusChartBuf."Data Type"::DateTime);
        BalanceDate:=WorkDate - 1; // demo. Should be TODAY.
        CalcBankBalance(BalanceDate, TotalBalance, BankCreditLimit);
        for i:=1 to 6 do begin //  Generate 6 columns
            CustNetChange:=CalcCustNetChange(BalanceDate, BalanceDate);
            VendNetChange:=CalcVendNetChange(BalanceDate, BalanceDate);
            TotalBalance:=TotalBalance + CustNetChange + VendNetChange;
            //AddPeriodColumn(BalanceDate);  // X-Axis value //IMPUPG
            BusChartBuf.SetValueByIndex(1 - 1, i - 1, CustNetChange); // zero indexed.
            BusChartBuf.SetValueByIndex(2 - 1, i - 1, VendNetChange);
            BusChartBuf.SetValueByIndex(3 - 1, i - 1, TotalBalance);
            BusChartBuf.SetValueByIndex(4 - 1, i - 1, BankCreditLimit);
            BalanceDate:=BalanceDate + 1;
        end;
    end;
    procedure OnDataPointClicked(var BusChartBuf: Record "Business Chart Buffer")
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        DrillDownDate: Date;
    begin
        DrillDownDate:=WorkDate + BusChartBuf."Drill-Down X Index" + 1; // ref. first balance date in GenerateData function
        case BusChartBuf."Drill-Down Measure Index" + 1 of 1: // Customer
 DrillDownCust(DrillDownDate);
        2: // Vendor
 DrillDownVend(DrillDownDate);
        4: // Bank Credit limits
 DrillDownBank;
        end;
    end;
    local procedure CalcCustNetChange(FromDate: Date; ToDate: Date): Decimal var
        CustLedgEntry: Record "Cust. Ledger Entry";
        TotalRemainingAmount: Decimal;
    begin
        CustLedgEntry.SetCurrentKey(Open, "Due Date");
        CustLedgEntry.SetRange(Open, true);
        CustLedgEntry.SetRange("Due Date", FromDate, ToDate);
        if CustLedgEntry.Find('-')then repeat CustLedgEntry.CalcFields("Remaining Amt. (LCY)");
                TotalRemainingAmount:=TotalRemainingAmount + CustLedgEntry."Remaining Amt. (LCY)";
            until CustLedgEntry.Next = 0;
        exit(TotalRemainingAmount);
    end;
    local procedure CalcVendNetChange(FromDate: Date; ToDate: Date): Decimal var
        VendLedgEntry: Record "Vendor Ledger Entry";
        TotalRemainingAmount: Decimal;
    begin
        VendLedgEntry.SetCurrentKey(Open, "Due Date");
        VendLedgEntry.SetRange(Open, true);
        VendLedgEntry.SetRange("Due Date", FromDate, ToDate);
        if VendLedgEntry.Find('-')then repeat VendLedgEntry.CalcFields("Remaining Amt. (LCY)");
                TotalRemainingAmount:=TotalRemainingAmount + VendLedgEntry."Remaining Amt. (LCY)";
            until VendLedgEntry.Next = 0;
        exit(TotalRemainingAmount);
    end;
    local procedure CalcBankBalance(EndDate: Date; var TotalBalance: Decimal; var BankCreditLimit: Decimal)
    var
        BankAcc: Record "Bank Account";
    begin
        BankAcc.SetFilter("Date Filter", '..%1', EndDate);
        if BankAcc.Find('-')then repeat BankAcc.CalcFields("Balance at Date (LCY)");
                TotalBalance:=TotalBalance + BankAcc."Balance at Date (LCY)";
                BankCreditLimit:=BankCreditLimit + BankAcc."Min. Balance";
            until BankAcc.Next = 0;
    end;
    local procedure DrillDownCust(DrillDownDate: Date)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.SetRange(Open, true);
        CustLedgEntry.SetRange("Due Date", DrillDownDate, DrillDownDate);
        PAGE.RunModal(PAGE::"Customer Ledger Entries", CustLedgEntry);
    end;
    local procedure DrillDownVend(DrillDownDate: Date)
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.SetRange(Open, true);
        VendLedgEntry.SetRange("Due Date", DrillDownDate, DrillDownDate);
        PAGE.RunModal(PAGE::"Vendor Ledger Entries", VendLedgEntry);
    end;
    local procedure DrillDownBank()
    begin
        PAGE.RunModal(PAGE::"Bank Account List");
    end;
}
