tableextension 60020 "PurchRcptHeaderExt" extends "Purch. Rcpt. Header"
{
    DataCaptionFields = "No.", "Buy-from Vendor Name";

    fields
    {
        field(50014; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            Description = 'ISS2.00';
            TableRelation = "Shipping Agent";
        }
        field(50015; "Third Party Shipping Acc. No."; Code[20])
        {
            Description = 'ISS2.00';

            trigger OnValidate()
            begin
            //TestShippingAccountNo("Account No.");
            end;
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
