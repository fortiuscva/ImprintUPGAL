pageextension 60069 "TrailingSalesOrdersSetupExt" extends "Trailing Sales Orders Setup"
{
    layout
    {
        addafter("Use Work Date as Base")
        {
            field("Salesperson Filter"; Rec."Salesperson Filter")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    if not Rec."Stat. Chart Salesperson Change" then // User %1 does not have permission to modify %2.
                        Error(ISSText001, UserId, Rec.FieldCaption("Salesperson Filter"));
                end;
            }
        }
    }
    var
        ISSText001: Label 'User %1 does not have permission to modify %2.';
    //Unsupported feature: PropertyChange. Please convert manually.
}
