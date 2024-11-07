report 50032 "Updte ILE"
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
                /*
                ILEGRec.RESET;
                ILEGRec.GET(86003);
                ILEGRec.Quantity := (ILEGRec.Quantity * ILEGRec."Qty. per Unit of Measure");
                ILEGRec.MODIFY;
                
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138641);
                ValueEntryGRec."Cost Amount (Expected)" := (ILEGRec.Quantity * ValueEntryGRec."Cost per Unit");
                ValueEntryGRec."Item Ledger Entry Quantity" := ILEGRec.Quantity;
                ValueEntryGRec."Invoiced Quantity":= ILEGRec.Quantity;
                ValueEntryGRec.MODIFY;
                
                
                ILEGRec.RESET;
                ILEGRec.GET(86004);
                ILEGRec.Quantity := (ILEGRec.Quantity * ILEGRec."Qty. per Unit of Measure");
                ILEGRec.MODIFY;
                
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138642);
                ValueEntryGRec."Cost Amount (Expected)" := (ILEGRec.Quantity * ValueEntryGRec."Cost per Unit");
                ValueEntryGRec."Item Ledger Entry Quantity" := ILEGRec.Quantity;
                ValueEntryGRec."Invoiced Quantity":= ILEGRec.Quantity;
                ValueEntryGRec.MODIFY;
                
                
                
                
                
                
                
                ILEGRec.RESET;
                ILEGRec.GET(86005);
                ILEGRec.Quantity := (ILEGRec.Quantity * ILEGRec."Qty. per Unit of Measure");
                ILEGRec.MODIFY;
                
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138643);
                ValueEntryGRec."Cost Amount (Expected)" := (ILEGRec.Quantity * ValueEntryGRec."Cost per Unit");
                ValueEntryGRec."Item Ledger Entry Quantity" := ILEGRec.Quantity;
                ValueEntryGRec."Invoiced Quantity":= ILEGRec.Quantity;
                ValueEntryGRec.MODIFY;
                
                
                
                ILEGRec.RESET;
                ILEGRec.GET(86006);
                ILEGRec.Quantity := (ILEGRec.Quantity * ILEGRec."Qty. per Unit of Measure");
                ILEGRec.MODIFY;
                
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138644);
                ValueEntryGRec."Cost Amount (Expected)" := (ILEGRec.Quantity * ValueEntryGRec."Cost per Unit");
                ValueEntryGRec."Item Ledger Entry Quantity" := ILEGRec.Quantity;
                ValueEntryGRec."Invoiced Quantity":= ILEGRec.Quantity;
                ValueEntryGRec.MODIFY;
                
                ILEGRec.RESET;
                ILEGRec.GET(86007);
                ILEGRec.Quantity := (ILEGRec.Quantity * ILEGRec."Qty. per Unit of Measure");
                ILEGRec.MODIFY;
                
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138646);
                ValueEntryGRec."Cost Amount (Expected)" := (ILEGRec.Quantity * ValueEntryGRec."Cost per Unit");
                ValueEntryGRec."Item Ledger Entry Quantity" := ILEGRec.Quantity;
                ValueEntryGRec."Invoiced Quantity":= ILEGRec.Quantity;
                ValueEntryGRec.MODIFY;
                
                
                
                ILEGRec.RESET;
                ILEGRec.GET(86008);
                ILEGRec.Quantity := (ILEGRec.Quantity * ILEGRec."Qty. per Unit of Measure");
                ILEGRec.MODIFY;
                
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138647);
                ValueEntryGRec."Cost Amount (Expected)" := (ILEGRec.Quantity * ValueEntryGRec."Cost per Unit");
                ValueEntryGRec."Item Ledger Entry Quantity" := ILEGRec.Quantity;
                ValueEntryGRec."Invoiced Quantity":= ILEGRec.Quantity;
                ValueEntryGRec.MODIFY;
                
                
                AmountGVr := ABS(ValueEntryGRec."Cost Amount (Expected)");
                
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624908);
                GLEntryGRec.Amount := 208.78;
                GLEntryGRec."Debit Amount" := 208.78;
                GLEntryGRec.MODIFY;
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624909);
                GLEntryGRec.Amount := -208.78;
                GLEntryGRec."Credit Amount" := 208.78;
                GLEntryGRec.MODIFY;
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624912);
                GLEntryGRec.Amount := 1879.02;
                GLEntryGRec."Debit Amount" := 1879.02;
                GLEntryGRec.MODIFY;
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624913);
                GLEntryGRec.Amount := -1879.02;
                GLEntryGRec."Credit Amount" := 1879.02;
                GLEntryGRec.MODIFY;
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624922);
                GLEntryGRec.Amount := 2087.8;
                GLEntryGRec."Debit Amount" :=2087.8;
                GLEntryGRec.MODIFY;
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624923);
                GLEntryGRec.Amount := -2087.8;
                GLEntryGRec."Credit Amount" := 2087.8;
                GLEntryGRec.MODIFY;
                
                
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624910);
                GLEntryGRec.Amount := -208.78;
                GLEntryGRec."Credit Amount" := 208.78;
                GLEntryGRec.MODIFY;
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624911);
                GLEntryGRec.Amount := 208.78;
                GLEntryGRec."Debit Amount" := 208.78;
                GLEntryGRec.MODIFY;
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624914);
                GLEntryGRec.Amount := -1879.02;
                GLEntryGRec."Credit Amount" := 1879.02;
                GLEntryGRec.MODIFY;
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624915);
                GLEntryGRec.Amount := 1879.02;
                GLEntryGRec."Debit Amount" := 1879.02;
                GLEntryGRec.MODIFY;
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624924);
                GLEntryGRec.Amount := -2087.8;
                GLEntryGRec."Credit Amount" := 2087.8;
                GLEntryGRec.MODIFY;
                
                GLEntryGRec.RESET;
                GLEntryGRec.GET(624925);
                GLEntryGRec.Amount := 2087.8;
                GLEntryGRec."Debit Amount" := 2087.8;
                GLEntryGRec.MODIFY;
                */
                /*
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138641);
                ValueEntryGRec."Valued Quantity" := ValueEntryGRec."Item Ledger Entry Quantity";
                ValueEntryGRec.MODIFY;
                
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138642);
                ValueEntryGRec."Valued Quantity" := ValueEntryGRec."Item Ledger Entry Quantity";
                ValueEntryGRec.MODIFY;
                
                
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138643);
                ValueEntryGRec."Valued Quantity" := ValueEntryGRec."Item Ledger Entry Quantity";
                ValueEntryGRec.MODIFY;
                
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138644);
                ValueEntryGRec."Valued Quantity" := ValueEntryGRec."Item Ledger Entry Quantity";
                ValueEntryGRec.MODIFY;
                
                
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138646);
                ValueEntryGRec."Valued Quantity" := ValueEntryGRec."Item Ledger Entry Quantity";
                ValueEntryGRec.MODIFY;
                
                
                ValueEntryGRec.RESET;
                ValueEntryGRec.GET(138647);
                ValueEntryGRec."Valued Quantity" := ValueEntryGRec."Item Ledger Entry Quantity";
                ValueEntryGRec.MODIFY;
                */
                ILEGRec.Reset;
                ILEGRec.Get(86004);
                ILEGRec."Applied Entry to Adjust":=true;
                ILEGRec.Modify;
                ILEGRec.Reset;
                ILEGRec.Get(86006);
                ILEGRec."Applied Entry to Adjust":=true;
                ILEGRec.Modify;
                ILEGRec.Reset;
                ILEGRec.Get(86008);
                ILEGRec."Applied Entry to Adjust":=true;
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
