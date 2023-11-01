page 50066 "Change Log - Customers"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Change Log Entry";
    SourceTableView = SORTING("Table No.", "Primary Key Field 1 Value")ORDER(Descending)WHERE("Table No."=FILTER(18), "Date and Time"=FILTER('07/01/17 10:30 AM'..'12/31/20 11:30 AM'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date and Time"; Rec."Date and Time")
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Type of Change"; Rec."Type of Change")
                {
                    ApplicationArea = All;
                }
                field("Old Value"; Rec."Old Value")
                {
                    ApplicationArea = All;
                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = All;
                }
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 1 Value"; Rec."Primary Key Field 1 Value")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 2 Value"; Rec."Primary Key Field 2 Value")
                {
                    ApplicationArea = All;
                }
                field("Primary Key Field 3 Value"; Rec."Primary Key Field 3 Value")
                {
                    ApplicationArea = All;
                }
                field("Record ID"; Rec."Record ID")
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
