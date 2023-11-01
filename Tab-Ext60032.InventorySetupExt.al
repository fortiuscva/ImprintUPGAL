tableextension 60032 "InventorySetupExt" extends "Inventory Setup"
{
    fields
    {
        field(50000; "Item Import Nos."; Code[10])
        {
            Description = 'ISS2.00';
            TableRelation = "No. Series";
        }
        field(50001; "Item Import Log Type"; Option)
        {
            Description = 'ISS2.00';
            OptionMembers = Full, "Errors & Updates", "Errors Only";
        }
        field(50010; "Default Location Code"; Code[10])
        {
            Description = 'ISS2.00';
            TableRelation = Location;
        }
    }
}
