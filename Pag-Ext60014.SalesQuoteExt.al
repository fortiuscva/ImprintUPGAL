pageextension 60014 "SalesQuoteExt" extends "Sales Quote"
{
    layout
    {
        //Unsupported feature: Change Level on ""Ship-to Contact"(Control 46)". Please convert manually.
        addfirst(Control107)
        {
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Foreign Trade")
        {
            group("E-Ship")
            {
                field("Third Party Shipping Acc. No."; Rec."Third Party Shipping Acc. No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        moveafter(General; "Shipping and Billing")
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
