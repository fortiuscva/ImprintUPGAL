report 50070 "Update Creation Date in GL"
{
    Permissions = TableData "G/L Entry"=rimd;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Register"; "G/L Register")
        {
            trigger OnAfterGetRecord()
            begin
                Window.Update(1, "G/L Register"."No.");
                GLEntryRec.Reset;
                GLEntryRec.SetRange("Entry No.", "From Entry No.", "To Entry No.");
                GLEntryRec.ModifyAll("Created Date", "Creation Date");
            end;
            trigger OnPostDataItem()
            begin
                Window.Close;
            end;
            trigger OnPreDataItem()
            begin
                Window.Open('Processing Register No....###1##############');
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
    var GLEntryRec: Record "G/L Entry";
    Window: Dialog;
}
