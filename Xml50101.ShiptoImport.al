xmlport 50101 "Ship-to Import"
{
    Direction = Import;
    UseRequestPage = false;

    schema
    {
    textelement(Root)
    {
    tableelement("Ship-to Address";
    "Ship-to Address")
    {
    AutoSave = false;
    XmlName = 'ShipTo';

    textelement(CustNo)
    {
    }
    fieldelement(Code;
    "Ship-to Address".Code)
    {
    }
    fieldelement(Name;
    "Ship-to Address".Name)
    {
    }
    fieldelement(Name2;
    "Ship-to Address"."Name 2")
    {
    }
    fieldelement(Address;
    "Ship-to Address".Address)
    {
    }
    fieldelement(Address2;
    "Ship-to Address"."Address 2")
    {
    }
    fieldelement(City;
    "Ship-to Address".City)
    {
    }
    fieldelement(Contact;
    "Ship-to Address".Contact)
    {
    }
    fieldelement(PhoneNo;
    "Ship-to Address"."Phone No.")
    {
    }
    fieldelement(TelexNo;
    "Ship-to Address"."Telex No.")
    {
    }
    textelement(ShipmentMethodCode)
    {
    }
    textelement(ShippingAgentCode)
    {
    }
    fieldelement(PlaceOfExport;
    "Ship-to Address"."Place of Export")
    {
    }
    textelement(CountryCode)
    {
    }
    fieldelement(LastDateModified;
    "Ship-to Address"."Last Date Modified")
    {
    }
    fieldelement(LocCode;
    "Ship-to Address"."Location Code")
    {
    }
    fieldelement(FaxNo;
    "Ship-to Address"."Fax No.")
    {
    }
    fieldelement(TelexAnswerBack;
    "Ship-to Address"."Telex Answer Back")
    {
    }
    fieldelement(PostCode;
    "Ship-to Address"."Post Code")
    {
    }
    fieldelement(County;
    "Ship-to Address".County)
    {
    }
    textelement(EMail)
    {
    }
    fieldelement(HomePage;
    "Ship-to Address"."Home Page")
    {
    }
    textelement(TaxAreaCode)
    {
    }
    fieldelement(TaxLiable;
    "Ship-to Address"."Tax Liable")
    {
    }
    textelement(shippingagentservicecode)
    {
    XmlName = 'ShippingAgentCode';
    }
    fieldelement(ServiceZone;
    "Ship-to Address"."Service Zone Code")
    {
    }
    fieldelement(UPSZone;
    "Ship-to Address"."UPS Zone")
    {
    }
    textelement(TaxRegNo)
    {
    }
    textelement(TaxExemptionNo)
    {
    }
    textelement(DefaultAddress)
    {
    }
    textelement(CustPopupNotes)
    {
    }
    trigger OnAfterInitRecord()
    begin
        "Ship-to Address".Init;
        Clear(TaxAreaCode);
        Clear(CustNo);
        Clear(TaxRegNo);
        Clear(EMail);
        Clear(CountryCode);
        Clear(ShippingAgentCode);
        Clear(ShippingAgentServiceCode);
        Clear(ShipmentMethodCode);
    end;
    trigger OnBeforeInsertRecord()
    begin
        CreateTaxArea(TaxAreaCode);
        if ShipTo2.Get(CustNo, "Ship-to Address".Code)then begin
            //Bring in the following:
            //  Tax Area Code
            //  Lead Source Code
            // Salesperson Code
            if ShipTo2."Tax Area Code" <> TaxAreaCode then begin
                ShipTo2.Validate("Tax Area Code", TaxAreaCode);
                //IF shipto2."Lead Source Code" <> TerritoryCode THEN
                //  shipto2.VALIDATE("Lead Source Code",TerritoryCode);
                //IF shipto2."Salesperson Code" <> SalespersonCode THEN
                //  shipto2.VALIDATE("Salesperson Code",SalespersonCode);
                ShipTo2.Modify;
                ShipToUpdated:=1;
            end;
            exit;
        end;
        if not Customer.Get(CustNo)then begin
            //ImportLog.LogMsg('100','Customer Not Found','Address Skipped',ImportLog."Msg. Type"::Error,
            //                   'Customer No.',CustNo,
            //                   'Ship-to Code',Code,
            //                   '','');
            currXMLport.Skip;
            exit;
        end;
        "Ship-to Address".Validate("Customer No.", CustNo);
        case CountryCode of 'US': CountryCode:='USA';
        'PUERTO RIC': CountryCode:='PR';
        'HONG KONG': CountryCode:='HK';
        end;
        "Ship-to Address".Validate("Country/Region Code", CountryCode);
        if ShipmentMethodCode <> '' then if not ShipmentMethod.Get(ShipmentMethodCode)then begin
                ShipmentMethod.Init;
                ShipmentMethod.Code:=ShipmentMethodCode;
                ShipmentMethod.Description:='IMPORTED';
                ShipmentMethod.Insert;
            end;
        "Ship-to Address".Validate("Shipment Method Code", ShipmentMethodCode);
        if ShippingAgentCode <> '' then if not ShippingAgent.Get(ShippingAgentCode)then begin
                ShippingAgent.Init;
                ShippingAgent.Code:=ShippingAgentCode;
                ShippingAgent.Name:='IMPORTED';
                ShippingAgent.Insert;
            end;
        "Ship-to Address".Validate("Shipping Agent Code", ShippingAgentCode);
        if ShippingAgentServiceCode <> '' then if not ShippingAgentService.Get(ShippingAgentCode, ShippingAgentServiceCode)then begin
                ShippingAgentService.Init;
                ShippingAgentService."Shipping Agent Code":=ShippingAgentCode;
                ShippingAgentService.Code:=ShippingAgentServiceCode;
                ShippingAgentService.Description:='IMPORTED';
                ShippingAgentService.Insert;
            end;
        "Ship-to Address".Validate("Shipping Agent Service Code", ShippingAgentServiceCode);
        if TaxAreaCode <> '' then begin
            if not TaxArea.Get(TaxAreaCode)then begin
                ImportLog.LogMsg('101', 'Tax Area Not Found', 'Field Left Blank', ImportLog."Msg. Type"::Error, 'Customer No.', "Ship-to Address"."Customer No.", 'Ship-to Code', "Ship-to Address".Code, 'Tax Area Code', TaxAreaCode);
                TaxAreaCode:='';
            end;
        end;
        "Ship-to Address".Validate("Tax Area Code", TaxAreaCode);
        if EMail <> '' then "Ship-to Address"."E-Mail":=EMail;
        "Ship-to Address".Insert(true);
        ShipToCreated:=1;
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
    trigger OnPostXmlPort()
    begin
        Message('%1 Ship-tos created.\\%2 Ship-tos updated.', ShipToCreated, ShipToUpdated);
    end;
    trigger OnPreXmlPort()
    begin
        ImportLog.StartImport('SHIP-TO');
    end;
    var ImportLog: Record "Import Message Log";
    Customer: Record Customer;
    ShipTo2: Record "Ship-to Address";
    TaxArea: Record "Tax Area";
    ShippingAgent: Record "Shipping Agent";
    ShippingAgentService: Record "Shipping Agent Services";
    ShipmentMethod: Record "Shipment Method";
    ShipToUpdated: Integer;
    ShipToCreated: Integer;
    procedure CreateTaxArea(CodeIn: Code[20])
    var
        CodeRec: Record "Tax Area";
    begin
        if CodeIn = '' then exit;
        if CodeRec.Get(CodeIn)then exit;
        CodeRec.Init;
        CodeRec.Code:=CodeIn;
        CodeRec.Description:='IMPORTED';
        CodeRec.Insert;
    end;
}
