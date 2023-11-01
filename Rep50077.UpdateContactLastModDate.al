report 50077 "Update Contact Last Mod. Date"
{
    // IMP1.01,03/07/17,SK: Created new reprot.
    Permissions = TableData Contact=rimd;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Contact; Contact)
        {
            trigger OnAfterGetRecord()
            begin
                Clear(HighestDateVarGbl);
                QuoteSalesHeadRecGbl.Reset;
                QuoteSalesHeadRecGbl.SetCurrentKey("Document Date");
                QuoteSalesHeadRecGbl.SetRange("Document Type", QuoteSalesHeadRecGbl."Document Type"::Quote);
                QuoteSalesHeadRecGbl.SetRange("Sell-to Contact No.", Contact."No.");
                if QuoteSalesHeadRecGbl.FindLast then HighestDateVarGbl:=QuoteSalesHeadRecGbl."Document Date";
                OrderSalesHeadRecGbl.Reset;
                OrderSalesHeadRecGbl.SetCurrentKey("Document Date");
                OrderSalesHeadRecGbl.SetRange("Document Type", OrderSalesHeadRecGbl."Document Type"::Order);
                OrderSalesHeadRecGbl.SetRange("Sell-to Contact No.", Contact."No.");
                if OrderSalesHeadRecGbl.FindLast then begin
                    if OrderSalesHeadRecGbl."Document Date" > HighestDateVarGbl then HighestDateVarGbl:=OrderSalesHeadRecGbl."Document Date";
                end;
                SalShipHeadRecGbl.Reset;
                SalShipHeadRecGbl.SetCurrentKey("Document Date");
                SalShipHeadRecGbl.SetRange("Sell-to Contact No.", "No.");
                if SalShipHeadRecGbl.FindLast then begin
                    if not SalesHeadRecGbl.Get(SalShipHeadRecGbl."Order No.")then begin
                        if SalShipHeadRecGbl."Document Date" > HighestDateVarGbl then HighestDateVarGbl:=SalShipHeadRecGbl."Document Date";
                    end;
                end;
                if HighestDateVarGbl > Contact."Last Date Modified" then begin
                    if HighestDateVarGbl <> 0D then begin
                        Contact."Last Date Modified":=HighestDateVarGbl;
                        Contact.Modify;
                        CounterVarGbl+=1;
                    end;
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
        if CounterVarGbl > 1 then Message('Updated Successfully');
    end;
    var QuoteSalesHeadRecGbl: Record "Sales Header";
    HighestDateVarGbl: Date;
    OrderSalesHeadRecGbl: Record "Sales Header";
    SalShipHeadRecGbl: Record "Sales Shipment Header";
    SalesHeadRecGbl: Record "Sales Header";
    CounterVarGbl: Integer;
}
