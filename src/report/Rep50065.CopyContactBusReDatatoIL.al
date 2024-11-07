report 50065 "Copy Contact Bus.Re Data to IL"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Temp - Contact Business Rel."; "Temp - Contact Business Rel.")
        {
            trigger OnAfterGetRecord()
            begin
                ContactBusRelRec.Init;
                ContactBusRelRec.TransferFields("Temp - Contact Business Rel.");
                ContactBusRelRec.Insert;
            end;
            trigger OnPreDataItem()
            begin
                ContactBusRelRec.ChangeCompany('Imprint Enterprises');
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
    var ContactBusRelRec: Record "Contact Business Relation";
}
