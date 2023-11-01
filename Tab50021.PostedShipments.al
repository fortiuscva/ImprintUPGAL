table 50021 "Posted Shipments"
{
    fields
    {
        field(1; Void; Text[30])
        {
        }
        field(2; "Tracking Number"; Text[50])
        {
        }
        field(3; Weight; Decimal)
        {
        }
        field(4; "Shipping Cost"; Decimal)
        {
        }
        field(5; "Sales Order Number"; Code[10])
        {
        }
        field(6; "Shipping Price"; Decimal)
        {
        }
        field(7; UPS_ShipCost; Text[30])
        {
        }
        field(8; UPS_ShipPrice; Text[30])
        {
        }
        field(9; UPS_Weight; Text[30])
        {
        }
        field(10; Processed; Boolean)
        {
        }
        field(11; TYPE; Text[30])
        {
        }
        field(12; "Shipment No."; Code[20])
        {
        }
    }
    keys
    {
        key(Key1; "Sales Order Number", "Tracking Number", Void)
        {
        }
        key(Key2; "Shipment No.")
        {
        }
    }
    fieldgroups
    {
    }
}
