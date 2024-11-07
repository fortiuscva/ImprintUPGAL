xmlport 50094 "Customers - MN"
{
    FieldSeparator = '<~>';
    Format = VariableText;

    schema
    {
    textelement(root)
    {
    tableelement(Customer;
    Customer)
    {
    XmlName = 'Customers';
    SourceTableView = SORTING("No.")ORDER(Ascending)WHERE("Salesperson Code"=FILTER('MFREEMAN'|'JMCGURRAN'));

    fieldelement(No;
    Customer."No.")
    {
    }
    fieldelement(Name;
    Customer.Name)
    {
    }
    fieldelement(Name2;
    Customer."Name 2")
    {
    }
    fieldelement(Address;
    Customer.Address)
    {
    }
    fieldelement(Address2;
    Customer."Address 2")
    {
    }
    fieldelement(City;
    Customer.City)
    {
    }
    fieldelement(State;
    Customer.County)
    {
    }
    fieldelement(Zip;
    Customer."Post Code")
    {
    }
    fieldelement(Contact;
    Customer.Contact)
    {
    }
    fieldelement(Phone;
    Customer."Phone No.")
    {
    }
    fieldelement(Credit;
    Customer."Credit Limit (LCY)")
    {
    }
    fieldelement(CustomerPostingGroup;
    Customer."Customer Posting Group")
    {
    }
    fieldelement(PaymentTerms;
    Customer."Payment Terms Code")
    {
    }
    fieldelement(Salesperson;
    Customer."Salesperson Code")
    {
    }
    fieldelement(ShipMethod;
    Customer."Shipment Method Code")
    {
    }
    fieldelement(ShippingAgent;
    Customer."Shipping Agent Code")
    {
    }
    fieldelement(Country;
    Customer."Country/Region Code")
    {
    }
    fieldelement(CollMethod;
    Customer."Collection Method")
    {
    }
    fieldelement(PayMethod;
    Customer."Payment Method Code")
    {
    }
    fieldelement(LastModified;
    Customer."Last Date Modified")
    {
    }
    fieldelement(Location;
    Customer."Location Code")
    {
    }
    fieldelement(fax;
    Customer."Fax No.")
    {
    }
    fieldelement(GenBusPosting;
    Customer."Gen. Bus. Posting Group")
    {
    }
    fieldelement(Email;
    Customer."E-Mail")
    {
    }
    fieldelement(TaxArea;
    Customer."Tax Area Code")
    {
    }
    fieldelement(TaxLiable;
    Customer."Tax Liable")
    {
    }
    fieldelement(TaxExempt;
    Customer."Tax Exemption No.")
    {
    }
    fieldelement(DateCreated;
    Customer."Date Created")
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
