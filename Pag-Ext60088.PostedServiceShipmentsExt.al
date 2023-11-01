pageextension 60088 "PostedServiceShipmentsExt" extends "Posted Service Shipments"
{
    layout
    {
        addafter(Name)
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
