report 50099 "Mass Delete Tables"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Mass Delete Table"; "Mass Delete Table")
        {
            trigger OnAfterGetRecord()
            begin
                PBMgt.UpdateProgressBar;
                CleanTable("Table No.");
                DelCount += 1;
            end;

            trigger OnPostDataItem()
            begin
                PBMgt.CloseProgressBar;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Delete Table", true);
                PBMgt.OpenProgressBar('Deleting Tables', Count, false, false);
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        // %1 selected tables have been deleted.
        Message(Text003, DelCount);
    end;

    trigger OnPreReport()
    begin
        // WARNING: This routine will permanantly...
        if not Confirm(Text001, false) then // The process has been cancelled.
            Error(Text002);
    end;

    var
        PBMgt: Codeunit "Progress Bar Management";
        DelCount: Integer;
        Text001: Label 'WARNING: This routine will permanantly delete all data in the selected tables.\\This cannot be reversed.\\Are you sure you wish to continue?';
        Text002: Label 'The process has been cancelled.';
        Text003: Label 'Selected tables have been deleted.';

    procedure CleanTable(TableNo: Integer)
    var
        RecordReference: RecordRef;
    begin
        RecordReference.Open(TableNo);
        RecordReference.DeleteAll;
    end;
}
