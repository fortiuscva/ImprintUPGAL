page 50015 "Shipping Accounts"
{
    PageType = List;
    SourceTable = "Shipping Account";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ship-to Type"; Rec."Ship-to Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to No."; Rec."Ship-to No.")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Shipping Insurance"; Rec."Shipping Insurance")
                {
                    ApplicationArea = All;
                }
                field("Default Account"; Rec."Default Account")
                {
                    ApplicationArea = All;
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                }
                field("Third Party Name"; Rec."Third Party Name")
                {
                    ApplicationArea = All;
                }
                field("Third Party Contact"; Rec."Third Party Contact")
                {
                    ApplicationArea = All;
                }
                field("Third Party Phone No."; Rec."Third Party Phone No.")
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
