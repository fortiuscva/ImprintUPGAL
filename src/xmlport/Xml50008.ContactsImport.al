xmlport 50008 "Contacts Import"
{
    // IMP1.01, SP6799, 5/21/19, AK: New XML port
    // IMP1.02,       , 06/05/19,VA: Added 3 new fields to the xmlport export. [Type, Company Name and SalesPerson Code]
    Direction = Import;
    Format = VariableText;
    TableSeparator = '<NewLine>';

    schema
    {
    textelement(Root)
    {
    tableelement(Contact;
    Contact)
    {
    AutoReplace = false;
    AutoSave = true;
    AutoUpdate = true;
    MinOccurs = Once;
    RequestFilterFields = "No.", Name;
    XmlName = 'ContactTable';
    SourceTableView = SORTING("No.")ORDER(Ascending)WHERE("Accounts Payable Contact"=FILTER(false));

    fieldelement(noval;
    Contact."No.")
    {
    FieldValidate = no;
    MinOccurs = Zero;
    }
    textelement(profitval)
    {
    MinOccurs = Zero;
    }
    textelement(SKIPType)
    {
    }
    fieldelement(contname;
    Contact.Name)
    {
    FieldValidate = yes;
    }
    textelement(SKIPCompanyName)
    {
    }
    fieldelement(SalespersonCode;
    Contact."Salesperson Code")
    {
    }
    fieldelement(add;
    Contact.Address)
    {
    FieldValidate = no;
    }
    fieldelement(add2;
    Contact."Address 2")
    {
    FieldValidate = no;
    }
    fieldelement(cityval;
    Contact.City)
    {
    FieldValidate = no;
    }
    fieldelement(St;
    Contact.County)
    {
    FieldValidate = no;
    }
    fieldelement(postcode;
    Contact."Post Code")
    {
    FieldValidate = no;
    }
    fieldelement(firstname;
    Contact."First Name")
    {
    FieldValidate = yes;
    }
    fieldelement(surname;
    Contact.Surname)
    {
    FieldValidate = yes;
    }
    fieldelement(phoneno;
    Contact."Phone No.")
    {
    FieldValidate = no;
    }
    fieldelement(emailval;
    Contact."E-Mail")
    {
    FieldValidate = no;
    }
    fieldelement(fld1;
    Contact."Industry - Food")
    {
    }
    fieldelement(fld2;
    Contact."Industry - Beverage")
    {
    }
    fieldelement(fld3;
    Contact."Industry - Medical & UDI")
    {
    }
    fieldelement(fld4;
    Contact."Industry - Chemicals & GHS")
    {
    }
    fieldelement(fld5;
    Contact."Industry - Transportation & Lo")
    {
    }
    fieldelement(fld20;
    Contact."Industry - Co-Packaging")
    {
    }
    fieldelement(fld6;
    Contact."Industry - Manufacturing")
    {
    }
    fieldelement(fld7;
    Contact."Industry - Cannabis")
    {
    }
    fieldelement(fld8;
    Contact."Industry - Fulfillment")
    {
    }
    fieldelement(fld9;
    Contact."Responsibility - Purchasing")
    {
    }
    fieldelement(fld10;
    Contact."Responsibility - IT")
    {
    }
    fieldelement(fld11;
    Contact."Responsibility - Plant Manager")
    {
    }
    fieldelement(fld12;
    Contact."Responsibility - Shipping Mgr.")
    {
    }
    fieldelement(fld13;
    Contact."Responsibility - Receiving Mgr")
    {
    }
    fieldelement(fld14;
    Contact."Responsibility - Operations")
    {
    }
    fieldelement(fld15;
    Contact."Responsibility - Logistics")
    {
    }
    fieldelement(fld16;
    Contact."Responsibility - Engineering")
    {
    }
    fieldelement(fld17;
    Contact."Responsibility - Maintenanace")
    {
    }
    fieldelement(fld18;
    Contact."Responsibility - Other")
    {
    }
    fieldelement(fld20;
    Contact."Printers - Brady")
    {
    }
    fieldelement(fld21;
    Contact."Printers - CAB")
    {
    }
    fieldelement(fld22;
    Contact."Printers - Datamax")
    {
    }
    fieldelement(fld23;
    Contact."Printers - Epson")
    {
    }
    fieldelement(fld24;
    Contact."Printers - GHS Printing")
    {
    }
    fieldelement(fld25;
    Contact."Printers - Godex")
    {
    }
    fieldelement(fld26;
    Contact."Printers - HP")
    {
    }
    fieldelement(fld27;
    Contact."Printers - Intermec")
    {
    }
    fieldelement(fld28;
    Contact."Printers - MARKEM")
    {
    }
    fieldelement(fld29;
    Contact."Bagging - Model / Details")
    {
    }
    fieldelement(fld30;
    Contact."Printers - None")
    {
    }
    fieldelement(fld31;
    Contact."Printers - Primera")
    {
    }
    fieldelement(fld32;
    Contact."Printers - Printronix")
    {
    }
    fieldelement(fld33;
    Contact."Printers - Sato")
    {
    }
    fieldelement(fld34;
    Contact."Printers - TSC")
    {
    }
    fieldelement(fld35;
    Contact."Printers - VIDEOJET")
    {
    }
    fieldelement(fld36;
    Contact."Printers - Void Fill")
    {
    }
    fieldelement(fld37;
    Contact."Printers - Zebra")
    {
    }
    fieldelement(fld38;
    Contact."Terminals - Datalogic")
    {
    }
    fieldelement(fld39;
    Contact."Terminals - Details")
    {
    }
    fieldelement(fld40;
    Contact."Terminals - Honeywell")
    {
    }
    fieldelement(fld41;
    Contact."Terminals - Intermec")
    {
    }
    fieldelement(fld42;
    Contact."Terminals - None")
    {
    }
    fieldelement(fld43;
    Contact."Terminals - Psion")
    {
    }
    fieldelement(fld44;
    Contact."Terminals - Zebra/Motorola/Sym")
    {
    }
    fieldelement(fld19;
    Contact.ID_Status)
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
