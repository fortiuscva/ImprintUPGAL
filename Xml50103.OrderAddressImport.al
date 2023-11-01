xmlport 50103 "Order Address Import"
{
    Direction = Import;

    schema
    {
    textelement(Root)
    {
    tableelement("Order Address";
    "Order Address")
    {
    XmlName = 'OrderAddress';

    fieldelement(VendorNo;
    "Order Address"."Vendor No.")
    {
    }
    fieldelement(Code;
    "Order Address".Code)
    {
    }
    fieldelement(Name;
    "Order Address".Name)
    {
    }
    fieldelement(Name2;
    "Order Address"."Name 2")
    {
    }
    fieldelement(Address;
    "Order Address".Address)
    {
    }
    fieldelement(Address2;
    "Order Address"."Address 2")
    {
    }
    fieldelement(City;
    "Order Address".City)
    {
    }
    fieldelement(Contact;
    "Order Address".Contact)
    {
    }
    fieldelement(PhoneNo;
    "Order Address"."Phone No.")
    {
    }
    fieldelement(TelexNo;
    "Order Address"."Telex No.")
    {
    }
    fieldelement(CountryCode;
    "Order Address"."Country/Region Code")
    {
    }
    fieldelement(LastDateModified;
    "Order Address"."Last Date Modified")
    {
    }
    fieldelement(FaxNo;
    "Order Address"."Fax No.")
    {
    }
    fieldelement(TelexAnswerBack;
    "Order Address"."Telex Answer Back")
    {
    }
    fieldelement(PostCode;
    "Order Address"."Post Code")
    {
    }
    fieldelement(County;
    "Order Address".County)
    {
    }
    fieldelement(EMail;
    "Order Address"."E-Mail")
    {
    }
    fieldelement(HomePage;
    "Order Address"."Home Page")
    {
    }
    textelement(EShipAgentService)
    {
    }
    textelement(ResidentialDelivery)
    {
    }
    textelement(ShippingPaymentType)
    {
    }
    textelement(ShippingInsurance)
    {
    }
    textelement(EShipAgentCode)
    {
    }
    textelement(EMailRuleCode)
    {
    }
    trigger OnAfterInitRecord()
    begin
        "Order Address".Init;
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
    trigger OnPreXmlPort()
    begin
        ImportLog.StartImport('ITEM');
    end;
    var ImportLog: Record "Import Message Log";
}
