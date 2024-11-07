pageextension 60052 "PostedPurchaseInvoicesExt" extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field("Buy-from County"; Rec."Buy-from County")
            {
                ApplicationArea = All;
            }
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
