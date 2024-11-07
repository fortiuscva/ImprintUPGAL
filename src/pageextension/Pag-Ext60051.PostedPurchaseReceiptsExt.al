pageextension 60051 "PostedPurchaseReceiptsExt" extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("Order Address Code")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Pay-to Name")
        {
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = All;
            }
        }
    }
}
