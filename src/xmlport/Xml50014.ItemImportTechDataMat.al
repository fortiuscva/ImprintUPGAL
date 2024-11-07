xmlport 50014 "Item Import (Tech Data Mat.)"
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
            tableelement(importbuffer;
            "Item Import Buffer")
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'ImportBuffer';
                SourceTableView = SORTING("Mfg. Item No.");

                textelement(xDistPartNo)
                {
                    Width = 18;
                }
                textelement(xDescription)
                {
                    Width = 250;
                }
                textelement(xLongDescription)
                {
                    Width = 1000;
                }
                textelement(xMfgPartNo)
                {
                    Width = 35;
                }
                textelement(xMfgName)
                {
                    Width = 40;
                }
                textelement(xMfgCode)
                {
                    Width = 15;
                }
                textelement(xUPC)
                {
                    Width = 18;
                }
                textelement(xCat1)
                {
                    Width = 9;
                }
                textelement(xCat2)
                {
                    Width = 35;
                }
                textelement(xCat3)
                {
                    Width = 9;
                }
                textelement(xCat4)
                {
                    Width = 35;
                }
                textelement(xCat5)
                {
                    Width = 9;
                }
                textelement(xCat6)
                {
                    Width = 35;
                }
                textelement(xAddedDate)
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
                textelement(xListPrice)
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
                    // Set numeric fields to zero if neccessary
                    SetBlankToZero(xListPrice);
                    // Convert tildes back to Quotes
                    xDistPartNo := ConvertStr(xDistPartNo, '~', '"');
                    xMfgPartNo := ConvertStr(xMfgPartNo, '~', '"');
                    xDescription := ConvertStr(xDescription, '~', '"');
                    // Map fields to Item Import Buffer
                    ImportBuffer."File Type" := ImportBuffer."File Type"::Item;
                    ImportBuffer."Mfg. Item No." := xMfgPartNo;
                    ImportBuffer.Description := CopyStr(xLongDescription, 1, 200);
                    ImportBuffer."Unit of Measure Code" := '';
                    ImportBuffer."Vendor Item No." := xDistPartNo;
                    Evaluate(ImportBuffer."List Price", xListPrice);
                    // Category?
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
        ImportSource.SetRange("Import Layout", ImportSource."Import Layout"::"TechData (Mat.)");
        if ImportSource.IsEmpty then // %1 with %2 of %3 not found.
            Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::"TechData (Mat.)"));
        if ImportSource.Count > 1 then // Multiple %1s with %2 of %3 were found.\\Only one is allowed.
            Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::"TechData (Mat.)"));
        ImportSource.FindFirst;
        ItemImportMgt.Initialize(ImportSource.Code, PricingDate, '', false);
    end;

    var
        ImportSource: Record "Item Import Source";
        ItemImportMgt: Codeunit "Item Import Management";
        ImportCode: Code[10];
        FirstLineDone: Boolean;
        Text001: Label '%1 with %2 of %3 not found.';
        Text002: Label 'Multiple %1s with %2 of %3 were found.\\Only one is allowed.';
        PricingDate: Date;

    procedure SetBlankToZero(var TextIn: Text[1000])
    begin
        if TextIn = '' then TextIn := '0';
    end;

    procedure ClearVars()
    begin
        Clear(xDistPartNo);
        Clear(xDescription);
        Clear(xLongDescription);
        Clear(xMfgPartNo);
        Clear(xMfgName);
        Clear(xMfgCode);
        Clear(xUPC);
        Clear(xCat1);
        Clear(xCat2);
        Clear(xCat3);
        Clear(xCat4);
        Clear(xCat5);
        Clear(xCat6);
        Clear(xAddedDate);
        Clear(xFiller1);
        Clear(xFiller2);
        Clear(xListPrice);
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
