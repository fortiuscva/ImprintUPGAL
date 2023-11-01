page 50011 "Sales Statistics Chart Setup"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = StandardDialog;
    SourceTable = "Sales Statistics Chart Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Use Work Date as Base"; Rec."Use Work Date as Base")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Filter"; Rec."Salesperson Filter")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if not Rec."Stat. Chart Salesperson Change" then // User %1 does not have permission to modify %2.
                            Error(Text001, UserId, Rec.FieldCaption("Salesperson Filter"));
                    end;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get(UserId) then begin
            Rec."User ID" := UserId;
            Rec."Use Work Date as Base" := true;
            Rec.Insert;
        end;
        Rec.FilterGroup(2);
        Rec.SetRange("User ID", UserId);
        Rec.FilterGroup(0);
    end;

    var
        Text001: Label 'User %1 does not have permission to modify %2.';
}
