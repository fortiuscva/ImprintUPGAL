report 50020 "Update ILE Purchase"
{
    Permissions = TableData "G/L Entry"=rimd,
        TableData "Item Ledger Entry"=rimd,
        TableData "Purchase Line"=rimd,
        TableData "Purch. Rcpt. Line"=rimd,
        TableData "Value Entry"=rimd;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")ORDER(Ascending)WHERE("Document Type"=CONST(Order), "Document No."=CONST('87202'), "Line No."=CONST(10000));

            trigger OnAfterGetRecord()
            begin
                "Purchase Line"."Outstanding Qty. (Base)":=0;
                "Purchase Line"."Qty. to Receive (Base)":=0;
                "Purchase Line"."Qty. Rcd. Not Invoiced (Base)":=9600;
                "Purchase Line"."Qty. Received (Base)":=9600;
                "Purchase Line".Modify;
            end;
        }
        dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")ORDER(Ascending)WHERE("Document No."=CONST('PR138111'), "Line No."=CONST(10000));

            trigger OnAfterGetRecord()
            begin
                "Purch. Rcpt. Line"."Quantity (Base)":=48000;
                "Purch. Rcpt. Line".Modify;
            end;
        }
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=CONST(269994));

            trigger OnAfterGetRecord()
            begin
                "Item Ledger Entry".Quantity:=48000;
                //"Item Ledger Entry"."Applied Entry to Adjust" := TRUE;
                "Item Ledger Entry".Modify;
            end;
        }
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=CONST(519323));

            trigger OnAfterGetRecord()
            begin
                "Value Entry"."Valued Quantity":=48000;
                "Value Entry"."Item Ledger Entry Quantity":=48000;
                "Value Entry"."Cost Amount (Expected)":=1349.28;
                "Value Entry"."Expected Cost Posted to G/L":=1349.28;
                "Value Entry"."Cost per Unit":=0.02811;
                "Value Entry".Modify;
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=FILTER(2148922|2148923));

            trigger OnAfterGetRecord()
            begin
                if "G/L Entry"."Entry No." = 2148922 then begin
                    "G/L Entry".Amount:=1349.28;
                    "G/L Entry"."Debit Amount":=1349.28;
                end
                else if "G/L Entry"."Entry No." = 2148923 then begin
                        "G/L Entry".Amount:=(0 - 1349.28);
                        "G/L Entry"."Credit Amount":=1349.28;
                    end;
                "G/L Entry".Modify;
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
