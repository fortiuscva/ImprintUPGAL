report 50078 "Update Language on Contacts"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Contact; Contact)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending);
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Contact.Validate("Language Code", 'ENG');
                Contact.Validate("Salutation Code", 'UNISEX');
                Contact.Modify;
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
