report 50055 "*** Fix entries"
{
    Permissions = TableData "G/L Entry"=rm,
        TableData "Value Entry"=rm;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
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
    trigger OnPreReport()
    begin
        VE.Get(110523);
        VE."Cost Amount (Actual)":=-25.07;
        VE."Cost Posted to G/L":=-25.07;
        VE.Modify;
        GE.Get(509857);
        GE.Amount:=-25.07;
        GE."Credit Amount":=25.07;
        GE.Modify;
        GE.Get(509858);
        GE.Amount:=25.07;
        GE."Debit Amount":=25.07;
        GE.Modify;
    end;
    var GE: Record "G/L Entry";
    VE: Record "Value Entry";
}
