page 50010 "Sales Statistics Chart"
{
    PageType = CardPart;
    SourceTable = "Business Chart Buffer";

    layout
    {
        area(content)
        {
            field(StatusText; StatusText)
            {
                ApplicationArea = All;
                Caption = 'Status Text';
            }
            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;

                /*trigger DataPointClicked(point: DotNet BusinessChartDataPoint)
                begin
                    SetDrillDownIndexes(point);
                    SalesStatMgt.DrillDown(Rec);
                end;

                trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
                begin
                end;*/
                //UPG
                trigger AddInReady()
                begin
                    SalesStatMgt.OnOpenPage(SalesStatSetup);
                    UpdateStatus;
                    SetActionsEnabled;
                end;
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(Show)
            {
                Caption = 'Show';
                Image = View;

                action(BothSales)
                {
                    Caption = 'All Sales';
                    Enabled = bothEnabled;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        SalesStatSetup.SetShowSales(SalesStatSetup."Show Sales"::All);
                        UpdateStatus;
                    end;
                }
                action(PostedSales)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales';
                    Enabled = postedenabled;

                    trigger OnAction()
                    begin
                        SalesStatSetup.SetShowSales(SalesStatSetup."Show Sales"::Posted);
                        UpdateStatus;
                    end;
                }
                action(ExpectedSales)
                {
                    ApplicationArea = All;
                    Caption = 'Expected Sales';
                    Enabled = expectedenabled;

                    trigger OnAction()
                    begin
                        SalesStatSetup.SetShowSales(SalesStatSetup."Show Sales"::Expected);
                        UpdateStatus;
                    end;
                }
            }
            group(PeriodLength)
            {
                Caption = 'Period Length';
                Image = Period;

                action(Day)
                {
                    Caption = 'Day';
                    Enabled = DayEnabled;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        SalesStatSetup.SetPeriodLength(SalesStatSetup."Period Length"::Day);
                        UpdateStatus;
                    end;
                }
                action(Week)
                {
                    ApplicationArea = All;
                    Caption = 'Week';
                    Enabled = WeekEnabled;

                    trigger OnAction()
                    begin
                        SalesStatSetup.SetPeriodLength(SalesStatSetup."Period Length"::Week);
                        UpdateStatus;
                    end;
                }
                action(Month)
                {
                    ApplicationArea = All;
                    Caption = 'Month';
                    Enabled = MonthEnabled;

                    trigger OnAction()
                    begin
                        SalesStatSetup.SetPeriodLength(SalesStatSetup."Period Length"::Month);
                        UpdateStatus;
                    end;
                }
                action(Quarter)
                {
                    ApplicationArea = All;
                    Caption = 'Quarter';
                    Enabled = QuarterEnabled;

                    trigger OnAction()
                    begin
                        SalesStatSetup.SetPeriodLength(SalesStatSetup."Period Length"::Quarter);
                        UpdateStatus;
                    end;
                }
                action(Year)
                {
                    ApplicationArea = All;
                    Caption = 'Year';
                    Enabled = YearEnabled;

                    trigger OnAction()
                    begin
                        SalesStatSetup.SetPeriodLength(SalesStatSetup."Period Length"::Year);
                        UpdateStatus;
                    end;
                }
            }
            group(Options)
            {
                Caption = 'Options';
                Image = SelectChart;

                group(ValueToCalculate)
                {
                    Caption = 'Value to Calculate';
                    Image = Calculate;

                    action(Sales)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales';
                        Enabled = salesenabled;

                        trigger OnAction()
                        begin
                            SalesStatSetup.SetValueToCalcuate(SalesStatSetup."Value to Calculate"::Sales);
                            UpdateStatus;
                        end;
                    }
                    action(Cost)
                    {
                        ApplicationArea = All;
                        Caption = 'Cost';
                        Enabled = costenabled;

                        trigger OnAction()
                        begin
                            SalesStatSetup.SetValueToCalcuate(SalesStatSetup."Value to Calculate"::Cost);
                            UpdateStatus;
                        end;
                    }
                    action(Profit)
                    {
                        ApplicationArea = All;
                        Caption = 'Profit';
                        Enabled = profitenabled;

                        trigger OnAction()
                        begin
                            SalesStatSetup.SetValueToCalcuate(SalesStatSetup."Value to Calculate"::Profit);
                            UpdateStatus;
                        end;
                    }
                }
                group("Chart Type")
                {
                    Caption = 'Chart Type';
                    Image = BarChart;

                    action(StackedArea)
                    {
                        ApplicationArea = All;
                        Caption = 'Stacked Area';
                        Enabled = StackedAreaEnabled;

                        trigger OnAction()
                        begin
                            SalesStatSetup.SetChartType(SalesStatSetup."Chart Type"::"Stacked Area");
                            UpdateStatus;
                        end;
                    }
                    action(StackedAreaPct)
                    {
                        ApplicationArea = All;
                        Caption = 'Stacked Area (%)';
                        Enabled = StackedAreaPctEnabled;

                        trigger OnAction()
                        begin
                            SalesStatSetup.SetChartType(SalesStatSetup."Chart Type"::"Stacked Area (%)");
                            UpdateStatus;
                        end;
                    }
                    action(StackedColumn)
                    {
                        ApplicationArea = All;
                        Caption = 'Stacked Column';
                        Enabled = StackedColumnEnabled;

                        trigger OnAction()
                        begin
                            SalesStatSetup.SetChartType(SalesStatSetup."Chart Type"::"Stacked Column");
                            UpdateStatus;
                        end;
                    }
                    action(StackedColumnPct)
                    {
                        ApplicationArea = All;
                        Caption = 'Stacked Column (%)';
                        Enabled = StackedColumnPctEnabled;

                        trigger OnAction()
                        begin
                            SalesStatSetup.SetChartType(SalesStatSetup."Chart Type"::"Stacked Column (%)");
                            UpdateStatus;
                        end;
                    }
                }
            }
            separator(Action25)
            {
            }
            action(Refresh)
            {
                ApplicationArea = All;
                Caption = 'Refresh';
                Image = Refresh;

                trigger OnAction()
                begin
                    NeedsUpdate := true;
                    UpdateStatus;
                end;
            }
            separator(Action27)
            {
            }
            action(Setup)
            {
                ApplicationArea = All;
                Caption = 'Setup';
                Image = Setup;

                trigger OnAction()
                begin
                    RunSetup;
                end;
            }
        }
    }
    trigger OnFindRecord(Which: Text): Boolean
    begin
        IMPUpdateChart;
    end;

    trigger OnOpenPage()
    begin
        SalesStatMgt.OnOpenPage(SalesStatSetup);
        SetActionsEnabled;
    end;

    var
        SalesStatSetup: Record "Sales Statistics Chart Setup";
        OldSalesStatSetup: Record "Sales Statistics Chart Setup";
        SalesStatMgt: Codeunit "Sales Statistics Chart Mgt.";
        StatusText: Text[250];
        NeedsUpdate: Boolean;
        [InDataSet]
        BothEnabled: Boolean;
        [InDataSet]
        PostedEnabled: Boolean;
        [InDataSet]
        ExpectedEnabled: Boolean;
        [InDataSet]
        DayEnabled: Boolean;
        [InDataSet]
        WeekEnabled: Boolean;
        [InDataSet]
        MonthEnabled: Boolean;
        [InDataSet]
        QuarterEnabled: Boolean;
        [InDataSet]
        YearEnabled: Boolean;
        [InDataSet]
        SalesEnabled: Boolean;
        [InDataSet]
        CostEnabled: Boolean;
        ProfitEnabled: Boolean;
        [InDataSet]
        StackedAreaEnabled: Boolean;
        [InDataSet]
        StackedAreaPctEnabled: Boolean;
        [InDataSet]
        StackedColumnEnabled: Boolean;
        [InDataSet]
        StackedColumnPctEnabled: Boolean;

    local procedure IMPUpdateChart()
    begin
        if not NeedsUpdate then exit;
        SalesStatMgt.UpdateData(Rec);
        Rec.Update(CurrPage.BusinessChart);
        UpdateStatus;
        NeedsUpdate := false;
    end;

    procedure UpdateStatus()
    begin
        NeedsUpdate := NeedsUpdate or (OldSalesStatSetup."Period Length" <> SalesStatSetup."Period Length") or (OldSalesStatSetup."Use Work Date as Base" <> SalesStatSetup."Use Work Date as Base") or (OldSalesStatSetup."Value to Calculate" <> SalesStatSetup."Value to Calculate") or (OldSalesStatSetup."Chart Type" <> SalesStatSetup."Chart Type") or (OldSalesStatSetup."Salesperson Filter" <> SalesStatSetup."Salesperson Filter") or (OldSalesStatSetup."Show Sales" <> SalesStatSetup."Show Sales");
        OldSalesStatSetup := SalesStatSetup;
        if NeedsUpdate then StatusText := SalesStatSetup.GetCurrentSelectionText;
        SetActionsEnabled;
    end;

    procedure RunSetup()
    begin
        PAGE.RunModal(PAGE::"Sales Statistics Chart Setup", SalesStatSetup);
        SalesStatSetup.Get(UserId);
        UpdateStatus;
    end;

    procedure SetActionsEnabled()
    begin
        BothEnabled := SalesStatSetup."Show Sales" <> SalesStatSetup."Show Sales"::All;
        PostedEnabled := SalesStatSetup."Show Sales" <> SalesStatSetup."Show Sales"::Posted;
        ExpectedEnabled := SalesStatSetup."Show Sales" <> SalesStatSetup."Show Sales"::Expected;
        DayEnabled := SalesStatSetup."Period Length" <> SalesStatSetup."Period Length"::Day;
        WeekEnabled := SalesStatSetup."Period Length" <> SalesStatSetup."Period Length"::Week;
        MonthEnabled := SalesStatSetup."Period Length" <> SalesStatSetup."Period Length"::Month;
        QuarterEnabled := SalesStatSetup."Period Length" <> SalesStatSetup."Period Length"::Quarter;
        YearEnabled := SalesStatSetup."Period Length" <> SalesStatSetup."Period Length"::Year;
        SalesEnabled := SalesStatSetup."Value to Calculate" <> SalesStatSetup."Value to Calculate"::Sales;
        CostEnabled := SalesStatSetup."Value to Calculate" <> SalesStatSetup."Value to Calculate"::Cost;
        ProfitEnabled := SalesStatSetup."Value to Calculate" <> SalesStatSetup."Value to Calculate"::Profit;
        StackedAreaEnabled := SalesStatSetup."Chart Type" <> SalesStatSetup."Chart Type"::"Stacked Area";
        StackedAreaPctEnabled := SalesStatSetup."Chart Type" <> SalesStatSetup."Chart Type"::"Stacked Area (%)";
        StackedColumnEnabled := SalesStatSetup."Chart Type" <> SalesStatSetup."Chart Type"::"Stacked Column";
        StackedColumnPctEnabled := SalesStatSetup."Chart Type" <> SalesStatSetup."Chart Type"::"Stacked Column (%)";
    end;
}
