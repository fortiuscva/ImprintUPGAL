xmlport 50060 "Tech Data Match Import"
{
    // Notes:
    //   No Serial Indicator
    //   No UoM Code
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
    textelement(Root)
    {
    tableelement(techdatadetail;
    "TEMP Tech Data Detail")
    {
    AutoReplace = false;
    AutoSave = false;
    AutoUpdate = false;
    XmlName = 'ImportBuffer';

    fieldelement(xDistPartNo;
    TechDataDetail."Dist. Part No.")
    {
    Width = 18;
    }
    fieldelement(xDescription;
    TechDataDetail.Description)
    {
    Width = 250;
    }
    textelement(xLongDescription)
    {
    Width = 1000;
    }
    fieldelement(xMfgPartNo;
    TechDataDetail."Mfg. Part No.")
    {
    Width = 35;
    }
    fieldelement(xMfgName;
    TechDataDetail."Mfg. Name")
    {
    Width = 40;
    }
    fieldelement(xMfgCode;
    TechDataDetail."Mfg. Code")
    {
    Width = 15;
    }
    fieldelement(xUPC;
    TechDataDetail."UPC No.")
    {
    Width = 18;
    }
    fieldelement(xCat1;
    TechDataDetail."Cat 1")
    {
    Width = 9;
    }
    fieldelement(xCat2;
    TechDataDetail."Cat 2")
    {
    Width = 35;
    }
    fieldelement(xCat3;
    TechDataDetail."Cat 3")
    {
    Width = 9;
    }
    fieldelement(xCat4;
    TechDataDetail."Cat 4")
    {
    Width = 35;
    }
    fieldelement(xCat5;
    TechDataDetail."Cat 5")
    {
    Width = 9;
    }
    fieldelement(xCat6;
    TechDataDetail."Cat 6")
    {
    Width = 35;
    }
    fieldelement(xAddedDate;
    TechDataDetail."Added Date")
    {
    Width = 19;
    }
    textelement(xFiller1)
    {
    Width = 1;
    }
    textelement(xFiller2)
    {
    Width = 40;
    }
    fieldelement(xListPrice;
    TechDataDetail."List Price")
    {
    Width = 17;
    }
    textelement(xWeight)
    {
    Width = 17;
    }
    textelement(xLength)
    {
    Width = 22;
    }
    textelement(xWidth)
    {
    Width = 22;
    }
    textelement(xHeight)
    {
    Width = 22;
    }
    textelement(xNoReturn)
    {
    Width = 1;
    }
    textelement(xReturnAuth)
    {
    Width = 1;
    }
    textelement(xEndUserInfo)
    {
    Width = 1;
    }
    textelement(xFreightException)
    {
    Width = 1;
    }
    trigger OnAfterInitRecord()
    begin
        Clear(TechDataDetail);
        ClearVars;
    end;
    trigger OnBeforeInsertRecord()
    begin
        // Skip the Header line
        if not FirstLineDone then begin
            FirstLineDone:=true;
            exit;
        end;
        // Set numeric fields to zero if neccessary
        // Convert tildes back to Quotes
        //xDistPartNo := CONVERTSTR(xDistPartNo,'~','"');
        //xMfgPartNo := CONVERTSTR(xMfgPartNo,'~','"');
        //xDescription := CONVERTSTR(xDescription,'~','"');
        // Map fields to Item Import Buffer
        TechDataDetail."Entry No.":=NextEntryNo;
        NextEntryNo+=1;
        TechDataDetail."Mfg. Part No. (Match)":=ItemImportMgt.CreateMatchNo(TechDataDetail."Mfg. Part No.");
        //"File Type" := "File Type"::Item;
        //"Mfg. Item No." := xMfgPartNo;
        //Description := COPYSTR(xLongDescription,1,200);
        //"Unit of Measure Code" := '';
        //"Vendor Item No." := xDistPartNo;
        //EVALUATE("List Price",xListPrice);
        // Category?
        TechDataDetail.Insert;
    // Import the Item
    //ItemImportMgt.ImportItem(ImportBuffer);
    end;
    }
    }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    trigger OnInitXmlPort()
    begin
        PricingDate:=Today;
    end;
    trigger OnPostXmlPort()
    begin
        //ItemImportMgt.FinishImport;
        Message('Process complete.');
    end;
    trigger OnPreXmlPort()
    begin
        //WITH ImportSource DO BEGIN
        //  RESET;
        //  SETRANGE("Import Layout","Import Layout"::"TechData (Mat.)");
        //  IF ISEMPTY THEN
        //    // %1 with %2 of %3 not found.
        //    ERROR(Text001,TABLECAPTION,FIELDCAPTION("Import Layout"),FORMAT("Import Layout"::"TechData (Mat.)"));
        //  IF COUNT > 1 THEN
        //    // Multiple %1s with %2 of %3 were found.\\Only one is allowed.
        //    ERROR(Text001,TABLECAPTION,FIELDCAPTION("Import Layout"),FORMAT("Import Layout"::"TechData (Mat.)"));
        //  FINDFIRST;
        //END;
        //ItemImportMgt.Initialize(ImportSource.Code,PricingDate,'');
        NextEntryNo:=1;
    end;
    var ImportSource: Record "Item Import Source";
    ItemImportMgt: Codeunit "Item Import Management";
    ImportCode: Code[10];
    FirstLineDone: Boolean;
    Text001: Label '%1 with %2 of %3 not found.';
    Text002: Label 'Multiple %1s with %2 of %3 were found.\\Only one is allowed.';
    PricingDate: Date;
    NextEntryNo: Integer;
    procedure SetBlankToZero(var TextIn: Text[1000])
    begin
        if TextIn = '' then TextIn:='0';
    end;
    procedure ClearVars()
    begin
        //CLEAR(xDistPartNo);
        //CLEAR(xDescription);
        Clear(xLongDescription);
        //CLEAR(xMfgPartNo);
        //CLEAR(xMfgName);
        //CLEAR(xMfgCode);
        //CLEAR(xUPC);
        //CLEAR(xCat1);
        //CLEAR(xCat2);
        //CLEAR(xCat3);
        //CLEAR(xCat4);
        //CLEAR(xCat5);
        //CLEAR(xCat6);
        //CLEAR(xAddedDate);
        Clear(xFiller1);
        Clear(xFiller2);
        //CLEAR(xListPrice);
        Clear(xWeight);
        Clear(xLength);
        Clear(xWidth);
        Clear(xHeight);
        Clear(xNoReturn);
        Clear(xReturnAuth);
        Clear(xEndUserInfo);
        Clear(xFreightException);
    end;
}
