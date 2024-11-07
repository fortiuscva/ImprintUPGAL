tableextension 60022 "PurchInvHeaderExt" extends "Purch. Inv. Header"
{
    DataCaptionFields = "No.", "Buy-from Vendor Name";

    fields
    {
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
