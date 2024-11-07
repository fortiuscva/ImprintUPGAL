report 50027 "DALE NEW Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/DALE NEW Report.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            column(TopXCustomer; TopXCustomer)
            {
            }
        }
        dataitem(Customer; Customer)
        {
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
                IncludeCaption = true;
            }
            column(SalesLCY_Customer; Customer."Sales (LCY)")
            {
            }
            column(ProfitLCY_Customer; Customer."Profit (LCY)")
            {
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
                    field(TopXCustomer; TopXCustomer)
                    {
                        Caption = 'Top X Customers';
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
        TopX = 'Top X:';
        Customers = 'Customers';
    }
    var
        TopXCustomer: Integer;
}
