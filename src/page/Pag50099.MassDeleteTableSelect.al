page 50099 "Mass Delete Table Select"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Mass Delete Table";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table No."; Rec."Table No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Table Name"; Rec."Table Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. of Records"; Rec."No. of Records")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Delete Table"; Rec."Delete Table")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';

                action("Insert / Update Tables")
                {
                    Caption = 'Insert / Update Tables';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.PopulateTables;
                        CurrPage.Update(false);
                    end;
                }
                action("Import / Export")
                {
                    Caption = 'Import / Export';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                    //CLEAR(MassDataport);
                    //MassDataport.RUNMODAL;
                    //CurrForm.UPDATE(FALSE);
                    end;
                }
                separator(Action1000000010)
                {
                }
                action("DELETE TABLES")
                {
                    Caption = 'DELETE TABLES';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                    //DeleteReport.RUN;
                    end;
                }
                separator(Action1000000012)
                {
                }
                action("Mark All Filtered")
                {
                    Caption = 'Mark All Filtered';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ModifyAll("Delete Table", true);
                    end;
                }
                action("Unmark All Filtered")
                {
                    Caption = 'Unmark All Filtered';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ModifyAll("Delete Table", false);
                    end;
                }
            }
        }
    }
}
