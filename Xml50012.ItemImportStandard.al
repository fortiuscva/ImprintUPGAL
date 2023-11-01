xmlport 50012 "Item Import (Standard)"
{
    Direction = Import;
    FieldDelimiter = '"';
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

                textelement(xMfgName)
                {
                }
                textelement(xMfgPartNo)
                {
                }
                textelement(xDistPartNo)
                {
                }
                textelement(xDescription)
                {
                }
                textelement(xQtyAvail)
                {
                    MinOccurs = Zero;
                }
                textelement(xSerialFlag)
                {
                }
                textelement(xListPrice)
                {
                    MinOccurs = Zero;
                }
                textelement(xPricePerM)
                {
                    MinOccurs = Zero;
                }
                textelement(xBaseUoM)
                {
                    MinOccurs = Zero;
                }
                textelement(xBasePrice)
                {
                    MinOccurs = Zero;
                }
                textelement(xUoM2)
                {
                    MinOccurs = Zero;
                }
                textelement(xUoM2QtyPer)
                {
                    MinOccurs = Zero;
                }
                textelement(xUoM2Price)
                {
                }
                textelement(xUoM3)
                {
                    MinOccurs = Zero;
                }
                textelement(xUoM3QtyPer)
                {
                    MinOccurs = Zero;
                }
                textelement(xUoM3Price)
                {
                    MinOccurs = Zero;
                }
                textelement(xItemCat)
                {
                    MinOccurs = Zero;
                }
                textelement(xProdGroup)
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
                    // Set numeric fields to zero if neccessary
                    SetBlankToZero(xListPrice);
                    SetBlankToZero(xPricePerM);
                    SetBlankToZero(xBasePrice);
                    SetBlankToZero(xQtyAvail);
                    SetBlankToZero(xUoM2QtyPer);
                    SetBlankToZero(xUoM2Price);
                    SetBlankToZero(xUoM3QtyPer);
                    SetBlankToZero(xUoM3Price);
                    // Convert tildes back to Quotes
                    xDescription := ConvertStr(xDescription, '~', '"');
                    // Map fields to Item Import Buffer
                    ImportBuffer."Mfg. Item No." := xMfgPartNo;
                    ImportBuffer.Description := xDescription;
                    ImportBuffer."Unit of Measure Code" := xBaseUoM;
                    ImportBuffer."Vendor Item No." := xDistPartNo;
                    Evaluate(ImportBuffer."List Price", xListPrice);
                    Evaluate(ImportBuffer."Unit Price", xBasePrice);
                    Evaluate(ImportBuffer."Price per M", xPricePerM);
                    if xSerialFlag = 'Y' then ImportBuffer."Serial Tracking" := true;
                    if xUoM2 <> '' then begin
                        ImportBuffer."UoM2 Code" := xUoM2;
                        Evaluate(ImportBuffer."UoM2 Qty. per UoM", xUoM2QtyPer);
                        Evaluate(ImportBuffer."UoM2 Price", xUoM2Price);
                    end;
                    if xUoM3 <> '' then begin
                        ImportBuffer."UoM3 Code" := xUoM3;
                        Evaluate(ImportBuffer."UoM3 Qty. per UoM", xUoM3QtyPer);
                        Evaluate(ImportBuffer."UoM3 Price", xUoM3Price);
                    end;
                    ImportBuffer."Item Category Code" := xItemCat;
                    ImportBuffer."Product Group Code" := xProdGroup;
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
                field(VendorNo; VendorNo)
                {
                    Caption = 'Vendor No.';
                    TableRelation = Vendor;
                    ApplicationArea = All;
                }
                field(PricingDate; PricingDate)
                {
                    Caption = 'Pricing Date';
                    ApplicationArea = All;
                }
                field(DescLock; DescLock)
                {
                    Caption = 'Description Lock';
                    ToolTip = 'Checking this will cause all Items to have the Description from this Import and be locked.';
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
        if VendorNo = '' then Error('Please specify Vendor No.');
        if PricingDate = 0D then Error('Please specify Pricing Date.');
        ImportSource.Reset;
        ImportSource.SetRange("Import Layout", ImportSource."Import Layout"::Standard);
        if ImportSource.IsEmpty then // %1 with %2 of %3 not found.
            Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::Standard));
        if ImportSource.Count > 1 then // Multiple %1s with %2 of %3 were found.\\Only one is allowed.
            Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::Standard));
        ImportSource.FindFirst;
        ItemImportMgt.Initialize(ImportSource.Code, PricingDate, VendorNo, false);
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
        DescLock: Boolean;

    procedure SetBlankToZero(var TextIn: Text[1000])
    begin
        if TextIn = '' then TextIn := '0';
    end;

    procedure ClearVars()
    begin
        Clear(xMfgName);
        Clear(xMfgPartNo);
        Clear(xDistPartNo);
        Clear(xDescription);
        Clear(xQtyAvail);
        Clear(xSerialFlag);
        Clear(xListPrice);
        Clear(xPricePerM);
        Clear(xBaseUoM);
        Clear(xBasePrice);
        Clear(xUoM2);
        Clear(xUoM2QtyPer);
        Clear(xUoM2Price);
        Clear(xUoM3);
        Clear(xUoM3QtyPer);
        Clear(xUoM3Price);
        Clear(xItemCat);
        Clear(xProdGroup);
    end;
}
