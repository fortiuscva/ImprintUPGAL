pageextension 60040 "PostedSalesCreditMemoExt" extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("Sell-to Contact")
        {
            field("Return Order No."; Rec."Return Order No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("Purchaser Code"; Rec."Purchaser Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to")
        {
            field("Tax Exemption No."; Rec."Tax Exemption No.")
            {
                ApplicationArea = All;
            }
            field("Tax Exempt Categories"; Rec."Tax Exempt Categories")
            {
                ApplicationArea = All;
            }
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = All;
            }
            field("CertCapture Exemption No."; Rec."CertCapture Exemption No.")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
