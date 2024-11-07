page 50006 "Item Import List"
{
    CardPageID = "Item Import";
    Editable = false;
    PageType = List;
    SourceTable = "Item Import Header";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Import Date"; Rec."Import Date")
                {
                    ApplicationArea = All;
                }
                field("Import Time"; Rec."Import Time")
                {
                    ApplicationArea = All;
                }
                field("Import User ID"; Rec."Import User ID")
                {
                    ApplicationArea = All;
                }
                field("Item Import Source Code"; Rec."Item Import Source Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Pricing Update Date"; Rec."Pricing Update Date")
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
