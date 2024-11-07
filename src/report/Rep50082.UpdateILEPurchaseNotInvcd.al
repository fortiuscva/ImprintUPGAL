report 50082 "Update ILE Purchase (Not Invcd"
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
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")ORDER(Ascending)WHERE("Document Type"=CONST(Order), "Document No."=CONST('137536'), "Line No."=CONST(10000));

            trigger OnAfterGetRecord()
            begin
                "Purchase Line"."Outstanding Qty. (Base)":=0;
                "Purchase Line"."Qty. to Receive (Base)":=0;
                "Purchase Line"."Qty. Rcd. Not Invoiced (Base)":=52200;
                "Purchase Line"."Qty. Received (Base)":=52200;
                "Purchase Line".Modify;
            end;
        }
        dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")ORDER(Ascending)WHERE("Document No."=CONST('PR195447'), "Line No."=CONST(10000));

            trigger OnAfterGetRecord()
            begin
                "Purch. Rcpt. Line"."Quantity (Base)":=52200;
                "Purch. Rcpt. Line".Modify;
            end;
        }
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=CONST(446714));

            trigger OnAfterGetRecord()
            begin
                "Item Ledger Entry".Quantity:=52200;
                "Item Ledger Entry".Modify;
            end;
        }
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=CONST(896165));

            trigger OnAfterGetRecord()
            begin
                "Value Entry"."Valued Quantity":=52200;
                "Value Entry"."Item Ledger Entry Quantity":=52200;
                "Value Entry"."Cost Amount (Expected)":=170.4;
                "Value Entry"."Expected Cost Posted to G/L":=170.4;
                "Value Entry"."Cost per Unit":=0.00326;
                "Value Entry".Modify;
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=FILTER(3585147|3585148));

            trigger OnAfterGetRecord()
            begin
                if "G/L Entry"."Entry No." = 3585147 then begin
                    "G/L Entry".Amount:=170.4;
                    "G/L Entry"."Debit Amount":=170.4;
                end
                else if "G/L Entry"."Entry No." = 3585148 then begin
                        "G/L Entry".Amount:=(0 - 170.4);
                        "G/L Entry"."Credit Amount":=170.4;
                    end;
                "G/L Entry".Modify;
            end;
            trigger OnPreDataItem()
            begin
            // CurrReport.BREAK;
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
