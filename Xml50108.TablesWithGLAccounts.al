xmlport 50108 "Tables With G/L Accounts"
{
    schema
    {
    textelement(Root)
    {
    tableelement("Customer Posting Group";
    "Customer Posting Group")
    {
    XmlName = 'CustPG';

    fieldelement(Code;
    "Customer Posting Group".Code)
    {
    }
    }
    tableelement("Vendor Posting Group";
    "Vendor Posting Group")
    {
    XmlName = 'VendPG';

    fieldelement(Code;
    "Vendor Posting Group".Code)
    {
    }
    }
    tableelement("Gen. Business Posting Group";
    "Gen. Business Posting Group")
    {
    XmlName = 'GenBusPG';

    fieldelement(Code;
    "Gen. Business Posting Group".Code)
    {
    }
    fieldelement(Description;
    "Gen. Business Posting Group".Description)
    {
    }
    fieldelement(DefVATBusPG;
    "Gen. Business Posting Group"."Def. VAT Bus. Posting Group")
    {
    }
    fieldelement(AutoInsertDefault;
    "Gen. Business Posting Group"."Auto Insert Default")
    {
    }
    }
    tableelement("Gen. Product Posting Group";
    "Gen. Product Posting Group")
    {
    XmlName = 'GenProgPG';

    fieldelement(Code;
    "Gen. Product Posting Group".Code)
    {
    }
    fieldelement(Description;
    "Gen. Product Posting Group".Description)
    {
    }
    fieldelement(DefVATProdPG;
    "Gen. Product Posting Group"."Def. VAT Prod. Posting Group")
    {
    }
    fieldelement(AutoInsertDefault;
    "Gen. Product Posting Group"."Auto Insert Default")
    {
    }
    }
    tableelement("General Posting Setup";
    "General Posting Setup")
    {
    XmlName = 'GenPostingSetup';

    fieldelement(GenBusPG;
    "General Posting Setup"."Gen. Bus. Posting Group")
    {
    }
    fieldelement(GenProdPG;
    "General Posting Setup"."Gen. Prod. Posting Group")
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
}
