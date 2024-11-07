tableextension 60015 "SalesShipmentLineExt" extends "Sales Shipment Line"
{
    fields
    {
        field(50030; "Last Direct Cost"; Decimal)
        {
            Description = 'IMP1.01';
            Editable = false;
        }
        field(60030; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
        }
        field(60031; "Direct Purchase"; Boolean)
        {
        }
        field(60032; "Ship-to Option"; Option)
        {
            OptionCaption = 'Location Code,Ship-to Code,Job Site';
            OptionMembers = Location, "Ship-to Code", "Job Site";
        }
        field(60033; "Ship-to Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE("Customer No."=FIELD("Sell-to Customer No."));
        }
    }
    keys
    {
        key(key10; Type, "No.")
        {
        }
    }
}
