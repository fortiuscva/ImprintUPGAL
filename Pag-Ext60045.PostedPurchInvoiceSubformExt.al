pageextension 60045 "PostedPurchInvoiceSubformExt" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("Vendor Resource No."; Rec."Vendor Resource No.")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
}
