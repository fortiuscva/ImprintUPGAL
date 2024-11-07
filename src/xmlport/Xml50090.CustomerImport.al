xmlport 50090 "Customer Import"
{
    schema
    {
        textelement(Root)
        {
            tableelement(Customer;
            Customer)
            {
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Customer';

                fieldelement(No;
                Customer."No.")
                {
                }
                fieldelement(Name;
                Customer.Name)
                {
                }
                fieldelement(SearchName;
                Customer."Search Name")
                {
                }
                fieldelement(Name2;
                Customer."AP Contact")
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
                fieldelement(Contact;
                Customer.Contact)
                {
                }
                fieldelement(PhoneNo;
                Customer."Phone No.")
                {
                }
                fieldelement(TelexNo;
                Customer."AP Phone No.")
                {
                }
                fieldelement(OurAccountNo;
                Customer."Our Account No.")
                {
                }
                textelement(TerritoryCode)
                {
                }
                fieldelement(ChainName;
                Customer."Chain Name")
                {
                }
                fieldelement(BugetedAmount;
                Customer."Budgeted Amount")
                {
                }
                fieldelement(CreditLimit;
                Customer."Credit Limit (LCY)")
                {
                }
                textelement(CustPG)
                {
                }
                fieldelement(CurrencyCode;
                Customer."Currency Code")
                {
                }
                fieldelement(CustPriceGroup;
                Customer."Customer Price Group")
                {
                }
                textelement(paymenttermscode)
                {
                    XmlName = 'PaymentTerms';
                }
                fieldelement(FinChargeTerms;
                Customer."Fin. Charge Terms Code")
                {
                }
                textelement(SalespersonCode)
                {
                }
                fieldelement(ShipmentMethodCode;
                Customer."Shipment Method Code")
                {
                }
                textelement(ShippingAgentCode)
                {
                }
                fieldelement(PlaceOfExport;
                Customer."Place of Export")
                {
                }
                fieldelement(InvDiscCode;
                Customer."Invoice Disc. Code")
                {
                }
                fieldelement(CustDiscGroup;
                Customer."Customer Disc. Group")
                {
                }
                textelement(CountryCode)
                {
                }
                fieldelement(CollectionMethod;
                Customer."Collection Method")
                {
                }
                fieldelement(Blocked;
                Customer.Blocked)
                {
                }
                fieldelement(InvoiceCopies;
                Customer."Invoice Copies")
                {
                }
                fieldelement(LastStatementNo;
                Customer."Last Statement No.")
                {
                }
                fieldelement(PrintStatements;
                Customer."Print Statements")
                {
                }
                textelement(BillToCustomerNo)
                {
                }
                fieldelement(Priority;
                Customer.Priority)
                {
                }
                textelement(PaymentMethodCode)
                {
                }
                fieldelement(LastDateModified;
                Customer."Last Date Modified")
                {
                }
                fieldelement(AppMethod;
                Customer."Application Method")
                {
                }
                fieldelement(PricesIncludingVAT;
                Customer."Prices Including VAT")
                {
                }
                textelement(LocationCode)
                {
                }
                fieldelement(FaxNo;
                Customer."Fax No.")
                {
                }
                fieldelement(TelexAnswerBack;
                Customer."Telex Answer Back")
                {
                }
                textelement(VATRegNo)
                {
                }
                fieldelement(CombineShipments;
                Customer."Combine Shipments")
                {
                }
                textelement(GenBusPG)
                {
                }
                fieldelement(PostCode;
                Customer."Post Code")
                {
                }
                fieldelement(County;
                Customer.County)
                {
                }
                textelement(Email)
                {
                }
                fieldelement(HomePage;
                Customer."Home Page")
                {
                }
                textelement(NoSeries)
                {
                }
                textelement(TaxAreaCode)
                {
                }
                fieldelement(TaxLiable;
                Customer."Tax Liable")
                {
                }
                textelement(VATBusPG)
                {
                }
                fieldelement(ShippingAdvice;
                Customer."Shipping Advice")
                {
                }
                fieldelement(ShippingTime;
                Customer."Shipping Time")
                {
                }
                textelement(shippingagentservicecode)
                {
                    XmlName = 'ShippingAgentService';
                }
                fieldelement(ServiceZone;
                Customer."Service Zone Code")
                {
                }
                fieldelement(BaseCalendar;
                Customer."Base Calendar Code")
                {
                }
                fieldelement(UPSZone;
                Customer."UPS Zone")
                {
                }
                fieldelement(TaxExemptionNo;
                Customer."Tax Exemption No.")
                {
                }
                fieldelement(CheckDateFormat;
                Customer."Check Date Format")
                {
                }
                fieldelement(CheckDateSep;
                Customer."Check Date Separator")
                {
                }
                textelement(xfiller1)
                {
                    XmlName = 'SecondaryCollectionMethod';
                }
                fieldelement(DateCreated;
                Customer."Date Created")
                {
                }
                trigger OnAfterInitRecord()
                begin
                    Customer.Init;
                    Clear(TerritoryCode);
                    Clear(SalespersonCode);
                    Clear(VATRegNo);
                    Clear(BillToCustomerNo);
                    Clear(NoSeries);
                    Clear(TaxAreaCode);
                    Clear(Email);
                    Clear(LocationCode);
                    Clear(CountryCode);
                    Clear(ShippingAgentCode);
                    Clear(ShippingAgentServiceCode);
                    Clear(PaymentTermsCode);
                    Clear(PaymentMethodCode);
                end;

                trigger OnBeforeInsertRecord()
                begin
                    CreateTaxArea(TaxAreaCode);
                    CreateLeadSource(TerritoryCode);
                    CreateSalesperson(SalespersonCode);
                    if Customer2.Get(Customer."No.") then begin
                        //Bring in the following:
                        //  Tax Area Code
                        //  Lead Source Code
                        // Salesperson Code
                        if Customer2."Tax Area Code" <> TaxAreaCode then Customer2.Validate("Tax Area Code", TaxAreaCode);
                        if Customer2."Lead Source Code" <> TerritoryCode then Customer2.Validate("Lead Source Code", TerritoryCode);
                        if Customer2."Salesperson Code" <> SalespersonCode then Customer2.Validate("Salesperson Code", SalespersonCode);
                        Customer2.Modify;
                        exit;
                    end;
                    if not Customer2.Get(Customer."No.") then //ERROR('Customer %1 already exists.',"No.");
                        ImportCount += 1;
                    Customer."No. Series" := NoSeries;
                    Customer."VAT Registration No." := VATRegNo;
                    Customer."Bill-to Customer No." := BillToCustomerNo;
                    case CountryCode of
                        'US':
                            CountryCode := 'USA';
                        'PUERTO RIC':
                            CountryCode := 'PR';
                    end;
                    Customer.Validate("Country/Region Code", CountryCode);
                    if LocationCode = 'NAPERVILLE' then LocationCode := 'AURORA';
                    Customer.Validate("Location Code", LocationCode);
                    if PaymentTermsCode <> '' then
                        if not PaymentTerms.Get(PaymentTermsCode) then begin
                            PaymentTerms.Init;
                            PaymentTerms.Code := PaymentTermsCode;
                            PaymentTerms.Description := 'IMPORTED';
                            PaymentTerms.Insert;
                        end;
                    Customer.Validate("Payment Terms Code", PaymentTermsCode);
                    if not PaymentMethod.Get(PaymentMethodCode) then begin
                        PaymentMethod.Init;
                        PaymentMethod.Code := PaymentMethodCode;
                        PaymentMethod.Description := 'IMPORTED';
                        PaymentMethod.Insert;
                    end;
                    Customer.Validate("Payment Method Code", PaymentMethodCode);
                    if ShippingAgentCode <> '' then
                        if not ShippingAgent.Get(ShippingAgentCode) then begin
                            ShippingAgent.Init;
                            ShippingAgent.Code := ShippingAgentCode;
                            ShippingAgent.Name := 'IMPORTED';
                            ShippingAgent.Insert;
                        end;
                    Customer.Validate("Shipping Agent Code", ShippingAgentCode);
                    if ShippingAgentServiceCode <> '' then
                        if not ShippingAgentService.Get(ShippingAgentCode, ShippingAgentServiceCode) then begin
                            ShippingAgentService.Init;
                            ShippingAgentService."Shipping Agent Code" := ShippingAgentCode;
                            ShippingAgentService.Code := ShippingAgentServiceCode;
                            ShippingAgentService.Description := 'IMPORTED';
                            ShippingAgentService.Insert;
                        end;
                    Customer.Validate("Shipping Agent Service Code", ShippingAgentServiceCode);
                    if TerritoryCode <> '' then begin
                        if not LeadSource.Get(TerritoryCode) then begin
                            if UseImportLog then ImportLog.LogMsg('100', 'Lead Source Code Not Found', 'Field Left Blank', ImportLog."Msg. Type"::Error, 'Customer No.', Customer."No.", 'Lead Source Code', TerritoryCode, '', '');
                            TerritoryCode := '';
                        end;
                    end;
                    Customer.Validate("Lead Source Code", TerritoryCode);
                    if TaxAreaCode <> '' then begin
                        if not TaxArea.Get(TaxAreaCode) then begin
                            if UseImportLog then ImportLog.LogMsg('101', 'Tax Area Code Not Found', 'Field Left Blank', ImportLog."Msg. Type"::Error, 'Customer No.', Customer."No.", 'Tax Area Code', TaxAreaCode, '', '');
                            TaxAreaCode := '';
                        end;
                    end;
                    Customer.Validate("Tax Area Code", TaxAreaCode);
                    if SalespersonCode <> '' then begin
                        if not Salesperson.Get(SalespersonCode) then begin
                            if UseImportLog then ImportLog.LogMsg('102', 'Salesperson Code Not Found', 'Field Left Blank', ImportLog."Msg. Type"::Error, 'Customer No.', Customer."No.", 'Salesperson Code', SalespersonCode, '', '');
                            SalespersonCode := '';
                        end;
                    end;
                    Customer.Validate("Salesperson Code", SalespersonCode);
                    // Posting Groups
                    //VALIDATE("Gen. Bus. Posting Group",'ALL');
                    //VALIDATE("Customer Posting Group",'ALL');
                    if Email <> '' then Customer."E-Mail" := Email;
                    Customer.Insert(true);
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
    trigger OnInitXmlPort()
    begin
        UseImportLog := true;
    end;

    trigger OnPostXmlPort()
    begin
        // Check Bill-to Customers
        Customer.Reset;
        if Customer.FindSet(false) then
            repeat
                if Customer."Bill-to Customer No." <> '' then begin
                    if not Customer2.Get(Customer."Bill-to Customer No.") then begin
                        if UseImportLog then ImportLog.LogMsg('500', 'Bill-to Customer Not Found', 'Field Left Blank', ImportLog."Msg. Type"::Error, 'Customer No.', Customer."No.", 'Bill-to Customer No.', Customer."Bill-to Customer No.", '', '');
                        Customer."Bill-to Customer No." := '';
                        Customer.Modify;
                    end;
                end;
            until Customer.Next = 0;
        Message('%1 Customers imported.', ImportCount);
    end;

    trigger OnPreXmlPort()
    begin
        if UseImportLog then ImportLog.StartImport('CUSTOMER');
    end;

    var
        ImportLog: Record "Import Message Log";
        Customer2: Record Customer;
        LeadSource: Record "Lead Source";
        TaxArea: Record "Tax Area";
        Salesperson: Record "Salesperson/Purchaser";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgentService: Record "Shipping Agent Services";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        UseImportLog: Boolean;
        ImportCount: Integer;

    procedure CreateLeadSource(CodeIn: Code[20])
    var
        CodeRec: Record "Lead Source";
    begin
        if CodeIn = '' then exit;
        if CodeRec.Get(CodeIn) then exit;
        CodeRec.Init;
        CodeRec.Code := CodeIn;
        CodeRec.Description := 'IMPORTED';
        CodeRec.Insert;
    end;

    procedure CreateSalesperson(CodeIn: Code[20])
    var
        CodeRec: Record "Salesperson/Purchaser";
    begin
        if CodeIn = '' then exit;
        if CodeRec.Get(CodeIn) then exit;
        CodeRec.Init;
        CodeRec.Code := CodeIn;
        CodeRec.Name := 'IMPORTED';
        CodeRec.Insert;
    end;

    procedure CreateTaxArea(CodeIn: Code[20])
    var
        CodeRec: Record "Tax Area";
    begin
        if CodeIn = '' then exit;
        if CodeRec.Get(CodeIn) then exit;
        CodeRec.Init;
        CodeRec.Code := CodeIn;
        CodeRec.Description := 'IMPORTED';
        CodeRec.Insert;
    end;
}
