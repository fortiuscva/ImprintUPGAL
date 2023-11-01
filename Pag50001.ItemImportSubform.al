page 50001 "Item Import Subform"
{
    PageType = ListPart;
    SourceTable = "Item Import Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("NAV Item No."; Rec."NAV Item No.")
                {
                    ApplicationArea = All;
                }
                field("Mfg. Item No."; Rec."Mfg. Item No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ApplicationArea = All;
                }
                field("Line Type"; Rec."Line Type")
                {
                    ApplicationArea = All;
                }
                field("Error Code"; Rec."Error Code")
                {
                    ApplicationArea = All;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                }
                field("Pricing Updated"; Rec."Pricing Updated")
                {
                    ApplicationArea = All;
                }
                field("Item Created"; Rec."Item Created")
                {
                    ApplicationArea = All;
                }
                field("Item Updated"; Rec."Item Updated")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
