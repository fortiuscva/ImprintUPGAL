report 60016 "Sales Credit Memo"
{
    // version NAVNA14.00
    DefaultLayout = RDLC;
    RDLCLayout = './Sales Credit Memo.rdlc';
    CaptionML = ENU = 'Sales Credit Memo', ESM = 'Nota crédito venta', FRC = 'Note de crédit de vente', ENC = 'Sales Credit Memo';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeadingML = ENU = 'Sales Credit Memo', ESM = 'Nota crédito venta', FRC = 'Note de crédit de vente', ENC = 'Sales Credit Memo';

            column(No_SalesCrMemoHeader; "No.")
            {
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Credit Memo"), "Print On Credit Memo" = CONST(true));

                    trigger OnAfterGetRecord();
                    begin
                        InsertTempLine(Comment, 10);
                    end;
                }
                trigger OnAfterGetRecord();
                begin
                    TempSalesCrMemoLine := "Sales Cr.Memo Line";
                    TempSalesCrMemoLine.Insert;
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem();
                begin
                    TempSalesCrMemoLine.Reset;
                    TempSalesCrMemoLine.DeleteAll;
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Credit Memo"), "Print On Credit Memo" = CONST(true), "Document Line No." = CONST(0));

                trigger OnAfterGetRecord();
                begin
                    InsertTempLine(Comment, 1000);
                end;

                trigger OnPreDataItem();
                begin
                    TempSalesCrMemoLine.Init;
                    TempSalesCrMemoLine."Document No." := "Sales Cr.Memo Header"."No.";
                    TempSalesCrMemoLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesCrMemoLine."Line No.";
                    TempSalesCrMemoLine.Insert;
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
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
                    column(CompanyAddressRemit1; CompanyAddressRemit[1])
                    {
                    }
                    column(CompanyAddressRemit2; CompanyAddressRemit[2])
                    {
                    }
                    column(CompanyAddressRemit3; CompanyAddressRemit[3])
                    {
                    }
                    column(CompanyAddressRemit4; CompanyAddressRemit[4])
                    {
                    }
                    column(CompanyAddressRemit5; CompanyAddressRemit[5])
                    {
                    }
                    column(CompanyAddressRemit6; CompanyAddressRemit[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress1; BillToAddress[1])
                    {
                    }
                    column(BillToAddress2; BillToAddress[2])
                    {
                    }
                    column(BillToAddress3; BillToAddress[3])
                    {
                    }
                    column(BillToAddress4; BillToAddress[4])
                    {
                    }
                    column(BillToAddress5; BillToAddress[5])
                    {
                    }
                    column(BillToAddress6; BillToAddress[6])
                    {
                    }
                    column(BillToAddress7; BillToAddress[7])
                    {
                    }
                    column(ShptDate_SalesCrMemoHeader; "Sales Cr.Memo Header"."Shipment Date")
                    {
                    }
                    column(ApplDocType_SalesCrMemoHeader; "Sales Cr.Memo Header"."Applies-to Doc. Type")
                    {
                    }
                    column(ApplDocNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Applies-to Doc. No.")
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
                    column(BilltoCustNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(YourRef_SalesCrMemoHeader; "Sales Cr.Memo Header"."Your Reference")
                    {
                    }
                    column(ExternalDocNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."External Document No.")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(DocDate_SalesCrMemoHeader; "Sales Cr.Memo Header"."Document Date")
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BillToAddress8; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(PrintFooter; PrintFooter)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(TaxIdentType_Cust; Format(Cust."Tax Identification Type"))
                    {
                    }
                    column(CreditCaption; CreditCaptionLbl)
                    {
                    }
                    column(ShipDateCaption; ShipDateCaptionLbl)
                    {
                    }
                    column(ApplytoTypeCaption; ApplytoTypeCaptionLbl)
                    {
                    }
                    column(ApplytoNumberCaption; ApplytoNumberCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(CreditMemoCaption; CreditMemoCaptionLbl)
                    {
                    }
                    column(CreditMemoNumberCaption; CreditMemoNumberCaptionLbl)
                    {
                    }
                    column(CreditMemoDateCaption; CreditMemoDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    dataitem(SalesCrMemoLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLineNo; TempSalesCrMemoLine."No.")
                        {
                        }
                        column(TempSalesCrMemoLineUOM; TempSalesCrMemoLine."Unit of Measure")
                        {
                        }
                        column(TempSalesCrMemoLineQty; TempSalesCrMemoLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; TempSalesCrMemoLine."Unit Price")
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(TempSalesCrMemoLineDesc; TempSalesCrMemoLine.Description + ' ' + TempSalesCrMemoLine."Description 2")
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesCrMemoLineAmtTaxLiable; TempSalesCrMemoLine.Amount - TaxLiable)
                        {
                        }
                        column(TempSalesCrMemoLineAmtAmtExclInvDisc; TempSalesCrMemoLine.Amount - AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLineAmtInclVATAmt; TempSalesCrMemoLine."Amount Including VAT" - TempSalesCrMemoLine.Amount)
                        {
                        }
                        column(TempSalesCrMemoLineAmtInclVAT; TempSalesCrMemoLine."Amount Including VAT")
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownAmt3; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
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
                        column(InvoiceDiscountCaption; InvoiceDiscountCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(AmountSubjecttoSalesTaxCaption; AmountSubjecttoSalesTaxCaptionLbl)
                        {
                        }
                        column(AmountExemptfromSalesTaxCaption; AmountExemptfromSalesTaxCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            if OnLineNumber = 1 then
                                TempSalesCrMemoLine.Find('-')
                            else
                                TempSalesCrMemoLine.Next;
                            if TempSalesCrMemoLine.Type.AsInteger() = 0 then begin
                                TempSalesCrMemoLine."No." := '';
                                TempSalesCrMemoLine."Unit of Measure" := '';
                                TempSalesCrMemoLine.Amount := 0;
                                TempSalesCrMemoLine."Amount Including VAT" := 0;
                                TempSalesCrMemoLine."Inv. Discount Amount" := 0;
                                TempSalesCrMemoLine.Quantity := 0;
                            end
                            else
                                if TempSalesCrMemoLine.Type = TempSalesCrMemoLine.Type::"G/L Account" then TempSalesCrMemoLine."No." := '';
                            if TempSalesCrMemoLine.Amount <> TempSalesCrMemoLine."Amount Including VAT" then
                                TaxLiable := TempSalesCrMemoLine.Amount
                            else
                                TaxLiable := 0;
                            AmountExclInvDisc := TempSalesCrMemoLine.Amount + TempSalesCrMemoLine."Inv. Discount Amount";
                            if TempSalesCrMemoLine.Quantity = 0 then
                                UnitPriceToPrint := 0 // so it won't print
                            else
                                UnitPriceToPrint := Round(AmountExclInvDisc / TempSalesCrMemoLine.Quantity, 0.1); //IMP1.01  old value:0.00001
                            if OnLineNumber = NumberOfLines then PrintFooter := true;
                        end;

                        trigger OnPreDataItem();
                        begin
                            Clear(TaxLiable);
                            Clear(AmountExclInvDisc);
                            NumberOfLines := TempSalesCrMemoLine.Count;
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }
                trigger OnAfterGetRecord();
                begin
                    // CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then SalesCrMemoPrinted.Run("Sales Cr.Memo Header");
                        CurrReport.Break;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
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
                //CurrReport.Language := Language.GetLanguageID("Language Code");
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                if PrintCompany then
                    if RespCenter.Get("Responsibility Center") then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInfo."Phone No." := RespCenter."Phone No.";
                        CompanyInfo."Fax No." := RespCenter."Fax No.";
                    end;
                if "Salesperson Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");
                if "Bill-to Customer No." = '' then begin
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                end;
                FormatAddress.SalesCrMemoBillTo(BillToAddress, "Sales Cr.Memo Header");
                FormatAddress.SalesCrMemoShipTo(ShipToAddress, ShipToAddress, "Sales Cr.Memo Header");
                if LogInteraction then if not CurrReport.Preview then SegManagement.LogDocument(6, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
                Clear(BreakdownTitle);
                Clear(BreakdownLabel);
                Clear(BreakdownAmt);
                TotalTaxLabel := Text008;
                TaxRegNo := '';
                TaxRegLabel := '';
                if "Tax Area Code" <> '' then begin
                    TaxArea.Get("Tax Area Code");
                    case TaxArea."Country/Region" of
                        TaxArea."Country/Region"::US:
                            TotalTaxLabel := Text005;
                        TaxArea."Country/Region"::CA:
                            begin
                                TotalTaxLabel := Text007;
                                TaxRegNo := CompanyInfo."VAT Registration No.";
                                TaxRegLabel := CompanyInfo.FieldCaption("VAT Registration No.");
                            end;
                    end;
                    SalesTaxCalc.StartSalesTaxCalculation;
                    if TaxArea."Use External Tax Engine" then
                        SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Sales Cr.Memo Header", 0, "No.")
                    else begin
                        SalesTaxCalc.AddSalesCrMemoLines("No.");
                        SalesTaxCalc.EndSalesTaxCalculation("Posting Date");
                    end;
                    SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                    BrkIdx := 0;
                    PrevPrintOrder := 0;
                    PrevTaxPercent := 0;
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
                        until TempSalesTaxAmtLine.Next = 0;
                    if BrkIdx = 1 then begin
                        Clear(BreakdownLabel);
                        Clear(BreakdownAmt);
                    end;
                end;
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

                    field(NoCopies; NoCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Number of Copies', ESM = 'Número de copias', FRC = 'Nombre de copies', ENC = 'Number of Copies';
                        ToolTipML = ENU = 'Specifies the number of copies of each document (in addition to the original) that you want to print.', ESM = 'Especifica el número de copias de cada documento (además del original) que desea imprimir.', FRC = 'Spécifie le nombre de copies de chaque document (en plus de l''original) que vous souhaitez imprimer.', ENC = 'Specifies the number of copies of each document (in addition to the original) that you want to print.';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Print Company Address', ESM = 'Imprimir dir. empresa', FRC = 'Imprimer l''adresse de la compagnie', ENC = 'Print Company Address';
                        ToolTipML = ENU = 'Specifies if your company address is printed at the top of the sheet, because you do not use pre-printed paper. Leave this check box blank to omit your company''s address.', ESM = 'Especifica si en la parte superior de la hoja se debe imprimir la dirección de la empresa porque no usa papel preimpreso. Deje la casilla en blanco para omitir la dirección de la empresa.', FRC = 'Spécifie si l''adresse de votre compagnie est imprimée en haut de la feuille, car vous n''utilisez pas de papier préimprimé. Décochez cette case pour ne pas imprimer l''adresse de votre compagnie.', ENC = 'Specifies if your company address is printed at the top of the sheet, because you do not use pre-printed paper. Leave this check box blank to omit your company''s address.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Log Interaction', ESM = 'Log interacción', FRC = 'Journal interaction', ENC = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTipML = ENU = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.', ESM = 'Especifica si desea registrar las interacciones relacionadas con la persona de contacto implicada en la tabla Mov. log de interacción.', FRC = 'Spécifie si vous souhaitez enregistrer les interactions associées avec la personne de contact impliquée dans la table Écriture du journal d''interaction.', ENC = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.';
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
        end;

        trigger OnOpenPage();
        begin
            //LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Cr. Memo") <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnPreReport();
    begin
        CompanyInfo.Get;
        SalesSetup.Get;
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
        if PrintCompany then
            FormatAddress.Company(CompanyAddress, CompanyInfo)
        else
            Clear(CompanyAddress);
        // ISS2.00 11.20.13 ==============================================\
        // Always print Remit-To Address
        FormatAddress.Company(CompanyAddressRemit, CompanyInfo) // End ===========================================================/
    end;

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesCrMemoLine: Record "Sales Cr.Memo Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        SalesCrMemoPrinted: Codeunit "Sales Cr. Memo-Printed";
        FormatAddress: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        SegManagement: Codeunit SegManagement;
        CompanyAddress: array[8] of Text[100];
        BillToAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        CopyTxt: Text;
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        LogInteraction: Boolean;
        Text000: TextConst ENU = 'COPY', ESM = 'COPIA', FRC = 'COPIER', ENC = 'COPY';
        TaxRegNo: Text;
        TaxRegLabel: Text;
        TotalTaxLabel: Text;
        BreakdownTitle: Text;
        BreakdownLabel: array[4] of Text;
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        Text003: TextConst ENU = 'Sales Tax Breakdown:', ESM = 'Análisis impto. vtas.:', FRC = 'Ventilation taxe de vente :', ENC = 'Sales Tax Breakdown:';
        Text004: TextConst ENU = 'Other Taxes', ESM = 'Otros impuestos', FRC = 'Autres taxes', ENC = 'Other Taxes';
        Text005: TextConst ENU = 'Total Sales Tax:', ESM = 'Total impto. vtas.:', FRC = 'Taxes de vente totales:', ENC = 'Total Sales Tax:';
        Text006: TextConst ENU = 'Tax Breakdown:', ESM = 'Desglose imptos.:', FRC = 'Ventilation fiscale :', ENC = 'Tax Breakdown:';
        Text007: TextConst ENU = 'Total Tax:', ESM = 'Total impto.:', FRC = 'Taxe totale :', ENC = 'Total Tax:';
        Text008: TextConst ENU = 'Tax:', ESM = 'Impto.:', FRC = 'Taxe :', ENC = 'Tax:';
        Text009: TextConst ENU = 'VOID CREDIT MEMO', ESM = 'ANULAR NOTA DE CRÉDITO', FRC = 'ANNULER NOTE DE CRÉDIT', ENC = 'VOID CREDIT MEMO';
        [InDataSet]
        LogInteractionEnable: Boolean;
        CreditCaptionLbl: TextConst ENU = 'Credit', ESM = 'Crédito', FRC = 'Crédit', ENC = 'Credit';
        ShipDateCaptionLbl: TextConst ENU = 'Ship Date', ESM = 'Fecha envío', FRC = 'Date de livraison', ENC = 'Ship Date';
        ApplytoTypeCaptionLbl: TextConst ENU = 'Apply to Type', ESM = 'Aplicar a tipo', FRC = 'Affecter au type', ENC = 'Apply to Type';
        ApplytoNumberCaptionLbl: TextConst ENU = 'Apply to Number', ESM = 'Aplicar a número', FRC = 'Affecter au numéro', ENC = 'Apply to Number';
        CustomerIDCaptionLbl: TextConst ENU = 'Customer ID', ESM = 'Id. cliente', FRC = 'Code de client', ENC = 'Customer ID';
        PONumberCaptionLbl: TextConst ENU = 'P.O. Number', ESM = 'Número pedido compra', FRC = 'N° de bon de commande', ENC = 'P.O. Number';
        SalesPersonCaptionLbl: TextConst ENU = 'SalesPerson', ESM = 'Vendedor', FRC = 'Représentant', ENC = 'SalesPerson';
        ShipCaptionLbl: TextConst ENU = 'Ship', ESM = 'Enviar', FRC = 'Livrer', ENC = 'Ship';
        CreditMemoCaptionLbl: TextConst ENU = 'CREDIT MEMO', ESM = 'NOTA CRÉDITO', FRC = 'NOTE DE CRÉDIT', ENC = 'CREDIT MEMO';
        CreditMemoNumberCaptionLbl: TextConst ENU = 'Credit Memo Number:', ESM = 'Número nota crédito:', FRC = 'Numéro de la note de crédit :', ENC = 'Credit Memo Number:';
        CreditMemoDateCaptionLbl: TextConst ENU = 'Credit Memo Date:', ESM = 'Fecha nota crédito:', FRC = 'Date de la note de crédit :', ENC = 'Credit Memo Date:';
        PageCaptionLbl: TextConst ENU = 'Page:', ESM = 'Pág.:', FRC = 'Page :', ENC = 'Page:';
        TaxIdentTypeCaptionLbl: TextConst ENU = 'Tax Ident. Type', ESM = 'Tipo de identificación fiscal', FRC = 'Type ident. taxe', ENC = 'Tax Ident. Type';
        ToCaptionLbl: TextConst ENU = 'To:', ESM = 'Para:', FRC = '‡ :', ENC = 'To:';
        ItemNoCaptionLbl: TextConst ENU = 'Item No.', ESM = 'Nº producto', FRC = 'N° d''article', ENC = 'Item No.';
        UnitCaptionLbl: TextConst ENU = 'Unit', ESM = 'Unidad', FRC = 'Unité', ENC = 'Unit';
        DescriptionCaptionLbl: TextConst ENU = 'Description', ESM = 'Descripción', FRC = 'Description', ENC = 'Description';
        QuantityCaptionLbl: TextConst ENU = 'Quantity', ESM = 'Cantidad', FRC = 'Quantité', ENC = 'Quantity';
        UnitPriceCaptionLbl: TextConst ENU = 'Unit Price', ESM = 'Precio unitario', FRC = 'Prix unitaire', ENC = 'Unit Price';
        TotalPriceCaptionLbl: TextConst ENU = 'Total Price', ESM = 'Precio total', FRC = 'Prix total', ENC = 'Total Price';
        SubtotalCaptionLbl: TextConst ENU = 'Subtotal:', ESM = 'Subtotal:', FRC = 'Sous-total :', ENC = 'Subtotal:';
        InvoiceDiscountCaptionLbl: TextConst ENU = 'Invoice Discount:', ESM = 'Descuento factura:', FRC = 'Escompte de la facture :', ENC = 'Invoice Discount:';
        TotalCaptionLbl: TextConst ENU = 'Total:', ESM = 'Total:', FRC = 'Total :', ENC = 'Total:';
        AmountSubjecttoSalesTaxCaptionLbl: TextConst ENU = 'Amount Subject to Sales Tax', ESM = 'Importe sujeto a impuestos de ventas', FRC = 'Montant assujetti à la taxe de vente', ENC = 'Amount Subject to Sales Tax';
        AmountExemptfromSalesTaxCaptionLbl: TextConst ENU = 'Amount Exempt from Sales Tax', ESM = 'Importe exento de impuestos de ventas', FRC = 'Montant exonéré de la taxe de vente', ENC = 'Amount Exempt from Sales Tax';
        CompanyAddressRemit: array[8] of Text[50];
    //[LineStart(1540)]
    local procedure InsertTempLine(Comment: Text[80]; IncrNo: Integer);
    begin
        TempSalesCrMemoLine.Init;
        TempSalesCrMemoLine."Document No." := "Sales Cr.Memo Header"."No.";
        TempSalesCrMemoLine."Line No." := HighestLineNo + IncrNo;
        HighestLineNo := TempSalesCrMemoLine."Line No.";
        if StrLen(Comment) <= MaxStrLen(TempSalesCrMemoLine.Description) then begin
            TempSalesCrMemoLine.Description := CopyStr(Comment, 1, MaxStrLen(TempSalesCrMemoLine.Description));
            TempSalesCrMemoLine."Description 2" := '';
        end
        else begin
            SpacePointer := MaxStrLen(TempSalesCrMemoLine.Description) + 1;
            while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do SpacePointer := SpacePointer - 1;
            if SpacePointer = 1 then SpacePointer := MaxStrLen(TempSalesCrMemoLine.Description) + 1;
            TempSalesCrMemoLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
            TempSalesCrMemoLine."Description 2" := CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesCrMemoLine."Description 2"));
        end;
        TempSalesCrMemoLine.Insert;
    end;
}
