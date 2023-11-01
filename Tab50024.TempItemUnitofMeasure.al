table 50024 "Temp - Item Unit of Measure"
{
    Caption = 'Temp - Item Unit of Measure';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = "Unit of Measure";
        }
        field(3; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0: 5;
            InitValue = 1;
        }
        field(7300; Length; Decimal)
        {
            Caption = 'Length';
            DecimalPlaces = 0: 5;
            MinValue = 0;
        }
        field(7301; Width; Decimal)
        {
            Caption = 'Width';
            DecimalPlaces = 0: 5;
            MinValue = 0;
        }
        field(7302; Height; Decimal)
        {
            Caption = 'Height';
            DecimalPlaces = 0: 5;
            MinValue = 0;
        }
        field(7303; Cubage; Decimal)
        {
            Caption = 'Cubage';
            DecimalPlaces = 0: 5;
            MinValue = 0;
        }
        field(7304; Weight; Decimal)
        {
            Caption = 'Weight';
            DecimalPlaces = 0: 5;
            MinValue = 0;
        }
        field(14000701; "Std. Pack UPC/EAN Number"; Code[20])
        {
            Caption = 'Std. Pack UPC/EAN Number';
        }
    }
    keys
    {
        key(Key1; "Item No.", "Code")
        {
        }
        key(Key2; "Item No.", "Qty. per Unit of Measure")
        {
        }
        key(Key3; "Code")
        {
        }
        key(Key4; "Std. Pack UPC/EAN Number")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Qty. per Unit of Measure")
        {
        }
    }
    var Text000: Label 'must be greater than 0';
    Item: Record Item;
    Text001: Label 'You cannot rename %1 %2 for item %3 because it is the item''s %4 and there are one or more open ledger entries for the item.';
    Text002: Label 'You cannot delete %1 %2 for item %3 because it is the item''s %4.';
    Text14000701: Label '%1 is normally 14 digit, use this number anyway?';
    Text14000702: Label 'Nothing Changed.';
    Text14000703: Label '%1 %2 is not part of %3, use tihs number anyway?';
    procedure CalcCubage()
    begin
    end;
    procedure CalcWeight()
    begin
    end;
    procedure TestNoOpenEntriesExist()
    var
        Item: Record Item;
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
    end;
    procedure TestItemSetup()
    begin
    end;
}
