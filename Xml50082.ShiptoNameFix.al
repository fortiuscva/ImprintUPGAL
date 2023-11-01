xmlport 50082 "Ship-to Name Fix"
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
    AutoReplace = false;
    AutoSave = false;
    AutoUpdate = false;
    XmlName = 'ShipTo';

    textelement(CustNo)
    {
    }
    textelement(xcode)
    {
    XmlName = 'Code';
    }
    textelement(xname)
    {
    XmlName = 'Name';
    }
    textelement(xname2)
    {
    XmlName = 'Name2';
    }
    textelement(Address)
    {
    }
    textelement(Address2)
    {
    }
    textelement(City)
    {
    }
    textelement(Contact)
    {
    }
    textelement(PhoneNo)
    {
    }
    textelement(TelexNo)
    {
    }
    textelement(ShipmentMethodCode)
    {
    }
    textelement(ShippingAgentCode)
    {
    }
    textelement(PlaceOfExport)
    {
    }
    textelement(CountryCode)
    {
    }
    textelement(LastDateModified)
    {
    }
    textelement(LocCode)
    {
    }
    textelement(FaxNo)
    {
    }
    textelement(TelexAnswerBack)
    {
    }
    textelement(PostCode)
    {
    }
    textelement(County)
    {
    }
    textelement(EMail)
    {
    }
    textelement(HomePage)
    {
    }
    textelement(TaxAreaCode)
    {
    }
    textelement(TaxLiable)
    {
    }
    textelement(shippingagentcode2)
    {
    XmlName = 'ShippingAgentCode';
    }
    textelement(ServiceZone)
    {
    }
    textelement(UPSZone)
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
        //"Ship-to Address".INIT;
        Clear(TaxAreaCode);
        Clear(CustNo);
        Clear(TaxRegNo);
        Clear(EMail);
    end;
    trigger OnBeforeInsertRecord()
    begin
        if not Customer.Get(CustNo)then begin
            //ImportLog.LogMsg('100','Customer Not Found','Address Skipped',ImportLog."Msg. Type"::Error,
            //                   'Customer No.',CustNo,
            //                   'Ship-to Code',Code,
            //                   '','');
            currXMLport.Skip;
            exit;
        end;
        //VALIDATE("Customer No.",CustNo);
        if not "Ship-to Address".Get(CustNo, xCode)then begin
            //ImportLog.LogMsg('100','Customer Not Found','Address Skipped',ImportLog."Msg. Type"::Error,
            //                   'Customer No.',CustNo,
            //                   'Ship-to Code',Code,
            //                   '','');
            currXMLport.Skip;
            exit;
        end;
        /*
                    IF TaxAreaCode <> '' THEN BEGIN
                      IF NOT TaxArea.GET(TaxAreaCode) THEN BEGIN
                        ImportLog.LogMsg('101','Tax Area Not Found','Field Left Blank',ImportLog."Msg. Type"::Error,
                                         'Customer No.',"Customer No.",
                                         'Ship-to Code',Code,
                                         'Tax Area Code',TaxAreaCode);
                        TaxAreaCode := '';
                      END;
                    END;
                    VALIDATE("Tax Area Code",TaxAreaCode);

                    IF EMail <> '' THEN
                      "E-Mail" := EMail;
                    */
        "Ship-to Address".Name:=xName;
        "Ship-to Address"."Name 2":=xName2;
        "Ship-to Address".Modify;
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
    //ImportLog.StartImport('SHIP-TO');
    end;
    var ImportLog: Record "Import Message Log";
    Customer: Record Customer;
    TaxArea: Record "Tax Area";
}
