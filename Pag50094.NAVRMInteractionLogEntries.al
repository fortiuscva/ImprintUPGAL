page 50094 "NAV RM Interaction Log Entries"
{
    Caption = 'Interaction Log Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Interaction Log Entry";
    SourceTableView = WHERE(Postponed=CONST(false));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;

                field(Canceled; Rec.Canceled)
                {
                    ApplicationArea = All;
                }
                field("Attempt Failed"; Rec."Attempt Failed")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Delivery Status"; Rec."Delivery Status")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Time of Interaction"; Rec."Time of Interaction")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Correspondence Type"; Rec."Correspondence Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Interaction Group Code"; Rec."Interaction Group Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Interaction Template Code"; Rec."Interaction Template Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("""Attachment No."" <> 0"; Rec."Attachment No." <> 0)
                {
                    BlankZero = true;
                    Caption = 'Attachment';
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec."Attachment No." <> 0 then;
                    //OpenAttachment; //UPGCloud
                    end;
                }
                field("Information Flow"; Rec."Information Flow")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Initiated By"; Rec."Initiated By")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Contact No."; Rec."Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Contact Company No."; Rec."Contact Company No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Evaluation; Rec.Evaluation)
                {
                    ApplicationArea = All;
                }
                field("Cost (LCY)"; Rec."Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Duration (Min.)"; Rec."Duration (Min.)")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Segment No."; Rec."Segment No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                }
                field("Campaign Entry No."; Rec."Campaign Entry No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Campaign Response"; Rec."Campaign Response")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Campaign Target"; Rec."Campaign Target")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ApplicationArea = All;
                }
                field("To-do No."; Rec."To-do No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Interaction Language Code"; Rec."Interaction Language Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Contact Via"; Rec."Contact Via")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
            group(Control78)
            {
                ShowCaption = false;

                field("Contact Name"; Rec."Contact Name")
                {
                    Caption = 'Contact Name';
                    DrillDown = false;
                    ApplicationArea = All;
                }
                field("Contact Company Name"; Rec."Contact Company Name")
                {
                    DrillDown = false;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Entry)
            {
                Caption = 'Ent&ry';
                Image = Entry;

                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Inter. Log Entry Comment Sheet";
                    RunPageLink = "Entry No."=FIELD("Entry No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Switch Check&mark in Canceled")
                {
                    Caption = 'Switch Check&mark in Canceled';
                    Image = ReopenCancelled;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(InteractionLogEntry);
                    //InteractionLogEntry.ToggleCanceledCheckmark;//UPGCloud
                    end;
                }
                action(Resend)
                {
                    Caption = 'Resend';
                    Image = Reuse;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractLogEntry: Record "Interaction Log Entry";
                        ResendAttachments: Report "Resend Attachments";
                    begin
                        InteractLogEntry.SetRange("Logged Segment Entry No.", Rec."Logged Segment Entry No.");
                        InteractLogEntry.SetRange("Entry No.", Rec."Entry No.");
                        ResendAttachments.SetTableView(InteractLogEntry);
                        ResendAttachments.RunModal;
                    end;
                }
                action("Evaluate Interaction")
                {
                    Caption = 'Evaluate Interaction';
                    Image = Evaluate;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(InteractionLogEntry);
                        InteractionLogEntry.EvaluateInteraction;
                    end;
                }
                separator(Action75)
                {
                }
                action("Create To-do")
                {
                    Caption = 'Create To-do';
                    Image = NewToDo;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                    //CreateTodo;
                    end;
                }
            }
            action(Show)
            {
                Caption = '&Show';
                Enabled = ShowEnable;
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*
                    if Rec."Attachment No." <> 0 then
                        //OpenAttachment  //UPGCloud
                    else*/
                    Rec.ShowDocument;
                end;
            }
            action("Create &Interact")
            {
                Caption = 'Create &Interact';
                Image = CreateInteraction;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.CreateInteraction;
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Contact Name", "Contact Company Name");
    end;
    trigger OnFindRecord(Which: Text): Boolean var
        RecordsFound: Boolean;
    begin
        RecordsFound:=Rec.Find(Which);
        FunctionsEnable:=RecordsFound;
        ShowEnable:=RecordsFound;
        EntryEnable:=RecordsFound;
        exit(RecordsFound);
    end;
    trigger OnInit()
    begin
        EntryEnable:=true;
        ShowEnable:=true;
        FunctionsEnable:=true;
    end;
    trigger OnOpenPage()
    begin
        SetCaption;
        /*
        // ISS2.00 DFP =========================================================\
        FilterSalesperson;
        // End =================================================================/
        */
        //IMP1.01 Start
        UserNameVarGbl:=CopyStr(UserId, 7);
        Rec.SetRange("Salesperson Code", UserNameVarGbl);
    //IMP1.01 Emd
    end;
    var InteractionLogEntry: Record "Interaction Log Entry";
    [InDataSet]
    FunctionsEnable: Boolean;
    [InDataSet]
    ShowEnable: Boolean;
    [InDataSet]
    EntryEnable: Boolean;
    UserNameVarGbl: Text;
    local procedure SetCaption()
    var
        Contact: Record Contact;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ToDo: Record "To-do";
        Opportunity: Record Opportunity;
    begin
        if Contact.Get(Rec."Contact Company No.")then CurrPage.Caption(CurrPage.Caption + ' - ' + Contact."Company No." + ' . ' + Contact."Company Name");
        if Contact.Get(Rec."Contact No.")then begin
            CurrPage.Caption(CurrPage.Caption + ' - ' + Contact."No." + ' . ' + Contact.Name);
            exit;
        end;
        if Rec."Contact Company No." <> '' then exit;
        if SalespersonPurchaser.Get(Rec."Salesperson Code")then begin
            CurrPage.Caption(CurrPage.Caption + ' - ' + Rec."Salesperson Code" + ' . ' + SalespersonPurchaser.Name);
            exit;
        end;
        if Rec."Interaction Template Code" <> '' then begin
            CurrPage.Caption(CurrPage.Caption + ' - ' + Rec."Interaction Template Code");
            exit;
        end;
        if ToDo.Get(Rec."To-do No.")then begin
            CurrPage.Caption(CurrPage.Caption + ' - ' + ToDo."No." + ' . ' + ToDo.Description);
            exit;
        end;
        if Opportunity.Get(Rec."Opportunity No.")then CurrPage.Caption(CurrPage.Caption + ' - ' + Opportunity."No." + ' . ' + Opportunity.Description);
    end;
}
