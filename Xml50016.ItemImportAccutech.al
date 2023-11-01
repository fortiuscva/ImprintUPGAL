xmlport 50016 "Item Import (Accutech)"
{
    // Notes:
    //   No Serial Indicator
    Direction = Import;
    FieldSeparator = ',';
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

                textelement(xDistPartNo)
                {
                }
                textelement(xMfgPartNo)
                {
                }
                textelement(xMfgName)
                {
                }
                textelement(xDescription)
                {
                }
                textelement(xBaseUoM)
                {
                }
                textelement(xListPrice)
                {
                }
                textelement(xBasePrice)
                {
                }
                textelement(xQtyAvail)
                {
                }
                textelement(xCat1)
                {
                }
                textelement(xCat2)
                {
                }
                textelement(xCat3)
                {
                }
                textelement(xUPC)
                {
                }
                textelement(xWeight)
                {
                }
                textelement(xMinOrderQty)
                {
                }
                textelement(xImage)
                {
                }
                textelement(xDescriptionLong)
                {
                }
                textelement(xCapacitySpeed)
                {
                }
                textelement(xPackSize)
                {
                }
                textelement(xWarranty)
                {
                }
                textelement(xBrand)
                {
                }
                textelement(xSurface)
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
                    // Set numeric fields to zero if neccessary
                    SetBlankToZero(xListPrice);
                    SetBlankToZero(xBasePrice);
                    // Convert tildes back to Quotes
                    xMfgPartNo := ConvertStr(xMfgPartNo, '~', '"');
                    xDistPartNo := ConvertStr(xDistPartNo, '~', '"');
                    xDescription := ConvertStr(xDescription, '~', '"');
                    // Map fields to Item Import Buffer
                    ImportBuffer."Mfg. Item No." := xMfgPartNo;
                    ImportBuffer.Description := xDescription;
                    ImportBuffer."Unit of Measure Code" := xBaseUoM;
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
        ImportSource.SetRange("Import Layout", ImportSource."Import Layout"::Accutech);
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
        Clear(xDistPartNo);
        Clear(xMfgPartNo);
        Clear(xMfgName);
        Clear(xDescription);
        Clear(xBaseUoM);
        Clear(xListPrice);
        Clear(xBasePrice);
        Clear(xQtyAvail);
        Clear(xCat1);
        Clear(xCat2);
        Clear(xCat3);
        Clear(xUPC);
        Clear(xWeight);
        Clear(xMinOrderQty);
        Clear(xImage);
        Clear(xDescriptionLong);
        Clear(xCapacitySpeed);
        Clear(xPackSize);
        Clear(xWarranty);
        Clear(xBrand);
        Clear(xSurface);
    end;
}
