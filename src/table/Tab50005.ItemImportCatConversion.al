table 50005 "Item Import Cat. Conversion"
{
    fields
    {
        field(1; "Item Import Source Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = "Item Import Source";
        }
        field(10; "Import Category 1"; Code[100])
        {
            NotBlank = true;
        }
        field(11; "Import Category 2"; Code[100])
        {
            NotBlank = true;
        }
        field(12; "Import Category 3"; Code[100])
        {
            NotBlank = true;
        }
        field(5702; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";

            trigger OnValidate()
            begin
                if "Item Category Code" <> xRec."Item Category Code" then begin
                    /* if not ProductGrp.Get("Item Category Code", "Product Group Code") then
                         Validate("Product Group Code", '')
                     else*/
                    //table  removed in bc19
                    Validate("Product Group Code");
                end;
            end;
        }
        field(5704; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            //TableRelation = "Product Group".Code WHERE("Item Category Code"=FIELD("Item Category Code"));
            TableRelation = "Item Category".Code WHERE("Code" = FIELD("Item Category Code"));
        }
    }
    keys
    {
        key(Key1; "Item Import Source Code", "Import Category 1", "Import Category 2", "Import Category 3")
        {
        }
    }
    fieldgroups
    {
    }
    var
    //ProductGrp: Record "Product Group";//UPG table removed
}
