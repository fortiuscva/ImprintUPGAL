pageextension 60059 "ShiptoAddressListExt" extends "Ship-to Address List"
{
    layout
    {
        addfirst(Control1)
        {
            field("Created Date"; Rec."Created Date")
            {
                ApplicationArea = All;
            }
            field("Created User ID"; Rec."Created User ID")
            {
                ApplicationArea = All;
            }
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Name)
        {
            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Address 2")
        {
            field(County; Rec.County)
            {
                ApplicationArea = All;
            }
        }
        addafter("Post Code")
        {
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
            }
            field("Tax Liable"; Rec."Tax Liable")
            {
                ApplicationArea = All;
            }
            field("Tax Liable Entry Date"; Rec."Tax Liable Entry Date")
            {
                ApplicationArea = All;
            }
            field("Tax Exemption No."; Rec."Tax Exemption No.")
            {
                ApplicationArea = All;
            }
            field("CertCapture Exemption No."; Rec."CertCapture Exemption No.")
            {
                ApplicationArea = All;
            }
            field("Tax Exempt Categories"; Rec."Tax Exempt Categories")
            {
                ApplicationArea = All;
            }
            field("Tax Exempt Entry Date"; Rec."Tax Exempt Entry Date")
            {
                ApplicationArea = All;
            }
            field("Tax Exempt Expiration Date"; Rec."Tax Exempt Expiration Date")
            {
                ApplicationArea = All;
            }
            field("Verbally Confirmed"; Rec."Verbally Confirmed")
            {
                ApplicationArea = All;
            }
            field("No Response"; Rec."No Response")
            {
                ApplicationArea = All;
            }
            field("Refuse to Provide Info"; Rec."Refuse to Provide Info")
            {
                ApplicationArea = All;
            }
            field("Self Assessed"; rec."Self Assessed")
            {
                ApplicationArea = All;
            }
            field("Self Assessed - Notes"; Rec."Self Assessed - Notes")
            {
                ApplicationArea = All;
            }
            field("First Tax Exempt Date on File"; rec."First Tax Exempt Date on File")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
