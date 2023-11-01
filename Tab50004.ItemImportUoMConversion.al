table 50004 "Item Import UoM Conversion"
{
    fields
    {
        field(1; "Item Import Source Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = "Item Import Source";
        }
        field(10; "Import Unit of Measure Code"; Code[20])
        {
            NotBlank = true;
        }
        field(20; "NAV Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
    }
    keys
    {
        key(Key1; "Item Import Source Code", "Import Unit of Measure Code")
        {
        }
    }
    fieldgroups
    {
    }
}
