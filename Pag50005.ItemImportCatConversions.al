page 50005 "Item Import Cat. Conversions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Import Cat. Conversion";

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
                field("Import Category 1"; Rec."Import Category 1")
                {
                    ApplicationArea = All;
                }
                field("Import Category 2"; Rec."Import Category 2")
                {
                    ApplicationArea = All;
                }
                field("Import Category 3"; Rec."Import Category 3")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
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
