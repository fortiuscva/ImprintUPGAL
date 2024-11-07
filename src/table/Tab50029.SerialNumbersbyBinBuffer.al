table 50029 "Serial Numbers by Bin Buffer"
{
    // IMP1.01,08/17/20,ST: Enhancements to display Serial No's by bin code.
    //                        Created new report.
    Caption = 'Lot Numbers by Bin Buffer';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(2; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
        }
        field(3; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(4; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';
        }
        field(5; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
        }
        field(6; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }
        field(7; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
        }
        field(8; "Qty. (Base)"; Decimal)
        {
            Caption = 'Qty. (Base)';
            DecimalPlaces = 0: 5;
        }
    }
    keys
    {
        key(Key1; "Item No.", "Variant Code", "Location Code", "Zone Code", "Bin Code", "Lot No.", "Serial No.")
        {
        }
    }
    fieldgroups
    {
    }
}
