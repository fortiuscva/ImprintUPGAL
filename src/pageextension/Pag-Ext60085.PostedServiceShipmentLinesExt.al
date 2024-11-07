pageextension 60085 "PostedServiceShipmentLinesExt" extends "Posted Service Shipment Lines"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
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
