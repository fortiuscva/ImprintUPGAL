tableextension 60050 "ReturnReceiptHeaderExt" extends "Return Receipt Header"
{
    DataCaptionFields = "No.", "Sell-to Customer Name";

    fields
    {
        field(50018; "Tax Exempt Categories"; Text[50])
        {
            Description = 'IMP1.02';
            Editable = false;
        }
        field(50026; "Purchaser Code"; Code[10])
        {
            Description = 'IMP1.01';
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50090; "Tax Exemption No."; Text[50])
        {
            Description = 'IMP1.02';
            Editable = false;
        }
    }
}
