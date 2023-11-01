pageextension 60068 "TrailingSalesOrdersChartExt" extends "Trailing Sales Orders Chart"
{
    actions
    {
        addafter(NoofOrders)
        {
            action(Profit)
            {
                ApplicationArea = All;
                Caption = 'Profit';
                Enabled = profitenabled;

                trigger OnAction();
                begin
                // SalesStatSetup.SetValueToCalcuate(SalesStatSetup."Value to Calculate"::Profit);//UPG MS ChangesBC19
                //UpdateStatus;//UPG
                end;
            }
        }
    }
    //procedure UpdateStatus();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NeedsUpdate :=
      NeedsUpdate or
      (OldTrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length") or
      (OldTrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders") or
      (OldTrailingSalesOrdersSetup."Use Work Date as Base" <> TrailingSalesOrdersSetup."Use Work Date as Base") or
      (OldTrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate") or
      (OldTrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type");

    OldTrailingSalesOrdersSetup := TrailingSalesOrdersSetup;

    if NeedsUpdate then
      StatusText := TrailingSalesOrdersSetup.GetCurrentSelectionText;

    SetActionsEnabled;
    */
    //end;
    var SalesStatSetup: Record 760;
    ProfitEnabled: Boolean;
//Unsupported feature: CodeModification on "OnFindRecord". Please convert manually.
//trigger OnFindRecord();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    UpdateChart;
    IsChartDataReady := true;

    if not IsChartAddInReady then
      SetActionsEnabled;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    UpdateChart;
    IsChartDataReady := TRUE;

    IF NOT IsChartAddInReady THEN
      SetActionsEnabled;
    */
//end;
//Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.
//trigger OnOpenPage();
//>>>> ORIGINAL CODE:
//begin
/*
    SetActionsEnabled;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    SalesStatMgt.OnOpenPage(SalesStatSetup);
    SetActionsEnabled;
    */
//end;
//Unsupported feature: CodeModification on ""BusinessChart@-5::AddInReady"(EVENT 14)". Please convert manually.
//trigger "BusinessChart@-5::AddInReady"(EVENT 14)();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    IsChartAddInReady := true;
    TrailingSalesOrdersMgt.OnOpenPage(TrailingSalesOrdersSetup);
    UpdateStatus;
    if IsChartDataReady then
      UpdateChart;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    IsChartAddInReady := TRUE;
    TrailingSalesOrdersMgt.OnOpenPage(TrailingSalesOrdersSetup);
    UpdateStatus;
    IF IsChartDataReady THEN
      UpdateChart;
    */
//end;
//Unsupported feature: CodeModification on ""BusinessChart@-5::Refresh"(EVENT 15)". Please convert manually.
//trigger "BusinessChart@-5::Refresh"(EVENT 15)();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    if IsChartAddInReady and IsChartDataReady then begin
      NeedsUpdate := true;
      UpdateChart
    end;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    IF IsChartAddInReady AND IsChartDataReady THEN BEGIN
      NeedsUpdate := TRUE;
      UpdateChart
    END;
    */
//end;
//Unsupported feature: CodeModification on "UpdateChart(PROCEDURE 6)". Please convert manually.
//procedure UpdateChart();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    if not NeedsUpdate then
      exit;
    if not IsChartAddInReady then
      exit;
    TrailingSalesOrdersMgt.UpdateData(Rec);
    Update(CurrPage.BusinessChart);
    UpdateStatus;
    NeedsUpdate := false;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    IF NOT NeedsUpdate THEN
      EXIT;
    IF NOT IsChartAddInReady THEN
      EXIT;
    #5..7
    NeedsUpdate := FALSE;
    */
//end;
//Unsupported feature: CodeModification on "UpdateStatus(PROCEDURE 8)". Please convert manually.
//procedure UpdateStatus();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    NeedsUpdate :=
      NeedsUpdate or
      (OldTrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length") or
      (OldTrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders") or
      (OldTrailingSalesOrdersSetup."Use Work Date as Base" <> TrailingSalesOrdersSetup."Use Work Date as Base") or
      (OldTrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate") or
      (OldTrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type");

    OldTrailingSalesOrdersSetup := TrailingSalesOrdersSetup;

    if NeedsUpdate then
      StatusText := TrailingSalesOrdersSetup.GetCurrentSelectionText;

    SetActionsEnabled;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    NeedsUpdate :=
      NeedsUpdate OR
      (OldTrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length") OR
      (OldTrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders") OR
      (OldTrailingSalesOrdersSetup."Use Work Date as Base" <> TrailingSalesOrdersSetup."Use Work Date as Base") OR
      (OldTrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate") OR
    #7..10
    IF NeedsUpdate THEN
    #12..14
    */
//end;
//Unsupported feature: CodeModification on "RunSetup(PROCEDURE 3)". Please convert manually.
//procedure RunSetup();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    PAGE.RunModal(PAGE::"Trailing Sales Orders Setup",TrailingSalesOrdersSetup);
    TrailingSalesOrdersSetup.Get(UserId);
    UpdateStatus;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    PAGE.RUNMODAL(PAGE::"Trailing Sales Orders Setup",TrailingSalesOrdersSetup);
    TrailingSalesOrdersSetup.GET(USERID);
    UpdateStatus;
    */
//end;
//Unsupported feature: CodeModification on "SetActionsEnabled(PROCEDURE 10)". Please convert manually.
//procedure SetActionsEnabled();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    AllOrdersEnabled := (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"All Orders") and
      IsChartAddInReady;
    OrdersUntilTodayEnabled :=
      (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"Orders Until Today") and
      IsChartAddInReady;
    DelayedOrdersEnabled := (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"Delayed Orders") and
      IsChartAddInReady;
    DayEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Day) and
      IsChartAddInReady;
    WeekEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Week) and
      IsChartAddInReady;
    MonthEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Month) and
      IsChartAddInReady;
    QuarterEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Quarter) and
      IsChartAddInReady;
    YearEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Year) and
      IsChartAddInReady;
    AmountEnabled :=
      (TrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate"::"Amount Excl. VAT") and
      IsChartAddInReady;
    NoOfOrdersEnabled :=
      (TrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate"::"No. of Orders") and
      IsChartAddInReady;
    StackedAreaEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Area") and
      IsChartAddInReady;
    StackedAreaPctEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Area (%)") and
      IsChartAddInReady;
    StackedColumnEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Column") and
      IsChartAddInReady;
    StackedColumnPctEnabled :=
      (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Column (%)") and
      IsChartAddInReady;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    AllOrdersEnabled := (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"All Orders") AND
      IsChartAddInReady;
    OrdersUntilTodayEnabled :=
      (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"Orders Until Today") AND
      IsChartAddInReady;
    DelayedOrdersEnabled := (TrailingSalesOrdersSetup."Show Orders" <> TrailingSalesOrdersSetup."Show Orders"::"Delayed Orders") AND
      IsChartAddInReady;
    DayEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Day) AND
      IsChartAddInReady;
    WeekEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Week) AND
      IsChartAddInReady;
    MonthEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Month) AND
      IsChartAddInReady;
    QuarterEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Quarter) AND
      IsChartAddInReady;
    YearEnabled := (TrailingSalesOrdersSetup."Period Length" <> TrailingSalesOrdersSetup."Period Length"::Year) AND
      IsChartAddInReady;
    AmountEnabled :=
      (TrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate"::"Amount Excl. VAT") AND
      IsChartAddInReady;
    NoOfOrdersEnabled :=
      (TrailingSalesOrdersSetup."Value to Calculate" <> TrailingSalesOrdersSetup."Value to Calculate"::"No. of Orders") AND
      IsChartAddInReady;
    StackedAreaEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Area") AND
      IsChartAddInReady;
    StackedAreaPctEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Area (%)") AND
      IsChartAddInReady;
    StackedColumnEnabled := (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Column") AND
      IsChartAddInReady;
    StackedColumnPctEnabled :=
      (TrailingSalesOrdersSetup."Chart Type" <> TrailingSalesOrdersSetup."Chart Type"::"Stacked Column (%)") AND
      IsChartAddInReady;
    */
//end;
//Unsupported feature: PropertyChange. Please convert manually.
}
