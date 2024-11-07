codeunit 50013 "TEMP PL FIX"
{
    trigger OnRun()
    begin
        /*PL.SETRANGE("Document Type",PL."Document Type"::Order);
        PL.SETRANGE("Document No.",'S01004394');
        PL.FINDFIRST;
        PL."Qty. per Unit of Measure" := 1;
        PL."Quantity (Base)" := 48;
        PL."Outstanding Qty. (Base)" := 0;
        PL."Qty. to Receive (Base)" := 0;
        PL."Qty. to Invoice (Base)" := 0;
        PL.MODIFY;
        */
        SL.SetRange("Document Type", SL."Document Type"::Order);
        SL.SetRange("Document No.", 'S01004394');
        SL.FindFirst;
        SL."Purchase Order No.":='';
        SL."Purch. Order Line No.":=0;
        SL.Modify;
    end;
    var PL: Record "Purchase Line";
    SL: Record "Sales Line";
}
