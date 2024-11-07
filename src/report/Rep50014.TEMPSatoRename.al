report 50014 "TEMP Sato Rename"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                "Mfg. Item No.":="Mfg. Item No." + 'R';
                "Mfg. Item No. (Match)":="Mfg. Item No. (Match)" + 'R';
                Modify;
            end;
            trigger OnPostDataItem()
            begin
                Message('Complete.');
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
}
