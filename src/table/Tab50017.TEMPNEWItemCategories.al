table 50017 "TEMP NEW Item Categories"
{
    fields
    {
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(100; "OLD Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category".Code;
        }
        field(200; "Redirect Code"; Code[10])
        {
            Description = 'ISS TEMP';
            TableRelation = "TEMP NEW Item Categories";
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
}
