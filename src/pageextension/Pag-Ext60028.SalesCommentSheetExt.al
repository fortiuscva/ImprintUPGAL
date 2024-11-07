pageextension 60028 "SalesCommentSheetExt" extends "Sales Comment Sheet"
{
    layout
    {
        addafter("Code")
        {
            field("Copy to Purch. Order"; Rec."Copy to Purch. Order")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
