report 50097 "Update Document tables"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Update Document tables.rdl';
    Permissions = TableData "Sales Shipment Line" = rimd,
        TableData "Sales Invoice Line" = rimd,
        TableData "Purch. Rcpt. Line" = rimd;

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending) WHERE("Document Type" = CONST(Order), "Document No." = CONST('46503'), "Line No." = CONST(10000));

            trigger OnAfterGetRecord()
            begin
                /*
                "Purchase Line"."Qty. Rcd. Not Invoiced (Base)" := 15200;
                "Purchase Line"."Qty. Received (Base)" := 15200;
                "Purchase Line"."Outstanding Qty. (Base)" := 15200;
                */
                "Purchase Line"."Qty. to Receive (Base)" := 0;
                "Purchase Line".Modify;
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
