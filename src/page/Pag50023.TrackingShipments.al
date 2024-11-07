page 50023 "Tracking Shipments"
{
    Editable = false;
    PageType = List;
    Permissions = TableData SHIPMENTS_ALL=r;
    SourceTable = SHIPMENTS_ALL;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = All;
                }
                field(Void; Rec.Void)
                {
                    ApplicationArea = All;
                }
                field("Sales Order Number"; Rec."Sales Order Number")
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
    var ShippingAgent: Record "Shipping Agent";
    TrackingInternetAddr: Text[250];
}
