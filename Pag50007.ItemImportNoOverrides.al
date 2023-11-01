page 50007 "Item Import No. Overrides"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Import No. Override";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Import Mfg. Item No."; Rec."Import Mfg. Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item No. (Match)"; Rec."Item No. (Match)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Override Item No."; Rec."Override Item No.")
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
