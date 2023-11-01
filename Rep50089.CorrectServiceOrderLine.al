report 50089 "Correct Service Order Line"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Service Line"; "Service Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")ORDER(Ascending)WHERE("Document Type"=CONST(Order), "Document No."=CONST('SO000889'), "Line No."=FILTER(10000));

            trigger OnAfterGetRecord()
            begin
                /*
                "Service Line".Amount := "Service Line"."Shipped Not Invoiced";
                "Service Line"."VAT Base Amount" := "Service Line"."Shipped Not Invoiced";
                "Service Line".MODIFY;
                */
                "Service Line"."Amount Including VAT":=130;
                "Service Line".Modify;
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
