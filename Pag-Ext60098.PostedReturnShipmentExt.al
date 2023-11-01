pageextension 60098 "PostedReturnShipmentExt" extends "Posted Return Shipment"
{
    layout
    {
        addafter("Purchaser Code")
        {
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
