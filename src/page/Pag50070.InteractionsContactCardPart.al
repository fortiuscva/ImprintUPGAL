page 50070 "Interactions Contact Card Part"
{
    PageType = ListPart;
    SourceTable = "Interaction Log Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Time of Interaction"; Rec."Time of Interaction")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Interaction Template Code"; Rec."Interaction Template Code")
                {
                    ApplicationArea = All;
                }
                field("Interaction Group Code"; Rec."Interaction Group Code")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
    /*
        //IMP1.01 Start
        UserNameVarGbl := COPYSTR(USERID,7);
        SETRANGE("Salesperson Code",UserNameVarGbl);
        //IMP1.01 Emd
        */
    end;
    var UserNameVarGbl: Text;
}
