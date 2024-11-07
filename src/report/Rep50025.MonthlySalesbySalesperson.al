report 50025 "Monthly Sales by Salesperson"
{
    // Notes on Date Arrays:
    //   [1] is the newest month (Dec of Current Year)
    //   [36] is the oldest month (Jan of 2 Years prior)
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Monthly Sales by Salesperson.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Salesperson; "Salesperson/Purchaser")
        {
            column(SPCode; Code)
            {
            }
            column(SPName; Name)
            {
            }
            column(SalesY3M01; MSales[36])
            {
            }
            column(SalesY3M02; MSales[35])
            {
            }
            column(SalesY3M03; MSales[34])
            {
            }
            column(SalesY3M04; MSales[33])
            {
            }
            column(SalesY3M05; MSales[32])
            {
            }
            column(SalesY3M06; MSales[31])
            {
            }
            column(SalesY3M07; MSales[30])
            {
            }
            column(SalesY3M08; MSales[29])
            {
            }
            column(SalesY3M09; MSales[28])
            {
            }
            column(SalesY3M10; MSales[27])
            {
            }
            column(SalesY3M11; MSales[26])
            {
            }
            column(SalesY3M12; MSales[25])
            {
            }
            column(SalesY2M01; MSales[24])
            {
            }
            column(SalesY2M02; MSales[23])
            {
            }
            column(SalesY2M03; MSales[22])
            {
            }
            column(SalesY2M04; MSales[21])
            {
            }
            column(SalesY2M05; MSales[20])
            {
            }
            column(SalesY2M06; MSales[19])
            {
            }
            column(SalesY2M07; MSales[18])
            {
            }
            column(SalesY2M08; MSales[17])
            {
            }
            column(SalesY2M09; MSales[16])
            {
            }
            column(SalesY2M10; MSales[15])
            {
            }
            column(SalesY2M11; MSales[14])
            {
            }
            column(SalesY2M12; MSales[13])
            {
            }
            column(SalesY1M01; MSales[12])
            {
            }
            column(SalesY1M02; MSales[11])
            {
            }
            column(SalesY1M03; MSales[10])
            {
            }
            column(SalesY1M04; MSales[9])
            {
            }
            column(SalesY1M05; MSales[8])
            {
            }
            column(SalesY1M06; MSales[7])
            {
            }
            column(SalesY1M07; MSales[6])
            {
            }
            column(SalesY1M08; MSales[5])
            {
            }
            column(SalesY1M09; MSales[4])
            {
            }
            column(SalesY1M10; MSales[3])
            {
            }
            column(SalesY1M11; MSales[2])
            {
            }
            column(SalesY1M12; MSales[1])
            {
            }
            column(ProfitY3M01; MProfit[36])
            {
            }
            column(ProfitY3M02; MProfit[35])
            {
            }
            column(ProfitY3M03; MProfit[34])
            {
            }
            column(ProfitY3M04; MProfit[33])
            {
            }
            column(ProfitY3M05; MProfit[32])
            {
            }
            column(ProfitY3M06; MProfit[31])
            {
            }
            column(ProfitY3M07; MProfit[30])
            {
            }
            column(ProfitY3M08; MProfit[29])
            {
            }
            column(ProfitY3M09; MProfit[28])
            {
            }
            column(ProfitY3M10; MProfit[27])
            {
            }
            column(ProfitY3M11; MProfit[26])
            {
            }
            column(ProfitY3M12; MProfit[25])
            {
            }
            column(ProfitY2M01; MProfit[24])
            {
            }
            column(ProfitY2M02; MProfit[23])
            {
            }
            column(ProfitY2M03; MProfit[22])
            {
            }
            column(ProfitY2M04; MProfit[21])
            {
            }
            column(ProfitY2M05; MProfit[20])
            {
            }
            column(ProfitY2M06; MProfit[19])
            {
            }
            column(ProfitY2M07; MProfit[18])
            {
            }
            column(ProfitY2M08; MProfit[17])
            {
            }
            column(ProfitY2M09; MProfit[16])
            {
            }
            column(ProfitY2M10; MProfit[15])
            {
            }
            column(ProfitY2M11; MProfit[14])
            {
            }
            column(ProfitY2M12; MProfit[13])
            {
            }
            column(ProfitY1M01; MProfit[12])
            {
            }
            column(ProfitY1M02; MProfit[11])
            {
            }
            column(ProfitY1M03; MProfit[10])
            {
            }
            column(ProfitY1M04; MProfit[9])
            {
            }
            column(ProfitY1M05; MProfit[8])
            {
            }
            column(ProfitY1M06; MProfit[7])
            {
            }
            column(ProfitY1M07; MProfit[6])
            {
            }
            column(ProfitY1M08; MProfit[5])
            {
            }
            column(ProfitY1M09; MProfit[4])
            {
            }
            column(ProfitY1M10; MProfit[3])
            {
            }
            column(ProfitY1M11; MProfit[2])
            {
            }
            column(ProfitY1M12; MProfit[1])
            {
            }
            column(MarginY3M01; MMargin[36])
            {
            }
            column(MarginY3M02; MMargin[35])
            {
            }
            column(MarginY3M03; MMargin[34])
            {
            }
            column(MarginY3M04; MMargin[33])
            {
            }
            column(MarginY3M05; MMargin[32])
            {
            }
            column(MarginY3M06; MMargin[31])
            {
            }
            column(MarginY3M07; MMargin[30])
            {
            }
            column(MarginY3M08; MMargin[29])
            {
            }
            column(MarginY3M09; MMargin[28])
            {
            }
            column(MarginY3M10; MMargin[27])
            {
            }
            column(MarginY3M11; MMargin[26])
            {
            }
            column(MarginY3M12; MMargin[25])
            {
            }
            column(MarginY2M01; MMargin[24])
            {
            }
            column(MarginY2M02; MMargin[23])
            {
            }
            column(MarginY2M03; MMargin[22])
            {
            }
            column(MarginY2M04; MMargin[21])
            {
            }
            column(MarginY2M05; MMargin[20])
            {
            }
            column(MarginY2M06; MMargin[19])
            {
            }
            column(MarginY2M07; MMargin[18])
            {
            }
            column(MarginY2M08; MMargin[17])
            {
            }
            column(MarginY2M09; MMargin[16])
            {
            }
            column(MarginY2M10; MMargin[15])
            {
            }
            column(MarginY2M11; MMargin[14])
            {
            }
            column(MarginY2M12; MMargin[13])
            {
            }
            column(MarginY1M01; MMargin[12])
            {
            }
            column(MarginY1M02; MMargin[11])
            {
            }
            column(MarginY1M03; MMargin[10])
            {
            }
            column(MarginY1M04; MMargin[9])
            {
            }
            column(MarginY1M05; MMargin[8])
            {
            }
            column(MarginY1M06; MMargin[7])
            {
            }
            column(MarginY1M07; MMargin[6])
            {
            }
            column(MarginY1M08; MMargin[5])
            {
            }
            column(MarginY1M09; MMargin[4])
            {
            }
            column(MarginY1M10; MMargin[3])
            {
            }
            column(MarginY1M11; MMargin[2])
            {
            }
            column(MarginY1M12; MMargin[1])
            {
            }
            column(MonthName01; MName[12])
            {
            }
            column(MonthName02; MName[11])
            {
            }
            column(MonthName03; MName[10])
            {
            }
            column(MonthName04; MName[9])
            {
            }
            column(MonthName05; MName[8])
            {
            }
            column(MonthName06; MName[7])
            {
            }
            column(MonthName07; MName[6])
            {
            }
            column(MonthName08; MName[5])
            {
            }
            column(MonthName09; MName[4])
            {
            }
            column(MonthName10; MName[3])
            {
            }
            column(MonthName11; MName[2])
            {
            }
            column(MonthName12; MName[1])
            {
            }
            column(YearName1; LastYear)
            {
            }
            column(YearName2; LastYear - 1)
            {
            }
            column(YearName3; LastYear - 2)
            {
            }
            trigger OnAfterGetRecord()
            begin
                // CurrReport.NewPage;
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
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
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
        TestDate: Date;

    procedure ClearSPVars()
    begin
        Clear(MSales);
        Clear(MProfit);
        Clear(MMargin);
    end;
}
