pageextension 60086 "PostedServiceCreditMemosExt" extends "Posted Service Credit Memos"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
    }
}
