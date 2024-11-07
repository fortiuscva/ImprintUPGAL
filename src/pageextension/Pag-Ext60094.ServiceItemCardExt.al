pageextension 60094 "ServiceItemCardExt" extends "Service Item Card"
{
    layout
    {
        addafter("Item Description")
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
