report 60024 "Purchase Order Ext"
{
    // version NAVNA14.03
    // ISS2.00 11.07.13 DFP - Added code to override Item No with Vendor Resource No.
    // ISSx.xx 10.04.13 DRR - Added Logo
    // 
    // SSI1.01,Update,11/25/14,DRH:  Added new field for Terms code.
    // IMP1.01,05/01/18,SK: Added code to get Item Tracking line in layout.
    // IMP1.02,09/07/18,SK: Added Terms & Conditions into layout.
    DefaultLayout = RDLC;
    RDLCLayout = './Purchase Order.rdl';
    CaptionML = ENU = 'Purchase Order', ESM = 'Pedido compra', FRC = 'Bon de commande', ENC = 'Purchase Order';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";

            column(No_PurchaseHeader; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(CompanyInfoPicture; CompanyInformation.Picture)
                    {
                    }
                    column(CompanyAddress1; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress2; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress3; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress4; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress5; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress6; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BuyFromAddress1; BuyFromAddress[1])
                    {
                    }
                    column(BuyFromAddress2; BuyFromAddress[2])
                    {
                    }
                    column(BuyFromAddress3; BuyFromAddress[3])
                    {
                    }
                    column(BuyFromAddress4; BuyFromAddress[4])
                    {
                    }
                    column(BuyFromAddress5; BuyFromAddress[5])
                    {
                    }
                    column(BuyFromAddress6; BuyFromAddress[6])
                    {
                    }
                    column(BuyFromAddress7; BuyFromAddress[7])
                    {
                    }
                    column(ExptRecptDt_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
                    {
                    }
                    column(ShipToAddress1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress7; ShipToAddress[7])
                    {
                    }
                    column(BuyfrVendNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(YourRef_PurchaseHeader; "Purchase Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchaseHeader; "Purchase Header"."No.")
                    {
                    }
                    column(OrderDate_PurchaseHeader; "Purchase Header"."Order Date")
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BuyFromAddress8; BuyFromAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Code)
                    {
                    }
                    column(CompanyInformationPhoneNo; CompanyInformation."Phone No.")
                    {
                    }
                    column(ShippingInfo_PurchaseHeader; ShippingInfo)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(VendTaxIdentificationType; Format(Vend."Tax Identification Type"))
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(ReceiveByCaption; ReceiveByCaptionLbl)
                    {
                    }
                    column(VendorIDCaption; VendorIDCaptionLbl)
                    {
                    }
                    column(ConfirmToCaption; ConfirmToCaptionLbl)
                    {
                    }
                    column(BuyerCaption; BuyerCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(ToCaption1; ToCaption1Lbl)
                    {
                    }
                    column(PurchOrderCaption; PurchOrderCaptionLbl)
                    {
                    }
                    column(PurchOrderNumCaption; PurchOrderNumCaptionLbl)
                    {
                    }
                    column(PurchOrderDateCaption; PurchOrderDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(TermsCaption; TermsCaptionLbl)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    column(ConfirmTEXT; ConfirmTEXT)
                    {
                    }
                    column(YourReferenceLbl; YourReferenceLbl)
                    {
                    }
                    column(ThirdPartyShipCaption; ThirdPartyShipLbl)
                    {
                    }
                    column(ShippingAgentCode_PurchaseHeader; "Purchase Header"."Shipping Agent Code")
                    {
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order));

                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(SubTotal; SubTotal)
                        {
                        }
                        column(ItemNumberToPrint; ItemNumberToPrint)
                        {
                        }
                        column(UnitofMeasure_PurchaseLine; "Unit of Measure")
                        {
                        }
                        column(Quantity_PurchaseLine; Quantity)
                        {
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(Description_PurchaseLine; Description + ' ' + "Description 2")
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(InvDiscountAmt_PurchaseLine; InvDisc)
                        {
                        }
                        column(TaxAmount; TaxAmount)
                        {
                        }
                        column(LineAmtTaxAmtInvDiscountAmt; GrandTotal)
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt3; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(DocumentNo_PurchaseLine; "Document No.")
                        {
                        }
                        column(ItemNoCaption; ItemNoCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(TotalPriceCaption; TotalPriceCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(InvDiscCaption; InvDiscCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(LineNo_PurchaseLine; "Purchase Line"."Line No.")
                        {
                        }
                        dataitem("Integer"; "Integer")
                        {
                            DataItemTableView = SORTING(Number);

                            column(LineNo_PurchaseLine_1; "Purchase Line"."Line No.")
                            {
                            }
                            column(Number; Number)
                            {
                            }
                            column(SerialNoVar; ReserEntry."Serial No.")
                            {
                            }
                            column(ItemNo; ReserEntry."Item No.")
                            {
                            }
                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then
                                    ReserEntry.FindSet
                                else
                                    ReserEntry.Next;
                            end;

                            trigger OnPreDataItem();
                            begin
                                SetRange(Number, 1, ReserEntry.Count);
                            end;
                        }
                        trigger OnAfterGetRecord();
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            Clear(AmountExclInvDisc); //IMP1.16
                            if ("Purchase Header"."Tax Area Code" <> '') and not UseExternalTaxEngine then SalesTaxCalc.AddPurchLine("Purchase Line");
                            if "Vendor Item No." <> '' then
                                ItemNumberToPrint := "Vendor Item No."
                            else
                                ItemNumberToPrint := "No.";
                            // ISS2.00 11.07.13 DFP ==================================================================\
                            if (Type = Type::Resource) and ("Vendor Resource No." <> '') then ItemNumberToPrint := "Vendor Resource No.";
                            // End ===================================================================================/
                            if Type.AsInteger() = 0 then begin
                                ItemNumberToPrint := '';
                                "Unit of Measure" := '';
                                "Line Amount" := 0;
                                "Inv. Discount Amount" := 0;
                                Quantity := 0;
                            end;
                            AmountExclInvDisc += "Line Amount";
                            SubTotal += "Line Amount";
                            InvDisc += "Inv. Discount Amount";
                            GrandTotal += "Line Amount" + TaxAmount - "Inv. Discount Amount";
                            if Quantity = 0 then
                                UnitPriceToPrint := 0 // so it won't print
                            else
                                UnitPriceToPrint := Round(AmountExclInvDisc / Quantity, 0.00001);
                            if OnLineNumber = NumberOfLines then begin
                                PrintFooter := true;
                                if "Purchase Header"."Tax Area Code" <> '' then begin
                                    if UseExternalTaxEngine then
                                        SalesTaxCalc.CallExternalTaxEngineForPurch("Purchase Header", true)
                                    else
                                        SalesTaxCalc.EndSalesTaxCalculation(UseDate);
                                    SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                                    BrkIdx := 0;
                                    PrevPrintOrder := 0;
                                    PrevTaxPercent := 0;
                                    TaxAmount := 0;
                                    TempSalesTaxAmtLine.Reset;
                                    TempSalesTaxAmtLine.SetCurrentKey("Print Order", "Tax Area Code for Key", "Tax Jurisdiction Code");
                                    if TempSalesTaxAmtLine.Find('-') then
                                        repeat
                                            if (TempSalesTaxAmtLine."Print Order" = 0) or (TempSalesTaxAmtLine."Print Order" <> PrevPrintOrder) or (TempSalesTaxAmtLine."Tax %" <> PrevTaxPercent) then begin
                                                BrkIdx := BrkIdx + 1;
                                                if BrkIdx > 1 then begin
                                                    if TaxArea."Country/Region" = TaxArea."Country/Region"::CA then
                                                        BreakdownTitle := Text006
                                                    else
                                                        BreakdownTitle := Text003;
                                                end;
                                                if BrkIdx > ArrayLen(BreakdownAmt) then begin
                                                    BrkIdx := BrkIdx - 1;
                                                    BreakdownLabel[BrkIdx] := Text004;
                                                end
                                                else
                                                    BreakdownLabel[BrkIdx] := StrSubstNo(TempSalesTaxAmtLine."Print Description", TempSalesTaxAmtLine."Tax %");
                                            end;
                                            BreakdownAmt[BrkIdx] := BreakdownAmt[BrkIdx] + TempSalesTaxAmtLine."Tax Amount";
                                            TaxAmount := TaxAmount + TempSalesTaxAmtLine."Tax Amount";
                                        until TempSalesTaxAmtLine.Next = 0;
                                    if BrkIdx = 1 then begin
                                        Clear(BreakdownLabel);
                                        Clear(BreakdownAmt);
                                    end;
                                end;
                            end;
                            //NA0003.END
                            //IMP1.01 Start
                            ReserEntry.Reset;
                            ReserEntry.SetRange("Source ID", "Document No.");
                            ReserEntry.SetRange("Source Ref. No.", "Line No.");
                            ReserEntry.SetFilter("Source Type", '=%1', 39);
                            ReserEntry.SetFilter("Source Subtype", '=%1', 1);
                            ReserEntry.SetRange("Item No.", "No.");
                            ReserEntry.SetFilter("Serial No.", '<>%1', '');
                            if ReserEntry.FindSet then;
                            //IMP1.01 End
                        end;

                        trigger OnPreDataItem();
                        begin
                            Clear(AmountExclInvDisc);
                            NumberOfLines := Count;
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }
                trigger OnAfterGetRecord();
                begin
                    //CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then PurchasePrinted.Run("Purchase Header");
                        CurrReport.Break;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                    TaxAmount := 0;
                    Clear(BreakdownTitle);
                    Clear(BreakdownLabel);
                    Clear(BreakdownAmt);
                    TotalTaxLabel := Text008;
                    if "Purchase Header"."Tax Area Code" <> '' then begin
                        TaxArea.Get("Purchase Header"."Tax Area Code");
                        case TaxArea."Country/Region" of
                            TaxArea."Country/Region"::US:
                                TotalTaxLabel := Text005;
                            TaxArea."Country/Region"::CA:
                                TotalTaxLabel := Text007;
                        end;
                        UseExternalTaxEngine := TaxArea."Use External Tax Engine";
                        SalesTaxCalc.StartSalesTaxCalculation;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    NoLoops := 1 + Abs(NoCopies);
                    if NoLoops <= 0 then NoLoops := 1;
                    CopyNo := 0;
                end;
            }
            trigger OnAfterGetRecord();
            begin
                if PrintCompany then
                    if RespCenter.Get("Responsibility Center") then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    end;
                //CurrReport.Language := Language.GetLanguageID("Language Code");
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                if "Purchaser Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Purchaser Code");
                if "Payment Terms Code" = '' then
                    Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");
                FormatAddress.PurchHeaderBuyFrom(BuyFromAddress, "Purchase Header");
                FormatAddress.PurchHeaderShipTo(ShipToAddress, "Purchase Header");
                if not CurrReport.Preview then begin
                    if ArchiveDocument then ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);
                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        SegManagement.LogDocument(13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
                    end;
                end;
                if "Posting Date" <> 0D then
                    UseDate := "Posting Date"
                else
                    UseDate := WorkDate;
                // ISSx.xx 03.05.14 DRR - Added to get the Shipping Agent ========================\
                Clear(ShippingInfo);
                Clear(ShippingAccount);
                ShippingAccount.SetRange("Ship-to Type", ShippingAccount."Ship-to Type"::Customer);
                ShippingAccount.SetRange("Ship-to No.", "Sell-to Customer No.");
                ShippingAccount.SetRange("Ship-to Code", "Ship-to Code");
                ShippingAccount.SetRange("Shipping Agent Code", "Shipping Agent Code");
                if ShippingAccount.FindFirst then begin
                    ShippingInfo := ShippingAccount."Account No." + ' ' + ShippingAccount.Description;
                end
                else begin
                    ShippingInfo := "Shipping Agent Code";
                end;
                // END ===========================================================================/
            end;

            trigger OnPreDataItem();
            begin
                if PrintCompany then
                    FormatAddress.Company(CompanyAddress, CompanyInformation)
                else
                    Clear(CompanyAddress);
                //ISS1.00 10.29.13 DRR - Added to show/hide logo
                if PrintLogo then CompanyInformation.CalcFields(Picture);
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

                    field(NumberOfCopies; NoCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Number of Copies', ESM = 'Número de copias', FRC = 'Nombre de copies', ENC = 'Number of Copies';
                        ToolTipML = ENU = 'Specifies the number of copies of each blanket purchase order, in addition to the original, that you want to print.', ESM = 'Especifica el número de copias de cada pedido de compras abierto, además del original, que desea imprimir.', FRC = 'Spécifie le nombre de copies, en plus de l''original, de chaque commande permanente achats que vous souhaitez imprimer.', ENC = 'Specifies the number of copies of each blanket purchase order, in addition to the original, that you want to print.';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Print Company Address', ESM = 'Imprimir dir. empresa', FRC = 'Imprimer l''adresse de la compagnie', ENC = 'Print Company Address';
                        ToolTipML = ENU = 'Specifies if you are printing on plain paper or if your company address is not pre-printed on your forms. If you do not select this field, the report will omit your company''s address.', ESM = 'Especifica si va a imprimir en papel normal o si la dirección de la empresa no está preimpresa en los formularios. Si no selecciona este campo, el informe omitirá la dirección de la empresa.', FRC = 'Spécifie si vous imprimez sur du papier ordinaire ou si l''adresse de votre compagnie n''est pas pré-imprimée sur vos formulaires. Si vous n''activez pas ce champ, le rapport ignorera l''adresse de votre compagnie.', ENC = 'Specifies if you are printing on plain paper or if your company address is not pre-printed on your forms. If you do not select this field, the report will omit your company''s address.';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Archive Document', ESM = 'Archivar documento', FRC = 'Archiver document', ENC = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;
                        ToolTipML = ENU = 'Specifies if the document is archived when you run the report.', ESM = 'Especifica si el documento se archiva cuando se ejecuta el informe.', FRC = 'Spécifie si le document est archivé lorsque vous exécutez le rapport.', ENC = 'Specifies if the document is archived when you run the report.';

                        trigger OnValidate();
                        begin
                            if not ArchiveDocument then LogInteraction := false;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Log Interaction', ESM = 'Log interacción', FRC = 'Journal interaction', ENC = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTipML = ENU = 'Specifies if the interaction with the vendor is logged when ,you run the report.', ESM = 'Especifica si la interacción con el proveedor ha iniciado sesión cuando se ejecuta el informe.', FRC = 'Spécifie si l''interaction avec le fournisseur est consignée lorsque vous exécutez le rapport.', ENC = 'Specifies if the interaction with the vendor is logged when ,you run the report.';

                        trigger OnValidate();
                        begin
                            if LogInteraction then ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(PrintLogo; PrintLogo)
                    {
                        Caption = 'Print Logo';
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit();
        begin
            LogInteractionEnable := true;
            ArchiveDocumentEnable := true;
        end;

        trigger OnOpenPage();
        begin
            ArchiveDocument := ArchiveManagement.PurchaseDocArchiveGranule;
            //LogInteraction:=SegManagement.FindInteractTmplCode(13) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Ord.") <> '';
            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnPreReport();
    begin
        CompanyInformation.Get('');
    end;

    var
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Vend: Record Vendor;
        CompanyAddress: array[8] of Text[100];
        BuyFromAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        CopyTxt: Text[10];
        ItemNumberToPrint: Text[20];
        PrintCompany: Boolean;
        PrintLogo: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        PurchasePrinted: Codeunit "Purch.Header-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        TaxAmount: Decimal;
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        UseDate: Date;
        Text000: TextConst ENU = 'COPY', ESM = 'COPIA', FRC = 'COPIER', ENC = 'COPY';
        Text003: TextConst ENU = 'Sales Tax Breakdown:', ESM = 'Análisis impto. vtas.:', FRC = 'Ventilation taxe de vente :', ENC = 'Sales Tax Breakdown:';
        Text004: TextConst ENU = 'Other Taxes', ESM = 'Otros impuestos', FRC = 'Autres taxes', ENC = 'Other Taxes';
        Text005: TextConst ENU = 'Total Sales Tax:', ESM = 'Total impto. vtas.:', FRC = 'Taxes de vente totales:', ENC = 'Total Sales Tax:';
        Text006: TextConst ENU = 'Tax Breakdown:', ESM = 'Desglose imptos.:', FRC = 'Ventilation fiscale :', ENC = 'Tax Breakdown:';
        Text007: TextConst ENU = 'Total Tax:', ESM = 'Total impto.:', FRC = 'Taxe totale :', ENC = 'Total Tax:';
        Text008: TextConst ENU = 'Tax:', ESM = 'Impto.:', FRC = 'Taxe :', ENC = 'Tax:';
        UseExternalTaxEngine: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        ToCaptionLbl: TextConst ENU = 'To:', ESM = 'Para:', FRC = '‡ :', ENC = 'To:';
        ReceiveByCaptionLbl: TextConst ENU = 'Receive By', ESM = 'Recibir por', FRC = 'Recevoir par', ENC = 'Receive By';
        VendorIDCaptionLbl: TextConst ENU = 'Vendor ID', ESM = 'Id. proveedor', FRC = 'Code de fournisseur', ENC = 'Vendor ID';
        ConfirmToCaptionLbl: TextConst ENU = 'Confirm To', ESM = 'Confirmar a', FRC = 'Confirmer à', ENC = 'Confirm To';
        BuyerCaptionLbl: TextConst ENU = 'Buyer', ESM = 'Comprador', FRC = 'Acheteur', ENC = 'Buyer';
        ShipCaptionLbl: TextConst ENU = 'Ship To:', ESM = 'Enviar', FRC = 'Livrer', ENC = 'Ship';
        ToCaption1Lbl: TextConst ENU = 'To:', ESM = 'Para:', FRC = '‡ :', ENC = 'To:';
        PurchOrderCaptionLbl: TextConst ENU = 'PURCHASE ORDER', ESM = 'PEDIDO COMPRA', FRC = 'BON DE COMMANDE', ENC = 'PURCHASE ORDER';
        PurchOrderNumCaptionLbl: TextConst ENU = 'Purchase Order Number:', ESM = 'Número pedido compra:', FRC = 'Numéro de bon de commande :', ENC = 'Purchase Order Number:';
        PurchOrderDateCaptionLbl: TextConst ENU = 'Purchase Order Date:', ESM = 'Fecha pedido compra:', FRC = 'Date du bon de commande :', ENC = 'Purchase Order Date:';
        PageCaptionLbl: TextConst ENU = 'Page:', ESM = 'Pág.:', FRC = 'Page :', ENC = 'Page:';
        ShipViaCaptionLbl: TextConst ENU = 'Ship Via', ESM = 'Envío a través de', FRC = 'Livrer par', ENC = 'Ship Via';
        TermsCaptionLbl: TextConst ENU = 'Terms', ESM = 'Términos', FRC = 'Modalités', ENC = 'Terms';
        PhoneNoCaptionLbl: TextConst ENU = 'Phone No.', ESM = 'Nº teléfono', FRC = 'N° téléphone', ENC = 'Phone No.';
        TaxIdentTypeCaptionLbl: TextConst ENU = 'Tax Ident. Type', ESM = 'Tipo de identificación fiscal', FRC = 'Type ident. taxe', ENC = 'Tax Ident. Type';
        ItemNoCaptionLbl: TextConst ENU = 'Item No.', ESM = 'Nº producto', FRC = 'N° d''article', ENC = 'Item No.';
        UnitCaptionLbl: TextConst ENU = 'Unit', ESM = 'Unidad', FRC = 'Unité', ENC = 'Unit';
        DescriptionCaptionLbl: TextConst ENU = 'Description', ESM = 'Descripción', FRC = 'Description', ENC = 'Description';
        QuantityCaptionLbl: TextConst ENU = 'Quantity', ESM = 'Cantidad', FRC = 'Quantité', ENC = 'Quantity';
        UnitPriceCaptionLbl: TextConst ENU = 'Unit Price', ESM = 'Precio unitario', FRC = 'Prix unitaire', ENC = 'Unit Price';
        TotalPriceCaptionLbl: TextConst ENU = 'Total Price', ESM = 'Precio total', FRC = 'Prix total', ENC = 'Total Price';
        SubtotalCaptionLbl: TextConst ENU = 'Subtotal:', ESM = 'Subtotal:', FRC = 'Sous-total :', ENC = 'Subtotal:';
        InvDiscCaptionLbl: TextConst ENU = 'Invoice Discount:', ESM = 'Descuento factura:', FRC = 'Escompte de la facture :', ENC = 'Invoice Discount:';
        TotalCaptionLbl: TextConst ENU = 'Total:', ESM = 'Total:', FRC = 'Total :', ENC = 'Total:';
        VendorOrderNoLbl: TextConst ENU = 'Vendor Order No.', ESM = 'Nº. de pedido de proveedor', FRC = 'N° commande fournisseur', ENC = 'Vendor Order No.';
        VendorInvoiceNoLbl: TextConst ENU = 'Vendor Invoice No.', ESM = 'Nº. de factura de proveedor', FRC = 'N° facture fournisseur', ENC = 'Vendor Invoice No.';
        ConfirmTEXT: Label 'Please confirm price and availability within 24 hours';
        YourReferenceLbl: Label 'Customer PO No:';
        ThirdPartyShipLbl: Label 'Shipping Instructions';
        ShippingAgent: Record "Shipping Agent";
        ShippingInfo: Text[250];
        ShippingAccount: Record "Shipping Account";
        "-IMP1.01-": Integer;
        TrackingSpecification: Record "Tracking Specification";
        ReserEntry: Record "Reservation Entry";
        SubTotal: Decimal;
        InvDisc: Decimal;
        GrandTotal: Decimal;

    procedure GetItemVendor(VendorNo: Code[20]; ItemNo: Code[20]): Text[20];
    var
        ItemVendor: Record "Item Vendor";
    begin
        // ISS2.00 12.12.13 DFP ========================================================================\
        // This function will return the Vendor Item No if possible, or Item No if not
        if ItemVendor.Get(ItemNo, VendorNo) then
            exit(ItemVendor."Vendor Item No.")
        else
            exit(ItemNo);
        // End =========================================================================================/
    end;
}
