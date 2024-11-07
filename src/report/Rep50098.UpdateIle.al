report 50098 "Update Ile"
{
    Permissions = TableData "G/L Entry"=rimd,
        TableData "Item Ledger Entry"=rimd,
        TableData "Value Entry"=rimd;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = WHERE("Entry No."=CONST(161103));

            trigger OnAfterGetRecord()
            begin
                //"Item Ledger Entry".Quantity:=80000;
                "Value Entry"."Valued Quantity":=(0 - 15200);
                "Value Entry"."Item Ledger Entry Quantity":=(0 - 15200);
                "Value Entry"."Invoiced Quantity":=(0 - 15200);
                "Value Entry"."Cost per Unit":=0.01973;
                "Value Entry"."Cost Amount (Expected)":=0;
                "Value Entry"."Cost Amount (Actual)":=(0 - 299.9);
                "Value Entry"."Expected Cost Posted to G/L":=0;
                "Value Entry"."Cost Posted to G/L":=(0 - 299.9);
                //"Value Entry"."Invoiced Quantity":=128000;
                Modify;
            end;
        }
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = WHERE("Entry No."=CONST(100162));

            trigger OnAfterGetRecord()
            begin
                "Item Ledger Entry".Quantity:=(0 - 15200);
                "Item Ledger Entry"."Invoiced Quantity":=(0 - 15200);
                "Item Ledger Entry"."Shipped Qty. Not Returned":=(0 - 15200);
                Modify;
            end;
        }
        dataitem(DebitEntry; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=CONST(715587));

            trigger OnAfterGetRecord()
            begin
                DebitEntry.Amount:=299.9;
                DebitEntry."Debit Amount":=299.9;
                DebitEntry.Modify;
            end;
        }
        dataitem(CreditEntry; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=CONST(715586));

            trigger OnAfterGetRecord()
            begin
                CreditEntry.Amount:=-299.9;
                CreditEntry."Credit Amount":=299.9;
                CreditEntry.Modify;
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
}
