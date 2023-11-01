report 50088 "Update Ser. Date at PSI"
{
    // IMP1.01,03/06/19,SK: Created new report to update "Service Date" At Posted Service Invoice (One time purpose only).
    Caption = 'Update Ser. Date at PSI';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Service Invoice Header"; "Service Invoice Header")
        {
            DataItemTableView = SORTING("Order No.")ORDER(Ascending)WHERE("Order No."=FILTER(<>''));
            RequestFilterFields = "Order No.";

            trigger OnAfterGetRecord()
            begin
                Clear(PosServShpHeadRecGbl);
                PosServShpHeadRecGbl.Reset;
                PosServShpHeadRecGbl.SetCurrentKey("Order No.");
                PosServShpHeadRecGbl.SetRange("Order No.", "Order No.");
                if PosServShpHeadRecGbl.FindFirst then begin
                    "Service Date":=PosServShpHeadRecGbl."Posting Date";
                    Counter+=1;
                    Modify;
                end;
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
    trigger OnPostReport()
    begin
        if Counter > 0 then Message('Updated Successfully');
    end;
    var PosServShpHeadRecGbl: Record "Service Shipment Header";
    Counter: Integer;
}
