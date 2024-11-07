pageextension 60048 "PostedSalesShipmentsExt" extends "Posted Sales Shipments"
{
    layout
    {
        addafter("Ship-to Name")
        {
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter("Shipment Method Code")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
