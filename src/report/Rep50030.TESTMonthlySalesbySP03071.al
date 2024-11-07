report 50030 "TEST Monthly Sales by SP 03071"
{
    // Notes on Date Arrays:
    //   [1] is the newest month (Dec of Current Year)
    //   [36] is the oldest month (Jan of 2 Years prior)
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/TEST Monthly Sales by SP 03071.rdl';
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
                column(TopXCustomer; TopXCustomer)
                {
                }
                dataitem(Customer; Customer)
                {
                    DataItemLink = "Salesperson Code" = FIELD(Code);

                    column(No_Customer; "No.")
                    {
                    }
                    column(Name_Customer; Name)
                    {
                        IncludeCaption = true;
                    }
                    column(SalesLCY_Customer; "Sales (LCY)")
                    {
                        IncludeCaption = true;
                    }
                    column(ProfitLCY_Customer; "Profit (LCY)")
                    {
                        IncludeCaption = true;
                    }
                    column(StatProfitExpected_Customer; "Stat. Profit (Expected)")
                    {
                    }
                    column(StatSalesExpected_Customer; "Stat. Sales (Expected)")
                    {
                    }
                    column(StatProfitPosted_Customer; "Stat. Profit (Posted)")
                    {
                    }
                    column(StatSalesPosted_Customer; "Stat. Sales (Posted)")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        SetRange("Date Filter", DMY2Date(1, 1, LastYear), DMY2Date(31, 12, LastYear));
                        CalcFields("Sales (LCY)", "Profit (LCY)", "Stat. Profit (Expected)", "Stat. Profit (Posted)", "Stat. Sales (Expected)", "Stat. Sales (Posted)");
                    end;
                }
                dataitem(SalesStatEntry; "Sales Statistic Entry")
                {
                    DataItemLink = "Salesperson Code" = FIELD(Code);
                    DataItemTableView = WHERE(Expected = CONST(false));

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
                    column(ItemCategory_SalesStatisticEntry; "Item Category Code")
                    {
                    }
                    column(Expected_salesStatisticEntry; Expected)
                    {
                    }
                    column(MonthName; MonthName)
                    {
                    }
                    column(YearName; YearName)
                    {
                    }
                    column(QuarterName; QuarterName)
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
                        case MonthInt of
                            1, 2, 3:
                                QuarterName := 'Q1';
                            4, 5, 6:
                                QuarterName := 'Q2';
                            7, 8, 9:
                                QuarterName := 'Q3';
                            10, 11, 12:
                                QuarterName := 'Q4';
                        end;
                        YearName := Format(Date2DMY("Posting Date", 3));
                    end;

                    trigger OnPreDataItem()
                    begin
                        //SETRANGE("Posting Date",MStartDate[36],MEndDate[1]);
                        // ISS TEMP 03.05.14
                        // This is filtering the every graph and table using the data from this DataItem
                        SetRange("Posting Date", DMY2Date(1, 1, LastYear - 2), DMY2Date(31, 12, LastYear));
                        //ERROR(FORMAT(MstartDate[36]) + ' - ' + FORMAT(MendDate[1]));
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    // CurrReport.NewPage;
                    ClearSPVars;
                    /*
                        WITH StatEntry DO BEGIN
                          RESET;
                          SETCURRENTKEY(Expected,"Salesperson Code","Posting Date");
                          SETRANGE(Expected,FALSE);
                          SETRANGE("Salesperson Code",Salesperson.Code);
                          FOR i := 1 TO 36 DO BEGIN
                            SETRANGE("Posting Date",MStartDate[i],MEndDate[i]);
                            CALCSUMS("Sales Amount","Profit Amount");
                            MSales[i] := "Profit Amount";
                            MProfit[i] := "Profit Amount";
                            IF MSales[i] <> 0 THEN
                              MMargin[i] := MProfit[i] / MSales[i];
                          END;
                        END;
                        */
                end;

                trigger OnPreDataItem()
                begin
                    FilterSalesperson;
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
        QuarterName: Text[30];

    procedure ClearSPVars()
    begin
        Clear(MSales);
        Clear(MProfit);
        Clear(MMargin);
    end;
}
