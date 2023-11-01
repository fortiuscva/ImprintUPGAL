page 50035 "Customer Stat. Field TEST"
{
    Editable = false;
    PageType = List;
    SourceTable = Customer;
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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Sales (LCY)"; Rec."Sales (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Profit (LCY)"; Rec."Profit (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Stat. Profit (Expected)"; Rec."Stat. Profit (Expected)")
                {
                    ApplicationArea = All;
                }
                field("Stat. Profit (Posted)"; Rec."Stat. Profit (Posted)")
                {
                    ApplicationArea = All;
                }
                field("Stat. Sales (Expected)"; Rec."Stat. Sales (Expected)")
                {
                    ApplicationArea = All;
                }
                field("Stat. Sales (Posted)"; Rec."Stat. Sales (Posted)")
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
