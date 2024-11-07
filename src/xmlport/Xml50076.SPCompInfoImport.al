xmlport 50076 "SP Comp Info Import"
{
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
    textelement(Root)
    {
    tableelement(spcompinfo;
    "Salesperson Company Info")
    {
    AutoSave = true;
    AutoUpdate = true;
    XmlName = 'SPCompInfo';
    SourceTableView = SORTING("Salesperson Code");

    fieldelement(Code;
    SPCompInfo."Salesperson Code")
    {
    }
    fieldelement(Name;
    SPCompInfo.Name)
    {
    }
    fieldelement(Name2;
    SPCompInfo."Name 2")
    {
    }
    fieldelement(Address;
    SPCompInfo.Address)
    {
    }
    fieldelement(Address2;
    SPCompInfo."Address 2")
    {
    }
    fieldelement(City;
    SPCompInfo.City)
    {
    }
    fieldelement(PhoneNo;
    SPCompInfo."Phone No.")
    {
    }
    fieldelement(PhoneNo2;
    SPCompInfo."Phone No. 2")
    {
    }
    fieldelement(TelexNo;
    SPCompInfo."Telex No.")
    {
    }
    fieldelement(FaxNo;
    SPCompInfo."Fax No.")
    {
    }
    fieldelement(LocCode;
    SPCompInfo."Location Code")
    {
    }
    fieldelement(PostCode;
    SPCompInfo."Post Code")
    {
    }
    fieldelement(County;
    SPCompInfo.County)
    {
    }
    fieldelement(EMail;
    SPCompInfo."E-Mail")
    {
    }
    fieldelement(HomePage;
    SPCompInfo."Home Page")
    {
    }
    fieldelement(Country;
    SPCompInfo."Country/Region Code")
    {
    }
    fieldelement(Enabled;
    SPCompInfo.Enabled)
    {
    }
    fieldelement(Terms1;
    SPCompInfo."Terms and Cond. 1")
    {
    }
    fieldelement(Terms2;
    SPCompInfo."Terms and Cond. 2")
    {
    }
    fieldelement(Terms3;
    SPCompInfo."Terms and Cond. 3")
    {
    }
    fieldelement(Terms4;
    SPCompInfo."Terms and Cond. 4")
    {
    }
    fieldelement(Terms5;
    SPCompInfo."Terms and Cond. 5")
    {
    }
    fieldelement(DocTagLine;
    SPCompInfo."Document Tag Line")
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
