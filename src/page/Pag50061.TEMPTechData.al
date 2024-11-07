page 50061 "TEMP Tech Data"
{
    Editable = false;
    PageType = List;
    SourceTable = "TEMP Tech Data";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Mfg. Part No. (Match)"; Rec."Mfg. Part No. (Match)")
                {
                    ApplicationArea = All;
                }
                field(Instances; Rec.Instances)
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
