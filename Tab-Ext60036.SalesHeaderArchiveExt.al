tableextension 60036 "SalesHeaderArchiveExt" extends "Sales Header Archive"
{
    DataCaptionFields = "No.", "Sell-to Customer Name", "Version No.";

    fields
    {
        field(50021; "E-Mail Address"; Text[80])
        {
            Caption = 'E-Mail';
            Description = 'IMP1.01';
            ExtendedDatatype = EMail;
        }
        field(50026; "Purchaser Code"; Code[10])
        {
            Description = 'IMP1.03';
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50030; "Repair Order"; Boolean)
        {
            Description = 'IMP1.02';
            Editable = false;
        }
    }
}
