pageextension 60077 "ServiceOrderSubformExt" extends "Service Order Subform"
{
    layout
    {
        addafter("No. of Previous Services")
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
