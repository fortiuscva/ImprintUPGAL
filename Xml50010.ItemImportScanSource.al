xmlport 50010 "Item Import (ScanSource)"
{
    // IMP1.01,03/15/17,SK: Added code "ImportBuffer - Import::OnBeforeInsertRecord()" to copy first 200 words in Description field from Importing file.
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
                textelement(xAlphaCode)
                {
                    MinOccurs = Zero;
                }
                textelement(xWeight)
                {
                    MinOccurs = Zero;
                }
                textelement(xWidth)
                {
                    MinOccurs = Zero;
                }
                textelement(xLength)
                {
                    MinOccurs = Zero;
                }
                textelement(xHeight)
                {
                    MinOccurs = Zero;
                }
                textelement(xBaseUoM)
                {
                    MinOccurs = Zero;
                }
                textelement(xStatus)
                {
                    MinOccurs = Zero;
                }
                textelement(xDateAdded)
                {
                    MinOccurs = Zero;
                }
                textelement(xEnhancedDescr)
                {
                    MinOccurs = Zero;
                }
                textelement(xCat1)
                {
                    MinOccurs = Zero;
                }
                textelement(xCat2)
                {
                    MinOccurs = Zero;
                }
                textelement(xCat3)
                {
                    MinOccurs = Zero;
                }
                textelement(xCat4)
                {
                    MinOccurs = Zero;
                }
                textelement(xUNSPSC)
                {
                    MinOccurs = Zero;
                }
                textelement(xCountryOfOrigin)
                {
                    MinOccurs = Zero;
                }
                textelement(xHarmonizationCode)
                {
                    MinOccurs = Zero;
                }
                textelement(xCommodityDescr)
                {
                    MinOccurs = Zero;
                }
                textelement(xPhysicalType)
                {
                    MinOccurs = Zero;
                }
                textelement(xSerialFlag)
                {
                    MinOccurs = Zero;
                }
                textelement(xProductLine)
                {
                    MinOccurs = Zero;
                }
                textelement(xLongDescription)
                {
                    TextType = BigText;
                    MinOccurs = Zero;
                }
                textelement(xImageDir)
                {
                    MinOccurs = Zero;
                }
                textelement(xSpecSheetDir)
                {
                    MinOccurs = Zero;
                }
                textelement(xCatalogVendorName)
                {
                    MinOccurs = Zero;
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
                        FirstLineDone := true;
                        exit;
                    end;
                    // Skip if Item is not active
                    if xStatus = 'INACTIVE' then exit;
                    // Set numeric fields to zero if neccessary
                    SetBlankToZero(xListPrice);
                    SetBlankToZero(xBasePrice);
                    SetBlankToZero(xQtyAvail);
                    // Map fields to Item Import Buffer
                    ImportBuffer."Mfg. Item No." := xVendPartNo;
                    //IMP1.01 Start
                    //Commented old to copy only first 200 words.
                    ImportBuffer.Description := Format(xDescription);
                    //Description := COPYSTR(FORMAT(xDescription),1,200);
                    //IMP1.01 End
                    ImportBuffer."Unit of Measure Code" := xBaseUoM;
                    ImportBuffer."Vendor Item No." := xDistPartNo;
                    ImportBuffer."Category 1" := xCat1;
                    ImportBuffer."Category 2" := xCat2;
                    ImportBuffer."Category 3" := xCat3;
                    Evaluate(ImportBuffer."List Price", xListPrice);
                    Evaluate(ImportBuffer."Unit Price", xBasePrice);
                    if xSerialFlag = 'Y' then ImportBuffer."Serial Tracking" := true;
                    // Import the Item
                    ItemImportMgt.ImportItem(ImportBuffer);
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
        PricingDate := Today;
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

    trigger OnPostXmlPort()
    begin
        ItemImportMgt.FinishImport;
    end;

    var
        ImportSource: Record "Item Import Source";
        ItemImportMgt: Codeunit "Item Import Management";
        ImportCode: Code[10];
        FirstLineDone: Boolean;
        PricingDate: Date;
        Text001: Label '%1 with %2 of %3 not found.';
        Text002: Label 'Multiple %1s with %2 of %3 were found.\\Only one is allowed.';

    procedure SetBlankToZero(var TextIn: Text[1000])
    begin
        if TextIn = '' then TextIn := '0';
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
        Clear(xAlphaCode);
        Clear(xWeight);
        Clear(xWidth);
        Clear(xLength);
        Clear(xHeight);
        Clear(xBaseUoM);
        Clear(xStatus);
        Clear(xDateAdded);
        Clear(xEnhancedDescr);
        Clear(xCat1);
        Clear(xCat2);
        Clear(xCat3);
        Clear(xCat4);
        Clear(xUNSPSC);
        Clear(xCountryOfOrigin);
        Clear(xHarmonizationCode);
        Clear(xCommodityDescr);
        Clear(xPhysicalType);
        Clear(xSerialFlag);
        Clear(xProductLine);
        Clear(xLongDescription);
        Clear(xImageDir);
        Clear(xSpecSheetDir);
        Clear(xCatalogVendorName);
    end;
}
