report 50024 "TEST Sales Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/TEST Sales Report.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            MaxIteration = 1;

            column(Jan; Jan)
            {
            }
            column(Feb; Feb)
            {
            }
            column(Mar; Mar)
            {
            }
            trigger OnAfterGetRecord()
            begin
                SalesStats.SetFilter("Posting Date", '%1', 20131201D);
                repeat
                    Jan += SalesStats."Profit Amount";
                until SalesStats.Next = 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        SalesStats: Record "Sales Statistic Entry";
        Jan: Decimal;
        Feb: Decimal;
        Mar: Decimal;
}
