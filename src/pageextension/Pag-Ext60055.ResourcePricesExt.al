pageextension 60055 "ResourcePricesExt" extends "Resource Prices"
{
    layout
    {
        addafter("Currency Code")
        {
            field("Minimum Quantity"; Rec."Minimum Quantity")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
