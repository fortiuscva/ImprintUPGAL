xmlport 50106 "Tax Setup Import"
{
    Direction = Import;
    UseRequestPage = false;

    schema
    {
    textelement(Root)
    {
    tableelement("Tax Area";
    "Tax Area")
    {
    XmlName = 'TaxArea';

    fieldelement(Code;
    "Tax Area".Code)
    {
    }
    fieldelement(Description;
    "Tax Area".Description)
    {
    }
    fieldelement(Country;
    "Tax Area"."Country/Region")
    {
    }
    }
    tableelement("Tax Jurisdiction";
    "Tax Jurisdiction")
    {
    XmlName = 'TaxJurisdiction';

    fieldelement(Code;
    "Tax Jurisdiction".Code)
    {
    }
    fieldelement(Description;
    "Tax Jurisdiction".Description)
    {
    }
    textelement(TaxAccountSales)
    {
    }
    textelement(TaxAccountPurch)
    {
    }
    textelement(ReportToJurisdiction)
    {
    }
    textelement(UnrealTaxAccSales)
    {
    }
    textelement(UnrealTaxAccPurch)
    {
    }
    textelement(ReverseChargePurch)
    {
    }
    textelement(UnrealRevChargePurch)
    {
    }
    fieldelement(UnrealVATType;
    "Tax Jurisdiction"."Unrealized VAT Type")
    {
    }
    textelement(CalcTaxOnTax)
    {
    }
    fieldelement(AdjForPmtDisc;
    "Tax Jurisdiction"."Adjust for Payment Discount")
    {
    }
    fieldelement(Country;
    "Tax Jurisdiction"."Country/Region")
    {
    }
    fieldelement(PrintOrder;
    "Tax Jurisdiction"."Print Order")
    {
    }
    fieldelement(PrintDescr;
    "Tax Jurisdiction"."Print Description")
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        "Tax Jurisdiction"."Report-to Jurisdiction":=ReportToJurisdiction;
        Evaluate("Tax Jurisdiction"."Calculate Tax on Tax", CalcTaxOnTax);
    end;
    }
    tableelement("Tax Group";
    "Tax Group")
    {
    XmlName = 'TaxGroup';

    fieldelement(Code;
    "Tax Group".Code)
    {
    }
    fieldelement(Descr;
    "Tax Group".Description)
    {
    }
    }
    tableelement("Tax Area Line";
    "Tax Area Line")
    {
    XmlName = 'TaxAreaLine';

    textelement(taxareacode)
    {
    XmlName = 'TaxArea';
    }
    fieldelement(TaxJurisdictionCode;
    "Tax Area Line"."Tax Jurisdiction Code")
    {
    }
    fieldelement(JurisdictionDescr;
    "Tax Area Line"."Jurisdiction Description")
    {
    }
    fieldelement(CalcOrder;
    "Tax Area Line"."Calculation Order")
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        if not TaxArea.Get(TaxAreaCode)then currXMLport.Skip
        else
            "Tax Area Line".Validate("Tax Area", TaxAreaCode);
    end;
    }
    tableelement("Tax Detail";
    "Tax Detail")
    {
    XmlName = 'TaxDetail';

    textelement(TaxJurisdictionCode)
    {
    }
    fieldelement(TaxGroupCode;
    "Tax Detail"."Tax Group Code")
    {
    }
    textelement(TaxType)
    {
    }
    fieldelement(MaxAmountQty;
    "Tax Detail"."Maximum Amount/Qty.")
    {
    }
    fieldelement(TaxBelowMax;
    "Tax Detail"."Tax Below Maximum")
    {
    }
    fieldelement(TaxAboveMax;
    "Tax Detail"."Tax Above Maximum")
    {
    }
    fieldelement(EffectiveDate;
    "Tax Detail"."Effective Date")
    {
    }
    fieldelement(CalcTaxOnTax;
    "Tax Detail"."Calculate Tax on Tax")
    {
    }
    fieldelement(ExpenseCapitalize;
    "Tax Detail"."Expense/Capitalize")
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        if not TaxJurisdiction.Get(TaxJurisdictionCode)then currXMLport.Skip
        else
        begin
            "Tax Detail".Validate("Tax Jurisdiction Code", TaxJurisdictionCode);
            if TaxType = 'Sales Tax' then TaxType:='Sales and Use Tax';
            Evaluate("Tax Detail"."Tax Type", TaxType);
            "Tax Detail".Validate("Tax Type");
        end;
    end;
    }
    tableelement("VAT Business Posting Group";
    "VAT Business Posting Group")
    {
    XmlName = 'VATBusinessPG';

    fieldelement(Code;
    "VAT Business Posting Group".Code)
    {
    }
    fieldelement(Description;
    "VAT Business Posting Group".Description)
    {
    }
    }
    tableelement("VAT Product Posting Group";
    "VAT Product Posting Group")
    {
    XmlName = 'VATProductPG';

    fieldelement(Code;
    "VAT Product Posting Group".Code)
    {
    }
    fieldelement(Description;
    "VAT Product Posting Group".Description)
    {
    }
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
    var TaxArea: Record "Tax Area";
    TaxJurisdiction: Record "Tax Jurisdiction";
}
