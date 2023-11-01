codeunit 50002 "Sales Statistics Chart Mgt."
{
    // Based off of C760 "Trailing Sales Orders Mgt."
    trigger OnRun()
    begin
    end;
    var SalesStatSetup: Record "Sales Statistics Chart Setup";
    SalesStatEntry: Record "Sales Statistic Entry";
    procedure OnOpenPage(var SalesStatSetup: Record "Sales Statistics Chart Setup")
    var
        UserSetup: Record "User Setup";
    begin
        Message('test');
        if not UserSetup.Get(UserId)then Clear(UserSetup);
        if not SalesStatSetup.Get(UserId)then begin
            SalesStatSetup."User ID":=UserId;
            SalesStatSetup."Use Work Date as Base":=true;
            SalesStatSetup."Period Length":=SalesStatSetup."Period Length"::Month;
            SalesStatSetup."Chart Type":=SalesStatSetup."Chart Type"::"Stacked Column";
            if UserSetup."Salespers./Purch. Code" = '' then SalesStatSetup."Salesperson Filter":='NOPERM1'
            else
                SalesStatSetup."Salesperson Filter":=UserSetup."Salespers./Purch. Code";
            SalesStatSetup."Stat. Chart Salesperson Change":=UserSetup."Stat. Chart Salesperson Change";
            SalesStatSetup."Show Sales":=SalesStatSetup."Show Sales"::All;
            SalesStatSetup."Value to Calculate":=SalesStatSetup."Value to Calculate"::Profit;
            SalesStatSetup.Insert;
        end
        else
        begin
            // Check if User if now locked down
            if not UserSetup."Stat. Chart Salesperson Change" then begin
                // Ensure User is locked down properly
                if UserSetup."Salespers./Purch. Code" = '' then SalesStatSetup."Salesperson Filter":='NOPERM2'
                else
                    SalesStatSetup."Salesperson Filter":=UserSetup."Salespers./Purch. Code";
                SalesStatSetup."Stat. Chart Salesperson Change":=UserSetup."Stat. Chart Salesperson Change";
                SalesStatSetup.Modify;
            end;
        end;
    end;
    procedure DrillDown(var BusChartBuf: Record "Business Chart Buffer")
    var
        SalesStatEntry: Record "Sales Statistic Entry";
        ToDate: Date;
        Measure: Integer;
    begin
        // Measure will be the Show Sales Option  (Both/Posted/Expected)
        Measure:=BusChartBuf."Drill-Down Measure Index";
        if(Measure < 0) or (Measure > 2)then exit;
        SalesStatSetup.Get(UserId);
        //SalesStatEntry.RESET;
        SalesStatEntry.SetFilter("Salesperson Code", SalesStatSetup."Salesperson Filter");
        //IF EVALUATE(SalesHeader.Status,BusChartBuf.GetMeasureValueString(Measure),9) THEN
        //  SalesHeader.SETRANGE(Status,SalesHeader.Status);
        case SalesStatSetup."Show Sales" of SalesStatSetup."Show Sales"::Posted: SalesStatEntry.SetRange(Expected, false);
        SalesStatSetup."Show Sales"::Expected: SalesStatEntry.SetRange(Expected, true);
        end;
        ToDate:=BusChartBuf.GetXValueAsDate(BusChartBuf."Drill-Down X Index");
        SalesStatEntry.SetRange("Posting Date", 0D, ToDate);
        PAGE.Run(PAGE::"Sales Statistic Entries", SalesStatEntry);
    end;
    procedure UpdateData(var BusChartBuf: Record "Business Chart Buffer")
    var
        ChartToStatusMap: array[4]of Integer;
        ToDate: array[5]of Date;
        FromDate: array[5]of Date;
        Value: Decimal;
        TotalValue: Decimal;
        ColumnNo: Integer;
        ExpectedLoop: Integer;
    begin
        SalesStatSetup.Get(UserId);
        BusChartBuf.Initialize;
        BusChartBuf."Period Length":=SalesStatSetup."Period Length";
        BusChartBuf.SetPeriodXAxis;
        //CreateMap(ChartToStatusMap);
        //FOR SalesHeaderStatus := 1 TO ARRAYLEN(ChartToStatusMap) DO BEGIN
        //  SalesHeader.Status := ChartToStatusMap[SalesHeaderStatus];
        //  AddMeasure(FORMAT(SalesHeader.Status),SalesHeader.Status,"Data Type"::Decimal,salesstatsetup.GetChartType);
        //END;
        BusChartBuf.AddMeasure('Posted', 1, BusChartBuf."Data Type"::Decimal, SalesStatSetup.GetChartType);
        BusChartBuf.AddMeasure('Expected', 2, BusChartBuf."Data Type"::Decimal, SalesStatSetup.GetChartType);
        if CalcPeriods(FromDate, ToDate, BusChartBuf)then begin
            BusChartBuf.AddPeriods(ToDate[1], ToDate[ArrayLen(ToDate)]);
            for ExpectedLoop:=1 to 2 do begin
                TotalValue:=0;
                for ColumnNo:=1 to ArrayLen(ToDate)do begin
                    Value:=GetSalesStatValue(ExpectedLoop = 2, FromDate[ColumnNo], ToDate[ColumnNo]);
                    if ColumnNo = 1 then TotalValue:=Value
                    else
                        TotalValue+=Value;
                    // Next line needs ExpectedLoop -1?
                    BusChartBuf.SetValueByIndex(ExpectedLoop - 1, ColumnNo - 1, TotalValue);
                end;
            end;
        end;
    end;
    local procedure CalcPeriods(var FromDate: array[5]of Date; var ToDate: array[5]of Date; var BusChartBuf: Record "Business Chart Buffer"): Boolean var
        MaxPeriodNo: Integer;
        i: Integer;
    begin
        MaxPeriodNo:=ArrayLen(ToDate);
        ToDate[MaxPeriodNo]:=SalesStatSetup.GetStartDate;
        if ToDate[MaxPeriodNo] = 0D then exit(false);
        for i:=MaxPeriodNo downto 1 do begin
            if i > 1 then begin
                FromDate[i]:=BusChartBuf.CalcFromDate(ToDate[i]);
                ToDate[i - 1]:=FromDate[i] - 1;
            end
            else
                //error('got here');
                FromDate[i]:=0D end;
        exit(true);
    end;
    procedure GetSalesStatValue(ExpectedFilter: Boolean; FromDate: Date; ToDate: Date): Decimal begin
        //RESET;
        SalesStatEntry.SetFilter("Salesperson Code", SalesStatSetup."Salesperson Filter");
        SalesStatEntry.SetRange("Posting Date", FromDate, ToDate);
        SalesStatEntry.SetRange(Expected, ExpectedFilter);
        case SalesStatSetup."Value to Calculate" of SalesStatSetup."Value to Calculate"::Sales: begin
            SalesStatEntry.CalcSums("Sales Amount");
            exit(SalesStatEntry."Sales Amount");
        end;
        SalesStatSetup."Value to Calculate"::Cost: begin
            SalesStatEntry.CalcSums("Cost Amount");
            exit(SalesStatEntry."Cost Amount");
        end;
        SalesStatSetup."Value to Calculate"::Profit: begin
            SalesStatEntry.CalcSums("Profit Amount");
            exit(SalesStatEntry."Profit Amount");
        end;
        end;
    end;
    local procedure GetSalesOrderValue(Status: Option; FromDate: Date; ToDate: Date): Decimal begin
    /* UNUSED
        IF salesstatsetup."Value to Calculate" = salesstatsetup."Value to Calculate"::"No. of Orders" THEN
          EXIT(GetSalesOrderCount(Status,FromDate,ToDate));
        EXIT(GetSalesOrderAmount(Status,FromDate,ToDate));
        */
    end;
    local procedure GetSalesOrderAmount(Status: Option; FromDate: Date; ToDate: Date): Decimal var
        CurrExchRate: Record "Currency Exchange Rate";
        TrailingSalesOrderQry: Query "Trailing Sales Order Qry";
        Amount: Decimal;
        TotalAmount: Decimal;
    begin
    /* UNUSED
        IF salesstatsetup."Show Orders" = salesstatsetup."Show Orders"::"Delayed Orders" THEN
          TrailingSalesOrderQry.SETFILTER(ShipmentDate,'<%1',salesstatsetup.GetStartDate);
        
        TrailingSalesOrderQry.SETRANGE(Status,Status);
        TrailingSalesOrderQry.SETRANGE(DocumentDate,FromDate,ToDate);
        TrailingSalesOrderQry.OPEN;
        WHILE TrailingSalesOrderQry.READ DO BEGIN
          IF TrailingSalesOrderQry.CurrencyCode = '' THEN
            Amount := TrailingSalesOrderQry.Amount
          ELSE
            Amount := ROUND(TrailingSalesOrderQry.Amount / CurrExchRate.ExchangeRate(TODAY,TrailingSalesOrderQry.CurrencyCode));
          TotalAmount := TotalAmount + Amount;
        END;
        EXIT(TotalAmount);
        */
    end;
    local procedure GetSalesOrderCount(Status: Option; FromDate: Date; ToDate: Date): Decimal begin
    /* UNUSED
        SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
        IF salesstatsetup."Show Orders" = salesstatsetup."Show Orders"::"Delayed Orders" THEN
          SalesHeader.SETFILTER("Shipment Date",'<%1',salesstatsetup.GetStartDate)
        ELSE
          SalesHeader.SETRANGE("Shipment Date");
        SalesHeader.SETRANGE(Status,Status);
        SalesHeader.SETRANGE("Document Date",FromDate,ToDate);
        EXIT(SalesHeader.COUNT);
        */
    end;
    procedure CreateMap(var Map: array[4]of Integer)
    var
        SalesHeader: Record "Sales Header";
    begin
    /* UNUSED
        Map[1] := SalesHeader.Status::Released;
        Map[2] := SalesHeader.Status::"Pending Prepayment";
        Map[3] := SalesHeader.Status::"Pending Approval";
        Map[4] := SalesHeader.Status::Open;
        */
    end;
}
