table 50010 "Salesperson Company Info"
{
    fields
    {
        field(1; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(4; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(5; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(6; City; Text[30])
        {
            Caption = 'City';
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
        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(8; "Phone No. 2"; Text[30])
        {
            Caption = 'Phone No. 2';
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Telex No."; Text[30])
        {
            Caption = 'Telex No.';
        }
        field(10; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit"=CONST(false));
        }
        field(29; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(30; "Post Code"; Code[20])
        {
            Caption = 'ZIP Code';
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
        field(31; County; Text[30])
        {
            Caption = 'State';
        }
        field(34; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(35; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(36; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50500; "Salesperson Name"; Text[50])
        {
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code=FIELD("Salesperson Code")));
            Description = 'ISS';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50501; Enabled; Boolean)
        {
            Description = 'ISS';
        }
        field(50505; "Terms and Cond. 1"; Text[250])
        {
            Description = 'ISS';
        }
        field(50506; "Terms and Cond. 2"; Text[250])
        {
            Description = 'ISS';
        }
        field(50507; "Terms and Cond. 3"; Text[250])
        {
            Description = 'ISS';
        }
        field(50508; "Terms and Cond. 4"; Text[250])
        {
            Description = 'ISS';
        }
        field(50509; "Terms and Cond. 5"; Text[250])
        {
            Description = 'ISS';
        }
        field(50540; "Quote Text 1"; Text[250])
        {
            Description = 'ISS';
        }
        field(50541; "Quote Text 2"; Text[250])
        {
            Description = 'ISS';
        }
        field(50542; "Quote Text 3"; Text[250])
        {
            Description = 'ISS';
        }
        field(50543; "Quote Text 4"; Text[250])
        {
            Description = 'ISS';
        }
        field(50550; "Document Tag Line"; Text[100])
        {
            Description = 'ISS';
        }
        field(50560; "Document Banner"; Text[100])
        {
            Description = 'ISS';
        }
    }
    keys
    {
        key(Key1; "Salesperson Code")
        {
        }
    }
    fieldgroups
    {
    }
    var PostCode: Record "Post Code";
    ISSText001: Label 'Do you wish to copy fields from %1 to %2 %3?';
    ISSText002: Label 'The process has been canceled.';
    procedure CopyFromCompany()
    var
        CompanyInfo: Record "Company Information";
        SPCompanyInfo: Record "Salesperson Company Info";
    begin
        // Do you wish to copy fields from %1 to %2 %3?
        if not Confirm(ISSText001, false, CompanyInfo.TableCaption, SPCompanyInfo.TableCaption, "Salesperson Code")then Error(ISSText002);
        // Make sure record has been inserted
        if not SPCompanyInfo.Get("Salesperson Code")then Insert;
        SPCompanyInfo:=Rec;
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        Rec.TransferFields(CompanyInfo);
        "Salesperson Code":=SPCompanyInfo."Salesperson Code";
        Enabled:=SPCompanyInfo.Enabled;
        "Terms and Cond. 1":=SPCompanyInfo."Terms and Cond. 1";
        "Terms and Cond. 2":=SPCompanyInfo."Terms and Cond. 2";
        "Terms and Cond. 3":=SPCompanyInfo."Terms and Cond. 3";
        "Terms and Cond. 4":=SPCompanyInfo."Terms and Cond. 4";
        "Terms and Cond. 5":=SPCompanyInfo."Terms and Cond. 5";
        Modify;
    end;
}
