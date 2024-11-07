pageextension 60101 "BinContentExt" extends "Bin Content"
{
    layout
    {
        addafter(Control3)
        {
            part(Control1100796000; "Serial Numbers by Bin FactBox")
            {
                SubPageLink = "Item No."=FIELD("Item No."), "Variant Code"=FIELD("Variant Code"), "Location Code"=FIELD("Location Code");
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
