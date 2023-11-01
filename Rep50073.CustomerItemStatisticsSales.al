report 50073 "Customer/Item Statistics Sales"
{
    // <changelog>
    //   <add id="NA0000" dev="JNOZZI" date="2006-02-17" area="REPORTS SR" feature="622"
    //     releaseversion="NAVNA4.00.02">North American Customer / Item Statistics Report.</add>
    //   <change id="NA0001" dev="V-VIGUO" date="2008-05-12" area="REPORTS SR" feature="NC14261"
    //     baseversion="NAVNA4.00.02" releaseversion="NAVNA6.00">Report Transformation - local Report Layout</change>
    //   <change id="NA0002" dev="JNOZZI" date="2008-08-11" area="REPORTS SR" feature="NC26984"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00">Fix PrintToExcel so no code for it is in the sections.
    //     </change>
    // </changelog>
    // 
    // IMP1.01,03/07/17,SK: Add code in OnInitReport, OnPreReport, Value Entry - OnPreDataItem().
    //                      Add new dataitem as Salesperson/Purchaser.
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerItem Statistics Sales.rdl';
    Caption = 'Customer/Item Statistics';
    UseRequestPage = false;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            RequestFilterFields = "Code";

            column(Code_SalespersonPurchaser; "Salesperson/Purchaser".Code)
            {
            }
            column(Name_SalespersonPurchaser; "Salesperson/Purchaser".Name)
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "Salesperson Code"=FIELD(Code);
                DataItemTableView = SORTING("Salesperson Code")ORDER(Ascending);
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Search Name", "Customer Posting Group";

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
                column(Customer_TABLECAPTION___________FilterString; Customer.TableCaption + ':  ' + FilterString)
                {
                }
                column(Value_Entry__TABLECAPTION___________FilterString2; "Value Entry".TableCaption + ':  ' + FilterString2)
                {
                }
                column(groupno; groupno)
                {
                }
                column(PrintToExcel; PrintToExcel)
                {
                }
                column(FilterString; FilterString)
                {
                }
                column(FilterString2; FilterString2)
                {
                }
                column(OnlyOnePerPage; OnlyOnePerPage)
                {
                }
                column(Customer__No__; "No.")
                {
                }
                column(Customer_Name; Name)
                {
                }
                column(Customer__Phone_No__; "Phone No.")
                {
                }
                column(Customer_Contact; Contact)
                {
                }
                column(Value_Entry___Sales_Amount__Actual__; "Value Entry"."Sales Amount (Actual)")
                {
                }
                column(Profit; Profit)
                {
                }
                column(Value_Entry___Discount_Amount_; "Value Entry"."Discount Amount")
                {
                }
                column(Profit__; "Profit%")
                {
                DecimalPlaces = 1: 1;
                }
                column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
                {
                }
                column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
                {
                }
                column(Customer_Item_StatisticsCaption; Customer_Item_StatisticsCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Customer_NoCaption; Customer_NoCaptionLbl)
                {
                }
                column(Customer_NameCaption; FieldCaption(Name))
                {
                }
                column(Value_Entry__Item_No__Caption; "Value Entry".FieldCaption("Item No."))
                {
                }
                column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
                {
                }
                column(Invoiced_Quantity_Caption; Invoiced_Quantity_CaptionLbl)
                {
                }
                column(Value_Entry__Sales_Amount__Actual__Caption; Value_Entry__Sales_Amount__Actual__CaptionLbl)
                {
                }
                column(Profit_Control38Caption; Profit_Control38CaptionLbl)
                {
                }
                column(Value_Entry__Discount_Amount_Caption; Value_Entry__Discount_Amount_CaptionLbl)
                {
                }
                column(Profit___Control40Caption; Profit___Control40CaptionLbl)
                {
                }
                column(Item__Base_Unit_of_Measure_Caption; Item__Base_Unit_of_Measure_CaptionLbl)
                {
                }
                column(Phone_Caption; Phone_CaptionLbl)
                {
                }
                column(Contact_Caption; Contact_CaptionLbl)
                {
                }
                column(Report_TotalCaption; Report_TotalCaptionLbl)
                {
                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Source No."=FIELD("No."), "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"), "Posting Date"=FIELD("Date Filter");
                    DataItemTableView = SORTING("Source Type", "Source No.", "Item Ledger Entry Type", "Item No.", "Posting Date")WHERE("Source Type"=CONST(Customer), "Item Ledger Entry Type"=CONST(Sale), "Expected Cost"=CONST(false));
                    RequestFilterFields = "Item No.", "Inventory Posting Group", "Posting Date";

                    column(Value_Entry__Item_No__; "Item No.")
                    {
                    }
                    column(Item_Description; Item.Description)
                    {
                    }
                    column(Invoiced_Quantity_;-"Invoiced Quantity")
                    {
                    }
                    column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                    {
                    }
                    column(Profit_Control38; Profit)
                    {
                    }
                    column(Value_Entry__Discount_Amount_; "Discount Amount")
                    {
                    }
                    column(Profit___Control40; "Profit%")
                    {
                    DecimalPlaces = 1: 1;
                    }
                    column(Value_Entry__Sales_Amount__Actual__; "Sales Amount (Actual)")
                    {
                    }
                    column(Customer__No___Control41; Customer."No.")
                    {
                    }
                    column(Value_Entry__Sales_Amount__Actual___Control42; "Sales Amount (Actual)")
                    {
                    }
                    column(Profit_Control43; Profit)
                    {
                    }
                    column(Value_Entry__Discount_Amount__Control44; "Discount Amount")
                    {
                    }
                    column(Profit___Control45; "Profit%")
                    {
                    DecimalPlaces = 1: 1;
                    }
                    column(Value_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Value_Entry_Source_No_; "Source No.")
                    {
                    }
                    column(Value_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {
                    }
                    column(Value_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                    {
                    }
                    column(Customer_TotalCaption; Customer_TotalCaptionLbl)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        // NA0002.begin
                        if ValueEntryTotalForItem."Item No." <> "Item No." then begin
                            "CalculateProfit%";
                            if PrintToExcel and (ValueEntryTotalForItem."Item No." <> '')then MakeExcelDataBody;
                            Clear(ValueEntryTotalForItem);
                            ProfitTotalForItem:=0;
                            //NA0001.begin
                            if not Item.Get("Item No.")then begin
                                Item.Description:=Text000;
                                Item."Base Unit of Measure":='';
                            end;
                        //NA0001.end
                        end;
                        // NA0002.end
                        Profit:="Sales Amount (Actual)" + "Cost Amount (Actual)";
                        "Discount Amount":=-"Discount Amount";
                        // NA0002.begin
                        ValueEntryTotalForItem."Item No.":="Item No.";
                        ValueEntryTotalForItem."Invoiced Quantity"+="Invoiced Quantity";
                        ValueEntryTotalForItem."Sales Amount (Actual)"+="Sales Amount (Actual)";
                        ValueEntryTotalForItem."Discount Amount"+="Discount Amount";
                        ProfitTotalForItem+=Profit;
                    // NA0002.end
                    end;
                    trigger OnPostDataItem()
                    begin
                        // NA0002.begin
                        if PrintToExcel and (ValueEntryTotalForItem."Item No." <> '')then begin
                            "CalculateProfit%";
                            MakeExcelDataBody;
                        end;
                    // NA0002.end
                    end;
                    trigger OnPreDataItem()
                    begin
                        //CurrReport.CreateTotals("Invoiced Quantity", "Sales Amount (Actual)", Profit, "Discount Amount");
                        SetFilter("Posting Date", '%1..%2', WeekStart, WeekEnd); //IMP1.01
                        // NA0002.begin
                        Clear(ValueEntryTotalForItem);
                        ProfitTotalForItem:=0;
                    // NA0002.end
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                //NA0001.begin
                //IF OnlyOnePerPage THEN
                //groupno := groupno + 1
                //NA0001.end
                end;
                trigger OnPreDataItem()
                begin
                //CurrReport.NEWPAGEPERRECORD := OnlyOnePerPage;
                //CurrReport.CreateTotals("Value Entry"."Sales Amount (Actual)", Profit, "Value Entry"."Discount Amount");
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

                    field(OnlyOnePerPage; OnlyOnePerPage)
                    {
                        Caption = 'New Page per Account';
                        ApplicationArea = All;
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print To Excel';
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
    trigger OnInitReport()
    begin
        OnlyOnePerPage:=true; //IMP1.01
    end;
    trigger OnPostReport()
    begin
        if PrintToExcel then CreateExcelbook;
    end;
    trigger OnPreReport()
    begin
        //IMP1.01 Start
        WeekEnd:=CalcDate('-WD5', Today);
        WeekStart:=CalcDate('-WD1', WeekEnd);
        Customer.SetFilter("Date Filter", '%1..%2', WeekStart, WeekEnd);
        "Value Entry".SetFilter("Posting Date", '%1..%2', WeekStart, WeekEnd);
        //IMP1.01 End
        PeriodText:="Value Entry".GetFilter("Posting Date");
        CompanyInformation.Get;
        FilterString:=Customer.GetFilters;
        FilterString2:="Value Entry".GetFilters;
        OnlyOnePerPage:=false;
        if PrintToExcel then MakeExcelInfo;
    end;
    var ExcelBuf: Record "Excel Buffer" temporary;
    FilterString: Text[250];
    FilterString2: Text[250];
    PeriodText: Text[30];
    Profit: Decimal;
    "Profit%": Decimal;
    OnlyOnePerPage: Boolean;
    Item: Record Item;
    CompanyInformation: Record "Company Information";
    PrintToExcel: Boolean;
    Text000: Label 'Invalid Item';
    Text001: Label 'Data';
    Text002: Label 'Customer/Item Statistics';
    Text003: Label 'Company Name';
    Text004: Label 'Report No.';
    Text005: Label 'Report Name';
    Text006: Label 'User ID';
    Text007: Label 'Date / Time';
    Text008: Label 'Customer Filters';
    Text009: Label 'Value Entry Filters';
    Text010: Label 'Contribution Margin';
    Text011: Label 'Contribution Ratio';
    groupno: Integer;
    ValueEntryTotalForItem: Record "Value Entry";
    ProfitTotalForItem: Decimal;
    Customer_Item_StatisticsCaptionLbl: Label 'Customer/Item Statistics';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    Customer_NoCaptionLbl: Label 'Customer No';
    Item_DescriptionCaptionLbl: Label 'Item Description';
    Invoiced_Quantity_CaptionLbl: Label 'Quantity';
    Value_Entry__Sales_Amount__Actual__CaptionLbl: Label 'Amount';
    Profit_Control38CaptionLbl: Label 'Contribution Margin';
    Value_Entry__Discount_Amount_CaptionLbl: Label 'Discount';
    Profit___Control40CaptionLbl: Label 'Contrib Ratio';
    Item__Base_Unit_of_Measure_CaptionLbl: Label 'Unit';
    Phone_CaptionLbl: Label 'Phone:';
    Contact_CaptionLbl: Label 'Contact:';
    Report_TotalCaptionLbl: Label 'Report Total';
    Customer_TotalCaptionLbl: Label 'Customer Total';
    "-IMP1.01-": Integer;
    WeekStart: Date;
    WeekEnd: Date;
    procedure "CalculateProfit%"()
    begin
        // NA0002.begin
        if ValueEntryTotalForItem."Sales Amount (Actual)" <> 0 then "Profit%":=Round(100 * ProfitTotalForItem / ValueEntryTotalForItem."Sales Amount (Actual)", 0.1)
        else
            "Profit%":=0;
    // NA0002.end
    end;
    local procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(Format(Text003), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Format(Text002), false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text004), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Customer/Item Statistics", false, false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text007), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Today, false, false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(Time, false, false, false, false, '', ExcelBuf."Cell Type"::Time);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text008), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text009), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString2, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;
    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer.FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Value Entry".FieldCaption("Item No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.FieldCaption(Description), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Value Entry".FieldCaption("Invoiced Quantity"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Item.FieldCaption("Base Unit of Measure"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Value Entry".FieldCaption("Sales Amount (Actual)"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Format(Text010), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Format(Text011), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Value Entry".FieldCaption("Discount Amount"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
    end;
    local procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer.Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        // NA0002.begin
        ExcelBuf.AddColumn(ValueEntryTotalForItem."Item No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        // NA0002.end
        ExcelBuf.AddColumn(Item.Description, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        // NA0002.begin
        ExcelBuf.AddColumn(-ValueEntryTotalForItem."Invoiced Quantity", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        // NA0002.end
        ExcelBuf.AddColumn(Item."Base Unit of Measure", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        // NA0002.begin
        ExcelBuf.AddColumn(ValueEntryTotalForItem."Sales Amount (Actual)", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ProfitTotalForItem, false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
        // NA0002.end
        ExcelBuf.AddColumn("Profit%" / 100, false, '', false, false, false, '0.0%', ExcelBuf."Cell Type"::Number);
        // NA0002.begin
        ExcelBuf.AddColumn(ValueEntryTotalForItem."Discount Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number);
    // NA0002.end
    end;
    local procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel(Text001, Text002, CompanyName, UserId, '');//UPGCloud
        //UPGCloud >>
        ExcelBuf.CreateNewBook('Text002');
        ExcelBuf.WriteSheet('Text002', CompanyName(), UserId());
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
        //UPGCloud <<
        Error('');
    end;
}
