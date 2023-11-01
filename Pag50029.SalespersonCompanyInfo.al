page 50029 "Salesperson Company Info"
{
    PageType = Card;
    SourceTable = "Salesperson Company Info";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Name"; Rec."Salesperson Name")
                {
                    ApplicationArea = All;
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    Caption = 'State / ZIP Code';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';

                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';

                field("Quote Text 1"; Rec."Quote Text 1")
                {
                    ApplicationArea = All;
                }
                field("Quote Text 2"; Rec."Quote Text 2")
                {
                    ApplicationArea = All;
                }
                field("Quote Text 3"; Rec."Quote Text 3")
                {
                    ApplicationArea = All;
                }
                field("Quote Text 4"; Rec."Quote Text 4")
                {
                    ApplicationArea = All;
                }
                field("Document Tag Line"; Rec."Document Tag Line")
                {
                    ApplicationArea = All;
                }
                field("Document Banner"; Rec."Document Banner")
                {
                    ApplicationArea = All;
                }
            }
            group("Terms and Conditions")
            {
                Caption = 'Terms and Conditions';

                field("Terms and Cond. 1"; Rec."Terms and Cond. 1")
                {
                    ApplicationArea = All;
                }
                field("Terms and Cond. 2"; Rec."Terms and Cond. 2")
                {
                    ApplicationArea = All;
                }
                field("Terms and Cond. 3"; Rec."Terms and Cond. 3")
                {
                    ApplicationArea = All;
                }
                field("Terms and Cond. 4"; Rec."Terms and Cond. 4")
                {
                    ApplicationArea = All;
                }
                field("Terms and Cond. 5"; Rec."Terms and Cond. 5")
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
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Company")
            {
                Caption = '&Company';
                Image = Company;

                action("Copy Address and Picture")
                {
                    ApplicationArea = All;
                    Caption = 'Copy Address and Picture';
                    Image = Position;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Responsibility Center List";

                    trigger OnAction()
                    begin
                        CurrPage.Update(true);
                        Rec.CopyFromCompany;
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }
}
