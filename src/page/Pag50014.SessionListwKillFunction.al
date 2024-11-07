page 50014 "Session List w/ Kill Function"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Session,SQL Trace';
    RefreshOnActivate = true;
    SourceTable = "Active Session";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Session ID"; SessionIdText)
                {
                    ApplicationArea = All;
                    Caption = 'Session ID';
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                    Editable = false;
                }
                field(IsSQLTracing; IsSQLTracing)
                {
                    ApplicationArea = All;
                    Caption = 'SQL Tracing';

                    trigger OnValidate()
                    begin
                        // DEBUGGER.EnableSqlTrace(Rec."Session ID", IsSQLTracing);//UPGCloud
                    end;
                }
                field("Client Type"; ClientTypeText)
                {
                    ApplicationArea = All;
                    Caption = 'Client Type';
                    Editable = false;
                }
                field("Login Datetime"; Rec."Login Datetime")
                {
                    ApplicationArea = All;
                    Caption = 'Login Date';
                    Editable = false;
                }
                field("Server Computer Name"; Rec."Server Computer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Server Computer Name';
                    Editable = false;
                }
                field("Server Instance Name"; Rec."Server Instance Name")
                {
                    ApplicationArea = All;
                    Caption = 'Server Instance Name';
                    Editable = false;
                }
                field(IsDebugging; IsDebugging)
                {
                    ApplicationArea = All;
                    Caption = 'Debugging';
                    Editable = false;
                }
                field(IsDebugged; IsDebugged)
                {
                    ApplicationArea = All;
                    Caption = 'Debugged';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            separator(Action8)
            {
            }
            group(Session)
            {
                Caption = 'Session';

                action("Debug Selected Session")
                {
                    ApplicationArea = All;
                    Caption = 'Debug';
                    Enabled = CanDebugSelectedSession;
                    Image = Debug;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+S';
                    ToolTip = 'Debug the selected session';

                    trigger OnAction()
                    begin
                        //DebuggerManagement.SetDebuggedSession(Rec);//UPG
                        //DebuggerManagement.OpenDebuggerTaskPage;;//UPG
                    end;
                }
                action("Debug Next Session")
                {
                    ApplicationArea = All;
                    Caption = 'Debug Next';
                    Enabled = CanDebugNextSession;
                    Image = DebugNext;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+N';
                    ToolTip = 'Debug the next session that breaks code execution.';

                    trigger OnAction()
                    var
                        DebuggedSessionTemp: Record "Active Session";
                    begin
                        DebuggedSessionTemp."Session ID" := 0;
                        //DebuggerManagement.SetDebuggedSession(DebuggedSessionTemp);;//UPG
                        //DebuggerManagement.OpenDebuggerTaskPage;;//UPG
                    end;
                }
                action("KILL Session")
                {
                    ApplicationArea = All;
                    Image = Stop;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        // ISS
                        if Confirm('Kill Session?') then StopSession(Rec."Session ID");
                        // End
                    end;
                }
            }
            group("SQL Trace")
            {
                Caption = 'SQL Trace';

                action("Start Full SQL Tracing")
                {
                    ApplicationArea = All;
                    Caption = 'Start Full SQL Tracing';
                    Enabled = NOT FullSQLTracingStarted;
                    Image = Continue;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        //DEBUGGER.EnableSqlTrace(0, true);//UPGCloud
                        FullSQLTracingStarted := true;
                    end;
                }
                action("Stop Full SQL Tracing")
                {
                    ApplicationArea = All;
                    Caption = 'Stop Full SQL Tracing';
                    Enabled = FullSQLTracingStarted;
                    Image = Stop;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        //DEBUGGER.EnableSqlTrace(0, false);//UPGCloud
                        FullSQLTracingStarted := false;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        /*
        IsDebugging := DEBUGGER.IsActive and (Rec."Session ID" = DEBUGGER.DebuggingSessionId);
        IsDebugged := DEBUGGER.IsAttached and (Rec."Session ID" = DEBUGGER.DebuggedSessionId);
        IsSQLTracing := DEBUGGER.EnableSqlTrace(Rec."Session ID");
        */
        //UPGCloud
        // If this is the empty row, clear the Session ID and Client Type
        if Rec."Session ID" = 0 then begin
            SessionIdText := '';
            ClientTypeText := '';
        end
        else begin
            SessionIdText := Format(Rec."Session ID");
            ClientTypeText := Format(Rec."Client Type");
        end;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        /*
        CanDebugNextSession := not DEBUGGER.IsActive;
        CanDebugSelectedSession := not DEBUGGER.IsAttached and not Rec.IsEmpty;
        */
        //UPGCloud
        // If the session list is empty, insert an empty row to carry the button state to the client
        if not Rec.Find(Which) then begin
            Rec.Init;
            Rec."Session ID" := 0;
        end;
        exit(true);
    end;

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Server Instance ID", '=%1', ServiceInstanceId);
        Rec.SetFilter("Session ID", '<>%1', SessionId);
        Rec.FilterGroup(0);
        //FullSQLTracingStarted := DEBUGGER.EnableSqlTrace(0);//UPGCloud
    end;

    var //DebuggerManagement: Codeunit "Debugger Management";//UPG
        [InDataSet]
        CanDebugNextSession: Boolean;
        [InDataSet]
        CanDebugSelectedSession: Boolean;
        [InDataSet]
        FullSQLTracingStarted: Boolean;
        IsDebugging: Boolean;
        IsDebugged: Boolean;
        IsSQLTracing: Boolean;
        SessionIdText: Text;
        ClientTypeText: Text;
}
