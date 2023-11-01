page 50013 "Demo Cash Flow Chart"
{
    layout
    {
        area(content)
        {
            usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;

                /* trigger DataPointClicked(point: DotNet BusinessChartDataPoint)
                 begin
                     BusinessChartBuffer.SetDrillDownIndexes(point);
                     DemoCashFlowChartMgt.OnDataPointClicked(BusinessChartBuffer);
                 end;

                 trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
                 begin
                 end;*/
                //UPG
                trigger AddInReady()
                begin
                    UpdateChart;
                end;
            }
        }
    }
    actions
    {
    }
    var BusinessChartBuffer: Record "Business Chart Buffer";
    DemoCashFlowChartMgt: Codeunit "Demo Cash Flow Chart Mgt.";
    local procedure UpdateChart()
    begin
        DemoCashFlowChartMgt.GenerateData(BusinessChartBuffer);
        BusinessChartBuffer.Update(CurrPage.Chart);
    end;
}
