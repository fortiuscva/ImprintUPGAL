xmlport 50013 "Item Import (Ingram)"
{
    // Notes:
    //   No Serial Indicator
    //   No UoM Code
    Direction = Import;
    FieldSeparator = '<TAB>';
    Format = VariableText;
    FieldDelimiter = '<">';

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

                textelement(xLineCode)
                {
                }
                textelement(xDistPartNo)
                {
                }
                textelement(xMfgCode)
                {
                }
                textelement(xMfgName)
                {
                }
                textelement(xDescription)
                {
                }
                textelement(xDescription2)
                {
                }
                textelement(xListPrice)
                {
                }
                textelement(xMfgPartNo)
                {
                }
                textelement(xCode1)
                {
                }
                textelement(xBasePrice)
                {
                }
                textelement(xCode2)
                {
                }
                textelement(xUPC)
                {
                }
                trigger OnAfterInitRecord()
                begin
                    Clear(ImportBuffer);
                    ClearVars;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    // NO HEADER ON INGRAM
                    // Skip the Header line
                    //IF NOT FirstLineDone THEN BEGIN
                    //  FirstLineDone := TRUE;
                    //  EXIT;
                    //END;
                    // Set numeric fields to zero if neccessary
                    SetBlankToZero(xListPrice);
                    SetBlankToZero(xBasePrice);
                    // Convert tildes back to Quotes
                    xMfgPartNo := ConvertStr(xMfgPartNo, '~', '"');
                    xDescription := ConvertStr(xDescription, '~', '"');
                    xDescription2 := ConvertStr(xDescription2, '~', '"');
                    // Remove spaces to right of fields (Ingram specific)
                    xDistPartNo := DelChr(xDistPartNo, '>', ' ');
                    xDescription := DelChr(xDescription, '>', ' ');
                    xDescription2 := DelChr(xDescription2, '>', ' ');
                    xMfgPartNo := DelChr(xMfgPartNo, '>', ' ');
                    // Map fields to Item Import Buffer
                    ImportBuffer."Mfg. Item No." := xMfgPartNo;
                    ImportBuffer.Description := xDescription + ' ' + xDescription2;
                    ImportBuffer."Unit of Measure Code" := '';
                    ImportBuffer."Vendor Item No." := xDistPartNo;
                    Evaluate(ImportBuffer."List Price", xListPrice);
                    Evaluate(ImportBuffer."Unit Price", xBasePrice);
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

    trigger OnPostXmlPort()
    begin
        ItemImportMgt.FinishImport;
    end;

    trigger OnPreXmlPort()
    begin
        ImportSource.Reset;
        ImportSource.SetRange("Import Layout", ImportSource."Import Layout"::Ingram);
        if ImportSource.IsEmpty then // %1 with %2 of %3 not found.
            Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::Ingram));
        if ImportSource.Count > 1 then // Multiple %1s with %2 of %3 were found.\\Only one is allowed.
            Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::Ingram));
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
        VendorNo: Code[20];

    procedure SetBlankToZero(var TextIn: Text[1000])
    begin
        if TextIn = '' then TextIn := '0';
    end;

    procedure ClearVars()
    begin
        Clear(xLineCode);
        Clear(xDistPartNo);
        Clear(xMfgCode);
        Clear(xMfgName);
        Clear(xDescription);
        Clear(xDescription2);
        Clear(xListPrice);
        Clear(xMfgPartNo);
        Clear(xBasePrice);
        Clear(xCode1);
        Clear(xCode2);
        Clear(xUPC);
    end;
}
