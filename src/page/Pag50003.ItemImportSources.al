page 50003 "Item Import Sources"
{
    PageType = List;
    SourceTable = "Item Import Source";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Import Layout"; Rec."Import Layout")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Pass Category"; Rec."Pass Category")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Source")
            {
                Caption = '&Source';

                action("UoM Conversions")
                {
                    ApplicationArea = All;
                    Caption = 'UoM Conversions';
                    Promoted = true;
                    RunObject = Page "Item Import UoM Conversions";
                    RunPageLink = "Item Import Source Code"=FIELD(Code);
                }
                action("Category Conversions")
                {
                    ApplicationArea = All;
                    Caption = 'Category Conversions';
                    Promoted = true;
                    RunObject = Page "Item Import Cat. Conversions";
                    RunPageLink = "Item Import Source Code"=FIELD(Code);
                }
            }
        }
    }
}
