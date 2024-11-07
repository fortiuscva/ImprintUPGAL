xmlport 50015 "Item Import (Tech Data Price)"
{
    // Notes:
    //   No Serial Indicator
    //   No UoM Code
    Direction = Import;
    FieldSeparator = '<TAB>';
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
                    Width = 18;
                }
                textelement(xBasePrice)
                {
                    Width = 250;
                }
                textelement(xPromo)
                {
                    Width = 1000;
                }
                textelement(xPricingEndDate)
                {
                    Width = 35;
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
                    SetBlankToZero(xBasePrice);
                    // Convert tildes back to Quotes
                    xDistPartNo := ConvertStr(xDistPartNo, '~', '"');
                    // Convert to the NAV Item No
                    ItemVendor.Reset;
                    ItemVendor.SetCurrentKey("Vendor No.", "Vendor Item No.");
                    ItemVendor.SetRange("Vendor No.", ImportSource."Vendor No.");
                    ItemVendor.SetRange("Vendor Item No.", xDistPartNo);
                    if not ItemVendor.FindFirst then Clear(ItemVendor);
                    // Convert Pricing End Date to NAV format
                    // Import file sample: 2013-12-31
                    if StrLen(xPricingEndDate) = 10 then begin
                        xPricingEndDate := CopyStr(xPricingEndDate, 6) + '-' + CopyStr(xPricingEndDate, 1, 4);
                    end;
                    // Map fields to Item Import Buffer
                    ImportBuffer."File Type" := ImportBuffer."File Type"::Price;
                    ImportBuffer."Mfg. Item No." := ItemVendor."Item No.";
                    ImportBuffer."Pricing Item Not Found" := (ImportBuffer."Mfg. Item No." = '');
                    ImportBuffer."Unit of Measure Code" := '';
                    ImportBuffer."Vendor Item No." := xDistPartNo;
                    Evaluate(ImportBuffer."Unit Price", xBasePrice);
                    if Evaluate(ImportBuffer."Pricing End Date", xPricingEndDate) then;
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
        ImportSource.SetRange("Import Layout", ImportSource."Import Layout"::"TechData (Price)");
        if ImportSource.IsEmpty then // %1 with %2 of %3 not found.
            Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::"TechData (Mat.)"));
        if ImportSource.Count > 1 then // Multiple %1s with %2 of %3 were found.\\Only one is allowed.
            Error(Text001, ImportSource.TableCaption, ImportSource.FieldCaption("Import Layout"), Format(ImportSource."Import Layout"::"TechData (Mat.)"));
        ImportSource.FindFirst;
        ItemImportMgt.Initialize(ImportSource.Code, PricingDate, '', false);
        // Will be needed for Item Vendor search
        ImportSource.TestField("Vendor No.");
    end;

    var
        ImportSource: Record "Item Import Source";
        ItemImportMgt: Codeunit "Item Import Management";
        ItemVendor: Record "Item Vendor";
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
        Clear(xBasePrice);
        Clear(xPromo);
        Clear(xPricingEndDate);
    end;
}
