tableextension 60035 "ContactExt" extends Contact
{
    DataCaptionFields = "No.", Name;

    fields
    {
        field(50050; "Customer No."; Code[20])
        {
            CalcFormula = Lookup("Contact Business Relation"."No." WHERE("Contact No."=FIELD("No."), "Link to Table"=CONST(Customer)));
            Caption = 'Customer No.';
            Description = 'ISS2.00';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Customer;
        }
        field(50051; Blocked; Boolean)
        {
            Caption = 'Blocked';
            Description = 'ISS2.00';
        }
        field(50099; "Date Created"; Date)
        {
            Description = 'ISS2.00';
        }
        field(50100; "Lead Source Code"; Code[50])
        {
            Description = 'ISS2.00';
            TableRelation = "Lead Source".Code;
        }
        field(50101; ID_Status; Option)
        {
            OptionCaption = ', ,Cold Qualified Lead, Customer, Dead, Do Not Call, Prospect, Secondary Contact, Unqualified Lead, Vendor, Customer Do Not Call, Customer Secondary Contact, Delete, Out of Business';
            OptionMembers = , " ", "Cold Qualified Lead", " Customer", " Dead", " Do Not Call", " Prospect", " Secondary Contact", " Unqualified Lead", " Vendor", " Customer Do Not Call", " Customer Secondary Contact", " Delete", " Out of Business";
        }
        field(50102; Department; Text[50])
        {
        }
        field(50103; "SIC Code"; Text[50])
        {
        }
        field(50104; "Automated Pkg"; Text[50])
        {
        }
        field(50105; "User 3"; Text[50])
        {
            Caption = 'Telemarketing';
        }
        field(50106; "User 4"; Text[50])
        {
        }
        field(50107; "Mailing Data"; Text[50])
        {
        }
        field(50108; "Lead Group ID"; Text[50])
        {
        }
        field(50109; "User 7"; Text[50])
        {
        }
        field(50110; Revenue; Decimal)
        {
            DecimalPlaces = 2: 2;
        }
        field(50111; "Product Type"; Text[100])
        {
        }
        field(50112; Employees; Text[50])
        {
        }
        field(50113; "# of Employees"; Integer)
        {
        }
        field(50114; Region; Text[50])
        {
        }
        field(50115; Territory; Option)
        {
            OptionCaption = ', ,East,Mid West,North,North East,North West,South,South East,South West,West';
            OptionMembers = , " ", East, "Mid West", North, "North East", "North West", South, "South East", "South West", West;
        }
        field(50116; Division; Text[50])
        {
        }
        field(50117; "County Name"; Text[50])
        {
        }
        field(50118; "Add to Newsletter"; Boolean)
        {
        }
        field(50120; "Printers - Brady"; Boolean)
        {
            Caption = 'Brady';
        }
        field(50121; "Printers - Datamax"; Boolean)
        {
            Caption = 'Datamax';
        }
        field(50122; "Printers - Epson"; Boolean)
        {
            Caption = 'Epson';
        }
        field(50123; "Printers - GHS Printing"; Boolean)
        {
            Caption = 'GHS Printing';
        }
        field(50124; "Printers - Godex"; Boolean)
        {
            Caption = 'Godex';
        }
        field(50125; "Printers - HP"; Boolean)
        {
            Caption = 'HP';
        }
        field(50126; "Printers - Intermec"; Boolean)
        {
            Caption = 'Intermec';
        }
        field(50127; "Printers - Printronix"; Boolean)
        {
            Caption = 'Printronix';
        }
        field(50128; "Printers - Sato"; Boolean)
        {
            Caption = 'Sato';
        }
        field(50129; "Printers - Void Fill"; Boolean)
        {
            Caption = 'Void Fill';
        }
        field(50130; "Printers - Zebra"; Boolean)
        {
            Caption = 'Zebra';
        }
        field(50131; "Printers - None"; Boolean)
        {
            Caption = 'None';
        }
        field(50132; "Printers - Model / Details"; Text[200])
        {
            Caption = 'Model / Details';
        }
        field(50133; "Bagging - Automated Packaging"; Boolean)
        {
            Caption = 'Automated Packaging';
        }
        field(50134; "Bagging - Model / Details"; Text[200])
        {
            Caption = 'Model / Details';
        }
        field(50135; "Scanners - Datalogic"; Boolean)
        {
            Caption = 'Datalogic';
        }
        field(50136; "Scanners - Honeywell"; Boolean)
        {
            Caption = 'Honeywell';
        }
        field(50137; "Scanners - Intermec"; Boolean)
        {
            Caption = 'Intermec';
        }
        field(50138; "Scanners - Many Various"; Boolean)
        {
        }
        field(50139; "Scanners - Zebra/Motorola/Symb"; Boolean)
        {
            Caption = 'Zebra/Motorola/Symbol';
        }
        field(50140; "Scanners - None"; Boolean)
        {
            Caption = 'None';
        }
        field(50141; "Scanners - Model / Details"; Text[200])
        {
            Caption = 'Model / Details';
        }
        field(50142; "Printers - CAB"; Boolean)
        {
            Caption = 'CAB';
        }
        field(50143; "Printers - MARKEM"; Boolean)
        {
            Caption = 'MARKEM';
        }
        field(50144; "Printers - Primera"; Boolean)
        {
            Caption = 'Primera';
        }
        field(50145; "Printers - TSC"; Boolean)
        {
            Caption = 'TSC';
        }
        field(50146; "Printers - VIDEOJET"; Boolean)
        {
            Caption = 'VIDEOJET';
        }
        field(50147; "Software - Bartender"; Boolean)
        {
            Caption = 'Bartender';
        }
        field(50148; "Software - Loftware"; Boolean)
        {
            Caption = 'Loftware';
        }
        field(50149; "Software - Nicelabel"; Boolean)
        {
            Caption = 'Nicelabel';
        }
        field(50150; "Software - Other"; Boolean)
        {
            Caption = 'Other';
        }
        field(50151; "Software - Teklynx"; Boolean)
        {
            Caption = 'Teklynx';
        }
        field(50152; "Terminals - Datalogic"; Boolean)
        {
            Caption = 'Datalogic';
        }
        field(50153; "Terminals - Honeywell"; Boolean)
        {
            Caption = 'Honeywell';
        }
        field(50154; "Terminals - Intermec"; Boolean)
        {
            Caption = 'Intermec';
        }
        field(50155; "Terminals - None"; Boolean)
        {
            Caption = 'None';
        }
        field(50156; "Terminals - Psion"; Boolean)
        {
            Caption = 'Psion';
        }
        field(50157; "Terminals - Zebra/Motorola/Sym"; Boolean)
        {
            Caption = 'Zebra/Motorola/Symbol';
        }
        field(50158; "Service Contracts - APC"; Boolean)
        {
            Caption = 'APC';
        }
        field(50159; "Service Contracts - Bartender"; Boolean)
        {
            Caption = 'Bartender';
        }
        field(50160; "Service Contracts - Honeywell"; Boolean)
        {
            Caption = 'Honeywell';
        }
        field(50161; "Service Contracts - Imprint"; Boolean)
        {
            Caption = 'Imprint';
        }
        field(50162; "Service Contracts - NSC"; Boolean)
        {
            Caption = 'NSC';
        }
        field(50163; "Service Contracts - Zebra/Moto"; Boolean)
        {
            Caption = 'Zebra/Motorola';
        }
        field(50164; "Software - Details"; Text[200])
        {
            Caption = 'Details';
        }
        field(50165; "Terminals - Details"; Text[200])
        {
            Caption = 'Details';
        }
        field(50166; "Service Contracts - Details"; Text[200])
        {
            Caption = 'Details';
        }
        field(50167; "Accounts Payable Contact"; Boolean)
        {
            trigger OnValidate()
            begin
            //IMP1.01 Start
            /*
                UserRecGbl.RESET;
                UserRecGbl.SETRANGE("User Name",USERID);
                UserRecGbl.SETRANGE("Edit Accounts Payable Contacts",TRUE);
                IF NOT UserRecGbl.FINDFIRST THEN
                  ERROR(Text50001,UserRecGbl.FIELDCAPTION("Edit Accounts Payable Contacts"),UserRecGbl.TABLECAPTION);
                */
            /*
                IF "Accounts Payable Contact" <> xRec."Accounts Payable Contact" THEN BEGIN
                  IF NOT "Accounts Payable Contact" THEN
                    IF NOT UserMgmt.CheckEditAccountPay THEN
                      ERROR(Text50001);
                  IF NOT xRec."Accounts Payable Contact" AND "Accounts Payable Contact" THEN BEGIN
                    IF NOT CONFIRM(Text50002,FALSE,"No.") THEN
                      ERROR(Text50003);
                  END;
                END;
                */
            //IMP1.01 End
            end;
        }
        field(50168; Extension; Text[50])
        {
        }
        field(50169; "Industry - Food"; Boolean)
        {
        }
        field(50170; "Industry - Beverage"; Boolean)
        {
        }
        field(50171; "Industry - Medical & UDI"; Boolean)
        {
        }
        field(50172; "Industry - Chemicals & GHS"; Boolean)
        {
        }
        field(50173; "Industry - Transportation & Lo"; Boolean)
        {
            Caption = 'Industry - Transportation & Logistics';
        }
        field(50174; "Industry - Co-Packaging"; Boolean)
        {
        }
        field(50175; "Industry - Manufacturing"; Boolean)
        {
        }
        field(50176; "Industry - Cannabis"; Boolean)
        {
        }
        field(50177; "Industry - Fulfillment"; Boolean)
        {
        }
        field(50178; "Responsibility - Purchasing"; Boolean)
        {
        }
        field(50179; "Responsibility - IT"; Boolean)
        {
        }
        field(50180; "Responsibility - Plant Manager"; Boolean)
        {
        }
        field(50181; "Responsibility - Shipping Mgr."; Boolean)
        {
        }
        field(50182; "Responsibility - Receiving Mgr"; Boolean)
        {
            Caption = 'Responsibility - Receiving Mgr.';
        }
        field(50183; "Responsibility - Operations"; Boolean)
        {
        }
        field(50184; "Responsibility - Logistics"; Boolean)
        {
        }
        field(50185; "Responsibility - Engineering"; Boolean)
        {
        }
        field(50186; "Responsibility - Maintenanace"; Boolean)
        {
        }
        field(50187; "Responsibility - Other"; Boolean)
        {
        }
        modify(Name)
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Search Name")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Name 2")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify(Address)
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Address 2")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify(City)
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Phone No.")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Telex No.")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Territory Code")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Language Code")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Currency Code")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Salesperson Code")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Country/Region Code")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify(Comment)
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Fax No.")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Telex Answer Back")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("VAT Registration No.")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify(Image)
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Post Code")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify(County)
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("E-Mail")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Home Page")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("No. Series")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify(Type)
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Company No.")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Company Name")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Lookup Contact No.")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Job Title")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Extension No.")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Mobile Phone No.")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify(Pager)
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Organizational Level Code")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Exclude from Segment")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("No. of Job Responsibilities")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("No. of Industry Groups")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("No. of Business Relations")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("No. of Mailing Groups")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("External ID")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("No. of Interactions")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Cost (LCY)")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Duration (Min.)")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("No. of Opportunities")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Estimated Value (LCY)")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Calcd. Current Value (LCY)")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Opportunity Entry Exists")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Task Entry Exists")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Correspondence Type")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Salutation Code")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("Search E-Mail")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
        modify("E-Mail 2")
        {
        trigger OnAfterValidate()
        begin
            CheckUserStatus();
        end;
        }
    }
    keys
    {
        key(key100_; Revenue)
        {
        }
    }
    trigger OnAfterInsert()
    begin
        //IMP1.01 Start
        IF GETFILTER("Company No.") <> '' THEN IF GETRANGEMIN("Company No.") = GETRANGEMAX("Company No.")THEN BEGIN
                Type:=Type::Person;
                VALIDATE("Company No.", GETRANGEMIN("Company No."));
            END;
        //IMP1.01 ENd
        // ISS2.00 11.01.13 DFP ===========================================\
        "Date Created":=WORKDATE;
    // End ============================================================/
    end;
    trigger OnBeforeDelete()
    begin
        CheckUserStatus; //IMP1.01
    end;
    PROCEDURE "---IMP1.01---"();
    BEGIN
    END;
    PROCEDURE CheckUserStatus();
    BEGIN
        IF "Accounts Payable Contact" THEN IF NOT UpdateCodeGVar.CheckEditAccountPay THEN ERROR(Text50001);
    END;
    var UserRecGbl: Record 2000000120;
    UpdateCodeGVar: Codeunit UpdateCode;
    Text50001: label 'You do not have permission to Update or Delete the  Accounts Payable Contacts';
    UserMgmt: Codeunit 418;
    Text50002: label 'Making contact %1 as Account Payable Contact will lead to user permission issues for further modifications on this contact. Do you want to proceed?';
    Text50003: label 'Update interrupted to respect the warning.';
    UserSetup: Record 91;
    UserSetupFound: Boolean;
}
