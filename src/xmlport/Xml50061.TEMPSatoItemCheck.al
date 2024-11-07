xmlport 50061 "TEMP Sato Item Check"
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
    }
    textelement(xSerialFlag)
    {
    }
    textelement(xListPrice)
    {
    }
    textelement(xPricePerM)
    {
    }
    textelement(xBaseUoM)
    {
    }
    textelement(xBasePrice)
    {
    }
    textelement(xUoM2)
    {
    }
    textelement(xUoM2QtyPer)
    {
    }
    textelement(xUoM2Price)
    {
    }
    textelement(xUoM3)
    {
    }
    textelement(xUoM3QtyPer)
    {
    }
    textelement(xUoM3Price)
    {
    }
    textelement(xItemCat)
    {
    }
    textelement(xProdGroup)
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
        xDescription:=ConvertStr(xDescription, '~', '"');
        // Map fields to Item Import Buffer
        SatoBuffer."New Item No.":=xMfgPartNo;
        // Description := xDescription;
        //"Unit of Measure Code" := xBaseUoM;
        //"Vendor Item No." := xDistPartNo;
        SatoBuffer."Old Item No.":=CopyStr(xMfgPartNo, 1, StrLen(xMfgPartNo) - 1);
        //EVALUATE("List Price",xListPrice);
        //EVALUATE("Unit Price",xBasePrice);
        //EVALUATE("Price per M",xPricePerM);
        //IF xSerialFlag = 'Y' THEN
        //  "Serial Tracking" := TRUE;
        // Roll
        if xUoM2 <> '' then begin
            //"UoM2 Code" := xUoM2;
            Evaluate(SatoBuffer."Roll Qty.", xUoM2QtyPer);
        //EVALUATE("UoM2 Price",xUoM2Price);
        end;
        // Case
        if xUoM3 <> '' then begin
            //"UoM3 Code" := xUoM3;
            Evaluate(SatoBuffer."Case Qty.", xUoM3QtyPer);
        //EVALUATE("UoM3 Price",xUoM3Price);
        end;
        //"Item Category Code" := xItemCat;
        //"Product Group Code" := xProdGroup;
        SatoBuffer.Insert;
        CheckBuffer(SatoBuffer);
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
            }
        }
        actions
        {
        }
    }
    var ImportSource: Record "Item Import Source";
    ImportCode: Code[10];
    FirstLineDone: Boolean;
    PricingDate: Date;
    Text001: Label '%1 with %2 of %3 not found.';
    Text002: Label 'Multiple %1s with %2 of %3 were found.\\Only one is allowed.';
    VendorNo: Code[20];
    SatoBuffer: Record "Sato TEMP";
    procedure SetBlankToZero(var TextIn: Text[1000])
    begin
        if TextIn = '' then TextIn:='0';
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
    procedure CheckBuffer(SatoBuffer: Record "Sato TEMP")
    var
        Item: Record Item;
        ItemUoM: Record "Item Unit of Measure";
        SalesLine: Record "Sales Line";
        ItemLedger: Record "Item Ledger Entry";
    begin
        SatoBuffer."Old Item Exists":=Item.Get(SatoBuffer."Old Item No.");
        if SatoBuffer."Old Item Exists" then begin
            SalesLine.Reset;
            SalesLine.SetRange(Type, SalesLine.Type::Item);
            SalesLine.SetRange("No.", SatoBuffer."Old Item No.");
            SatoBuffer."Old Item on Order":=not SalesLine.IsEmpty;
            ItemLedger.Reset;
            ItemLedger.SetCurrentKey("Item No.");
            ItemLedger.SetRange("Item No.", SatoBuffer."Old Item No.");
            SatoBuffer."Old Item Posted":=not ItemLedger.IsEmpty;
            if ItemUoM.Get(SatoBuffer."Old Item No.", 'ROLL')then SatoBuffer."Old Roll Qty.":=ItemUoM."Qty. per Unit of Measure";
            if ItemUoM.Get(SatoBuffer."Old Item No.", 'CASE')then SatoBuffer."Old Case Qty.":=ItemUoM."Qty. per Unit of Measure";
            SatoBuffer."Old Roll Qty. Mismatch":=SatoBuffer."Old Roll Qty." <> SatoBuffer."Roll Qty.";
            SatoBuffer."Old Case Qty. Mismatch":=SatoBuffer."Old Case Qty." <> SatoBuffer."Case Qty.";
        end;
        SatoBuffer.Modify;
    end;
}
