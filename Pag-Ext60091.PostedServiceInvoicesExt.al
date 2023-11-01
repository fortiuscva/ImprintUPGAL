pageextension 60091 "PostedServiceInvoicesExt" extends "Posted Service Invoices"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Name")
        {
            field("Service Date"; Rec."Service Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Exchange Status")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
