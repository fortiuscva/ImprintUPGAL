pageextension 60070 "ContactCardExt" extends "Contact Card"
{
    layout
    {
        addafter("Search Name")
        {
            field(Extension; Rec.Extension)
            {
                ApplicationArea = All;
            }
        }
        movebefore(Extension; "Phone No.")
        addafter("Salesperson Code")
        {
            field(ID_Status; Rec.ID_Status)
            {
                ApplicationArea = All;
                OptionCaption = '<, ,Cold Qualified Lead, Customer, Dead, Do Not Call, Prospect, Secondary Contact, Unqualified Lead, Vendor, Customer Do Not Call, Customer Secondary Contact, Delete, Out of Business';
            }
            field("Lead Source Code"; Rec."Lead Source Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Organizational Level Code")
        {
            field("Date Created"; Rec."Date Created")
            {
                ApplicationArea = All;
            }
        }
        addafter("Parental Consent Received")
        {
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
            }
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = All;
            }
            field("Accounts Payable Contact"; Rec."Accounts Payable Contact")
            {
                ApplicationArea = All;
            }
        }
        addfirst(Communication)
        {
            field("Add to Newsletter"; Rec."Add to Newsletter")
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Title")
        {
            field(Department; Rec.Department)
            {
                ApplicationArea = All;
            }
        }
        addafter("Profile Questionnaire")
        {
            group("User Fields")
            {
                field("SIC Code"; Rec."SIC Code")
                {
                    ApplicationArea = All;
                }
                field("Automated Pkg"; Rec."Automated Pkg")
                {
                    ApplicationArea = All;
                }
                field("User 3"; Rec."User 3")
                {
                    ApplicationArea = All;
                }
                field("User 4"; Rec."User 4")
                {
                    ApplicationArea = All;
                }
                field("Mailing Data"; Rec."Mailing Data")
                {
                    ApplicationArea = All;
                }
                field("Lead Group ID"; Rec."Lead Group ID")
                {
                    ApplicationArea = All;
                }
                field("User 7"; Rec."User 7")
                {
                    ApplicationArea = All;
                }
                field(Revenue; Rec.Revenue)
                {
                    ApplicationArea = All;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                }
                field(Employees; Rec.Employees)
                {
                    ApplicationArea = All;
                }
            }
            group(Printers)
            {
                Caption = 'Printers';

                field("Printers - Brady"; Rec."Printers - Brady")
                {
                    ApplicationArea = All;
                }
                field("Printers - Datamax"; Rec."Printers - Datamax")
                {
                    ApplicationArea = All;
                }
                field("Printers - Epson"; Rec."Printers - Epson")
                {
                    ApplicationArea = All;
                }
                field("Printers - GHS Printing"; Rec."Printers - GHS Printing")
                {
                    ApplicationArea = All;
                }
                field("Printers - Godex"; Rec."Printers - Godex")
                {
                    ApplicationArea = All;
                }
                field("Printers - HP"; Rec."Printers - HP")
                {
                    ApplicationArea = All;
                }
                field("Printers - Intermec"; Rec."Printers - Intermec")
                {
                    ApplicationArea = All;
                }
                field("Printers - Printronix"; Rec."Printers - Printronix")
                {
                    ApplicationArea = All;
                }
                field("Printers - Sato"; Rec."Printers - Sato")
                {
                    ApplicationArea = All;
                }
                field("Printers - Void Fill"; Rec."Printers - Void Fill")
                {
                    ApplicationArea = All;
                }
                field("Printers - Zebra"; Rec."Printers - Zebra")
                {
                    ApplicationArea = All;
                }
                field("Printers - CAB"; Rec."Printers - CAB")
                {
                    ApplicationArea = All;
                }
                field("Printers - MARKEM"; Rec."Printers - MARKEM")
                {
                    ApplicationArea = All;
                }
                field("Printers - Primera"; Rec."Printers - Primera")
                {
                    ApplicationArea = All;
                }
                field("Printers - TSC"; Rec."Printers - TSC")
                {
                    ApplicationArea = All;
                }
                field("Printers - VIDEOJET"; Rec."Printers - VIDEOJET")
                {
                    ApplicationArea = All;
                }
                field("Printers - None"; Rec."Printers - None")
                {
                    ApplicationArea = All;
                }
                field("Printers - Model / Details"; Rec."Printers - Model / Details")
                {
                    ApplicationArea = All;
                }
            }
            group(Terminals)
            {
                Caption = 'Terminals';

                field("Terminals - Datalogic"; Rec."Terminals - Datalogic")
                {
                    ApplicationArea = All;
                }
                field("Terminals - Honeywell"; Rec."Terminals - Honeywell")
                {
                    ApplicationArea = All;
                }
                field("Terminals - Intermec"; Rec."Terminals - Intermec")
                {
                    ApplicationArea = All;
                }
                field("Terminals - Psion"; Rec."Terminals - Psion")
                {
                    ApplicationArea = All;
                }
                field("Terminals - Zebra/Motorola/Sym"; Rec."Terminals - Zebra/Motorola/Sym")
                {
                    ApplicationArea = All;
                }
                field("Terminals - None"; Rec."Terminals - None")
                {
                    ApplicationArea = All;
                }
                field("Terminals - Details"; Rec."Terminals - Details")
                {
                    ApplicationArea = All;
                }
            }
            group(Software)
            {
                Caption = 'Software';

                field("Software - Bartender"; Rec."Software - Bartender")
                {
                    ApplicationArea = All;
                }
                field("Software - Loftware"; Rec."Software - Loftware")
                {
                    ApplicationArea = All;
                }
                field("Software - Nicelabel"; Rec."Software - Nicelabel")
                {
                    ApplicationArea = All;
                }
                field("Software - Teklynx"; Rec."Software - Teklynx")
                {
                    ApplicationArea = All;
                }
                field("Software - Other"; Rec."Software - Other")
                {
                    ApplicationArea = All;
                }
                field("Software - Details"; Rec."Software - Details")
                {
                    ApplicationArea = All;
                }
            }
            group(Bagging)
            {
                Caption = 'Bagging';

                field("Bagging - Automated Packaging"; Rec."Bagging - Automated Packaging")
                {
                    ApplicationArea = All;
                }
                field("Bagging - Model / Details"; Rec."Bagging - Model / Details")
                {
                    ApplicationArea = All;
                }
            }
            group(Scanners)
            {
                Caption = 'Scanners';

                field("Scanners - Datalogic"; Rec."Scanners - Datalogic")
                {
                    ApplicationArea = All;
                }
                field("Scanners - Honeywell"; Rec."Scanners - Honeywell")
                {
                    ApplicationArea = All;
                }
                field("Scanners - Intermec"; Rec."Scanners - Intermec")
                {
                    ApplicationArea = All;
                }
                field("Scanners - Zebra/Motorola/Symb"; Rec."Scanners - Zebra/Motorola/Symb")
                {
                    ApplicationArea = All;
                }
                field("Scanners - None"; Rec."Scanners - None")
                {
                    ApplicationArea = All;
                }
                field("Scanners - Model / Details"; Rec."Scanners - Model / Details")
                {
                    ApplicationArea = All;
                }
            }
            group("Service Contracts")
            {
                Caption = 'Service Contracts';

                field("Service Contracts - APC"; Rec."Service Contracts - APC")
                {
                    ApplicationArea = All;
                }
                field("Service Contracts - Bartender"; Rec."Service Contracts - Bartender")
                {
                    ApplicationArea = All;
                }
                field("Service Contracts - Honeywell"; Rec."Service Contracts - Honeywell")
                {
                    ApplicationArea = All;
                }
                field("Service Contracts - Imprint"; Rec."Service Contracts - Imprint")
                {
                    ApplicationArea = All;
                }
                field("Service Contracts - NSC"; Rec."Service Contracts - NSC")
                {
                    ApplicationArea = All;
                }
                field("Service Contracts - Zebra/Moto"; Rec."Service Contracts - Zebra/Moto")
                {
                    ApplicationArea = All;
                }
                field("Service Contracts - Details"; Rec."Service Contracts - Details")
                {
                    ApplicationArea = All;
                }
            }
            group("Industry and Responsibility")
            {
                Caption = 'Industry and Responsibility';

                field("Industry - Food"; Rec."Industry - Food")
                {
                    ApplicationArea = All;
                }
                field("Industry - Beverage"; Rec."Industry - Beverage")
                {
                    ApplicationArea = All;
                }
                field("Industry - Medical & UDI"; Rec."Industry - Medical & UDI")
                {
                    ApplicationArea = All;
                }
                field("Industry - Chemicals & GHS"; Rec."Industry - Chemicals & GHS")
                {
                    ApplicationArea = All;
                }
                field("Industry - Transportation & Lo"; Rec."Industry - Transportation & Lo")
                {
                    ApplicationArea = All;
                }
                field("Industry - Co-Packaging"; Rec."Industry - Co-Packaging")
                {
                    ApplicationArea = All;
                }
                field("Industry - Manufacturing"; Rec."Industry - Manufacturing")
                {
                    ApplicationArea = All;
                }
                field("Industry - Cannabis"; Rec."Industry - Cannabis")
                {
                    ApplicationArea = All;
                }
                field("Industry - Fulfillment"; Rec."Industry - Fulfillment")
                {
                    ApplicationArea = All;
                }
                field("Responsibility - Purchasing"; Rec."Responsibility - Purchasing")
                {
                    ApplicationArea = All;
                }
                field("Responsibility - IT"; Rec."Responsibility - IT")
                {
                    ApplicationArea = All;
                }
                field("Responsibility - Plant Manager"; Rec."Responsibility - Plant Manager")
                {
                    ApplicationArea = All;
                }
                field("Responsibility - Shipping Mgr."; Rec."Responsibility - Shipping Mgr.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility - Receiving Mgr"; Rec."Responsibility - Receiving Mgr")
                {
                    ApplicationArea = All;
                }
                field("Responsibility - Operations"; Rec."Responsibility - Operations")
                {
                    ApplicationArea = All;
                }
                field("Responsibility - Logistics"; Rec."Responsibility - Logistics")
                {
                    ApplicationArea = All;
                }
                field("Responsibility - Engineering"; Rec."Responsibility - Engineering")
                {
                    ApplicationArea = All;
                }
                field("Responsibility - Maintenanace"; Rec."Responsibility - Maintenanace")
                {
                    ApplicationArea = All;
                }
                field("Responsibility - Other"; Rec."Responsibility - Other")
                {
                    ApplicationArea = All;
                }
            }
            part(Interactions; "Interactions Contact Card Part")
            {
                Caption = 'Interactions';
                ShowFilter = false;
                SubPageLink = "Contact Company No."=FIELD("Company No."), "Contact No."=FILTER(<>''), "Contact No."=FIELD(FILTER("Lookup Contact No."));
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
