page 50028 "TEMP Item Category Check"
{
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TEMP Item Category Check";
    SourceTableView = SORTING("Item Import Code")WHERE("Item Import Code"=CONST('SCANSOURCE'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Item Import Code"; Rec."Item Import Code")
                {
                    ApplicationArea = All;
                }
                field("Old Item Category Code"; Rec."Old Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("New Item Category Code"; Rec."New Item Category Code")
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
