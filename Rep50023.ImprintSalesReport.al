report 50023 "Imprint Sales Report"
{
    // <changelog>
    //   <add id="NA0000" dev="JNOZZI" date="2006-02-21" area="REPORTS SR" feature="622"
    //     releaseversion="NAVNA4.00.01">North American Top __ Customer List Report.</add>
    //   <change id="NA0001" dev="JNOZZI" date="2006-02-22" area="REPORTS GL" feature="282"
    //     baseversion="NAVNA4.00.01" releaseversion="NAVNA5.00">Add ability to Print to Excel.</change>
    //   <change id="NA0002" dev="JNOZZI" date="2006-05-16" area="REPORTS SR"  request="15738"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Make Top Customer Report Date Aware - Use the Balance on
    //     Date field</change>
    //   <change id="NA0003" dev="V-GEXION" date="2008-05-17" area="REPORTS SR" feature="NC14261"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA6.00">Report Transformation - local Report Layout</change>
    //   <change id="NA0004" dev="JNOZZI" date="2008-08-13" area="REPORTS SR" feature="NC26984"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00">Fix PrintToExcel so no code for it is in the sections.
    //     </change>
    //   <change id="NA0005" dev="JNOZZI" date="2008-11-17" area="REPORTS SR" feature="NC31858"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00.01">Correct problem where totals were not printed correctly.
    //     </change>
    //   <change id="NA0006" dev="ALL-E" date="2011-03-03" area="REPORTS SR" feature="VSTF253725"
    //     baseversion="NA6.00.01" releaseversion="NA7.00">
    //     Caption of Customer Top 10 List Report is Translated To Top  Customer List in the NA Local Version</change>
    // </changelog>
    //IMP1.01,30-Oct-23,SK: -> Added code to rank the customer with new option "Profit".
    //                    -> Changed the array length to 1000 to have this report process 999 records.
    DefaultLayout = RDLC;
    RDLCLayout = './Imprint Sales Report.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'IMP Customer Top 10 List';

    dataset
    {
        dataitem(Heading; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            column(MainTitle; MainTitle)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(SubTitle; SubTitle)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(ColHead; ColHead)
            {
            }
            column(PrintToExcel; PrintToExcel)
            {
            }
            column(Heading_Number; Number)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(iCaption; iCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(TopNo_i_Caption; TopNo_i_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "No.", "Customer Posting Group", "Salesperson Code", "Date Filter";

                trigger OnAfterGetRecord()
                begin
                    Window.Update(1, "No.");
                    // NA0001.begin
                    // IF TopType = TopType::"Balance ($)" THEN BEGIN
                    // CALCFIELDS("Balance (LCY)");
                    // TempAmount := "Balance (LCY)";
                    // END ELSE BEGIN
                    // CALCFIELDS("Sales (LCY)");
                    // TempAmount := "Sales (LCY)";
                    // END;
                    // GrandTotal := GrandTotal + TempAmount;
                    // TopNo[NextTopLineNo] := "No.";
                    // TopAmount[NextTopLineNo] := TempAmount;
                    // NA0001.end
                    // NA0001.begin
                    // NA0002.begin
                    // CALCFIELDS("Balance (LCY)","Sales (LCY)");
                    // TopBalance[NextTopLineNo] := "Balance (LCY)";
                    // NA0002.end
                    // NA0002.begin
                    CalcFields("Balance on Date (LCY)", "Sales (LCY)");

                    //IMP1.01 Start
                    CLEAR(CostCalcMgt);
                    CALCFIELDS("Profit (LCY)");
                    CustSalesLCY := "Sales (LCY)";
                    CustProfit := "Profit (LCY)" + CostCalcMgt.NonInvtblCostAmt(Customer);
                    AdjmtCostLCY := CustSalesLCY - CustProfit + CostCalcMgt.CalcCustActualCostLCY(Customer);
                    AdjCustProfit := CustProfit + AdjmtCostLCY;
                    //IMP1.01 End

                    TopBalance[NextTopLineNo] := "Balance on Date (LCY)";
                    // NA0002.end
                    TopSale[NextTopLineNo] := "Sales (LCY)";

                    //IMP1.01 Start
                    TopProfit[NextTopLineNo] := AdjCustProfit;
                    //IMP1.01 End

                    if TopType = TopType::"Balance ($)" then
                        TopAmount[NextTopLineNo] := TopBalance[NextTopLineNo]
                    //IMP1.01 Start
                    else
                        if TopType = TopType::"Profit $" then
                            TopAmount[NextTopLineNo] := TopProfit[NextTopLineNo]
                        //IMP1.01 End
                        else
                            TopAmount[NextTopLineNo] := TopSale[NextTopLineNo];
                    GrandTotal := GrandTotal + TopAmount[NextTopLineNo];
                    GrandTotalBalance := GrandTotalBalance + TopBalance[NextTopLineNo];
                    GrandTotalSale := GrandTotalSale + TopSale[NextTopLineNo];
                    TopNo[NextTopLineNo] := "No.";
                    // NA0001.end
                    TopName[NextTopLineNo] := Name;
                    i := NextTopLineNo;
                    if NextTopLineNo < (CustomersToRank + 1) then NextTopLineNo := NextTopLineNo + 1;
                    while i > 1 do begin
                        i := i - 1;
                        if TopAmount[i + 1] > TopAmount[i] then begin
                            // Sort the Customers by amount, largest should be first, smallest last. Put
                            // values from position i into save variables, move values from position
                            // i+1 to position i then put save values back in array in position i+1.
                            // NA0001.begin
                            // TempNo := TopNo[i];
                            // TempAmount := TopAmount[i];
                            // TempName := TopName[i];
                            // TopNo[i] := TopNo[i + 1];
                            // TopAmount[i] := TopAmount[i + 1];
                            // TopName[i] := TopName[i + 1];
                            // TopNo[i + 1] := TempNo;
                            // TopAmount[i + 1] := TempAmount;
                            // TopName[i + 1] := TempName;
                            // NA0001.end
                            // NA0001.begin
                            SwapCode(TopNo, i);
                            SwapAmt(TopAmount, i);
                            SwapAmt(TopSale, i);
                            SwapAmt(TopBalance, i);
                            //IMP1.01 Start
                            SwapAmt(TopProfit, i);
                            //IMP1.01 End
                            SwapText(TopName, i);
                            // NA0001.end
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    NextTopLineNo := 1;
                    Window.Open(Text000 + ' #1########');
                end;
            }
            dataitem("Print Loop"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 99;

                column(i; i)
                {
                }
                column(TopNo_i_; TopNo[i])
                {
                }
                column(Top__; "Top%")
                {
                    DecimalPlaces = 1 : 1;
                }
                column(TopAmount_i_; TopAmount[i])
                {
                }
                column(BarText; BarText)
                {
                }
                column(TopName_i_; TopName[i])
                {
                }
                column(BarTextNNC; BarTextNNC)
                {
                }
                column(STRSUBSTNO__Top__1_Total__2__CustomersToRank_TopTotalText_; StrSubstNo('Top %1 Total %2', CustomersToRank, TopTotalText))
                {
                }
                column(Top___Control23; "Top%")
                {
                    DecimalPlaces = 1 : 1;
                }
                column(TopTotal; TopTotal)
                {
                }
                column(V100_0____Top__; 100.0 - "Top%")
                {
                    DecimalPlaces = 1 : 1;
                }
                column(GrandTotal___TopTotal; GrandTotal - TopTotal)
                {
                }
                column(Total_____TopTotalText; 'Total ' + TopTotalText)
                {
                }
                column(GrandTotal; GrandTotal)
                {
                }
                column(Print_Loop_Number; Number)
                {
                }
                column(All_other_customersCaption; All_other_customersCaptionLbl)
                {
                }
                column(V100_0Caption; V100_0CaptionLbl)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    i := i + 1;
                    // NA0005.begin
                    // IF i = NextTopLineNo THEN
                    // CurrReport.BREAK;
                    // NA0005.end
                    // NA0005.begin
                    if i = NextTopLineNo then begin
                        if TopType = TopType::"Balance ($)" then
                            TopTotalText := Text115
                        //IMP1.01 Start
                        else
                            if TopType = TopType::"Profit $" then
                                TopTotalText := Text50000
                            //IMP1.01 End
                            else
                                TopTotalText := Text005;
                        if GrandTotal <> 0 then
                            "Top%" := Round(TopTotal / GrandTotal * 100, 0.1)
                        else
                            "Top%" := 0;
                        CurrReport.Break;
                    end;
                    // NA0005.end
                    TopTotal := TopTotal + TopAmount[i];
                    // NA0001.begin
                    TopTotalBalance := TopTotalBalance + TopBalance[i];
                    TopTotalSale := TopTotalSale + TopSale[i];
                    //IMP1.01 Start
                    TopTotalProfit := TopTotalProfit + TopProfit[i];
                    //IMP1.01 End
                    // NA0001.end
                    if (TopAmount[1] > 0) and (TopAmount[i] > 0) then
                        BarText := ParagraphHandling.PadStrProportional('', Round(TopAmount[i] / TopAmount[1] * 61, 1), 7, '|')
                    else
                        BarText := '';
                    if GrandTotal <> 0 then
                        "Top%" := Round(TopAmount[i] / GrandTotal * 100, 0.1)
                    else
                        "Top%" := 0;
                    // NA0003.Begin
                    if (TopAmount[1] > 0) and (TopAmount[i] > 0) then
                        BarTextNNC := Round(TopAmount[i] / TopAmount[1] * 100, 1)
                    else
                        BarTextNNC := 0;
                    if TopType = TopType::"Balance ($)" then
                        TopTotalText := 'Amount Outstanding'
                    //IMP1.01 Start
                    else
                        if TopType = TopType::"Profit $" then
                            TopTotalText := 'Profit'
                        //IMP1.01 End
                        else
                            TopTotalText := 'Sales';
                    // NA0003.End
                    // NA0004.begin
                    if PrintToExcel then MakeExcelDataBody;
                    // NA0004.end
                end;

                trigger OnPostDataItem()
                begin
                    // NA0004.begin
                    if PrintToExcel then
                        //IMP1.01 Start
                        //if (GrandTotalBalance <> TopTotalBalance) or (GrandTotalSale <> TopTotalSale) then begin //Base Code Commented
                        if (GrandTotalBalance <> TopTotalBalance) OR (GrandTotalSale <> TopTotalSale) OR (GrandTotalProfit <> TopTotalProfit) then begin //IMP1.01 End
                            if GrandTotal <> 0 then
                                "Top%" := Round(TopTotal / GrandTotal * 100, 0.1)
                            else
                                "Top%" := 0;
                            ExcelBuf.NewRow;
                            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(Format(Text114), false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn(GrandTotalSale - TopTotalSale, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn(GrandTotalBalance - TopTotalBalance, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
                            ExcelBuf.AddColumn((100 - "Top%") / 100, false, '', false, false, false, '0.0%', ExcelBuf."Cell Type"::Number);
                        end;
                    // NA0004.end
                end;

                trigger OnPreDataItem()
                begin
                    Window.Close;
                    i := 0;
                end;
            }
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(Show; TopType)
                    {
                        Caption = 'Show';
                        OptionCaption = 'Sales ($),Balance ($),Profit ($)';
                        ApplicationArea = All;
                    }
                    field(CustomersToRank; CustomersToRank)
                    {
                        Caption = 'No. of Customers to Rank';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            // NA0001.begin
                            // IF CustomersToRank > 99 THEN
                            // ERROR('Number of customers must be no greater than 99');
                            // NA0001.end
                            // NA0001.begin
                            if not (CustomersToRank < ArrayLen(TopNo)) then
                                Error(Text008, ArrayLen(TopNo));
                            // NA0001.end
                        end;
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            CustomersToRank := 199;
        end;
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        // NA0001.begin
        if PrintToExcel then CreateExcelbook;
        // NA0001.end
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        if CustomersToRank = 0 then // default
            CustomersToRank := 20;
        if TopType = TopType::"Balance ($)" then begin
            // NA0001.begin
            // SubTitle := Text001;
            // NA0001.end
            // NA0001.begin
            if Customer.GetFilter("Date Filter") = '' then
                SubTitle := Text001
            else
                SubTitle := Text006 + ' ' + Format(Customer.GetRangeMax("Date Filter")) + ')';
            // NA0001.end
            ColHead := Text002;
            //IMP1.01 Start
        end else
            if TopType = TopType::"Profit $" then begin
                if Customer.GETFILTER("Date Filter") = '' then
                    SubTitle := Text50002
                else
                    SubTitle := Text50003 + ' ' +
                      FORMAT(Customer.GETRANGEMAX("Date Filter")) + ')';
                ColHead := Text50000;
                //IMP1.01 End
            end else begin
                if Customer.GetFilter("Date Filter") = '' then
                    SubTitle := Text003
                else
                    SubTitle := Text004 + ' ' + Customer.GetFilter("Date Filter") + ')';
                ColHead := Text005;
            end;
        // NA0001.begin
        // MainTitle := Text006 + ' '+ FORMAT(CustomersToRank) + Text007;
        // NA0001.end
        // NA0001.begin
        MainTitle := StrSubstNo(Text102, CustomersToRank);
        // NA0001.end
        /* Temporarily remove date filter, since it will show in the header anyway */
        Customer.SetRange("Date Filter");
        FilterString := Customer.GetFilters;
        // NA0001.begin
        if PrintToExcel then MakeExcelInfo;
        // NA0001.end
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        FilterString: Text[250];
        MainTitle: Text[150];
        SubTitle: Text[150];
        ColHead: Text[15];
        TopTotalText: Text[250];
        BarText: Text[250];
        TopName: array[1000] of Text[100];
        "Top%": Decimal;
        GrandTotal: Decimal;
        GrandTotalBalance: Decimal;
        GrandTotalSale: Decimal;
        TopAmount: array[1000] of Decimal;
        TopTotal: Decimal;
        TopTotalBalance: Decimal;
        TopTotalSale: Decimal;
        TopBalance: array[1000] of Decimal;
        TopSale: array[1000] of Decimal;
        i: Integer;
        NextTopLineNo: Integer;
        CustomersToRank: Integer;
        TopType: Option "Sales ($)","Balance ($)","Profit $";
        TopNo: array[1000] of Code[20];
        CompanyInformation: Record "Company Information";
        Window: Dialog;
        ParagraphHandling: Codeunit 10025;
        Text000: Label 'Going through customers ';
        Text001: Label '(by Balance Due)';
        Text002: Label 'Balances';
        Text003: Label '(by Total Sales)';
        Text004: Label '(by Sales During the Period';
        Text005: Label 'Sales';
        PrintToExcel: Boolean;
        Text006: Label '(by Balance Due as of';
        Text008: Label 'Number of customers must be less than %1';
        Text101: Label 'Data';
        Text102: Label 'Top %1 Customers';
        Text103: Label 'Company Name';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        Text108: Label 'Subtitle';
        Text109: Label 'Customer Filters';
        Text110: Label 'Sales Amount';
        Text111: Label 'Balance Amount';
        Text112: Label 'Percent of Total Sales';
        Text113: Label 'Percent of Total Balance';
        Text114: Label 'All other customers';
        BarTextNNC: Integer;
        Text115: Label 'Amount Outstanding';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        iCaptionLbl: Label 'Rank';
        EmptyStringCaptionLbl: Label '%';
        TopNo_i_CaptionLbl: Label 'Customer';
        NameCaptionLbl: Label 'Name';
        All_other_customersCaptionLbl: Label 'All other customers';
        V100_0CaptionLbl: Label '100.0';
        Text50000: Label 'Profit';
        Text50001: Label 'Percent of Total Profit';
        Text50002: Label '(by Total Profit)';
        Text50003: Label '(by Profit During the Period';
        CostCalcMgt: codeunit "Cost Calculation Management";
        CustSalesLCY: Decimal;
        AdjmtCostLCY: Decimal;
        CustProfit: Decimal;
        AdjCustProfit: Decimal;
        GrandTotalProfit: Decimal;
        TopTotalProfit: Decimal;
        TopProfit: array[1000] of Decimal;

    local procedure MakeExcelInfo()
    begin
        // NA0001.begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(Format(Text103), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text105), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Format(MainTitle), false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text104), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddInfoColumn(REPORT::"Customer Top 10 List",FALSE,FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text106), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text107), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Today, false, false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(Time, false, false, false, false, '', ExcelBuf."Cell Type"::Time);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text108), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(SubTitle, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text109), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
        // NA0001.end
    end;

    local procedure MakeExcelDataHeader()
    begin
        // NA0001.begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer.TableCaption + ' ' + Customer.FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Format(Text110), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Format(Text111), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        //IMP1.01 Start
        ExcelBuf.AddColumn(FORMAT(Text50000), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        //IMP1.01 End
        if TopType = TopType::"Balance ($)" then
            ExcelBuf.AddColumn(Format(Text113), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text)
        //IMP1.01 Start
        else
            if TopType = TopType::"Profit $" then
                ExcelBuf.AddColumn(FORMAT(Text50001), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text)
            //IMP1.01 End
            else
                ExcelBuf.AddColumn(Format(Text112), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        // NA0001.end
    end;

    local procedure MakeExcelDataBody()
    begin
        // NA0001.begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(TopNo[i], false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TopName[i], false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TopSale[i], false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TopBalance[i], false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(TopProfit[i], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number); //IMP1.01
        ExcelBuf.AddColumn("Top%" / 100, false, '', false, false, false, '0.0%', ExcelBuf."Cell Type"::Number);
        // NA0001.end
    end;

    local procedure CreateExcelbook()
    begin
        // NA0001.begin
        //ExcelBuf.CreateBookAndOpenExcel(Text101, MainTitle, CompanyName, UserId, '');//UPGCloud
        //UPGCloud >>
        ExcelBuf.CreateNewBook('MainTitle');
        ExcelBuf.WriteSheet('MainTitle', CompanyName(), UserId());
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        //UPGCloud <<
        Error('');
        // NA0001.end
    end;

    local procedure SwapAmt(var AmtArray: array[100] of Decimal; Index: Integer)
    var
        TempAmt: Decimal;
    begin
        // NA0001.begin
        TempAmt := AmtArray[Index];
        AmtArray[Index] := AmtArray[Index + 1];
        AmtArray[Index + 1] := TempAmt;
        // NA0001.end
    end;

    local procedure SwapText(var TextArray: array[100] of Text[50]; Index: Integer)
    var
        TempText: Text[50];
    begin
        // NA0001.begin
        TempText := TextArray[Index];
        TextArray[Index] := TextArray[Index + 1];
        TextArray[Index + 1] := TempText;
        // NA0001.end
    end;

    local procedure SwapCode(var CodeArray: array[100] of Code[20]; Index: Integer)
    var
        TempCode: Code[20];
    begin
        // NA0001.begin
        TempCode := CodeArray[Index];
        CodeArray[Index] := CodeArray[Index + 1];
        CodeArray[Index + 1] := TempCode;
        // NA0001.end
    end;
}
