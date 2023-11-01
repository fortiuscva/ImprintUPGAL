table 50006 "Item Import No. Override"
{
    DrillDownPageID = "Item Import No. Overrides";
    LookupPageID = "Item Import No. Overrides";

    fields
    {
        field(1; "Import Mfg. Item No."; Code[40])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                Clear("Item No. (Match)");
                if "Import Mfg. Item No." <> '' then "Item No. (Match)":=ItemImportMgt.CreateMatchNo("Import Mfg. Item No.");
            end;
        }
        field(5; "Vendor No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                CalcFields("Vendor Name");
            end;
        }
        field(10; "Item No. (Match)"; Code[20])
        {
            Editable = false;
        }
        field(12; "Override Item No."; Code[20])
        {
            TableRelation = Item;
            ValidateTableRelation = false;
        }
        field(100; "Vendor Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No."=FIELD("Vendor No.")));
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Import Mfg. Item No.", "Vendor No.")
        {
        }
        key(Key2; "Item No. (Match)", "Vendor No.")
        {
        }
    }
    fieldgroups
    {
    }
    var ItemImportMgt: Codeunit "Item Import Management";
}
