report 50033 "Updte ILE 99957"
{
    Permissions = TableData "G/L Entry"=rimd,
        TableData "Item Ledger Entry"=rimd,
        TableData "Value Entry"=rimd;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord()
            begin
                ILEGRec.Reset;
                ILEGRec.Get(99957);
                ILEGRec.Quantity:=0;
                ILEGRec.Modify;
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
    var ILEGRec: Record "Item Ledger Entry";
    ValueEntryGRec: Record "Value Entry";
    GLEntryGRec: Record "G/L Entry";
    AmountGVr: Decimal;
}
