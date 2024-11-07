pageextension 60005 "CustomerCardExt" extends "Customer Card"
{
    layout
    {
        addafter("Credit Limit (LCY)")
        {
            field("Last Credit Check Date"; Rec."Last Credit Check Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Disable Search by Name")
        {
            field("Lead Source Code"; Rec."Lead Source Code")
            {
                ApplicationArea = All;
            }
            field("Blocked Reason Code"; rec."Blocked Reason Code")
            {
                ApplicationArea = All;
            }
            field("Created Date"; rec."Created Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Created User ID"; rec."Created User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter(ContactDetails)
        {
            field("AP Contact"; Rec."AP Contact")
            {
                ApplicationArea = All;
            }
            field("AP Phone No."; Rec."AP Phone No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Customer No.")
        {
            field("Tax Liable Entry Date"; rec."Tax Liable Entry Date")
            {
                ApplicationArea = All;
            }
            field("Verbally Confirmed"; rec."Verbally Confirmed")
            {
                ApplicationArea = All;
            }
            field("No Response"; Rec."No Response")
            {
                ApplicationArea = All;
            }
            field("Refuse to Provide Info"; rec."Refuse to Provide Info")
            {
                ApplicationArea = All;
            }
            field("Self Assessed"; rec."Self Assessed")
            {
                ApplicationArea = All;
            }
            field("Self Assessed - Notes"; rec."Self Assessed - Notes")
            {
                ApplicationArea = All;
            }
            field("Tax Exempt Muti-State"; rec."Tax Exempt Muti-State")
            {
                ApplicationArea = All;
            }
            field("CertCapture Exemption No."; rec."CertCapture Exemption No.")
            {
                ApplicationArea = All;
            }
            field("Tax Exempt Categories"; rec."Tax Exempt Categories")
            {
                ApplicationArea = All;
            }
            field("First Tax Exempt Date on File"; rec."First Tax Exempt Date on File")
            {
                ApplicationArea = All;
            }
            field("Tax Exempt Entry Date"; rec."Tax Exempt Entry Date")
            {
                ApplicationArea = All;
            }
            field("Tax Exempt Expiration Date"; rec."Tax Exempt Expiration Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Phone No.")
        {
            field("Order Confirmation Email"; Rec."Order Confirmation Email")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(ApprovalEntries)
        {
            action("Shipping Accounts")
            {
                Caption = 'Shipping Accounts';
                ApplicationArea = All;
                RunObject = Page "Shipping Accounts";
                RunPageLink = "Ship-to Type"=CONST(Customer), "Ship-to No."=FIELD("No.");
            }
        }
        addafter(Action140)
        {
            action("Recent Posted Invoice Lines")
            {
                Caption = 'Recent Posted Invoice Lines';
                ApplicationArea = All;
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Recent Sales Invoice Lines";
                RunPageLink = "Sell-to Customer No."=FIELD("No.");
            }
            action("Recent Posted Cr. Memo Lines")
            {
                Caption = 'Recent Posted Cr. Memo Lines';
                ApplicationArea = All;
                Image = LedgerEntries;
                RunObject = Page "Recent Sales Cr. Memo Lines";
                RunPageLink = "Sell-to Customer No."=FIELD("No.");
            }
            action("Recet Posted Service Invoice Lines")
            {
                Caption = 'Recet Posted Service Invoice Lines';
                ApplicationArea = All;
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Recent Pst. Service Inv. Lines";
                RunPageLink = "Customer No."=FIELD("No.");
                RunPageView = SORTING("Customer No.");
            }
        }
    }
    trigger OnOpenPage()
    begin
        // ISS2.00 DFP =========================================================\
        Rec.FilterSalesperson;
    // End =================================================================/
    end;
    var ZdPrevRecID: RecordId;
    ZdRecRef: RecordRef;
}
