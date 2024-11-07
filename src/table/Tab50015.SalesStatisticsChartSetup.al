table 50015 "Sales Statistics Chart Setup"
{
    fields
    {
        field(1; "User ID"; Text[132])
        {
            Caption = 'User ID';
            Description = 'USE';
        }
        field(2; "Period Length"; Option)
        {
            Caption = 'Period Length';
            Description = 'USE';
            OptionCaption = 'Day,Week,Month,Quarter,Year';
            OptionMembers = Day, Week, Month, Quarter, Year;
        }
        field(3; "xShow Orders"; Option)
        {
            Caption = 'Show Orders';
            Description = 'no';
            Enabled = false;
            OptionCaption = 'All Orders,Orders Until Today,Delayed Orders';
            OptionMembers = "All Orders", "Orders Until Today", "Delayed Orders";
        }
        field(4; "Use Work Date as Base"; Boolean)
        {
            Caption = 'Use Work Date as Base';
            Description = 'USE';
        }
        field(5; "Value to Calculate"; Option)
        {
            Caption = 'Value to Calculate';
            Description = 'USE';
            OptionMembers = Sales, Cost, Profit;
        }
        field(6; "Chart Type"; Option)
        {
            Caption = 'Chart Type';
            Description = 'USE';
            OptionCaption = 'Stacked Area,Stacked Area (%),Stacked Column,Stacked Column (%)';
            OptionMembers = "Stacked Area", "Stacked Area (%)", "Stacked Column", "Stacked Column (%)";
        }
        field(7; "xLatest Order Document Date"; Date)
        {
            CalcFormula = Max("Sales Header"."Document Date" WHERE("Document Type"=CONST(Order)));
            Caption = 'Latest Order Document Date';
            Description = 'no';
            Enabled = false;
            FieldClass = FlowField;
        }
        field(100; "Salesperson Filter"; Text[200])
        {
            TableRelation = "Salesperson/Purchaser";
            ValidateTableRelation = false;
        }
        field(101; "Stat. Chart Salesperson Change"; Boolean)
        {
            Description = 'Allow change SP Filter';
        }
        field(105; "Show Sales"; Option)
        {
            OptionMembers = All, Posted, Expected;
        }
    }
    keys
    {
        key(Key1; "User ID")
        {
        }
    }
    fieldgroups
    {
    }
    var Text001: Label 'Updated at %1.';
    procedure GetCurrentSelectionText(): Text[100]begin
        exit(Format("Show Sales") + '|' + Format("Period Length") + '|' + Format("Value to Calculate") + '|. (' + StrSubstNo(Text001, Time) + ')');
    end;
    procedure GetStartDate(): Date var
        StartDate: Date;
    begin
        if "Use Work Date as Base" then StartDate:=WorkDate
        else
            StartDate:=Today;
        //IF "xShow Orders" = "xShow Orders"::"All Orders" THEN BEGIN
        //  CALCFIELDS("xLatest Order Document Date");
        //  StartDate := "xLatest Order Document Date";
        //END;
        exit(StartDate);
    end;
    procedure GetChartType(): Integer var
        BusinessChartBuf: Record "Business Chart Buffer";
    begin
        case "Chart Type" of "Chart Type"::"Stacked Area": exit(BusinessChartBuf."Chart Type"::StackedArea);
        "Chart Type"::"Stacked Area (%)": exit(BusinessChartBuf."Chart Type"::StackedArea100);
        "Chart Type"::"Stacked Column": exit(BusinessChartBuf."Chart Type"::StackedColumn);
        "Chart Type"::"Stacked Column (%)": exit(BusinessChartBuf."Chart Type"::StackedColumn100);
        end;
    end;
    procedure SetPeriodLength(PeriodLength: Option)
    begin
        "Period Length":=PeriodLength;
        Modify;
    end;
    procedure SetShowSales(ShowSales: Integer)
    begin
        // Was Show Orders
        "Show Sales":=ShowSales;
        Modify;
    end;
    procedure SetValueToCalcuate(ValueToCalc: Integer)
    begin
        "Value to Calculate":=ValueToCalc;
        Modify;
    end;
    procedure SetChartType(ChartType: Integer)
    begin
        "Chart Type":=ChartType;
        Modify;
    end;
}
