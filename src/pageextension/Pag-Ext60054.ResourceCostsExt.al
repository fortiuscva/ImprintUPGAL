pageextension 60054 "ResourceCostsExt" extends "Resource Costs"
{
    layout
    {
        addafter("Cost Type")
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
