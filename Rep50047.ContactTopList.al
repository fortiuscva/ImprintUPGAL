report 50047 "Contact Top  List"
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
    // 
    // IMP1.01,26-Jan-16,ST: -> Added code to rank the customer with new option "Profit".
    //                       -> Changed the array length to 1000 to have this report process 999 records.
    Caption = 'Customer Contact Mailing List';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(contactrec; Contact)
        {
            DataItemTableView = WHERE(Type = FILTER(Person));

            dataitem("Contact Business Relation"; "Contact Business Relation")
            {
                DataItemLink = "Contact No." = FIELD("Company No.");
                DataItemTableView = SORTING("Contact No.", "Business Relation Code") ORDER(Ascending) WHERE("Link to Table" = FILTER(Customer));

                dataitem(Customer; Customer)
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemTableView = SORTING("No.");

                    trigger OnAfterGetRecord()
                    begin
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
                        Clear(CostCalcMgt);
                        CalcFields("Profit (LCY)");
                        CustSalesLCY := "Sales (LCY)";
                        CustProfit := "Profit (LCY)" + CostCalcMgt.NonInvtblCostAmt(Customer);
                        AdjmtCostLCY := CustSalesLCY - CustProfit + CostCalcMgt.CalcCustActualCostLCY(Customer);
                        AdjCustProfit := CustProfit + AdjmtCostLCY;
                        //IMP1.01 End
                        tempcontact.Init;
                        tempcontact."No." := contactrec."No.";
                        if TopType = TopType::"Balance ($)" then
                            tempcontact.Revenue := "Balance on Date (LCY)"
                        else
                            if TopType = TopType::"Profit $" then
                                tempcontact.Revenue := AdjCustProfit
                            else
                                tempcontact.Revenue := "Sales (LCY)";
                        tempcontact."Search Name" := "No.";
                        tempcontact.Insert;
                    end;
                }
            }
            trigger OnAfterGetRecord()
            begin
                Window.Update(1, "No.");
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
            MaxIteration = 999;

            trigger OnAfterGetRecord()
            begin
                OnLineNumber += 1;
                tempcontact.SetCurrentKey(Revenue);
                tempcontact.Ascending(false);
                if OnLineNumber = 1 then
                    tempcontact.Find('-')
                else
                    tempcontact.Next;
                contrec.Get(tempcontact."No.");
                custrec.Get(tempcontact."Search Name");
                if contrec.Type = contrec.Type::Company then CurrReport.Skip;
                if storecust <> tempcontact."Search Name" then begin
                    storecust := tempcontact."Search Name";
                    custcount += 1;
                end;
                if custcount > CustomersToRank then CurrReport.Skip;
                i := i + 1;
                // /NA0004.begin
                MakeExcelDataBody;
                // NA0004.end
            end;

            trigger OnPostDataItem()
            begin
                // NA0004.begin
                if PrintToExcel then //IMP1.01 Start
                                     //Base Code Commented
                                     /*
                                     IF (GrandTotalBalance <> TopTotalBalance) OR (GrandTotalSale <> TopTotalSale) THEN BEGIN
                                     */
                    if (GrandTotalBalance <> TopTotalBalance) or (GrandTotalSale <> TopTotalSale) or (GrandTotalProfit <> TopTotalProfit) then begin
                        //IMP1.01 End
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
                tempcontact.Reset;
                numberoflines := tempcontact.Count;
                //IF numberoflines >CustomersToRank THEN
                // numberoflines:=CustomersToRank;
                SetRange(Number, 1, numberoflines);
                OnLineNumber := 0;
                custcount := 0;
            end;
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
                            if not (CustomersToRank < ArrayLen(TopNo)) then Error(Text008, ArrayLen(TopNo));
                            // NA0001.end
                        end;
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                        Visible = false;
                        ApplicationArea = All;
                    }
                }
            }
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
        // NA0001.begin
        //IF PrintToExcel THEN
        CreateExcelbook;
        // NA0001.end
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        tempcontact.DeleteAll;
        if CustomersToRank = 0 then // default
            CustomersToRank := 20;
        MakeExcelInfo;
    end;

    var
        storecust: Code[30];
        custcount: Integer;
        contrec: Record Contact;
        custrec: Record Customer;
        OnLineNumber: Integer;
        numberoflines: Integer;
        tempcontact: Record Contact temporary;
        ExcelBuf: Record "Excel Buffer" temporary;
        FilterString: Text[250];
        MainTitle: Text[150];
        SubTitle: Text[150];
        ColHead: Text[15];
        TopTotalText: Text[40];
        BarText: Text[250];
        TopName: array[1000] of Text[50];
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
        ParagraphHandling: Codeunit "Paragraph Handling";
        Text000: Label 'Going through contacts';
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
        "-IMP1.01-": Integer;
        CustSalesLCY: Decimal;
        AdjmtCostLCY: Decimal;
        CustProfit: Decimal;
        AdjCustProfit: Decimal;
        CostCalcMgt: Codeunit "Cost Calculation Management";
        GrandTotalProfit: Decimal;
        TopTotalProfit: Decimal;
        TopProfit: array[1000] of Decimal;
        //"--IMP1.01--" 
        Text50000: Label 'Profit';
        Text50001: Label 'Percent of Total Profit';
        Text50002: Label '(by Total Profit)';
        Text50003: Label '(by Profit During the Period';

    local procedure MakeExcelInfo()
    begin
        MakeExcelDataHeader;
        // NA0001.end
    end;

    local procedure MakeExcelDataHeader()
    begin
        // NA0001.begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Format(TopType), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Company Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Name 2', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Address', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Address 2', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('City', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('State', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Post Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Country/Region Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Home Page', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Phone No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Email', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('ID Status', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Salesperson Code', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer No.', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer Name', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure MakeExcelDataBody()
    begin
        // NA0001.begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(tempcontact.Revenue, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec."Company Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec."Name 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec.Address, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec."Address 2", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec.City, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec.County, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec."Post Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec."Country/Region Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec."Home Page", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec."Phone No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec."E-Mail", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec.ID_Status, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(contrec."Salesperson Code", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(tempcontact."Search Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(custrec.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure CreateExcelbook()
    begin
        // NA0001.begin
        //ExcelBuf.CreateBookAndOpenExcel('Top Contact', MainTitle, CompanyName, UserId, '');//UPGCloud
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
