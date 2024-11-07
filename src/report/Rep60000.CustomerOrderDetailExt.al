report 60000 "Customer - Order Detail Ext"
{
    // version NAVW114.00
    // ISS2.00 12.11.13 DFP - Changed Left Margin in Layout from 1.05834 to 2.5cm
    // ISSx.xx 12.02.13 DRR - Added code from original report from LANAC EAK BEGIN
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/Customer - Order Detail.rdl';
    CaptionML = ENU = 'Customer - Order Detail', ESM = 'Cliente - Líneas pedidos', FRC = 'Client - Détail de commande', ENC = 'Customer - Order Detail';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", Priority;

            column(ShipmentPeriodDate; StrSubstNo(Text000, PeriodText))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(CustTableCapCustFilter; TableCaption + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(SalesOrderLineFilter; StrSubstNo(Text001, SalesLineFilter))
            {
            }
            column(SalesLineFilter; SalesLineFilter)
            {
            }
            column(No_Customer; "No.")
            {
                IncludeCaption = true;
            }
            column(Name_Customer; Name)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(CustOrderDetailCaption; CustOrderDetailCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(AllAmtAreInLCYCaption; AllAmtAreInLCYCaptionLbl)
            {
            }
            column(ShipmentDateCaption; ShipmentDateCaptionLbl)
            {
            }
            column(QtyOnBackOrderCaption; QtyOnBackOrderCaptionLbl)
            {
            }
            column(OutstandingOrdersCaption; OutstandingOrdersCaptionLbl)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Bill-to Customer No." = FIELD("No."), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Document Type", "Bill-to Customer No.", "Currency Code") WHERE("Document Type" = CONST(Order), "Outstanding Quantity" = FILTER(<> 0));
                RequestFilterFields = "Shipment Date";
                RequestFilterHeadingML = ENU = 'Sales Order Line', ESM = 'Línea de pedido de venta', FRC = 'Ligne de document de vente', ENC = 'Sales Order Line';

                column(SalesHeaderNo; SalesHeader."No.")
                {
                }
                column(SalesHeaderOrderDate; SalesHeader."Order Date")
                {
                }
                column(Description_SalesLine; Description)
                {
                    IncludeCaption = true;
                }
                column(No_SalesLine; "No.")
                {
                    IncludeCaption = true;
                }
                column(Type_SalesLine; Type)
                {
                    IncludeCaption = true;
                }
                column(ShipmentDate_SalesLine; Format("Shipment Date"))
                {
                }
                column(Quantity_SalesLine; Quantity)
                {
                    IncludeCaption = true;
                }
                column(OutStandingQty_SalesLine; "Outstanding Quantity")
                {
                    IncludeCaption = true;
                }
                column(BackOrderQty; BackOrderQty)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(UnitPrice_SalesLine; "Unit Price")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                    IncludeCaption = true;
                }
                column(LineDiscAmt_SalesLine; "Line Discount Amount")
                {
                    IncludeCaption = true;
                }
                column(InvDiscAmt_SalesLine; "Inv. Discount Amount")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                    IncludeCaption = true;
                }
                column(SalesOrderAmount; SalesOrderAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(SalesHeaderCurrCode; SalesHeader."Currency Code")
                {
                }
                column(SalesProfit; SalesProfit)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                trigger OnAfterGetRecord();
                begin
                    NewOrder := "Document No." <> SalesHeader."No.";
                    if NewOrder then SalesHeader.Get(1, "Document No.");
                    if "Shipment Date" <= WorkDate then
                        BackOrderQty := "Outstanding Quantity"
                    else
                        BackOrderQty := 0;
                    Currency.InitRoundingPrecision;
                    if "VAT Calculation Type" in ["VAT Calculation Type"::"Normal VAT", "VAT Calculation Type"::"Reverse Charge VAT"] then
                        SalesOrderAmount := Round((Amount + "VAT Base Amount" * "VAT %" / 100) * "Outstanding Quantity" / Quantity / (1 + "VAT %" / 100), Currency."Amount Rounding Precision")
                    else
                        SalesOrderAmount := Round("Outstanding Amount" / (1 + "VAT %" / 100), Currency."Amount Rounding Precision");
                    SalesOrderAmountLCY := SalesOrderAmount;
                    if SalesHeader."Currency Code" <> '' then begin
                        if SalesHeader."Currency Factor" <> 0 then SalesOrderAmountLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate, SalesHeader."Currency Code", SalesOrderAmountLCY, SalesHeader."Currency Factor"));
                        if PrintAmountsInLCY then begin
                            "Unit Price" := Round(CurrExchRate.ExchangeAmtFCYToLCY(WorkDate, SalesHeader."Currency Code", "Unit Price", SalesHeader."Currency Factor"));
                            SalesOrderAmount := SalesOrderAmountLCY;
                        end;
                    end;
                    if SalesHeader."Prices Including VAT" then begin
                        "Unit Price" := "Unit Price" / (1 + "VAT %" / 100);
                        "Inv. Discount Amount" := "Inv. Discount Amount" / (1 + "VAT %" / 100);
                    end;
                    "Inv. Discount Amount" := "Inv. Discount Amount" * "Outstanding Quantity" / Quantity;
                    CurrencyCode2 := SalesHeader."Currency Code";
                    if PrintAmountsInLCY then CurrencyCode2 := '';
                    CurrencyTotalBuffer.UpdateTotal(CurrencyCode2, SalesOrderAmount, Counter1, Counter1);
                    // ISSx.xx 12.02.13 DRR - Added code from original report from LANAC EAK BEGIN
                    SalesProfit := Round("Profit %" * SalesOrderAmount / 100, 0.01);
                    //SalesTotalProfit := SalesTotalProfit + SalesProfit;
                    //SalesTotalProfit2 := SalesTotalProfit2 + SalesProfit;
                    // LANAC EAK END
                end;

                trigger OnPreDataItem();
                begin
                    Clear(SalesOrderAmountLCY);
                    Clear(SalesOrderAmount);
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                column(TotalAmt_CurrTotalBuff; CurrencyTotalBuffer."Total Amount")
                {
                    AutoFormatExpression = CurrencyTotalBuffer."Currency Code";
                    AutoFormatType = 1;
                }
                column(CurrCode_CurrTotalBuff; CurrencyTotalBuffer."Currency Code")
                {
                }
                trigger OnAfterGetRecord();
                begin
                    if Number = 1 then
                        OK := CurrencyTotalBuffer.Find('-')
                    else
                        OK := CurrencyTotalBuffer.Next <> 0;
                    if not OK then CurrReport.Break;
                    CurrencyTotalBuffer2.UpdateTotal(CurrencyTotalBuffer."Currency Code", CurrencyTotalBuffer."Total Amount", Counter1, Counter1);
                end;

                trigger OnPostDataItem();
                begin
                    CurrencyTotalBuffer.DeleteAll;
                end;
            }
            trigger OnAfterGetRecord();
            begin
                if PrintOnlyOnePerPage then PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem();
            begin
                PageGroupNo := 1;
                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                Clear(SalesOrderAmountLCY);
            end;
        }
        dataitem(Integer2; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

            column(TotalAmt_CurrTotalBuff2; CurrencyTotalBuffer2."Total Amount")
            {
                AutoFormatExpression = CurrencyTotalBuffer2."Currency Code";
                AutoFormatType = 1;
            }
            column(CurrCode_CurrTotalBuff2; CurrencyTotalBuffer2."Currency Code")
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            trigger OnAfterGetRecord();
            begin
                if Number = 1 then
                    OK := CurrencyTotalBuffer2.Find('-')
                else
                    OK := CurrencyTotalBuffer2.Next <> 0;
                if not OK then CurrReport.Break;
            end;

            trigger OnPostDataItem();
            begin
                CurrencyTotalBuffer2.DeleteAll;
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

                    field(ShowAmountsInLCY; PrintAmountsInLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Show Amounts in $', ESM = 'Muestra los importes en $.', FRC = 'Afficher les montants en $', ENC = 'Show Amounts in $';
                        ToolTipML = ENU = 'Specifies if the reported amounts are shown in the local currency.', ESM = 'Especifica si los importes notificados se muestran en la divisa local.', FRC = 'Indique s''il faut afficher les montants déclarés dans la devise locale.', ENC = 'Specifies if the reported amounts are shown in the local currency.';
                    }
                    field(NewPagePerCustomer; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'New Page per Customer', ESM = 'Página nueva por cliente', FRC = 'Nouvelle page par client', ENC = 'New Page per Customer';
                        ToolTipML = ENU = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.', ESM = 'Especifica si la información de cada cliente se imprime en una nueva página en caso que haya elegido incluir dos o más clientes en el informe.', FRC = 'Spécifie si les informations de chaque client sont imprimées sur une nouvelle page si vous avez choisi deux ou plusieurs clients à inclure dans le rapport.', ENC = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
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
        label(OrderNoCaption;
        ENU = 'Order No.', ESM = 'Nº pedido', FRC = 'N° commande', ENC = 'Order No.')
    }
    trigger OnPreReport();
    var
        FormatDocument: Codeunit "Format Document";
    begin
        CustFilter := FormatDocument.GetRecordFiltersWithCaptions(Customer);
        SalesLineFilter := "Sales Line".GetFilters;
        PeriodText := "Sales Line".GetFilter("Shipment Date");
    end;

    var
        Text000: TextConst ENU = 'Shipment Date: %1', ESM = 'Fecha envío: %1', FRC = 'Date de livraison : %1', ENC = 'Shipment Date: %1';
        Text001: TextConst ENU = 'Sales Order Line: %1', ESM = 'Línea pedido venta: %1', FRC = 'Ligne bordereau de vente : %1', ENC = 'Sales Order Line: %1';
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        CurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        CustFilter: Text;
        SalesLineFilter: Text;
        SalesOrderAmount: Decimal;
        SalesOrderAmountLCY: Decimal;
        PrintAmountsInLCY: Boolean;
        PeriodText: Text;
        PrintOnlyOnePerPage: Boolean;
        BackOrderQty: Decimal;
        NewOrder: Boolean;
        OK: Boolean;
        Counter1: Integer;
        CurrencyCode2: Code[10];
        PageGroupNo: Integer;
        CustOrderDetailCaptionLbl: TextConst ENU = 'Customer - Order Detail', ESM = 'Cliente - Líneas pedidos', FRC = 'Client - Détail de commande', ENC = 'Customer - Order Detail';
        PageCaptionLbl: TextConst ENU = 'Page', ESM = 'Pág.', FRC = 'Page', ENC = 'Page';
        AllAmtAreInLCYCaptionLbl: TextConst ENU = 'All amounts are in $', ESM = 'Importes en divisa local', FRC = 'Tous les montants sont en $', ENC = 'All amounts are in $';
        ShipmentDateCaptionLbl: TextConst ENU = 'Shipment Date', ESM = 'Fecha envío', FRC = 'Date de livraison', ENC = 'Shipment Date';
        QtyOnBackOrderCaptionLbl: TextConst ENU = 'Quantity on Back Order', ESM = 'Cant. pedidos pendientes', FRC = 'Qté sur commande en retard', ENC = 'Quantity on Back Order';
        OutstandingOrdersCaptionLbl: TextConst ENU = 'Outstanding Orders', ESM = 'Importe pedidos pendientes', FRC = 'Commandes en suspens', ENC = 'Outstanding Orders';
        TotalCaptionLbl: TextConst ENU = 'Total', ESM = 'Total', FRC = 'Total', ENC = 'Total';
        SalesProfit: Decimal;
        ProfitPercent: Decimal;

    procedure InitializeRequest(ShowAmountInLCY: Boolean; NewPagePerCustomer: Boolean);
    begin
        PrintAmountsInLCY := ShowAmountInLCY;
        PrintOnlyOnePerPage := NewPagePerCustomer;
    end;
}
