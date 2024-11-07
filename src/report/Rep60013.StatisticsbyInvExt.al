report 60013 "Statistics by Inv .Ext"
{
    // version NAVNA14.03
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Salesperson Statistics by Inv..rdl';
    Caption = 'Statistics by Inv .Ext';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code", "Date Filter";
            RequestFilterHeadingML = ENU = 'Salesperson', ESM = 'Vendedor', FRC = 'Représentant', ENC = 'Salesperson';

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
                trigger OnAfterGetRecord();
                var
                    CostCalcMgt: Codeunit "Cost Calculation Management";
                begin
                    if "Document Type" in ["Document Type"::Invoice, "Document Type"::"Credit Memo"] then "Profit (LCY)" += CostCalcMgt.CalcCustLedgAdjmtCostLCY("Cust. Ledger Entry");
                    if "Sales (LCY)" > 0 then begin
                        "Profit%" := Round("Profit (LCY)" / "Sales (LCY)" * 100, 0.1);
                    end
                    else
                        "Profit%" := 0;
                end;
            }
            trigger OnPreDataItem();
            begin
                if PrintDetail then begin
                    SubTitle := '(Detail)';
                end
                else
                    SubTitle := '(Summary)';
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
                    CaptionML = ENU = 'Options', ESM = 'Opciones', FRC = 'Options', ENC = 'Options';

                    field(PrintDetail; PrintDetail)
                    {
                        CaptionML = ENU = 'Print Detail', ESM = 'Impr. detalle', FRC = 'Imprimer détails', ENC = 'Print Detail';
                        ToolTipML = ENU = 'Specifies that you want to see all of the order information listed. If this field is not selected, only summary information will print for each vendor.', ESM = 'Especifica que desea ver toda la información de pedidos incluida. Si no se selecciona este campo, se imprimirá únicamente información de resumen para cada proveedor.', FRC = 'Spécifie que vous souhaitez voir toutes les informations de commande répertoriées. Si ce champ n''est pas sélectionné, seules les informations récapitulatives seront imprimées pour chaque fournisseur.', ENC = 'Specifies that you want to see all of the order information listed. If this field is not selected, only summary information will print for each vendor.';
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
    trigger OnPreReport();
    begin
        CompanyInformation.Get;
        PeriodText := "Salesperson/Purchaser".GetFilter("Date Filter");
        "Salesperson/Purchaser".SetRange("Date Filter");
        FilterString := "Salesperson/Purchaser".GetFilters;
    end;

    var
        FilterString: Text;
        SubTitle: Text[88];
        PeriodText: Text;
        PrintDetail: Boolean;
        "Profit%": Decimal;
        CompanyInformation: Record "Company Information";
        Salesperson_Statistics_by_InvoiceCaptionLbl: TextConst ENU = 'Salesperson Statistics by Invoice', ESM = 'Estadísticas vendedor por factura', FRC = 'Statistiques du représentant par facture', ENC = 'Salesperson Statistics by Invoice';
        CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page', ESM = 'Pág.', FRC = 'Page', ENC = 'Page';
        For_the_periodCaptionLbl: TextConst ENU = 'For the period', ESM = 'Para el periodo', FRC = 'Pour la période', ENC = 'For the period';
        Salesperson_Purchaser_CodeCaptionLbl: TextConst ENU = 'Salesperson', ESM = 'Vendedor', FRC = 'Représentant', ENC = 'Salesperson';
        ContributionCaptionLbl: TextConst ENU = 'Contribution', ESM = 'Contribución', FRC = 'Cotisation', ENC = 'Contribution';
        InvoiceCaptionLbl: TextConst ENU = 'Invoice', ESM = 'Factura', FRC = 'Facture', ENC = 'Invoice';
        CashCaptionLbl: TextConst ENU = 'Cash', ESM = 'Efectivo', FRC = 'Encaisse', ENC = 'Cash';
        RemainingCaptionLbl: TextConst ENU = 'Remaining', ESM = 'Pendiente', FRC = 'Restant', ENC = 'Remaining';
        DateCaptionLbl: TextConst ENU = 'Date', ESM = 'Fecha', FRC = 'Date', ENC = 'Date';
        Cust__Ledger_Entry__Document_Type_CaptionLbl: TextConst ENU = 'Doc Type', ESM = 'Tipo doc', FRC = 'Type de document', ENC = 'Doc Type';
        Cust__Ledger_Entry__Sales__LCY__CaptionLbl: TextConst ENU = 'Sales', ESM = 'Ventas', FRC = 'Ventes', ENC = 'Sales';
        Cust__Ledger_Entry__Profit__LCY__CaptionLbl: TextConst ENU = 'Margin', ESM = 'Margen', FRC = 'Marge', ENC = 'Margin';
        Profit___Control48CaptionLbl: TextConst ENU = 'Ratio', ESM = 'Tasa', FRC = 'Ratio', ENC = 'Ratio';
        Cust__Ledger_Entry__Inv__Discount__LCY__CaptionLbl: TextConst ENU = 'Discount', ESM = 'Descuento', FRC = 'Escompte', ENC = 'Discount';
        Cust__Ledger_Entry__Pmt__Disc__Given__LCY__CaptionLbl: TextConst ENU = 'Discount', ESM = 'Descuento', FRC = 'Escompte', ENC = 'Discount';
        Cust__Ledger_Entry__Remaining_Amt___LCY__CaptionLbl: TextConst ENU = 'Balance', ESM = 'Saldo', FRC = 'Solde', ENC = 'Balance';
        Cust__Ledger_Entry__Customer_No__CaptionLbl: TextConst ENU = 'Customer', ESM = 'Cliente', FRC = 'Client', ENC = 'Customer';
        CodeCaptionLbl: TextConst ENU = 'Code', ESM = 'Código', FRC = 'Code', ENC = 'Code';
        NameCaptionLbl: TextConst ENU = 'Name', ESM = 'Nombre', FRC = 'Nom', ENC = 'Name';
        Cust__Ledger_Entry__Sales__LCY___Control62CaptionLbl: TextConst ENU = 'Sales', ESM = 'Ventas', FRC = 'Ventes', ENC = 'Sales';
        Cust__Ledger_Entry__Profit__LCY___Control63CaptionLbl: TextConst ENU = 'Margin', ESM = 'Margen', FRC = 'Marge', ENC = 'Margin';
        Profit___Control64CaptionLbl: TextConst ENU = 'Ratio', ESM = 'Tasa', FRC = 'Ratio', ENC = 'Ratio';
        Cust__Ledger_Entry__Inv__Discount__LCY___Control65CaptionLbl: TextConst ENU = 'DIscount', ESM = 'Descuento', FRC = 'Escompte', ENC = 'DIscount';
        Cust__Ledger_Entry__Pmt__Disc__Given__LCY___Control66CaptionLbl: TextConst ENU = 'Discount', ESM = 'Descuento', FRC = 'Escompte', ENC = 'Discount';
        Cust__Ledger_Entry__Remaining_Amt___LCY___Control67CaptionLbl: TextConst ENU = 'Balance', ESM = 'Saldo', FRC = 'Solde', ENC = 'Balance';
        Report_TotalCaptionLbl: TextConst ENU = 'Report Total', ESM = 'Total informe', FRC = 'Total du rapport', ENC = 'Report Total';
        Salesperson_TotalCaptionLbl: TextConst ENU = 'Salesperson Total', ESM = 'Total vendedor', FRC = 'Total du représentant', ENC = 'Salesperson Total';
}
