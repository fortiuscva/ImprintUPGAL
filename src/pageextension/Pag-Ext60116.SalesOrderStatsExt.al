pageextension 60116 "SalesOrderStatsExt" extends "Sales Order Stats."
{
    layout
    {
        modify("TotalAdjCostLCY[1] - TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            trigger OnDrillDown()
            begin
                Rec.LookupAdjmtValueEntries(0);
            end;
        }
        modify("TotalAdjCostLCY[2] - TotalSalesLineLCY[2].""Unit Cost (LCY)""")
        {
            trigger OnDrillDown()
            begin
                Rec.LookupAdjmtValueEntries(1);
            end;
        }
    }
    var myInt: Integer;
}
