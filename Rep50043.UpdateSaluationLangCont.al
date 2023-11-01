report 50043 "Update Saluation & Lang. Cont."
{
    // IMP1.01,SP5696,03/21/17,SK: Created new report.
    Permissions = TableData Contact=rimd;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Contact; Contact)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Validate("Salutation Code", 'UNISEX');
                Validate("Language Code", 'ENG');
                CountVarGbl+=1;
                Modify;
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
    trigger OnPostReport()
    begin
        if CountVarGbl > 0 then Message('Updated Successfully');
    end;
    var CountVarGbl: Integer;
}
