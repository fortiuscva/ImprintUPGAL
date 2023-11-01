pageextension 60080 "ServiceItemWorksheetSubformExt" extends "Service Item Worksheet Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
            {
                ApplicationArea = All;
            }
        }
        addafter("Tax Liable")
        {
            field("Resource 1"; Rec."Resource 1")
            {
                ApplicationArea = All;
            }
            field("Resource 2"; Rec."Resource 2")
            {
                ApplicationArea = All;
            }
        }
    }
}
