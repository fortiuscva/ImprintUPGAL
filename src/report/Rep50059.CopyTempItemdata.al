report 50059 "Copy Temp Item data"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Temp - Item"; "Temp - Item")
        {
            trigger OnAfterGetRecord()
            begin
                TempItem.Init;
                TempItem.TransferFields("Temp - Item");
                TempItem.Insert;
            end;
            trigger OnPreDataItem()
            begin
                TempItem.ChangeCompany('Imprint Enterprises MN');
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
    var TempItem: Record "Temp - Item";
}
