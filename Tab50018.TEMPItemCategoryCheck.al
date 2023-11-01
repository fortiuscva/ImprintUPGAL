table 50018 "TEMP Item Category Check"
{
    fields
    {
        field(1; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Item Import Code"; Code[10])
        {
            Description = 'ISS2.00';
            TableRelation = "Item Import Source";
        }
        field(20; "Old Item Category Code"; Code[10])
        {
            TableRelation = "Item Category";
        }
        field(30; "New Item Category Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Item Category Code" WHERE("No."=FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category";
        }
    }
    keys
    {
        key(Key1; "Item No.")
        {
        }
        key(Key2; "Item Import Code")
        {
        }
    }
    fieldgroups
    {
    }
}
