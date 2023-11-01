page 50022 "Posted Tracking Shipments"
{
    Editable = false;
    PageType = List;
    Permissions = TableData "Posted Shipments"=r;
    SourceTable = "Posted Shipments";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sales Order Number"; Rec."Sales Order Number")
                {
                    ApplicationArea = All;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Tracking Number"; Rec."Tracking Number")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        ShippingAgent.Get('UPS');
                        TrackingInternetAddr:=StrSubstNo(ShippingAgent."Internet Address", Rec."Tracking Number");
                        HyperLink(TrackingInternetAddr);
                    end;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                }
                field("Shipping Cost"; Rec."Shipping Cost")
                {
                    ApplicationArea = All;
                }
                field("Shipping Price"; Rec."Shipping Price")
                {
                    ApplicationArea = All;
                }
                field(Void; Rec.Void)
                {
                    ApplicationArea = All;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = All;
                }
                field(TYPE; Rec.TYPE)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var TrackingInternetAddr: Text[250];
    ShippingAgent: Record "Shipping Agent";
}
