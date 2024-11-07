pageextension 60095 "ServiceItemListExt" extends "Service Item List"
{
    layout
    {
        addafter("Item Description")
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
    }
}
