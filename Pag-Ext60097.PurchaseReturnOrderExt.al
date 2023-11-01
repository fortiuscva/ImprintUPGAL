pageextension 60097 "PurchaseReturnOrderExt" extends "Purchase Return Order"
{
    layout
    {
        addafter("Purchaser Code")
        {
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
