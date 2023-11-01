page 50004 "Item Import UoM Conversions"
{
    PageType = List;
    SourceTable = "Item Import UoM Conversion";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Import Source Code"; Rec."Item Import Source Code")
                {
                    ApplicationArea = All;
                }
                field("Import Unit of Measure Code"; Rec."Import Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("NAV Unit of Measure Code"; Rec."NAV Unit of Measure Code")
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
