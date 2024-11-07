pageextension 60033 "PurchaseQuoteSubformExt" extends "Purchase Quote Subform"
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
//Unsupported feature: PropertyChange. Please convert manually.
}
