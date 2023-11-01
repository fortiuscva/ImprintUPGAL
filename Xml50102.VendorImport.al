xmlport 50102 "Vendor Import"
{
    Direction = Import;

    schema
    {
    textelement(Root)
    {
    tableelement(Vendor;
    Vendor)
    {
    XmlName = 'Vendor';

    fieldelement(No;
    Vendor."No.")
    {
    }
    fieldelement(Name;
    Vendor.Name)
    {
    }
    fieldelement(SearchName;
    Vendor."Search Name")
    {
    }
    fieldelement(Name2;
    Vendor."Name 2")
    {
    }
    fieldelement(Address;
    Vendor.Address)
    {
    }
    fieldelement(Address2;
    Vendor."Address 2")
    {
    }
    fieldelement(City;
    Vendor.City)
    {
    }
    fieldelement(Contact;
    Vendor.Contact)
    {
    }
    fieldelement(PhoneNo;
    Vendor."Phone No.")
    {
    }
    fieldelement(TelexNo;
    Vendor."Telex No.")
    {
    }
    fieldelement(OurAccountNo;
    Vendor."Our Account No.")
    {
    }
    textelement(TerritoryCode)
    {
    }
    fieldelement(GlobalDimension1Code;
    Vendor."Global Dimension 1 Code")
    {
    }
    fieldelement(GlobalDimension2Code;
    Vendor."Global Dimension 2 Code")
    {
    }
    fieldelement(BudgetedAmount;
    Vendor."Budgeted Amount")
    {
    }
    textelement(VendorPostingGroup)
    {
    }
    fieldelement(CurrencyCode;
    Vendor."Currency Code")
    {
    }
    fieldelement(LanguageCode;
    Vendor."Language Code")
    {
    }
    fieldelement(StatisticsGroup;
    Vendor."Statistics Group")
    {
    }
    textelement(PaymentTermsCode)
    {
    }
    fieldelement(FinChargeTermsCode;
    Vendor."Fin. Charge Terms Code")
    {
    }
    textelement(PurchaserCode)
    {
    }
    fieldelement(ShipmentMethodCode;
    Vendor."Shipment Method Code")
    {
    }
    fieldelement(ShippingAgentCode;
    Vendor."Shipping Agent Code")
    {
    }
    fieldelement(InvoiceDiscCode;
    Vendor."Invoice Disc. Code")
    {
    }
    fieldelement(CountryCode;
    Vendor."Country/Region Code")
    {
    }
    fieldelement(Blocked;
    Vendor.Blocked)
    {
    }
    textelement(PaytoVendorNo)
    {
    }
    fieldelement(Priority;
    Vendor.Priority)
    {
    }
    fieldelement(PaymentMethodCode;
    Vendor."Payment Method Code")
    {
    }
    fieldelement(LastDateModified;
    Vendor."Last Date Modified")
    {
    }
    fieldelement(ApplicationMethod;
    Vendor."Application Method")
    {
    }
    textelement(PricesIncludingVAT)
    {
    }
    fieldelement(FaxNo;
    Vendor."Fax No.")
    {
    }
    fieldelement(TelexAnswerBack;
    Vendor."Telex Answer Back")
    {
    }
    fieldelement(VATRegistrationNo;
    Vendor."VAT Registration No.")
    {
    }
    textelement(GenBusPostingGroup)
    {
    }
    fieldelement(PostCode;
    Vendor."Post Code")
    {
    }
    fieldelement(County;
    Vendor.County)
    {
    }
    textelement(EMail)
    {
    }
    fieldelement(HomePage;
    Vendor."Home Page")
    {
    }
    textelement(NoSeries)
    {
    }
    fieldelement(TaxAreaCode;
    Vendor."Tax Area Code")
    {
    }
    fieldelement(TaxLiable;
    Vendor."Tax Liable")
    {
    }
    textelement(VATBusPostingGroup)
    {
    }
    fieldelement(BlockPaymentTolerance;
    Vendor."Block Payment Tolerance")
    {
    }
    fieldelement(ICPartnerCode;
    Vendor."IC Partner Code")
    {
    }
    textelement(PrimaryContactNo)
    {
    }
    fieldelement(ResponsibilityCenter;
    Vendor."Responsibility Center")
    {
    }
    fieldelement(LocationCode;
    Vendor."Location Code")
    {
    }
    fieldelement(LeadTimeCalculation;
    Vendor."Lead Time Calculation")
    {
    }
    textelement(ReverseAuctionParticipant)
    {
    }
    textelement(NotificationProcessCode)
    {
    }
    textelement(QueuePriority)
    {
    }
    fieldelement(BaseCalendarCode;
    Vendor."Base Calendar Code")
    {
    }
    fieldelement(UPSZone;
    Vendor."UPS Zone")
    {
    }
    fieldelement(FederalIDNo;
    Vendor."Federal ID No.")
    {
    }
    fieldelement(BankCommunication;
    Vendor."Bank Communication")
    {
    }
    fieldelement(CheckDateFormat;
    Vendor."Check Date Format")
    {
    }
    fieldelement(CheckDateSeparator;
    Vendor."Check Date Separator")
    {
    }
    fieldelement(s1099Code;
    Vendor."IRS 1099 Code")
    {
    }
    textelement(DefaultCOANo)
    {
    }
    textelement(EShipAgentService)
    {
    }
    textelement(ResidentialDelivery)
    {
    }
    textelement(IRSEINNumber)
    {
    }
    textelement(ShippingPaymentType)
    {
    }
    textelement(ShippingInsurance)
    {
    }
    textelement(EMailRuleCode)
    {
    }
    textelement(UseEMailRuleforOrderAddr)
    {
    }
    textelement(CheckForNote)
    {
    }
    trigger OnAfterInitRecord()
    begin
        Vendor.Init;
        Clear(PaytoVendorNo);
        Clear(NoSeries);
        Clear(EMail);
        Clear(PricesIncludingVAT);
        Clear(PaymentTermsCode);
        Clear(PurchaserCode);
    end;
    trigger OnBeforeInsertRecord()
    begin
        Vendor."No. Series":=NoSeries;
        Vendor."Pay-to Vendor No.":=PaytoVendorNo;
        Vendor."E-Mail":=EMail;
        // Posting Groups
        //VALIDATE("Gen. Bus. Posting Group",'ALL');
        //VALIDATE("Vendor Posting Group",'ALL');
        Evaluate(Vendor."Prices Including VAT", PricesIncludingVAT);
        if PaymentTermsCode <> '' then if not PaymentTerms.Get(PaymentTermsCode)then begin
                PaymentTerms.Init;
                PaymentTerms.Code:=PaymentTermsCode;
                PaymentTerms.Description:='IMPORTED';
                PaymentTerms.Insert;
            end;
        Vendor.Validate("Payment Terms Code", PaymentTermsCode);
        if PurchaserCode <> '' then if not Salesperson.Get(PurchaserCode)then begin
                Salesperson.Init;
                Salesperson.Code:=PurchaserCode;
                Salesperson.Name:='IMPORTED';
                Salesperson.Insert;
            end;
        Vendor.Validate("Purchaser Code", PurchaserCode);
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
        // Check Pay-to Vendors
        Vendor.Reset;
        if Vendor.FindSet(false)then repeat if Vendor."Pay-to Vendor No." <> '' then begin
                    if not Vendor2.Get(Vendor."Pay-to Vendor No.")then begin
                        ImportLog.LogMsg('500', 'Pay-to Vendor Not Found', 'Field Left Blank', ImportLog."Msg. Type"::Error, 'Vendor No.', Vendor."No.", 'Pay-to Vendor No.', Vendor."Pay-to Vendor No.", '', '');
                        Vendor."Pay-to Vendor No.":='';
                        Vendor.Modify;
                    end;
                end;
            until Vendor.Next = 0;
    end;
    trigger OnPreXmlPort()
    begin
        ImportLog.StartImport('VENDOR');
    end;
    var ImportLog: Record "Import Message Log";
    Vendor2: Record Vendor;
    PaymentTerms: Record "Payment Terms";
    Salesperson: Record "Salesperson/Purchaser";
}
