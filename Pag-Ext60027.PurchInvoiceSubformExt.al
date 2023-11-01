pageextension 60027 "PurchInvoiceSubformExt" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Vendor Resource No."; Rec."Vendor Resource No.")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
}
