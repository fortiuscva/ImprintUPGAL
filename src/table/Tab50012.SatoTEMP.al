table 50012 "Sato TEMP"
{
    fields
    {
        field(1; "New Item No."; Code[20])
        {
        }
        field(2; "Old Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(20; "Roll Qty."; Decimal)
        {
        }
        field(30; "Case Qty."; Decimal)
        {
        }
        field(50; "Old Item Exists"; Boolean)
        {
        }
        field(51; "Old Item on Order"; Boolean)
        {
        }
        field(52; "Old Item Posted"; Boolean)
        {
        }
        field(60; "Old Roll Qty."; Decimal)
        {
        }
        field(61; "Old Roll Qty. Mismatch"; Boolean)
        {
        }
        field(70; "Old Case Qty."; Decimal)
        {
        }
        field(71; "Old Case Qty. Mismatch"; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "New Item No.")
        {
        }
    }
    fieldgroups
    {
    }
}
