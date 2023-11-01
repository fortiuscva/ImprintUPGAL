xmlport 50107 "Country Codes Import"
{
    schema
    {
    textelement(Root)
    {
    tableelement("Country/Region";
    "Country/Region")
    {
    XmlName = 'Country';

    fieldelement(Code;
    "Country/Region".Code)
    {
    }
    fieldelement(Name;
    "Country/Region".Name)
    {
    }
    fieldelement(EUCountryCode;
    "Country/Region"."EU Country/Region Code")
    {
    }
    fieldelement(IntrastatCode;
    "Country/Region"."Intrastat Code")
    {
    }
    textelement(AddressFormat)
    {
    }
    textelement(ContactAddressFormat)
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        case AddressFormat of 'City+ZIP Code': AddressFormat:='City+Post Code';
        'City+State+ZIP Code': AddressFormat:='City+County+Post Code';
        end;
        Evaluate("Country/Region"."Address Format", AddressFormat);
        Evaluate("Country/Region"."Contact Address Format", ContactAddressFormat);
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
}
