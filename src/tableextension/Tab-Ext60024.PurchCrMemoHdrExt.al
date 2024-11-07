tableextension 60024 "PurchCrMemoHdrExt" extends "Purch. Cr. Memo Hdr."
{
    DataCaptionFields = "No.", "Buy-from Vendor Name";

    fields
    {
        field(50026; "Salesperson Code"; Code[10])
        {
            Description = 'IMP1.02';
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50030; "PO Sample"; Boolean)
        {
            Description = 'IMP1.01';
            Editable = false;
        }
        field(50035; "Customer PO No."; Code[35])
        {
            Caption = 'Customer PO No.';
        }
    }
}
