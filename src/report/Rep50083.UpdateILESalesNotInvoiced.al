report 50083 "Update ILE Sales(Not Invoiced)"
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
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")ORDER(Ascending)WHERE("Document Type"=CONST(Order), "Document No."=CONST('S01149036'), "Line No."=CONST(20000));

            trigger OnAfterGetRecord()
            begin
                "Sales Line"."Outstanding Qty. (Base)":=0;
                "Sales Line"."Qty. to Ship (Base)":=0;
                "Sales Line"."Quantity (Base)":=52200;
                "Sales Line"."Qty. Shipped Not Invd. (Base)":=52200;
                "Sales Line"."Qty. Shipped (Base)":=52200;
                "Sales Line"."Qty. per Unit of Measure":=1000;
                "Sales Line"."Qty. to Invoice (Base)":=52200;
                "Sales Line".Modify;
            end;
        }
        dataitem("Sales Shipment Line"; "Sales Shipment Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")ORDER(Ascending)WHERE("Document No."=CONST('PS1170569'), "Line No."=CONST(20000));

            trigger OnAfterGetRecord()
            begin
                "Sales Shipment Line"."Quantity (Base)":=52200;
                //"Sales Shipment Line"."Qty. per Unit of Measure" := 12000;
                //"Sales Shipment Line"."Qty. Invoiced (Base)" := 16500;
                "Sales Shipment Line".Modify;
            end;
        }
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=CONST(446715));

            trigger OnAfterGetRecord()
            begin
                "Item Ledger Entry".Quantity:=(0 - 52200);
                //"Item Ledger Entry"."Invoiced Quantity" := (0-16500);
                "Item Ledger Entry"."Shipped Qty. Not Returned":=(0 - 52200);
                //"Item Ledger Entry"."Qty. per Unit of Measure" := 12000;
                "Item Ledger Entry".Modify;
            end;
        }
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=FILTER(896166));

            trigger OnAfterGetRecord()
            begin
                if "Value Entry"."Entry No." = 896166 then begin
                    "Value Entry"."Valued Quantity":=(0 - 52200);
                    "Value Entry"."Item Ledger Entry Quantity":=(0 - 52200);
                    //"Value Entry"."Invoiced Quantity" := (0-9600);
                    //"Value Entry"."Cost Amount (Actual)" := (0-55.01);
                    "Value Entry"."Cost Amount (Expected)":=(0 - 170.4);
                    "Value Entry"."Expected Cost Posted to G/L":=(0 - 170.4);
                    "Value Entry"."Cost per Unit":=0.00326;
                    "Value Entry".Modify;
                end;
            /*
                IF "Value Entry"."Entry No." = 637150 THEN BEGIN
                  "Value Entry"."Valued Quantity" := (0-176000);
                  "Value Entry"."Cost Amount (Expected)" := (0);
                  "Value Entry"."Expected Cost Posted to G/L" := (0);
                  "Value Entry"."Cost per Unit" := 0;
                  "Value Entry".MODIFY;
                END;
                */
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.")ORDER(Ascending)WHERE("Entry No."=FILTER(3585149|3585150));

            trigger OnAfterGetRecord()
            begin
                if "G/L Entry"."Entry No." = 3585149 then begin
                    "G/L Entry".Amount:=(0 - 170.4);
                    "G/L Entry"."Credit Amount":=170.4;
                end;
                if "G/L Entry"."Entry No." = 3585150 then begin
                    "G/L Entry".Amount:=170.4;
                    "G/L Entry"."Debit Amount":=170.4;
                end;
                /*
                IF "G/L Entry"."Entry No." = 2594501 THEN BEGIN
                  "G/L Entry".Amount := 0;
                  "G/L Entry"."Debit Amount" := 0;
                END;
                IF "G/L Entry"."Entry No." = 2594502 THEN BEGIN
                  "G/L Entry".Amount := (0-0);
                  "G/L Entry"."Credit Amount" := 0;
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
            trigger OnPreDataItem()
            begin
            //CurrReport.BREAK;
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
