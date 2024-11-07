pageextension 60017 "pageextension70000043" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Bill-to")
        {
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
