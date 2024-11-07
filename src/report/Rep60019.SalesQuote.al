report 60019 "Sales Quote"
{
    // version NAVNA14.08
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/Sales Quote.rdl';
    CaptionML = ENU = 'Sales - Quote', ESM = 'Ventas - Cotización', FRC = 'Devis - Vente', ENC = 'Sales - Quote';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Quote));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeadingML = ENU = 'Sales Order', ESM = 'Pedido venta', FRC = 'Document de vente', ENC = 'Sales Order';

            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Quote));

                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Quote), "Print On Quote" = CONST(true));

                    trigger OnAfterGetRecord();
                    begin
                        TempSalesLine.Init;
                        TempSalesLine."Document Type" := "Sales Header"."Document Type";
                        TempSalesLine."Document No." := "Sales Header"."No.";
                        TempSalesLine."Line No." := HighestLineNo + 10;
                        HighestLineNo := TempSalesLine."Line No.";
                        if StrLen(Comment) <= MaxStrLen(TempSalesLine.Description) then begin
                            TempSalesLine.Description := Comment;
                            TempSalesLine."Description 2" := '';
                        end
                        else begin
                            SpacePointer := MaxStrLen(TempSalesLine.Description) + 1;
                            while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do SpacePointer := SpacePointer - 1;
                            if SpacePointer = 1 then SpacePointer := MaxStrLen(TempSalesLine.Description) + 1;
                            TempSalesLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                            TempSalesLine."Description 2" := CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesLine."Description 2"));
                        end;
                        TempSalesLine.Insert;
                    end;
                }
                trigger OnAfterGetRecord();
                begin
                    TempSalesLine := "Sales Line";
                    TempSalesLine.Insert;
                    HighestLineNo := "Line No.";
                    if ("Sales Header"."Tax Area Code" <> '') and not UseExternalTaxEngine then SalesTaxCalc.AddSalesLine(TempSalesLine);
                end;

                trigger OnPostDataItem();
                begin
                    if "Sales Header"."Tax Area Code" <> '' then begin
                        if UseExternalTaxEngine then
                            SalesTaxCalc.CallExternalTaxEngineForSales("Sales Header", true)
                        else
                            SalesTaxCalc.EndSalesTaxCalculation(UseDate);
                        SalesTaxCalc.DistTaxOverSalesLines(TempSalesLine);
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

                trigger OnPreDataItem();
                begin
                    TempSalesLine.Reset;
                    TempSalesLine.DeleteAll;
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Quote), "Print On Quote" = CONST(true), "Document Line No." = CONST(0));

                trigger OnAfterGetRecord();
                begin
                    TempSalesLine.Init;
                    TempSalesLine."Document Type" := "Sales Header"."Document Type";
                    TempSalesLine."Document No." := "Sales Header"."No.";
                    TempSalesLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesLine."Line No.";
                    if StrLen(Comment) <= MaxStrLen(TempSalesLine.Description) then begin
                        TempSalesLine.Description := Comment;
                        TempSalesLine."Description 2" := '';
                    end
                    else begin
                        SpacePointer := MaxStrLen(TempSalesLine.Description) + 1;
                        while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do SpacePointer := SpacePointer - 1;
                        if SpacePointer = 1 then SpacePointer := MaxStrLen(TempSalesLine.Description) + 1;
                        TempSalesLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                        TempSalesLine."Description 2" := CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesLine."Description 2"));
                    end;
                    TempSalesLine.Insert;
                end;

                trigger OnPreDataItem();
                begin
                    TempSalesLine.Init;
                    TempSalesLine."Document Type" := "Sales Header"."Document Type";
                    TempSalesLine."Document No." := "Sales Header"."No.";
                    TempSalesLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesLine."Line No.";
                    TempSalesLine.Insert;
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo3.Picture)
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
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(OrderDate_SalesHeader; "Sales Header"."Order Date")
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
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
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
                    column(CustTaxIdentificationType; Format(Cust."Tax Identification Type"))
                    {
                    }
                    column(SellCaption; SellCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(SalesQuoteCaption; SalesQuoteCaptionLbl)
                    {
                    }
                    column(SalesQuoteNumberCaption; SalesQuoteNumberCaptionLbl)
                    {
                    }
                    column(SalesQuoteDateCaption; SalesQuoteDateCaptionLbl)
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
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    dataitem(SalesLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(Number_IntegerLine; Number)
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesLineNo; TempSalesLine."No.")
                        {
                        }
                        column(TempSalesLineUOM; TempSalesLine."Unit of Measure Code")
                        {
                        }
                        column(TempSalesLineQuantity; TempSalesLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(TempSalesLineDescription; TempSalesLine.Description + ' ' + TempSalesLine."Description 2")
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesLineLineAmtTaxLiable; TempSalesLine."Line Amount" - TaxLiable)
                        {
                        }
                        column(TempSalesLineInvDiscAmt; TempSalesLine."Inv. Discount Amount")
                        {
                        }
                        column(TaxAmount; TaxAmount)
                        {
                        }
                        column(TempSalesLineLineAmtTaxAmtInvDiscAmt; TempSalesLine."Line Amount" + TaxAmount - TempSalesLine."Inv. Discount Amount")
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
                        column(AmtSubjecttoSalesTaxCptn; AmtSubjecttoSalesTaxCptnLbl)
                        {
                        }
                        column(AmtExemptfromSalesTaxCptn; AmtExemptfromSalesTaxCptnLbl)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            if OnLineNumber = 1 then
                                TempSalesLine.Find('-')
                            else
                                TempSalesLine.Next;
                            if TempSalesLine.Type.AsInteger() = 0 then begin
                                TempSalesLine."No." := '';
                                TempSalesLine."Unit of Measure" := '';
                                TempSalesLine."Line Amount" := 0;
                                TempSalesLine."Inv. Discount Amount" := 0;
                                TempSalesLine.Quantity := 0;
                            end
                            else if TempSalesLine.Type = TempSalesLine.Type::"G/L Account" then TempSalesLine."No." := '';
                            if TempSalesLine."Tax Area Code" <> '' then
                                TaxAmount := TempSalesLine."Amount Including VAT" - TempSalesLine.Amount
                            else
                                TaxAmount := 0;
                            if TaxAmount <> 0 then
                                TaxLiable := TempSalesLine.Amount
                            else
                                TaxLiable := 0;
                            OnAfterCalculateSalesTax("Sales Header", TempSalesLine, TaxAmount, TaxLiable);
                            AmountExclInvDisc := TempSalesLine."Line Amount";
                            if TempSalesLine.Quantity = 0 then
                                UnitPriceToPrint := 0 // so it won't print
                            else
                                UnitPriceToPrint := Round(AmountExclInvDisc / TempSalesLine.Quantity, 0.00001);
                            if OnLineNumber = NumberOfLines then PrintFooter := true;
                        end;

                        trigger OnPreDataItem();
                        begin
                            Clear(TaxLiable);
                            Clear(TaxAmount);
                            Clear(AmountExclInvDisc);
                            TempSalesLine.Reset;
                            NumberOfLines := TempSalesLine.Count;
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }
                trigger OnAfterGetRecord();
                begin
                    //CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then SalesPrinted.Run("Sales Header");
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
                if PrintCompany then
                    if RespCenter.Get("Responsibility Center") then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    end;
                //CurrReport.Language := Language.GetLanguageID("Language Code");
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                FormatDocumentFields("Sales Header");
                if not Cust.Get("Sell-to Customer No.") then Clear(Cust);
                FormatAddress.SalesHeaderSellTo(BillToAddress, "Sales Header");
                FormatAddress.SalesHeaderShipTo(ShipToAddress, ShipToAddress, "Sales Header");
                if not CurrReport.Preview then begin
                    if ArchiveDocument then ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);
                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(1, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        else
                            SegManagement.LogDocument(1, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    end;
                end;
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
                                TaxRegNo := CompanyInformation."VAT Registration No.";
                                TaxRegLabel := CompanyInformation.FieldCaption("VAT Registration No.");
                            end;
                    end;
                    UseExternalTaxEngine := TaxArea."Use External Tax Engine";
                    SalesTaxCalc.StartSalesTaxCalculation;
                end;
                UseDate := WorkDate;
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
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Archive Document', ESM = 'Archivar documento', FRC = 'Archiver document', ENC = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;
                        ToolTipML = ENU = 'Specifies if the document is archived after you preview or print it.', ESM = 'Especifica si el documento se archiva después de visualizarlo previamente o imprimirlo.', FRC = 'Indique si le document est archivé après son aperçu ou son impression.', ENC = 'Specifies if the document is archived after you preview or print it.';

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
                        ToolTipML = ENU = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.', ESM = 'Especifica si desea registrar las interacciones relacionadas con la persona de contacto implicada en la tabla Mov. log de interacción.', FRC = 'Spécifie si vous souhaitez enregistrer les interactions associées avec la personne de contact impliquée dans la table Écriture du journal d''interaction.', ENC = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.';

                        trigger OnValidate();
                        begin
                            if LogInteraction then ArchiveDocument := ArchiveDocumentEnable;
                        end;
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
            ArchiveDocument := (SalesSetup."Archive Quotes" = SalesSetup."Archive Quotes"::Question) or (SalesSetup."Archive Quotes" = SalesSetup."Archive Quotes"::Always);
            //LogInteraction:=SegManagement.FindInteractTmplCode(1) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Qte.") <> '';
            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnInitReport();
    begin
        CompanyInfo.Get;
        SalesSetup.Get;
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    trigger OnPreReport();
    begin
        if PrintCompany then
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
    end;

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesLine: Record "Sales Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        SalesPrinted: Codeunit "Sales-Printed";
        FormatAddress: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        CompanyAddress: array[8] of Text[100];
        BillToAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        CopyTxt: Text;
        SalespersonText: Text[50];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        TaxAmount: Decimal;
        ArchiveDocument: Boolean;
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
        UseDate: Date;
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
        SellCaptionLbl: TextConst ENU = 'Sell', ESM = 'Vender', FRC = 'Vendre', ENC = 'Sell';
        ToCaptionLbl: TextConst ENU = 'To:', ESM = 'Para:', FRC = '‡ :', ENC = 'To:';
        CustomerIDCaptionLbl: TextConst ENU = 'Customer ID', ESM = 'Id. cliente', FRC = 'Code de client', ENC = 'Customer ID';
        SalesPersonCaptionLbl: TextConst ENU = 'SalesPerson', ESM = 'Vendedor', FRC = 'Représentant', ENC = 'SalesPerson';
        ShipCaptionLbl: TextConst ENU = 'Ship', ESM = 'Enviar', FRC = 'Livrer', ENC = 'Ship';
        SalesQuoteCaptionLbl: TextConst ENU = 'Sales Quote', ESM = 'Cotización venta', FRC = 'Devis', ENC = 'Sales Quote';
        SalesQuoteNumberCaptionLbl: TextConst ENU = 'Sales Quote Number:', ESM = 'Número cotización venta:', FRC = 'N° de devis de vente :', ENC = 'Sales Quote Number:';
        SalesQuoteDateCaptionLbl: TextConst ENU = 'Sales Quote Date:', ESM = 'Fecha cotización venta:', FRC = 'Date de devis de vente :', ENC = 'Sales Quote Date:';
        PageCaptionLbl: TextConst ENU = 'Page:', ESM = 'Pág.:', FRC = 'Page :', ENC = 'Page:';
        ShipViaCaptionLbl: TextConst ENU = 'Ship Via', ESM = 'Envío a través de', FRC = 'Livrer par', ENC = 'Ship Via';
        TermsCaptionLbl: TextConst ENU = 'Terms', ESM = 'Términos', FRC = 'Modalités', ENC = 'Terms';
        TaxIdentTypeCaptionLbl: TextConst ENU = 'Tax Ident. Type', ESM = 'Tipo de identificación fiscal', FRC = 'Type ident. taxe', ENC = 'Tax Ident. Type';
        ItemNoCaptionLbl: TextConst ENU = 'Item No.', ESM = 'Nº producto', FRC = 'N° d''article', ENC = 'Item No.';
        UnitCaptionLbl: TextConst ENU = 'Unit', ESM = 'Unidad', FRC = 'Unité', ENC = 'Unit';
        DescriptionCaptionLbl: TextConst ENU = 'Description', ESM = 'Descripción', FRC = 'Description', ENC = 'Description';
        QuantityCaptionLbl: TextConst ENU = 'Quantity', ESM = 'Cantidad', FRC = 'Quantité', ENC = 'Quantity';
        UnitPriceCaptionLbl: TextConst ENU = 'Unit Price', ESM = 'Precio unitario', FRC = 'Prix unitaire', ENC = 'Unit Price';
        TotalPriceCaptionLbl: TextConst ENU = 'Total Price', ESM = 'Precio total', FRC = 'Prix total', ENC = 'Total Price';
        SubtotalCaptionLbl: TextConst ENU = 'Subtotal:', ESM = 'Subtotal:', FRC = 'Sous-total :', ENC = 'Subtotal:';
        InvoiceDiscountCaptionLbl: TextConst ENU = 'Invoice Discount:', ESM = 'Descuento factura:', FRC = 'Escompte de la facture :', ENC = 'Invoice Discount:';
        TotalCaptionLbl: TextConst ENU = 'Total:', ESM = 'Total:', FRC = 'Total :', ENC = 'Total:';
        AmtSubjecttoSalesTaxCptnLbl: TextConst ENU = 'Amount Subject to Sales Tax', ESM = 'Importe sujeto a impuestos de ventas', FRC = 'Montant assujetti à la taxe de vente', ENC = 'Amount Subject to Sales Tax';
        AmtExemptfromSalesTaxCptnLbl: TextConst ENU = 'Amount Exempt from Sales Tax', ESM = 'Importe exento de impuestos de ventas', FRC = 'Montant exonéré de la taxe de vente', ENC = 'Amount Exempt from Sales Tax';
    //[LineStart(1573)]
    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header");
    begin
        FormatDocument.SetSalesPerson(SalesPurchPerson, SalesHeader."Salesperson Code", SalespersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
    end;

    [IntegrationEvent(false, false)]
    //[LineStart(1580)]
    local procedure OnAfterCalculateSalesTax(var SalesHeaderParm: Record "Sales Header"; var SalesLineParm: Record "Sales Line"; var TaxAmount: Decimal; var TaxLiable: Decimal);
    begin
    end;
}
