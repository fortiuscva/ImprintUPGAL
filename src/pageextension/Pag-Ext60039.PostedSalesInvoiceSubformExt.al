pageextension 60039 "PostedSalesInvoiceSubformExt" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Job Contract Entry No.")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
            }
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
