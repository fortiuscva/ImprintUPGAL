xmlport 50024 "Import Company Contacts"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement(Contact;
    Contact)
    {
    AutoSave = false;
    XmlName = 'Contacts';

    textelement(CompanyNameVar)
    {
    }
    textelement(Phone)
    {
    }
    textelement(Address)
    {
    }
    textelement(City)
    {
    }
    textelement(State)
    {
    }
    textelement(Zip)
    {
    }
    textelement(Fax)
    {
    }
    textelement(CountyDesc)
    {
    }
    textelement(Website)
    {
    }
    textelement(Employees)
    {
    }
    textelement(Sales)
    {
    }
    textelement(SIC)
    {
    }
    textelement(SICDesc)
    {
    }
    textelement(Salesperson)
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        ContactRecGbl.Init;
        ContactRecGbl."No.":='';
        ContactRecGbl.Type:=ContactRecGbl.Type::Company;
        ContactRecGbl.Insert(true);
        ContactRecGbl.Validate("Company Name", CompanyNameVar);
        if Phone <> '' then ContactRecGbl."Phone No.":=Phone;
        ContactRecGbl.Validate(Address, Address);
        ContactRecGbl.Validate(City, City);
        ContactRecGbl.Validate(County, State);
        ContactRecGbl.Validate("Post Code", Zip);
        ContactRecGbl.Validate("Fax No.", Fax);
        ContactRecGbl.Validate("County Name", CountyDesc);
        ContactRecGbl.Validate("Home Page", Website);
        ContactRecGbl.Validate(Employees, Employees);
        if Sales <> '' then Evaluate(SalesVarGbl, Sales);
        ContactRecGbl.Validate(Revenue, SalesVarGbl);
        ContactRecGbl.Validate("SIC Code", SIC);
        ContactRecGbl.Validate("Product Type", SICDesc);
        ContactRecGbl.Validate("Salesperson Code", Salesperson);
        ContactRecGbl.Modify;
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
    var ContactRecGbl: Record Contact;
    SalesVarGbl: Decimal;
}
