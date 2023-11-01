pageextension 60100 "PostedReturnReceiptsExt" extends "Posted Return Receipts"
{
    layout
    {
        addafter("Sell-to Post Code")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
