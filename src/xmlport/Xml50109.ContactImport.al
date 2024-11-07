xmlport 50109 "Contact Import"
{
    schema
    {
    textelement(Root)
    {
    tableelement(Contact;
    Contact)
    {
    AutoSave = false;
    XmlName = 'Contact';

    fieldelement(No;
    Contact."No.")
    {
    }
    fieldelement(Name;
    Contact.Name)
    {
    }
    fieldelement(SearchName;
    Contact."Search Name")
    {
    }
    fieldelement(Name2;
    Contact."Name 2")
    {
    }
    fieldelement(Address;
    Contact.Address)
    {
    }
    fieldelement(Address2;
    Contact."Address 2")
    {
    }
    fieldelement(City;
    Contact.City)
    {
    }
    fieldelement(PhoneNo;
    Contact."Phone No.")
    {
    }
    fieldelement(TelexNo;
    Contact."Telex No.")
    {
    }
    textelement(territorycode)
    {
    XmlName = 'TerritoryCode';
    }
    fieldelement(CurrencyCode;
    Contact."Currency Code")
    {
    }
    fieldelement(LanguageCode;
    Contact."Language Code")
    {
    }
    textelement(SalespersonCode)
    {
    }
    fieldelement(CountryCode;
    Contact."Country/Region Code")
    {
    }
    fieldelement(LastDateModified;
    Contact."Last Date Modified")
    {
    }
    fieldelement(FaxNo;
    Contact."Fax No.")
    {
    }
    fieldelement(TelexAnswerBack;
    Contact."Telex Answer Back")
    {
    }
    textelement(VATRegNo)
    {
    }
    fieldelement(PostCost;
    Contact."Post Code")
    {
    }
    fieldelement(County;
    Contact.County)
    {
    }
    fieldelement(EMail;
    Contact."E-Mail")
    {
    }
    fieldelement(HomePage;
    Contact."Home Page")
    {
    }
    textelement(NoSeries)
    {
    }
    fieldelement(Type;
    Contact.Type)
    {
    }
    textelement(CompanyNo)
    {
    }
    textelement(xcompanyname)
    {
    XmlName = 'CompanyName';
    }
    textelement(LookupContactNo)
    {
    }
    fieldelement(FirstName;
    Contact."First Name")
    {
    }
    fieldelement(MiddleName;
    Contact."Middle Name")
    {
    }
    fieldelement(Surname;
    Contact.Surname)
    {
    }
    textelement(JobTitle)
    {
    }
    fieldelement(Initials;
    Contact.Initials)
    {
    }
    fieldelement(ExtensionNo;
    Contact."Extension No.")
    {
    }
    fieldelement(MobilePhoneNo;
    Contact."Mobile Phone No.")
    {
    }
    fieldelement(Pager;
    Contact.Pager)
    {
    }
    fieldelement(OrgLevel;
    Contact."Organizational Level Code")
    {
    }
    fieldelement(ExcludeFromSeg;
    Contact."Exclude from Segment")
    {
    }
    fieldelement(ExtID;
    Contact."External ID")
    {
    }
    fieldelement(CorrType;
    Contact."Correspondence Type")
    {
    }
    fieldelement(SalutationCode;
    Contact."Salutation Code")
    {
    }
    fieldelement(SearchEmail;
    Contact."Search E-Mail")
    {
    }
    textelement(VersionNo)
    {
    }
    fieldelement(LastTimeModified;
    Contact."Last Time Modified")
    {
    }
    textelement(Password)
    {
    }
    textelement(PasswordPacking)
    {
    }
    textelement(LoginID)
    {
    }
    textelement(NotificationProcess)
    {
    }
    textelement(EnablementDate)
    {
    }
    textelement(QueuePriority)
    {
    }
    textelement(OnlineUserType)
    {
    }
    textelement(OnBehalfOf)
    {
    }
    textelement(CatalogSet)
    {
    }
    textelement(ContactClassification)
    {
    }
    textelement(Blocked)
    {
    }
    trigger OnAfterGetRecord()
    begin
    /*
                    WITH Contact DO BEGIN
                      IF (Type = Type::Person) AND
                         ("Company No." = '') THEN
                        currXMLport.SKIP;
                    
                      IF ("Last Date Modified" = 031810D) THEN
                        currXMLport.SKIP;
                    END;
                    */
    end;
    trigger OnAfterInitRecord()
    begin
        Clear(CompanyNo);
        Clear(xCompanyName);
        Clear(SalespersonCode);
        Clear(NoSeries);
        Clear(VATRegNo);
        Clear(TerritoryCode);
        Clear(LookupContactNo);
        Clear(JobTitle);
    end;
    trigger OnBeforeInsertRecord()
    begin
        if CompanyNo <> '' then begin
            //"Company No." := CompanyNo;
            //"Company Name" := xCompanyName;
            Contact.Validate("Company No.", CompanyNo);
            Contact.Validate("Company Name", xCompanyName);
        end;
        if Salesperson.Get(SalespersonCode)then Contact.Validate("Salesperson Code", SalespersonCode);
        Contact."No. Series":=NoSeries;
        Contact."VAT Registration No.":=VATRegNo;
        if TerritoryCode <> '' then begin
            if not LeadSource.Get(TerritoryCode)then begin
                LeadSource.Init;
                LeadSource.Code:=TerritoryCode;
                LeadSource.Insert;
            end;
        end;
        Contact.Validate("Lead Source Code", TerritoryCode);
        Contact."Job Title":=CopyStr(JobTitle, 1, 30);
        Contact.Insert(true);
        Contact.Validate("Lookup Contact No.", LookupContactNo);
        Contact.Modify;
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
    var Salesperson: Record "Salesperson/Purchaser";
    LeadSource: Record "Lead Source";
}
