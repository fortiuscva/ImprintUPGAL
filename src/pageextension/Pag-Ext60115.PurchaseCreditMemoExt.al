pageextension 60115 "PurchaseCreditMemoExt" extends "Purchase Credit Memo"
{
    layout
    {
        addafter("Applies-to ID")
        {
            field("Third Party Shipping Acc. No."; rec."Third Party Shipping Acc. No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
