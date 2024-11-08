report 50015 "ORIG -  SP Statistics by Inv."
{
    // <changelog>
    //   <add id="NA0000" dev="JNOZZI" date="2006-02-21" area="REPORTS SR" feature="622"
    //     releaseversion="NAVNA4.00">North American Salesperson Statistics by Invoice Report.</add>
    //   <change id="NA0001" dev="V-HACAO" date="2008-06-05" area="REPORTS SR" feature=" NC14261"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA6.00">Report Transformation - local Report Layout.</change>
    // </changelog>
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/ORIG -  SP Statistics by Inv..rdl';
    Caption = 'Salesperson Statistics by Inv.';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code", "Date Filter";
            RequestFilterHeading = 'Salesperson';

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
            column(PeriodText; PeriodText)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(PrintDetail; PrintDetail)
            {
            }
            column(Salesperson_Purchaser_Code; Code)
            {
            }
            column(Salesperson_Purchaser_Name; Name)
            {
            }
            column(Cust__Ledger_Entry___Sales__LCY__; "Cust. Ledger Entry"."Sales (LCY)")
            {
            }
            column(Cust__Ledger_Entry___Profit__LCY__; "Cust. Ledger Entry"."Profit (LCY)")
            {
            }
            column(Profit__; "Profit%")
            {
                DecimalPlaces = 1 : 1;
            }
            column(Cust__Ledger_Entry___Inv__Discount__LCY__; "Cust. Ledger Entry"."Inv. Discount (LCY)")
            {
            }
            column(Cust__Ledger_Entry___Pmt__Disc__Given__LCY__; "Cust. Ledger Entry"."Pmt. Disc. Given (LCY)")
            {
            }
            column(Cust__Ledger_Entry___Remaining_Amt___LCY__; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
            {
            }
            column(Salesperson_Purchaser_Date_Filter; "Date Filter")
            {
            }
            column(Salesperson_Statistics_by_InvoiceCaption; Salesperson_Statistics_by_InvoiceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(For_the_periodCaption; For_the_periodCaptionLbl)
            {
            }
            column(Salesperson_Purchaser_CodeCaption; Salesperson_Purchaser_CodeCaptionLbl)
            {
            }
            column(ContributionCaption; ContributionCaptionLbl)
            {
            }
            column(InvoiceCaption; InvoiceCaptionLbl)
            {
            }
            column(CashCaption; CashCaptionLbl)
            {
            }
            column(RemainingCaption; RemainingCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Document_Type_Caption; Cust__Ledger_Entry__Document_Type_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Sales__LCY__Caption; Cust__Ledger_Entry__Sales__LCY__CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Profit__LCY__Caption; Cust__Ledger_Entry__Profit__LCY__CaptionLbl)
            {
            }
            column(Profit___Control48Caption; Profit___Control48CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Inv__Discount__LCY__Caption; Cust__Ledger_Entry__Inv__Discount__LCY__CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Pmt__Disc__Given__LCY__Caption; Cust__Ledger_Entry__Pmt__Disc__Given__LCY__CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Remaining_Amt___LCY__Caption; Cust__Ledger_Entry__Remaining_Amt___LCY__CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Customer_No__Caption; Cust__Ledger_Entry__Customer_No__CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; "Cust. Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Sales__LCY___Control62Caption; Cust__Ledger_Entry__Sales__LCY___Control62CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Profit__LCY___Control63Caption; Cust__Ledger_Entry__Profit__LCY___Control63CaptionLbl)
            {
            }
            column(Profit___Control64Caption; Profit___Control64CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Inv__Discount__LCY___Control65Caption; Cust__Ledger_Entry__Inv__Discount__LCY___Control65CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Pmt__Disc__Given__LCY___Control66Caption; Cust__Ledger_Entry__Pmt__Disc__Given__LCY___Control66CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Remaining_Amt___LCY___Control67Caption; Cust__Ledger_Entry__Remaining_Amt___LCY___Control67CaptionLbl)
            {
            }
            column(Report_TotalCaption; Report_TotalCaptionLbl)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Salesperson Code" = FIELD(Code), "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Salesperson Code", "Posting Date");

                column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Document_Type_; "Document Type")
                {
                }
                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
                {
                }
                column(Cust__Ledger_Entry__Sales__LCY__; "Sales (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Profit__LCY__; "Profit (LCY)")
                {
                }
                column(Profit___Control48; "Profit%")
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Cust__Ledger_Entry__Inv__Discount__LCY__; "Inv. Discount (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Pmt__Disc__Given__LCY__; "Pmt. Disc. Given (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amt___LCY__; "Remaining Amt. (LCY)")
                {
                }
                column(Salesperson_Purchaser__Code; "Salesperson/Purchaser".Code)
                {
                }
                column(Cust__Ledger_Entry__Sales__LCY___Control53; "Sales (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Profit__LCY___Control54; "Profit (LCY)")
                {
                }
                column(Profit___Control55; "Profit%")
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Cust__Ledger_Entry__Inv__Discount__LCY___Control56; "Inv. Discount (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Pmt__Disc__Given__LCY___Control57; "Pmt. Disc. Given (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amt___LCY___Control58; "Remaining Amt. (LCY)")
                {
                }
                column(Salesperson_Purchaser__Code_Control60; "Salesperson/Purchaser".Code)
                {
                }
                column(Salesperson_Purchaser__Name; "Salesperson/Purchaser".Name)
                {
                }
                column(Cust__Ledger_Entry__Sales__LCY___Control62; "Sales (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Profit__LCY___Control63; "Profit (LCY)")
                {
                }
                column(Profit___Control64; "Profit%")
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Cust__Ledger_Entry__Inv__Discount__LCY___Control65; "Inv. Discount (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Pmt__Disc__Given__LCY___Control66; "Pmt. Disc. Given (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Remaining_Amt___LCY___Control67; "Remaining Amt. (LCY)")
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Salesperson_Code; "Salesperson Code")
                {
                }
                column(Salesperson_TotalCaption; Salesperson_TotalCaptionLbl)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "Sales (LCY)" > 0 then begin
                        "Profit%" := Round("Profit (LCY)" / "Sales (LCY)" * 100, 0.1);
                    end
                    else
                        "Profit%" := 0;
                end;

                trigger OnPreDataItem()
                begin
                    /* CurrReport.CreateTotals("Sales (LCY)","Profit (LCY)","Inv. Discount (LCY)","Pmt. Disc. Given (LCY)",
                           "Remaining Amt. (LCY)");*/
                end;
            }
            trigger OnPreDataItem()
            begin
                /* CurrReport.CreateTotals("Cust. Ledger Entry"."Sales (LCY)","Cust. Ledger Entry"."Profit (LCY)",
                   "Cust. Ledger Entry"."Inv. Discount (LCY)",
                   "Cust. Ledger Entry"."Pmt. Disc. Given (LCY)","Cust. Ledger Entry"."Remaining Amt. (LCY)");*/
                //NA0001.Begin , move code from  'OnPreSection'
                if PrintDetail then begin
                    SubTitle := '(Detail)';
                end
                else
                    SubTitle := '(Summary)';
                //NA0001.End
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

                    field(PrintDetail; PrintDetail)
                    {
                        Caption = 'Print Detail';
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
    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        PeriodText := "Salesperson/Purchaser".GetFilter("Date Filter");
        "Salesperson/Purchaser".SetRange("Date Filter");
        FilterString := "Salesperson/Purchaser".GetFilters;
    end;

    var
        FilterString: Text[250];
        SubTitle: Text[88];
        PeriodText: Text[30];
        PrintDetail: Boolean;
        "Profit%": Decimal;
        CompanyInformation: Record "Company Information";
        Salesperson_Statistics_by_InvoiceCaptionLbl: Label 'Salesperson Statistics by Invoice';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        For_the_periodCaptionLbl: Label 'For the period';
        Salesperson_Purchaser_CodeCaptionLbl: Label 'Salesperson';
        ContributionCaptionLbl: Label 'Contribution';
        InvoiceCaptionLbl: Label 'Invoice';
        CashCaptionLbl: Label 'Cash';
        RemainingCaptionLbl: Label 'Remaining';
        DateCaptionLbl: Label 'Date';
        Cust__Ledger_Entry__Document_Type_CaptionLbl: Label 'Doc Type';
        Cust__Ledger_Entry__Sales__LCY__CaptionLbl: Label 'Sales';
        Cust__Ledger_Entry__Profit__LCY__CaptionLbl: Label 'Margin';
        Profit___Control48CaptionLbl: Label 'Ratio';
        Cust__Ledger_Entry__Inv__Discount__LCY__CaptionLbl: Label 'Discount';
        Cust__Ledger_Entry__Pmt__Disc__Given__LCY__CaptionLbl: Label 'Discount';
        Cust__Ledger_Entry__Remaining_Amt___LCY__CaptionLbl: Label 'Balance';
        Cust__Ledger_Entry__Customer_No__CaptionLbl: Label 'Customer';
        CodeCaptionLbl: Label 'Code';
        NameCaptionLbl: Label 'Name';
        Cust__Ledger_Entry__Sales__LCY___Control62CaptionLbl: Label 'Sales';
        Cust__Ledger_Entry__Profit__LCY___Control63CaptionLbl: Label 'Margin';
        Profit___Control64CaptionLbl: Label 'Ratio';
        Cust__Ledger_Entry__Inv__Discount__LCY___Control65CaptionLbl: Label 'DIscount';
        Cust__Ledger_Entry__Pmt__Disc__Given__LCY___Control66CaptionLbl: Label 'Discount';
        Cust__Ledger_Entry__Remaining_Amt___LCY___Control67CaptionLbl: Label 'Balance';
        Report_TotalCaptionLbl: Label 'Report Total';
        Salesperson_TotalCaptionLbl: Label 'Salesperson Total';
}
