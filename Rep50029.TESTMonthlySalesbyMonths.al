report 50029 "TEST Monthly Sales by Months"
{
    // Notes on Date Arrays:
    //   [1] is the newest month (Dec of Current Year)
    //   [36] is the oldest month (Jan of 2 Years prior)
    DefaultLayout = RDLC;
    RDLCLayout = './TEST Monthly Sales by Months.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Root; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            dataitem(Salesperson; "Salesperson/Purchaser")
            {
                RequestFilterFields = "Code";

                column(SPCode; Code)
                {
                }
                column(SPName; Name)
                {
                }
                dataitem("Sales Statistic Entry"; "Sales Statistic Entry")
                {
                    DataItemLink = "Salesperson Code" = FIELD(Code);

                    column(Expected_SalesStatisticEntry; Expected)
                    {
                    }
                    column(DocumentType_SalesStatisticEntry; "Document Type")
                    {
                    }
                    column(DocumentNo_SalesStatisticEntry; "Document No.")
                    {
                    }
                    column(PostingDate_SalesStatisticEntry; "Posting Date")
                    {
                    }
                    column(SelltoCustomerNo_SalesStatisticEntry; "Sell-to Customer No.")
                    {
                    }
                    column(SalespersonCode_SalesStatisticEntry; "Salesperson Code")
                    {
                    }
                    column(SalesAmount_SalesStatisticEntry; "Sales Amount")
                    {
                    }
                    column(CostAmount_SalesStatisticEntry; "Cost Amount")
                    {
                    }
                    column(ProfitAmount_SalesStatisticEntry; "Profit Amount")
                    {
                    }
                    column(MonthName; MonthName)
                    {
                    }
                    column(YearName; YearName)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        MonthInt := Date2DMY("Posting Date", 2);
                        case MonthInt of
                            1:
                                MonthName := 'January';
                            2:
                                MonthName := 'February';
                            3:
                                MonthName := 'March';
                            4:
                                MonthName := 'April';
                            5:
                                MonthName := 'May';
                            6:
                                MonthName := 'June';
                            7:
                                MonthName := 'July';
                            8:
                                MonthName := 'August';
                            9:
                                MonthName := 'September';
                            10:
                                MonthName := 'October';
                            11:
                                MonthName := 'November';
                            12:
                                MonthName := 'December';
                        end;
                        YearName := Format(Date2DMY("Posting Date", 3));
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Posting Date", MStartDate[36], MEndDate[1]);
                        //ERROR(FORMAT(MstartDate[36]) + ' - ' + FORMAT(MendDate[1]));
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    //CurrReport.NewPage;
                    ClearSPVars;
                    StatEntry.Reset;
                    StatEntry.SetCurrentKey(Expected, "Salesperson Code", "Posting Date");
                    StatEntry.SetRange(Expected, false);
                    StatEntry.SetRange("Salesperson Code", Salesperson.Code);
                    for i := 1 to 36 do begin
                        StatEntry.SetRange("Posting Date", MStartDate[i], MEndDate[i]);
                        StatEntry.CalcSums("Sales Amount", "Profit Amount");
                        MSales[i] := StatEntry."Profit Amount";
                        MProfit[i] := StatEntry."Profit Amount";
                        if MSales[i] <> 0 then MMargin[i] := MProfit[i] / MSales[i];
                    end;
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(LastYear; LastYear)
                    {
                        Caption = 'Last Year';
                        MaxValue = 2200;
                        MinValue = 1980;
                        ApplicationArea = All;
                    }
                    field(TopXCustomer; TopXCustomer)
                    {
                        Caption = 'Top X Customers:';
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            if TopXCustomer = 0 then TopXCustomer := 10;
        end;
    }
    labels
    {
        TopX = 'Top';
        Customers = 'Customers';
    }
    trigger OnInitReport()
    begin
        LastYear := Date2DMY(WorkDate, 3);
    end;

    trigger OnPreReport()
    begin
        // Check for required parameters
        if LastYear = 0 then // Please enter %1.
            Error(Text001, 'Last Year');
        // Fill Monthly Start and End Dates
        Clear(MStartDate);
        Clear(MEndDate);
        DateRec.Reset;
        DateRec.SetRange("Period Type", DateRec."Period Type"::Month);
        DateRec.SetRange("Period Start", 20010101D, DMY2Date(31, 12, LastYear));
        for i := 1 to 36 do begin
            DateRec.FindLast;
            MStartDate[i] := DateRec."Period Start";
            MEndDate[i] := NormalDate(DateRec."Period End");
            MName[i] := DateRec."Period Name";
            DateRec.SetRange("Period Start", 20010101D, CalcDate('-1D', MStartDate[i]));
        end;
        //i := 1;
        //error(FORMAT(MStartDate[i]) + ' - ' + FORMAT(MEndDate[i]));
    end;

    var
        StatEntry: Record "Sales Statistic Entry";
        DateRec: Record Date;
        LastYear: Integer;
        MStartDate: array[36] of Date;
        MEndDate: array[36] of Date;
        MSales: array[36] of Decimal;
        MProfit: array[36] of Decimal;
        MMargin: array[36] of Decimal;
        Text001: Label 'Please enter %1.';
        MName: array[36] of Text[30];
        i: Integer;
        TopXCustomer: Integer;
        MonthInt: Integer;
        MonthName: Text[30];
        YearName: Text[30];

    procedure ClearSPVars()
    begin
        Clear(MSales);
        Clear(MProfit);
        Clear(MMargin);
    end;
}
