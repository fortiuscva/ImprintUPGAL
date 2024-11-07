pageextension 60099 "PostedReturnReceiptExt" extends "Posted Return Receipt"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("Purchaser Code"; Rec."Purchaser Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Code")
        {
            field("Tax Exemption No."; Rec."Tax Exemption No.")
            {
                ApplicationArea = All;
            }
            field("Tax Exempt Categories"; Rec."Tax Exempt Categories")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
