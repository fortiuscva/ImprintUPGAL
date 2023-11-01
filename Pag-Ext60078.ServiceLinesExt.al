pageextension 60078 "ServiceLinesExt" extends "Service Lines"
{
    layout
    {
        addafter("Quantity Invoiced")
        {
            field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
            {
                ApplicationArea = All;
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("Resource 1"; Rec."Resource 1")
            {
                ApplicationArea = All;
            }
            field("Resource 2"; Rec."Resource 2")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
