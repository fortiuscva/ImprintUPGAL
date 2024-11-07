pageextension 60000 "CompanyInformationExt" extends "Company Information"
{
    layout
    {
        modify("Ship-to County")
        {
            ApplicationArea = Basic, Suite;
        }
        addafter(IBAN)
        {
            field("Remit-to Name"; Rec."Remit-to Name")
            {
                ApplicationArea = All;
            }
            field("Remit-to Address"; Rec."Remit-to Address")
            {
                ApplicationArea = All;
            }
            field("Remit-to Address 2"; Rec."Remit-to Address 2")
            {
                ApplicationArea = All;
            }
            field("Remit-to City"; Rec."Remit-to City")
            {
                ApplicationArea = All;
            }
            field("Remit-to County"; Rec."Remit-to County")
            {
                ApplicationArea = All;
            }
            field("Remit-to Post Code"; Rec."Remit-to Post Code")
            {
                ApplicationArea = All;
            }
            field("Remit-to Country/Region Code"; Rec."Remit-to Country/Region Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
