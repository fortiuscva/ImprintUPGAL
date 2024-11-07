report 50058 "Copy Temp data"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Temp - Customer"; "Temp - Customer")
        {
            trigger OnAfterGetRecord()
            begin
                Tempcustomer.Init;
                Tempcustomer.TransferFields("Temp - Customer");
                Tempcustomer.Insert;
            end;
            trigger OnPreDataItem()
            begin
                Tempcustomer.ChangeCompany('Imprint Enterprises MN');
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
    var Tempcustomer: Record "Temp - Customer";
}
