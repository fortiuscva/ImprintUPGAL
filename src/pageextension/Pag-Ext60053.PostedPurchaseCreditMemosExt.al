pageextension 60053 "PostedPurchaseCreditMemosExt" extends "Posted Purchase Credit Memos"
{
    layout
    {
        addafter("No.")
        {
            field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
