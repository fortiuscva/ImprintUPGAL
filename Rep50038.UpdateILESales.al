report 50038 "Update ILE Sales"
{
    Permissions = TableData "G/L Entry"=rimd,
        TableData "Item Ledger Entry"=rimd,
        TableData "Sales Line"=rimd,
        TableData "Purchase Line"=rimd,
        TableData "Sales Shipment Line"=rimd,
        TableData "Purch. Rcpt. Line"=rimd,
        TableData "Value Entry"=rimd;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")ORDER(Ascending)WHERE("Document Type"=CONST(Order), "Document No."=CONST('S01103517'), "Line No."=CONST(20000));

            trigger OnAfterGetRecord()
            begin
                "Sales Line"."Quantity (Base)":=48000;
                "Sales Line"."Outstanding Qty. (Base)":=0;
                "Sales Line"."Qty. to Ship (Base)":=0;
                //"Sales Line"."Qty. to Invoice (Base)" := 48000;
                //"Sales Line"."Qty. Shipped (Base)" := 48000;
                //"Sales Line"."Qty. Shipped Not Invd. (Base)" := 48000;
                //"Sales Line"."Qty. per Unit of Measure" := 1000;
                "Sales Line".Modify;
            end;
        }
        dataitem("Sales Shipment Line"; "Sales Shipment Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")ORDER(Ascending)WHERE("Document No."=CONST('PS1114478'), "Line No."=CONST(20000));

            trigger OnAfterGetRecord()
            begin
                "Sales Shipment Line"."Quantity (Base)":=48000;
                //"Sales Shipment Line"."Qty. per Unit of Measure" := 1000;
                //"Sales Shipment Line"."Qty. Invoiced (Base)" := 16500;
                "Sales Shipment Line".Modify;
            end;
        }
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=CONST(269995));

            trigger OnAfterGetRecord()
            begin
                "Item Ledger Entry".Quantity:=(0 - 48000);
                //"Item Ledger Entry"."Invoiced Quantity" := (0-16500);
                "Item Ledger Entry"."Shipped Qty. Not Returned":=(0 - 48000);
                "Item Ledger Entry".Modify;
            end;
        }
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=FILTER(519324));

            trigger OnAfterGetRecord()
            begin
                if "Value Entry"."Entry No." = 519324 then begin
                    "Value Entry"."Valued Quantity":=(0 - 48000);
                    "Value Entry"."Item Ledger Entry Quantity":=(0 - 48000);
                    //"Value Entry"."Invoiced Quantity" := (0-9600);
                    //"Value Entry"."Cost Amount (Actual)" := (0-55.01);
                    "Value Entry"."Cost Amount (Expected)":=(0 - 1349.28);
                    "Value Entry"."Expected Cost Posted to G/L":=(0 - 1349.28);
                    "Value Entry"."Cost per Unit":=0.02811;
                    //"Value Entry"."Item Ledger Entry Quantity" := (0 -  48000);
                    //"Value Entry"."Valued Quantity" := (0 - 48000);
                    "Value Entry".Modify;
                end;
            /*
                IF "Value Entry"."Entry No." = 519325 THEN BEGIN
                  "Value Entry"."Valued Quantity" := (0-16500);
                  //"Value Entry"."Item Ledger Entry Quantity" := (0 - 9600);
                  "Value Entry"."Invoiced Quantity" := (0-16500);
                  "Value Entry"."Cost Amount (Actual)" := (0-65.84);
                  "Value Entry"."Cost Posted to G/L" := (0-65.84);
                  "Value Entry"."Cost Amount (Expected)" := 65.84;
                  "Value Entry"."Expected Cost Posted to G/L" := 65.84;
                  "Value Entry".MODIFY;
                END;
                */
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=FILTER(2148924|2148925));

            trigger OnAfterGetRecord()
            begin
                if "G/L Entry"."Entry No." = 2148924 then begin
                    "G/L Entry".Amount:=(0 - 1349.28);
                    "G/L Entry"."Credit Amount":=1349.28;
                end;
                if "G/L Entry"."Entry No." = 2148925 then begin
                    "G/L Entry".Amount:=1349.28;
                    "G/L Entry"."Debit Amount":=1349.28;
                end;
                /*
                IF "G/L Entry"."Entry No." = 1160083 THEN BEGIN
                  "G/L Entry".Amount := 65.84;
                  "G/L Entry"."Debit Amount" := 65.84;
                END;
                IF "G/L Entry"."Entry No." = 1160084 THEN BEGIN
                  "G/L Entry".Amount := (0-65.84);
                  "G/L Entry"."Credit Amount" := 65.84;
                END;
                IF "G/L Entry"."Entry No." = 1160085 THEN BEGIN
                  "G/L Entry".Amount := 65.84;
                  "G/L Entry"."Debit Amount" := 65.84;
                END;
                IF "G/L Entry"."Entry No." = 1160086 THEN BEGIN
                  "G/L Entry".Amount := (0-65.84);
                  "G/L Entry"."Credit Amount" := 65.84;
                END;
                */
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
