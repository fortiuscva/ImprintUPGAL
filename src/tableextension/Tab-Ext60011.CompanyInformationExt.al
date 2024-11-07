tableextension 60011 "CompanyInformationExt" extends "Company Information"
{
    fields
    {
        modify(City)
        {
        TableRelation = IF("Country/Region Code"=CONST(''))"Post Code".City
        ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code".City WHERE("Country/Region Code"=FIELD("Country/Region Code"));
        }
        modify("Ship-to City")
        {
        TableRelation = IF("Ship-to Country/Region Code"=CONST(''))"Post Code".City
        ELSE IF("Ship-to Country/Region Code"=FILTER(<>''))"Post Code".City WHERE("Country/Region Code"=FIELD("Ship-to Country/Region Code"));
        }
        modify("Location Code")
        {
        TableRelation = Location WHERE("Use As In-Transit"=CONST(false));
        }
        modify("Post Code")
        {
        TableRelation = IF("Country/Region Code"=CONST(''))"Post Code".Code
        ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code".Code WHERE("Country/Region Code"=FIELD("Country/Region Code"));
        //Unsupported feature: Property Modification (ValidateTableRelation) on ""Post Code"(Field 30)".
        //Unsupported feature: Property Modification (TestTableRelation) on ""Post Code"(Field 30)".
        }
        modify("Ship-to Post Code")
        {
        TableRelation = IF("Ship-to Country/Region Code"=CONST(''))"Post Code".Code
        ELSE IF("Ship-to Country/Region Code"=FILTER(<>''))"Post Code".Code WHERE("Country/Region Code"=FIELD("Ship-to Country/Region Code"));
        //Unsupported feature: Property Modification (ValidateTableRelation) on ""Ship-to Post Code"(Field 32)".
        //Unsupported feature: Property Modification (TestTableRelation) on ""Ship-to Post Code"(Field 32)".
        }
        modify("Country/Region Code")
        {
        TableRelation = "Country/Region";
        }
        modify("Ship-to Country/Region Code")
        {
        TableRelation = "Country/Region";
        }
        field(50000; "Remit-to Name"; Text[50])
        {
            Description = 'ISS2.00';
        }
        field(50001; "Remit-to Name 2"; Text[50])
        {
            Description = 'ISS2.00';
        }
        field(50002; "Remit-to Address"; Text[50])
        {
            Description = 'ISS2.00';
        }
        field(50003; "Remit-to Address 2"; Text[50])
        {
            Description = 'ISS2.00';
        }
        field(50004; "Remit-to City"; Text[30])
        {
            Description = 'ISS2.00';
            TableRelation = IF("Country/Region Code"=CONST(''))"Post Code".City
            ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code".City WHERE("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(50005; "Remit-to County"; Text[30])
        {
            Caption = 'Remit-to State';
            Description = 'ISS2.00';
        }
        field(50006; "Remit-to Post Code"; Code[20])
        {
            Caption = 'Remit-to Zip Code';
            Description = 'ISS2.00';
            TableRelation = IF("Country/Region Code"=CONST(''))"Post Code".Code
            ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code".Code WHERE("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(50007; "Remit-to Country/Region Code"; Code[10])
        {
            Description = 'ISS2.00';
            TableRelation = "Country/Region";
        }
    }
    var PostCode: record "Post Code";
}
