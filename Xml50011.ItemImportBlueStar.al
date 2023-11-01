xmlport 50011 "Item Import (BlueStar)"
{
    // IMP1.01,10/02/19,ST: Modifications handled to skip updating item description.
    //                       - Added code in "ImportBuffer - Import::OnBeforeInsertRecord()".
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;
    RecordSeparator = '<LF>';
    TableSeparator = '<None>';

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

                textelement(xRecType)
                {
                }
                textelement(xVendName)
                {
                }
                textelement(xVendPartNo)
                {
                }
                textelement(xBasePrice)
                {
                }
                textelement(xListPrice)
                {
                }
                textelement(xSerialFlag)
                {
                }
                textelement(xTangibleFlag)
                {
                }
                textelement(xQtyAvail)
                {
                }
                textelement(xWeight)
                {
                }
                textelement(xCountryOfOrigin)
                {
                }
                textelement(xDescription)
                {
                }
                textelement(xCat1)
                {
                }
                textelement(xMfgCode)
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
                        FirstLineDone := true;
                        exit;
                    end;
                    // Skip if Item is not "tangible"
                    //IF xTangibleFlag = 'N' THEN
                    //  EXIT;
                    // Set numeric fields to zero if neccessary
                    SetBlankToZero(xListPrice);
                    SetBlankToZero(xBasePrice);
                    SetBlankToZero(xQtyAvail);
                    // Map fields to Item Import Buffer
                    ImportBuffer."Mfg. Item No." := xVendPartNo;
                    ImportBuffer.Description := xDescription;
                    ImportBuffer."Unit of Measure Code" := '';
                    ImportBuffer."Vendor Item No." := xVendPartNo;
                    ImportBuffer."Category 1" := xCat1;
                    Evaluate(ImportBuffer."List Price", xListPrice);
                    Evaluate(ImportBuffer."Unit Price", xBasePrice);
                    if xSerialFlag = 'Y' then ImportBuffer."Serial Tracking" := true;
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
        PricingDate := Today;
    end;

    trigger OnPostXmlPort()
    begin
        ItemImportMgt.FinishImport;
    end;

    trigger OnPreXmlPort()
    begin
        if PricingDate = 0D then Error('Please specify Pricing Date.');
        ImportSource.Reset;
        ImportSource.SetRange("Import Layout", ImportSource."Import Layout"::BlueStar);
        if ImportSource.IsEmpty then // %1 with %2 of %3 not found.
            Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::BlueStar));
        if ImportSource.Count > 1 then // Multiple %1s with %2 of %3 were found.\\Only one is allowed.
            Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::BlueStar));
        ImportSource.FindFirst;
        ItemImportMgt.Initialize(ImportSource.Code, PricingDate, '', false);
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
        Clear(xRecType);
        Clear(xVendName);
        Clear(xVendPartNo);
        Clear(xSerialFlag);
        Clear(xTangibleFlag);
        Clear(xDescription);
        Clear(xBasePrice);
        Clear(xListPrice);
        Clear(xQtyAvail);
        Clear(xWeight);
        Clear(xCountryOfOrigin);
        Clear(xCat1);
        Clear(xMfgCode);
    end;
}
