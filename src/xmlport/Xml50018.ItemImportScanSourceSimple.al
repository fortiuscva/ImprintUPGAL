xmlport 50018 "Item Import ScanSource- Simple"
{
    // IMP1.01,03/15/17,SK: Added code "ImportBuffer - Import::OnBeforeInsertRecord()" to copy first 200 words in Description field from Importing file.
    // IMP1.02,11/13/19,SK: Modifications handled to skip updating item description.
    //                       - Added code in "ImportBuffer - Import::OnBeforeInsertRecord()".
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '|';
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement(importbuffer;
    "Item Import Buffer")
    {
    AutoReplace = false;
    AutoSave = false;
    AutoUpdate = false;
    XmlName = 'ImportBuffer';
    SourceTableView = SORTING("Mfg. Item No.");

    textelement(xCustNo)
    {
    }
    textelement(xVendName)
    {
    }
    textelement(xVendPartNo)
    {
    }
    textelement(xDistPartNo)
    {
    }
    textelement(xListPrice)
    {
    }
    textelement(xDescription)
    {
    }
    textelement(xBasePrice)
    {
    }
    textelement(xQtyAvail)
    {
    }
    trigger OnAfterInitRecord()
    begin
        Clear(ImportBuffer);
        ClearVars;
    end;
    trigger OnBeforeInsertRecord()
    begin
        // Skip the Header line
        if not FirstLineDone then begin
            FirstLineDone:=true;
            exit;
        end;
        // Skip if Item is not active
        //IF xStatus = 'INACTIVE' THEN
        //EXIT;
        // Set numeric fields to zero if neccessary
        SetBlankToZero(xListPrice);
        SetBlankToZero(xBasePrice);
        SetBlankToZero(xQtyAvail);
        // Map fields to Item Import Buffer
        ImportBuffer."Mfg. Item No.":=xVendPartNo;
        //IMP1.01 Start
        //Commented old to copy only first 200 words.
        ImportBuffer.Description:=Format(xDescription);
        //Description := COPYSTR(FORMAT(xDescription),1,200);
        //IMP1.01 End
        // "Unit of Measure Code" := xBaseUoM;
        ImportBuffer."Vendor Item No.":=xDistPartNo;
        //"Category 1" := xCat1;
        //"Category 2" := xCat2;
        //"Category 3" := xCat3;
        Evaluate(ImportBuffer."List Price", xListPrice);
        Evaluate(ImportBuffer."Unit Price", xBasePrice);
        // IF xSerialFlag = 'Y' THEN
        // "Serial Tracking" := TRUE;
        // Import the Item
        ItemImportMgt.SetRunForBlueStart(true); //IMP1.01
        ItemImportMgt.ImportItem(ImportBuffer);
        ItemImportMgt.SetRunForBlueStart(false); //IMP1.01
    end;
    }
    }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(PricingDate; PricingDate)
                {
                    Caption = 'Pricing Date';
                    ApplicationArea = All;
                }
            }
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
        ItemImportMgt.FinishImport;
    end;
    trigger OnPreXmlPort()
    begin
        if PricingDate = 0D then Error('Please specify Pricing Date.');
        ImportSource.Reset;
        ImportSource.SetRange("Import Layout", ImportSource."Import Layout"::ScanSource);
        if ImportSource.IsEmpty then // %1 with %2 of %3 not found.
 Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::ScanSource));
        if ImportSource.Count > 1 then // Multiple %1s with %2 of %3 were found.\\Only one is allowed.
 Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::ScanSource));
        ImportSource.FindFirst;
        ItemImportMgt.Initialize(ImportSource.Code, PricingDate, '', false);
    end;
    var ImportSource: Record "Item Import Source";
    ItemImportMgt: Codeunit "Item Import Management";
    ImportCode: Code[10];
    FirstLineDone: Boolean;
    PricingDate: Date;
    Text001: Label '%1 with %2 of %3 not found.';
    Text002: Label 'Multiple %1s with %2 of %3 were found.\\Only one is allowed.';
    procedure SetBlankToZero(var TextIn: Text[1000])
    begin
        if TextIn = '' then TextIn:='0';
    end;
    procedure ClearVars()
    begin
        Clear(xCustNo);
        Clear(xVendName);
        Clear(xVendPartNo);
        Clear(xDistPartNo);
        Clear(xListPrice);
        Clear(xDescription);
        Clear(xBasePrice);
        Clear(xQtyAvail);
    //CLEAR(xAlphaCode);
    //CLEAR(xWeight);
    //CLEAR(xWidth);
    //CLEAR(xLength);
    //CLEAR(xHeight);
    //CLEAR(xBaseUoM);
    //CLEAR(xStatus);
    //CLEAR(xDateAdded);
    //CLEAR(xEnhancedDescr);
    //CLEAR(xCat1);
    //CLEAR(xCat2);
    //CLEAR(xCat3);
    //CLEAR(xCat4);
    //CLEAR(xUNSPSC);
    //CLEAR(xCountryOfOrigin);
    //CLEAR(xHarmonizationCode);
    //CLEAR(xCommodityDescr);
    //CLEAR(xPhysicalType);
    //CLEAR(xSerialFlag);
    //CLEAR(xProductLine);
    //CLEAR(xLongDescription);
    //CLEAR(xImageDir);
    //CLEAR(xSpecSheetDir);
    //CLEAR(xCatalogVendorName);
    end;
}
