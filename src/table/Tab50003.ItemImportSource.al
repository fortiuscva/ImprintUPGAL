table 50003 "Item Import Source"
{
    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(5; "Import Layout"; Option)
        {
            OptionMembers = " ",Standard,ScanSource,Ingram,BlueStar,"TechData (Mat.)","TechData (Price)",Accutech;
        }
        field(10; Description; Text[30])
        {
        }
        field(20; Priority; Integer)
        {
        }
        field(30; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if ("Import Layout" = "Import Layout"::Standard) and ("Vendor No." <> '') then // When using Import Layout of Standard, Vendor No. is defined at time of import.
                    Error(Text001);
            end;
        }
        field(100; "Pass Category"; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }
    fieldgroups
    {
    }
    var
        Text001: Label 'When using Import Layout of Standard, Vendor No. is defined at time of import.';
}
