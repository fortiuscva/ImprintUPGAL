xmlport 50009 "Contacts Export"
{
    // IMP1.01, SP6799, 5/21/19, AK: New XML port
    // IMP1.02,       , 06/05/19,VA: Added 3 new fields to the xmlport export. [Type, Company Name and SalesPerson Code]
    Direction = Export;
    Format = VariableText;
    TableSeparator = '<NewLine>';

    schema
    {
    textelement(Root)
    {
    tableelement(Integer;
    Integer)
    {
    AutoSave = false;
    XmlName = 'integer';
    SourceTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1));
    UseTemporary = false;

    textelement(fld100)
    {
    }
    textelement(fld20)
    {
    }
    textelement(fld51)
    {
    }
    textelement(fld21)
    {
    MinOccurs = Zero;
    }
    textelement(fld52)
    {
    }
    textelement(fld53)
    {
    }
    textelement(fld22)
    {
    }
    textelement(fld23)
    {
    }
    textelement(fld24)
    {
    }
    textelement(fld25)
    {
    }
    textelement(fld26)
    {
    }
    textelement(fld27)
    {
    }
    textelement(fld28)
    {
    }
    textelement(fld29)
    {
    }
    textelement(fld30)
    {
    }
    textelement(fld31)
    {
    }
    textelement(fld32)
    {
    }
    textelement(fld33)
    {
    }
    textelement(fld34)
    {
    }
    textelement(fld35)
    {
    }
    textelement(fld36)
    {
    }
    textelement(fld37)
    {
    }
    textelement(fld38)
    {
    }
    textelement(fld39)
    {
    }
    textelement(fld40)
    {
    }
    textelement(fld41)
    {
    }
    textelement(fld42)
    {
    }
    textelement(fld43)
    {
    }
    textelement(fld44)
    {
    }
    textelement(fld45)
    {
    }
    textelement(fld46)
    {
    }
    textelement(fld47)
    {
    }
    textelement(fld48)
    {
    }
    textelement(fld49)
    {
    }
    textelement(fld125)
    {
    }
    textelement(fld101)
    {
    }
    textelement(fld102)
    {
    }
    textelement(fld103)
    {
    }
    textelement(fld104)
    {
    }
    textelement(fld105)
    {
    }
    textelement(fld106)
    {
    }
    textelement(fld107)
    {
    }
    textelement(fld108)
    {
    }
    textelement(fld109)
    {
    }
    textelement(fld110)
    {
    }
    textelement(fld111)
    {
    }
    textelement(fld112)
    {
    }
    textelement(fld113)
    {
    }
    textelement(fld114)
    {
    }
    textelement(fld115)
    {
    }
    textelement(fld116)
    {
    }
    textelement(fld117)
    {
    }
    textelement(fld118)
    {
    }
    textelement(fld119)
    {
    }
    textelement(fld120)
    {
    }
    textelement(fld121)
    {
    }
    textelement(fld122)
    {
    }
    textelement(fld123)
    {
    }
    textelement(fld124)
    {
    }
    textelement(fld50)
    {
    }
    }
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
    fieldelement(ContactType;
    Contact.Type)
    {
    }
    fieldelement(contname;
    Contact.Name)
    {
    FieldValidate = no;
    }
    fieldelement(CompanyName;
    Contact."Company Name")
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
    FieldValidate = no;
    }
    fieldelement(surname;
    Contact.Surname)
    {
    FieldValidate = no;
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
    fieldelement(fld45;
    Contact.ID_Status)
    {
    }
    trigger OnAfterGetRecord()
    begin
        AdjCustProfit:=0;
        profitval:='';
        contbusrel.Reset;
        contbusrel.SetRange("Contact No.", Contact."Company No.");
        contbusrel.SetRange("Link to Table", contbusrel."Link to Table"::Customer);
        if contbusrel.FindSet then begin
            cust.Get(contbusrel."No.");
            Clear(CostCalcMgt);
            cust.CalcFields("Profit (LCY)", "Sales (LCY)");
            CustSalesLCY:=cust."Sales (LCY)";
            CustProfit:=cust."Profit (LCY)" + CostCalcMgt.NonInvtblCostAmt(cust);
            AdjmtCostLCY:=CustSalesLCY - CustProfit + CostCalcMgt.CalcCustActualCostLCY(cust);
            AdjCustProfit:=CustProfit + AdjmtCostLCY;
            profitval:=Format(AdjCustProfit);
        end;
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
        fld100:='No';
        fld20:='Profit';
        fld51:='Type'; //IMP1.02
        fld21:='Name';
        fld52:='Company Name'; //IMP1.02
        fld53:='SalesPerson Code'; //IMP1.02
        fld22:='Address';
        fld23:='Address 2';
        fld24:='City';
        fld25:='State';
        fld26:='Post Code';
        fld27:='First Name';
        fld28:='Surname';
        fld29:='Phone No.';
        fld30:='E-mail';
        fld31:='Industry - Food';
        fld32:='Industry - Beverage';
        fld33:='Industry - Medical &UDI';
        fld34:='Industry - Chemical & GHS';
        fld35:='Industry - Transportation & Logistics';
        fld36:='Industry - Co-Packaging';
        fld37:='Industry - Manufacturing';
        fld38:='Industry - Cannabis';
        fld39:='Industry - Fulfillment';
        fld40:='Responsibility - Purchasing';
        fld41:='Responsibility - IT';
        fld42:='Responsibility - Plant Manager';
        fld43:='Responsibility - Shipping Mgr.';
        fld44:='Responsibility - Receiving Mgr.';
        fld45:='Responsibility - Operations';
        fld46:='Responsibility - Logistics';
        fld47:='Responsibility - Engineering';
        fld48:='Responsibility - Maintenance';
        fld49:='Responsibility - Other';
        fld125:='Printers - Brady';
        fld101:='Printers CAB';
        fld102:='Printers Datamax';
        fld103:='Printers Epson';
        fld104:='Printers - GHS Printing';
        fld105:='Printers Godex';
        fld106:='Printers HP';
        fld107:='Printers Intermec';
        fld108:='Printers MARKEM';
        fld109:='Printers - Model / Details';
        fld110:='Printers None';
        fld111:='Printers Primera';
        fld112:='Printers Printronix';
        fld113:='Printers Sato';
        fld114:='Printers TSC';
        fld115:='Printers VIDEOJET';
        fld116:='Printers - Void Fill';
        fld117:='Printers Zebra';
        fld118:='Terminals Datalogic';
        fld119:='Terminals Details';
        fld120:='Terminals Honeywell';
        fld121:='Terminals Intermec';
        fld122:='Terminals None';
        fld123:='Terminals Psion';
        fld124:='Terminals - Zebra/Motorola/Sym';
        fld50:='ID Status';
    end;
    var contbusrel: Record "Contact Business Relation";
    cust: Record Customer;
    CostCalcMgt: Codeunit 5836;
    CustSalesLCY: Decimal;
    AdjmtCostLCY: Decimal;
    CustProfit: Decimal;
    AdjCustProfit: Decimal;
}
