page 50088 "Contacts - Dormant Contacts"
{
    // ISS2.00 11.08.13 DFP - Added call to FilterSalesperson in OnOpenPage
    // ISS2.00 07.25.13 DFP - Added field:
    //                          50100 "Lead Source Code" after "Salesperson Code"
    // IMP1.01,SP5333,12/15/16,ST: Added code to OnOpenPage()/.
    //                             Declared Goal Variable.
    // 
    // IMP1.02,SP5333,02/14/17,ST: Added Global Variables. Added code to OnOpenPage to filter the contact based on the requirement whcih is are not activr contact from ast 18 months.
    Caption = 'Contact List';
    CardPageID = "Contact Card";
    DataCaptionFields = "Company No.";
    Editable = false;
    PageType = List;
    SourceTable = Contact;
    SourceTableView = SORTING("Company Name", "Company No.", Type, Name);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'NAV Customer ID#';
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Caption = 'Last edit date';
                    ApplicationArea = All;
                }
                field(ID_Status; Rec.ID_Status)
                {
                    Caption = 'ID Status';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Lead Source Code"; Rec."Lead Source Code")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    Caption = 'State';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("C&ontact")
            {
                Caption = 'C&ontact';
                Image = ContactPerson;

                group("Comp&any")
                {
                    Caption = 'Comp&any';
                    Enabled = CompanyGroupEnabled;
                    Image = Company;

                    action("Business Relations")
                    {
                        Caption = 'Business Relations';
                        Image = BusinessRelation;
                        RunObject = Page "Contact Business Relations";
                        RunPageLink = "Contact No."=FIELD("Company No.");
                        ApplicationArea = All;
                    }
                    action("Industry Groups")
                    {
                        Caption = 'Industry Groups';
                        Image = IndustryGroups;
                        RunObject = Page "Contact Industry Groups";
                        RunPageLink = "Contact No."=FIELD("Company No.");
                        ApplicationArea = All;
                    }
                    action("Web Sources")
                    {
                        Caption = 'Web Sources';
                        Image = Web;
                        RunObject = Page "Contact Web Sources";
                        RunPageLink = "Contact No."=FIELD("Company No.");
                        ApplicationArea = All;
                    }
                }
                group("P&erson")
                {
                    Caption = 'P&erson';
                    Enabled = PersonGroupEnabled;
                    Image = User;

                    action("Job Responsibilities")
                    {
                        Caption = 'Job Responsibilities';
                        Image = Job;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ContJobResp: Record "Contact Job Responsibility";
                        begin
                            Rec.TestField(Type, Rec.Type::Person);
                            ContJobResp.SetRange("Contact No.", Rec."No.");
                            PAGE.RunModal(PAGE::"Contact Job Responsibilities", ContJobResp);
                        end;
                    }
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Contact Picture";
                    RunPageLink = "No."=FIELD("No.");
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Rlshp. Mgt. Comment Sheet";
                    RunPageLink = "Table Name"=CONST(Contact), "No."=FIELD("No."), "Sub No."=CONST(0);
                    ApplicationArea = All;
                }
                group("Alternati&ve Address")
                {
                    Caption = 'Alternati&ve Address';
                    Image = Addresses;

                    action(Card)
                    {
                        Caption = 'Card';
                        Image = EditLines;
                        RunObject = Page "Contact Alt. Address List";
                        RunPageLink = "Contact No."=FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Date Ranges")
                    {
                        Caption = 'Date Ranges';
                        Image = DateRange;
                        RunObject = Page "Contact Alt. Addr. Date Ranges";
                        RunPageLink = "Contact No."=FIELD("No.");
                        ApplicationArea = All;
                    }
                }
                separator(Action48)
                {
                Caption = '';
                }
            }
            group("Related Information")
            {
                Caption = 'Related Information';
                Image = Users;

                action("Relate&d Contacts")
                {
                    Caption = 'Relate&d Contacts';
                    Image = Users;
                    RunObject = Page "Contact List";
                    RunPageLink = "Company No."=FIELD("Company No.");
                    ApplicationArea = All;
                }
                separator(Action52)
                {
                Caption = '';
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;

                action("Sales &Quotes")
                {
                    Caption = 'Sales &Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quotes";
                    RunPageLink = "Sell-to Contact No."=FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Contact No.");
                    ApplicationArea = All;
                }
                separator(Action69)
                {
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;

                action("Postponed &Interactions")
                {
                    Caption = 'Postponed &Interactions';
                    Image = PostponedInteractions;
                    RunObject = Page "Postponed Interactions";
                    RunPageLink = "Contact Company No."=FIELD("Company No."), "Contact No."=FILTER(<>''), "Contact No."=FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                    ApplicationArea = All;
                }
                action("Interaction Log E&ntries")
                {
                    Caption = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    RunObject = Page "Interaction Log Entries";
                    RunPageLink = "Contact Company No."=FIELD("Company No."), "Contact No."=FILTER(<>''), "Contact No."=FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Contact Statistics";
                    RunPageLink = "No."=FIELD("No.");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Make &Phone Call")
                {
                    Caption = 'Make &Phone Call';
                    Image = Calls;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TAPIManagement: Codeunit TAPIManagement;
                    begin
                        TAPIManagement.DialContCustVendBank(DATABASE::Contact, Rec."No.", Rec."Phone No.", '');
                    end;
                }
                action("Launch &Web Source")
                {
                    Caption = 'Launch &Web Source';
                    Image = LaunchWeb;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ContactWebSource: Record "Contact Web Source";
                    begin
                        ContactWebSource.SetRange("Contact No.", Rec."Company No.");
                        if PAGE.RunModal(PAGE::"Web Source Launch", ContactWebSource) = ACTION::LookupOK then ContactWebSource.Launch;
                    end;
                }
                action("Print Cover &Sheet")
                {
                    Caption = 'Print Cover &Sheet';
                    Image = PrintCover;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Cont: Record Contact;
                    begin
                        Cont:=Rec;
                        Cont.SetRecFilter;
                        REPORT.Run(REPORT::"Contact - Cover Sheet", true, false, Cont);
                    end;
                }
                group("Create as")
                {
                    Caption = 'Create as';
                    Image = CustomerContact;

                    action(Customer)
                    {
                        Caption = 'Customer';
                        Image = Customer;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            // CreateCustomer(ChooseCustomerTemplate);
                            rec.CreateCustomerFromTemplate(rec.ChooseNewCustomerTemplate);
                        end;
                    }
                    action(Vendor)
                    {
                        Caption = 'Vendor';
                        Image = Vendor;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Rec.CreateVendor;
                        end;
                    }
                    action(Bank)
                    {
                        Caption = 'Bank';
                        Image = Bank;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Rec.CreateBankAccount;
                        end;
                    }
                }
                group("Link with existing")
                {
                    Caption = 'Link with existing';
                    Image = Links;

                    action(Action63)
                    {
                        Caption = 'Customer';
                        Image = Customer;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Rec.CreateCustomerLink;
                        end;
                    }
                    action(Action64)
                    {
                        Caption = 'Vendor';
                        Image = Vendor;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Rec.CreateVendorLink;
                        end;
                    }
                    action(Action65)
                    {
                        Caption = 'Bank';
                        Image = Bank;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Rec.CreateBankAccountLink;
                        end;
                    }
                }
            }
            action("Create &Interact")
            {
                Caption = 'Create &Interact';
                Image = CreateInteraction;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.CreateInteraction;
                end;
            }
        }
        area(creation)
        {
            action("New Sales Quote")
            {
                Caption = 'New Sales Quote';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Sales Quote";
                RunPageLink = "Sell-to Contact No."=FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            action("Contact Cover Sheet")
            {
                Caption = 'Contact Cover Sheet';
                Image = "Report";
                Promoted = false;
                ApplicationArea = All;

                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                trigger OnAction()
                begin
                    Cont:=Rec;
                    Cont.SetRecFilter;
                    REPORT.Run(REPORT::"Contact - Cover Sheet", true, false, Cont);
                end;
            }
            action("Contact Company Summary")
            {
                Caption = 'Contact Company Summary';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Contact - Company Summary";
                ApplicationArea = All;
            }
            action("Contact Labels")
            {
                Caption = 'Contact Labels';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Contact - Labels";
                ApplicationArea = All;
            }
            action("Questionnaire Handout")
            {
                Caption = 'Questionnaire Handout';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Questionnaire - Handouts";
                ApplicationArea = All;
            }
            action("Sales Cycle Analysis")
            {
                Caption = 'Sales Cycle Analysis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Cycle - Analysis";
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        EnableFields;
        StyleIsStrong:=Rec.Type = Rec.Type::Company;
        NameIndent:=0;
        if Rec.Type <> Rec.Type::Company then begin
            Cont.SetCurrentKey("Company Name", "Company No.", Type, Name);
            if(Rec."Company No." <> '') and (not Rec.HasFilter) and (not Rec.MarkedOnly) and (Rec.CurrentKey = Cont.CurrentKey)then NameIndent:=1 end;
    end;
    trigger OnOpenPage()
    begin
        /*
        // ISS2.00 DFP =========================================================\
        FilterSalesperson;
        // End =================================================================/
        */
        //IMP1.01 Start
        UserNameVarGbl:=CopyStr(UserId, 7);
        //SETRANGE("Salesperson Code",UserNameVarGbl);
        //IMP1.01 Emd
        //IMP1.03 Start
        LastDateVarGbl:=CalcDate('-12M', Today);
        Rec.FilterGroup(2);
        ContactRecGbl.Reset;
        ContactRecGbl.SetRange(Type, ContactRecGbl.Type::Company);
        if ContactRecGbl.FindSet then repeat if(ContactRecGbl."Last Date Modified" <= LastDateVarGbl)then begin
                    ContactRecGbl.Mark(true);
                    PersContRecGbl.Reset;
                    PersContRecGbl.SetRange(Type, PersContRecGbl.Type::Person);
                    PersContRecGbl.SetRange("Company No.", ContactRecGbl."No.");
                    PersContRecGbl.SetFilter("Last Date Modified", '>%1', LastDateVarGbl);
                    if not PersContRecGbl.FindFirst then ContactRecGbl.Mark(true)
                    else
                        ContactRecGbl.Mark(false);
                end;
            until ContactRecGbl.Next = 0;
        ContactRecGbl.MarkedOnly(true);
        Rec.FilterGroup(2);
        Rec.Copy(ContactRecGbl);
        Rec.FilterGroup(0);
    //IMP1.03 End
    end;
    var Cont: Record Contact;
    [InDataSet]
    StyleIsStrong: Boolean;
    [InDataSet]
    NameIndent: Integer;
    CompanyGroupEnabled: Boolean;
    PersonGroupEnabled: Boolean;
    "-IMP1.01-": Integer;
    UserNameVarGbl: Text;
    "-IMP1.02-": Integer;
    PersContRecGbl: Record Contact;
    ContactRecGbl: Record Contact;
    LastDateVarGbl: Date;
    local procedure EnableFields()
    begin
        CompanyGroupEnabled:=Rec.Type = Rec.Type::Company;
        PersonGroupEnabled:=Rec.Type = Rec.Type::Person;
    end;
}
