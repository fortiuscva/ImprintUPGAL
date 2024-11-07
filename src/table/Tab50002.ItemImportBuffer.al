table 50002 "Item Import Buffer"
{
    fields
    {
        field(10; "Mfg. Item No."; Code[50])
        {
        }
        field(12; "Vendor Item No."; Text[50])
        {
        }
        field(15; Description; Text[200])
        {
        }
        field(38; "Price per M"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = '1,000 Price';
        }
        field(40; "List Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(42; "Unit Price"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(51; "Pricing End Date"; Date)
        {
        }
        field(60; "Unit of Measure Code"; Code[20])
        {
        }
        field(65; "UoM2 Code"; Code[20])
        {
        }
        field(66; "UoM2 Qty. per UoM"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(67; "UoM2 Price"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(70; "UoM3 Code"; Code[20])
        {
        }
        field(71; "UoM3 Qty. per UoM"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(72; "UoM3 Price"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(80; "Serial Tracking"; Boolean)
        {
        }
        field(81; "Lot Tracking"; Boolean)
        {
        }
        field(90; "Category 1"; Text[100])
        {
            Description = 'To Convert';
        }
        field(91; "Category 2"; Text[100])
        {
            Description = 'To Convert';
        }
        field(92; "Category 3"; Text[100])
        {
            Description = 'To Convert';
        }
        field(95; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            Description = 'No Convert';
            TableRelation = "Item Category";
        }
        field(96; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            Description = 'No Convert';
            TableRelation = "Item Category".Code WHERE("Code" = FIELD("Item Category Code"));
            //TableRelation = "Product Group".Code WHERE("Item Category Code"=FIELD("Item Category Code")); 
        }
        field(120; "File Type"; Option)
        {
            OptionMembers = Full,Item,Price;
        }
        field(200; "Pricing Item Not Found"; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Mfg. Item No.")
        {
        }
    }
    fieldgroups
    {
    }
}
