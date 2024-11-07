table 50001 "Item Import Line"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Invoice Header";
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(8; "NAV Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(10; "Mfg. Item No."; Code[40])
        {
        }
        field(12; "Vendor Item No."; Text[50])
        {
        }
        field(15; "Line Type"; Option)
        {
            OptionMembers = "No Change", Update, Error;
        }
        field(20; "Error Code"; Code[10])
        {
        }
        field(21; "Error Message"; Text[50])
        {
        }
        field(70; "Pricing Updated"; Boolean)
        {
        }
        field(90; "Item Created"; Boolean)
        {
        }
        field(91; "Item Updated"; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }
    fieldgroups
    {
    }
}
