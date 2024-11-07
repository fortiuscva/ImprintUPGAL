pageextension 60006 "CustomerListExt" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field("Created Date"; Rec."Created Date")
            {
                ApplicationArea = All;
            }
            field("Created User ID"; Rec."Created User ID")
            {
                ApplicationArea = All;
            }
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
            field("Tax Exempt Muti-State"; Rec."Tax Exempt Muti-State")
            {
                ApplicationArea = All;
            }
            field("CertCapture Exemption No."; Rec."CertCapture Exemption No.")
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
            field("Self Assessed"; Rec."Self Assessed")
            {
                ApplicationArea = All;
            }
            field("Self Assessed - Notes"; Rec."Self Assessed - Notes")
            {
                ApplicationArea = All;
            }
            field("First Tax Exempt Date on File"; Rec."First Tax Exempt Date on File")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field(Balance; Rec.Balance)
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
            }
        }
        addafter("Country/Region Code")
        {
            field("Primary Contact No."; Rec."Primary Contact No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Phone No.")
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
            field("AP Contact"; Rec."AP Contact")
            {
                ApplicationArea = All;
            }
            field("AP Phone No."; Rec."AP Phone No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("Lead Source Code"; Rec."Lead Source Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Credit Limit (LCY)")
        {
            field("Last Credit Check Date"; Rec."Last Credit Check Date")
            {
                ApplicationArea = All;
            }
        }
        addafter(Blocked)
        {
            field("Blocked Reason Code"; Rec."Blocked Reason Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("C&ontact")
        {
            action("Shipping Accounts")
            {
                Caption = 'Shipping Accounts';
                ApplicationArea = All;
                RunObject = Page "Shipping Accounts";
                RunPageLink = "Ship-to Type"=CONST(Customer), "Ship-to No."=FIELD("No.");
            }
        }
        addafter("Customer - Order Detail")
        {
            action("Report Imprint Statement v2")
            {
                ApplicationArea = All;
                RunObject = Report 50037;
                Image = Report;
            }
        }
    }
    trigger OnOpenPage()
    begin
        // ISS2.00 DFP =========================================================\
        Rec.FilterSalesperson;
    // End =================================================================/
    end;
}
