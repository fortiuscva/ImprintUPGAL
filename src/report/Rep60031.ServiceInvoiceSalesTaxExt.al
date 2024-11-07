report 60031 "Service Invoice-Sales TaxExt"
{
    // version NAVNA14.03
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/Service Invoice-Sales Tax.rdl';
    CaptionML = ENU = 'Service - Invoice', ESM = 'Servicio - Factura', FRC = 'Service - Facture', ENC = 'Service - Invoice';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Service Invoice Header"; "Service Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Customer No.", "No. Printed";
            RequestFilterHeadingML = ENU = 'Service Invoice', ESM = 'Factura servicio', FRC = 'Facture de service', ENC = 'Service Invoice';

            column(No_ServiceInvoiceHeader; "No.")
            {
            }
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
            {
            }
            dataitem("Service Invoice Line"; "Service Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord();
                begin
                    TempServInvoiceLine := "Service Invoice Line";
                    TempServInvoiceLine.Insert;
                end;

                trigger OnPreDataItem();
                begin
                    TempServInvoiceLine.Reset;
                    TempServInvoiceLine.DeleteAll;
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
                    column(CompanyInformationPicture; CompanyInformation.Picture)
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
                    column(DueDate_ServInvHeader; "Service Invoice Header"."Due Date")
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
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
                    column(BilltoCustNo_ServInvHdr; "Service Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(YourReference_ServInvHdr; "Service Invoice Header"."Customer PO No.")
                    {
                    }
                    column(OrderDate_ServInvHdr; "Service Invoice Header"."Order Date")
                    {
                    }
                    column(OrderNo_ServInvHdr; "Service Invoice Header"."Order No.")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(DocDate_ServInvHdr; "Service Invoice Header"."Document Date")
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
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(PrintFooter; PrintFooter)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(BillCaption; BillCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(DueDateCaption; DueDateCaptionLbl)
                    {
                    }
                    column(TermsCaption; TermsCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(PODateCaption; PODateCaptionLbl)
                    {
                    }
                    column(OurOrderNoCaption; OurOrderNoCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(InvoiceCaption; InvoiceCaptionLbl)
                    {
                    }
                    column(InvoiceNumberCaption; InvoiceNumberCaptionLbl)
                    {
                    }
                    column(InvoiceDateCaption; InvoiceDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(Resource1_ServiceInvoiceHeader; "Service Invoice Header"."Resource 1")
                    {
                    }
                    column(Resource2_ServiceInvoiceHeader; "Service Invoice Header"."Resource 2")
                    {
                    }
                    column(ResponseDate_ServiceInvoiceHeader; "Service Invoice Header"."Service Date")
                    {
                    }
                    column(Resource1_ServiceInvoiceHeader_Caption; "Service Invoice Header".FieldCaption("Resource 1"))
                    {
                    }
                    column(Resource2_ServiceInvoiceHeader_Caption; "Service Invoice Header".FieldCaption("Resource 2"))
                    {
                    }
                    column(ResponseDate_ServiceInvoiceHeader_Caption; "Service Invoice Header".FieldCaption("Service Date"))
                    {
                    }
                    dataitem(ServInvLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(ServInvLineNumber; Number)
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempServInvoiceLineNo; TempServInvoiceLine."No.")
                        {
                        }
                        column(TempServInvLineUOM; TempServInvoiceLine."Unit of Measure")
                        {
                        }
                        column(TempServInvoiceLine_Serv_Item_No; TempServInvoiceLine."Service Item No.")
                        {
                        }
                        column(ServItemRecGbl_Desc; ServItemRecGbl.Description)
                        {
                        }
                        column(TempServInvoiceLine_Service_Item_Serial_No; TempServInvoiceLine."Service Item Serial No.")
                        {
                        }
                        column(ServItemRecGbl_Desc_2; ServItemRecGbl."Description 2")
                        {
                        }
                        column(OrderedQuantity; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempServInvoiceLineQty; TempServInvoiceLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; TempServInvoiceLine."Unit Price")
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(TempServInvLineDescription; TempServInvoiceLine.Description)
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempServInvLineAmtTaxLiable; TempServInvoiceLine.Amount - TaxLiable)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
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
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(TempServInvLineAmtExclInvDisc; TempServInvoiceLine.Amount - AmountExclInvDisc)
                        {
                        }
                        column(TempServInvLineAmtInclVATAmt; TempServInvoiceLine."Amount Including VAT" - TempServInvoiceLine.Amount)
                        {
                        }
                        column(TempServInvLineAmtInclVAT; TempServInvoiceLine."Amount Including VAT")
                        {
                        }
                        column(ItemDescriptionCaption; ItemDescriptionCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(OrderQtyCaption; OrderQtyCaptionLbl)
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
                        column(AmtSubjectToSalesTaxCaption; AmtSubjectToSalesTaxCaptionLbl)
                        {
                        }
                        column(AmtExemptFromSalesTaxCaption; AmtExemptFromSalesTaxCaptionLbl)
                        {
                        }
                        column(InvoiceDiscountCaption; InvoiceDiscountCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        dataitem("Service Shipment Buffer"; "Integer")
                        {
                            DataItemTableView = SORTING(Number);

                            column(ServShpBufferPostingDate; ServiceShipmentBuffer."Posting Date")
                            {
                            }
                            column(ServShpBufferQuantity; ServiceShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ServShpBufferNumber; Number)
                            {
                            }
                            column(ShipmentCaption; ShipmentCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then
                                    ServiceShipmentBuffer.Find('-')
                                else
                                    ServiceShipmentBuffer.Next;
                                if Number > 1 then begin
                                    TaxLiable := 0;
                                    AmountExclInvDisc := 0;
                                    TempServInvoiceLine.Amount := 0;
                                    TempServInvoiceLine."Amount Including VAT" := 0;
                                end
                            end;

                            trigger OnPreDataItem();
                            begin
                                ServiceShipmentBuffer.SetRange("Document No.", "Service Invoice Line"."Document No.");
                                ServiceShipmentBuffer.SetRange("Line No.", "Service Invoice Line"."Line No.");
                                SetRange(Number, 1, ServiceShipmentBuffer.Count);
                            end;
                        }
                        trigger OnAfterGetRecord();
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            if OnLineNumber = 1 then
                                TempServInvoiceLine.Find('-')
                            else
                                TempServInvoiceLine.Next;
                            OrderedQuantity := 0;
                            if "Service Invoice Header"."Order No." = '' then
                                OrderedQuantity := TempServInvoiceLine.Quantity
                            else if OrderLine.Get(1, "Service Invoice Header"."Order No.", TempServInvoiceLine."Line No.") then
                                OrderedQuantity := OrderLine.Quantity
                            else begin
                                ShipmentLine.SetRange("Order No.", "Service Invoice Header"."Order No.");
                                ShipmentLine.SetRange("Order Line No.", TempServInvoiceLine."Line No.");
                                if ShipmentLine.Find('-') then
                                    repeat
                                        OrderedQuantity := OrderedQuantity + ShipmentLine.Quantity;
                                    until 0 = ShipmentLine.Next;
                            end;
                            DescriptionToPrint := TempServInvoiceLine.Description + ' ' + TempServInvoiceLine."Description 2";
                            if TempServInvoiceLine.Type.AsInteger() = 0 then begin
                                if OnLineNumber < NumberOfLines then begin
                                    TempServInvoiceLine.Next;
                                    if TempServInvoiceLine.Type.AsInteger() = 0 then begin
                                        DescriptionToPrint := CopyStr(DescriptionToPrint + ' ' + TempServInvoiceLine.Description + ' ' + TempServInvoiceLine."Description 2", 1, MaxStrLen(DescriptionToPrint));
                                        OnLineNumber := OnLineNumber + 1;
                                        ServInvLine.Next;
                                    end
                                    else
                                        TempServInvoiceLine.Next(-1);
                                end;
                                TempServInvoiceLine."No." := '';
                                TempServInvoiceLine."Unit of Measure" := '';
                                TempServInvoiceLine.Amount := 0;
                                TempServInvoiceLine."Amount Including VAT" := 0;
                                TempServInvoiceLine."Inv. Discount Amount" := 0;
                                TempServInvoiceLine.Quantity := 0;
                            end
                            else if TempServInvoiceLine.Type = TempServInvoiceLine.Type::"G/L Account" then TempServInvoiceLine."No." := '';
                            if TempServInvoiceLine.Amount <> TempServInvoiceLine."Amount Including VAT" then
                                TaxLiable := TempServInvoiceLine.Amount
                            else
                                TaxLiable := 0;
                            AmountExclInvDisc := TempServInvoiceLine.Amount + TempServInvoiceLine."Inv. Discount Amount";
                            if TempServInvoiceLine.Quantity = 0 then
                                UnitPriceToPrint := 0 // so it won't print
                            else
                                UnitPriceToPrint := Round(AmountExclInvDisc / TempServInvoiceLine.Quantity, 0.00001);
                            if ServItemRecGbl.Get(TempServInvoiceLine."Service Item No.") then; //IMP1.02
                            if OnLineNumber = NumberOfLines then PrintFooter := true;
                        end;

                        trigger OnPreDataItem();
                        begin
                            Clear(TaxLiable);
                            Clear(AmountExclInvDisc);
                            NumberOfLines := TempServInvoiceLine.Count;
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                    dataitem(LineFee; "Integer")
                    {
                        DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 ..));

                        column(LineFeeCaptionLbl; TempLineFeeNoteOnReportHist.ReportText)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            if not DisplayAdditionalFeeNote then CurrReport.Break;
                            if Number = 1 then begin
                                if not TempLineFeeNoteOnReportHist.FindSet then CurrReport.Break
                            end
                            else if TempLineFeeNoteOnReportHist.Next = 0 then CurrReport.Break;
                        end;
                    }
                }
                trigger OnAfterGetRecord();
                begin
                    //CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then ServiceInvCountPrinted.Run("Service Invoice Header");
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
                    NoLoops := 1 + Abs(NoCopies) + Customer."Invoice Copies";
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
                        CompanyAddress[9] := 'Phone: ' + RespCenter."Phone No.";
                        CompanyAddress[10] := 'Fax: ' + RespCenter."Phone No.";
                    end;
                //CurrReport.Language := Language.GetLanguageID("Language Code");
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                //?????
                //IF "Order No." = '' THEN
                //  OrderNoText := ''
                //ELSE
                //  OrderNoText := FIELDCAPTION("Order No.");
                if "Salesperson Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");
                if not Customer.Get("Bill-to Customer No.") then begin
                    Clear(Customer);
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                end;
                GetLineFeeNoteOnReportHist("No.");
                FormatAddress.ServiceInvBillTo(BillToAddress, "Service Invoice Header");
                FormatAddress.ServiceInvShipTo(ShipToAddress, ShipToAddress, "Service Invoice Header");
                if "Payment Terms Code" = '' then
                    Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");
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
                    SalesTaxCalc.StartSalesTaxCalculation;
                    if TaxArea."Use External Tax Engine" then
                        SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Service Invoice Header", 0, "No.")
                    else begin
                        SalesTaxCalc.AddServInvoiceLines("No.");
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

                    field(NumberOfCopies; NoCopies)
                    {
                        ApplicationArea = Service;
                        CaptionML = ENU = 'Number of Copies', ESM = 'Número de copias', FRC = 'Nombre de copies', ENC = 'Number of Copies';
                        ToolTipML = ENU = 'Specifies the number of copies to print of the document.', ESM = 'Especifica el número de copias del documento que se imprimirán.', FRC = 'Spécifie le nombre de copies du document à imprimer.', ENC = 'Specifies the number of copies to print of the document.';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = Service;
                        CaptionML = ENU = 'Print Company Address', ESM = 'Imprimir dir. empresa', FRC = 'Imprimer l''adresse de la compagnie', ENC = 'Print Company Address';
                        ToolTipML = ENU = 'Specifies if your company address is printed at the top of the sheet, because you do not use pre-printed paper. Leave this check box blank to omit your company''s address.', ESM = 'Especifica si en la parte superior de la hoja se debe imprimir la dirección de la empresa porque no usa papel preimpreso. Deje la casilla en blanco para omitir la dirección de la empresa.', FRC = 'Spécifie si l''adresse de votre compagnie est imprimée en haut de la feuille, car vous n''utilisez pas de papier préimprimé. Décochez cette case pour ne pas imprimer l''adresse de votre compagnie.', ENC = 'Specifies if your company address is printed at the top of the sheet, because you do not use pre-printed paper. Leave this check box blank to omit your company''s address.';
                    }
                    field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = Service;
                        CaptionML = ENU = 'Show Additional Fee Note', ESM = 'Mostrar nota recargo', FRC = 'Afficher la note de frais supplémentaires', ENC = 'Show Additional Fee Note';
                        ToolTipML = ENU = 'Specifies if you want notes about additional fees to be shown on the document.', ESM = 'Especifica si desea que las notas sobre los recargos se muestren en el documento.', FRC = 'Spécifie si vous souhaitez que des notes relatives aux frais supplémentaires soient affichées sur le document.', ENC = 'Specifies if you want notes about additional fees to be shown on the document.';
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
        // ShipmentLine.SETCURRENTKEY("Order No.","Order Line No.");
        GLSetup.Get;
        CompanyInformation.Get;
        ServiceSetup.Get;
        case ServiceSetup."Logo Position on Documents" of
            ServiceSetup."Logo Position on Documents"::"No Logo":
                ;
            ServiceSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo3.Get;
                    CompanyInfo3.CalcFields(Picture);
                end;
            ServiceSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.Get;
                    CompanyInfo1.CalcFields(Picture);
                end;
            ServiceSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.Get;
                    CompanyInfo2.CalcFields(Picture);
                end;
        end;
        if PrintCompany then
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
        CompanyAddress[1] := '';
        CompanyAddress[9] := 'Phone: ' + CompanyInformation."Phone No.";
        CompanyAddress[10] := 'Fax: ' + CompanyInformation."Fax No.";
        CompressArray(CompanyAddress);
        CustCu.CompanyRemit(CompanyAddressRemit, CompanyInformation);
    end;

    var
        CustCu: Codeunit 90000;
        TaxLiable: Decimal;
        OrderedQuantity: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        ServiceSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        OrderLine: Record "Service Line";
        ShipmentLine: Record "Service Shipment Line";
        TempServInvoiceLine: Record "Service Invoice Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        LanguageRec: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        TaxArea: Record "Tax Area";
        CompanyAddress: array[10] of Text[100];
        BillToAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        CopyTxt: Text[10];
        DescriptionToPrint: Text[210];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        ServiceShipmentBuffer: Record "Service Shipment Buffer" temporary;
        ServiceInvCountPrinted: Codeunit "Service Inv.-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        Text000: TextConst ENU = 'COPY', ESM = 'COPIA', FRC = 'COPIER', ENC = 'COPY';
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        Text003: TextConst ENU = 'Sales Tax Breakdown:', ESM = 'Análisis impto. vtas.:', FRC = 'Ventilation taxe de vente :', ENC = 'Sales Tax Breakdown:';
        Text004: TextConst ENU = 'Other Taxes', ESM = 'Otros impuestos', FRC = 'Autres taxes', ENC = 'Other Taxes';
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        Text005: TextConst ENU = 'Total Sales Tax:', ESM = 'Total impto. vtas.:', FRC = 'Taxes de vente totales:', ENC = 'Total Sales Tax:';
        Text006: TextConst ENU = 'Tax Breakdown:', ESM = 'Desglose imptos.:', FRC = 'Ventilation fiscale :', ENC = 'Tax Breakdown:';
        Text007: TextConst ENU = 'Total Tax:', ESM = 'Total impto.:', FRC = 'Taxe totale :', ENC = 'Total Tax:';
        Text008: TextConst ENU = 'Tax:', ESM = 'Impuesto:', FRC = 'Taxe :', ENC = 'Tax:';
        Text009: TextConst ENU = 'Void Invoice', ESM = 'Anular factura', FRC = 'Annuler facture', ENC = 'Void Invoice';
        BillCaptionLbl: TextConst ENU = 'Bill', ESM = 'Facturar', FRC = 'Facturer', ENC = 'Bill';
        ToCaptionLbl: TextConst ENU = 'To:', ESM = 'Para:', FRC = '‡ :', ENC = 'To:';
        DueDateCaptionLbl: TextConst ENU = 'Due Date', ESM = 'Fecha vencimiento', FRC = 'Date d''échéance', ENC = 'Due Date';
        TermsCaptionLbl: TextConst ENU = 'Terms', ESM = 'Términos', FRC = 'Modalités', ENC = 'Terms';
        CustomerIDCaptionLbl: TextConst ENU = 'Customer ID', ESM = 'Id. cliente', FRC = 'Code de client', ENC = 'Customer ID';
        PONumberCaptionLbl: TextConst ENU = 'P.O. Number', ESM = 'Número pedido compra', FRC = 'N° de bon de commande', ENC = 'P.O. Number';
        PODateCaptionLbl: TextConst ENU = 'P.O. Date', ESM = 'Fecha pedido compra', FRC = 'Date du bon de commande', ENC = 'P.O. Date';
        OurOrderNoCaptionLbl: TextConst ENU = 'Our Order No.', ESM = 'Nuestro pedido N°', FRC = 'Notre n° de commande', ENC = 'Our Order No.';
        SalesPersonCaptionLbl: TextConst ENU = 'SalesPerson', ESM = 'Vendedor', FRC = 'Représentant', ENC = 'SalesPerson';
        ShipCaptionLbl: TextConst ENU = 'Ship', ESM = 'Enviar', FRC = 'Livrer', ENC = 'Ship';
        InvoiceCaptionLbl: TextConst ENU = 'Service Invoice', ESM = 'Factura', FRC = 'Facture', ENC = 'Invoice';
        InvoiceNumberCaptionLbl: TextConst ENU = 'Invoice Number:', ESM = 'Número factura:', FRC = 'Numéro de facture :', ENC = 'Invoice Number:';
        InvoiceDateCaptionLbl: TextConst ENU = 'Invoice Date:', ESM = 'Fecha factura:', FRC = 'Date de la facture :', ENC = 'Invoice Date:';
        PageCaptionLbl: TextConst ENU = 'Page:', ESM = 'Pág.:', FRC = 'Page :', ENC = 'Page:';
        ItemDescriptionCaptionLbl: TextConst ENU = 'Item/Description', ESM = 'Producto/descripción', FRC = 'Article/Description', ENC = 'Item/Description';
        UnitCaptionLbl: TextConst ENU = 'Unit', ESM = 'Unidad', FRC = 'Unité', ENC = 'Unit';
        OrderQtyCaptionLbl: TextConst ENU = 'Order Qty', ESM = 'Cantidad pedido', FRC = 'Qté commande', ENC = 'Order Qty';
        QuantityCaptionLbl: TextConst ENU = 'Quantity', ESM = 'Cantidad', FRC = 'Quantité', ENC = 'Quantity';
        UnitPriceCaptionLbl: TextConst ENU = 'Unit Price', ESM = 'Precio unitario', FRC = 'Prix unitaire', ENC = 'Unit Price';
        TotalPriceCaptionLbl: TextConst ENU = 'Total Price', ESM = 'Precio total', FRC = 'Prix total', ENC = 'Total Price';
        AmtSubjectToSalesTaxCaptionLbl: TextConst ENU = 'Amount Subject to Sales Tax', ESM = 'Importe sujeto a impuestos de ventas', FRC = 'Montant assujetti à la taxe de vente', ENC = 'Amount Subject to Sales Tax';
        AmtExemptFromSalesTaxCaptionLbl: TextConst ENU = 'Amount Exempt from Sales Tax', ESM = 'Importe exento de impuestos de ventas', FRC = 'Montant exonéré de la taxe de vente', ENC = 'Amount Exempt from Sales Tax';
        InvoiceDiscountCaptionLbl: TextConst ENU = 'Invoice Discount:', ESM = 'Descuento factura:', FRC = 'Escompte de la facture :', ENC = 'Invoice Discount:';
        SubtotalCaptionLbl: TextConst ENU = 'Subtotal:', ESM = 'Subtotal:', FRC = 'Sous-total :', ENC = 'Subtotal:';
        TotalCaptionLbl: TextConst ENU = 'Total:', ESM = 'Total:', FRC = 'Total :', ENC = 'Total:';
        ShipmentCaptionLbl: TextConst ENU = 'Shipment', ESM = 'Envío', FRC = 'Livraison', ENC = 'Shipment';
        DisplayAdditionalFeeNote: Boolean;
        "-IMP1.01-": Integer;
        CompanyAddressRemit: array[8] of Text[50];
        "-IMP1.02-": Integer;
        ServItemRecGbl: Record "Service Item";

    procedure FindPostedShipmentDate(): Date;
    var
        ServiceShipmentHeader: Record "Service Shipment Header";
        ServiceShipmentBuffer2: Record "Service Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        if "Service Invoice Line"."Shipment No." <> '' then if ServiceShipmentHeader.Get("Service Invoice Line"."Shipment No.") then exit(ServiceShipmentHeader."Posting Date");
        if "Service Invoice Header"."Order No." = '' then exit("Service Invoice Header"."Posting Date");
        case "Service Invoice Line".Type of
            "Service Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Service Invoice Line");
            "Service Invoice Line".Type::"G/L Account", "Service Invoice Line".Type::Resource, "Service Invoice Line".Type::Cost:
                GenerateBufferFromShipment("Service Invoice Line");
            "Service Invoice Line".Type::" ":
                exit(0D);
        end;
        ServiceShipmentBuffer.Reset;
        ServiceShipmentBuffer.SetRange("Document No.", "Service Invoice Line"."Document No.");
        ServiceShipmentBuffer.SetRange("Line No.", "Service Invoice Line"."Line No.");
        if ServiceShipmentBuffer.Find('-') then begin
            ServiceShipmentBuffer2 := ServiceShipmentBuffer;
            if ServiceShipmentBuffer.Next = 0 then begin
                ServiceShipmentBuffer.Get(ServiceShipmentBuffer2."Document No.", ServiceShipmentBuffer2."Line No.", ServiceShipmentBuffer2."Entry No.");
                ServiceShipmentBuffer.Delete;
                exit(ServiceShipmentBuffer2."Posting Date");
            end;
            ServiceShipmentBuffer.CalcSums(Quantity);
            if ServiceShipmentBuffer.Quantity <> "Service Invoice Line".Quantity then begin
                ServiceShipmentBuffer.DeleteAll;
                exit("Service Invoice Header"."Posting Date");
            end;
        end
        else
            exit("Service Invoice Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(ServiceInvoiceLine2: Record "Service Invoice Line");
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := ServiceInvoiceLine2."Quantity (Base)";
        ValueEntry.SetCurrentKey("Document No.");
        ValueEntry.SetRange("Document No.", ServiceInvoiceLine2."Document No.");
        ValueEntry.SetRange("Posting Date", "Service Invoice Header"."Posting Date");
        ValueEntry.SetRange("Item Charge No.", '');
        ValueEntry.SetFilter("Entry No.", '%1..', FirstValueEntryNo);
        if ValueEntry.Find('-') then
            repeat
                if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                    if ServiceInvoiceLine2."Qty. per Unit of Measure" <> 0 then
                        Quantity := ValueEntry."Invoiced Quantity" / ServiceInvoiceLine2."Qty. per Unit of Measure"
                    else
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(ServiceInvoiceLine2, -Quantity, ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            until (ValueEntry.Next = 0) or (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(ServiceInvoiceLine: Record "Service Invoice Line");
    var
        ServiceInvoiceHeader: Record "Service Invoice Header";
        ServiceInvoiceLine2: Record "Service Invoice Line";
        ServiceShipmentHeader: Record "Service Shipment Header";
        ServiceShipmentLine: Record "Service Shipment Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        ServiceInvoiceHeader.SetCurrentKey("Order No.");
        ServiceInvoiceHeader.SetFilter("No.", '..%1', "Service Invoice Header"."No.");
        ServiceInvoiceHeader.SetRange("Order No.", "Service Invoice Header"."Order No.");
        if ServiceInvoiceHeader.Find('-') then
            repeat
                ServiceInvoiceLine2.SetRange("Document No.", ServiceInvoiceHeader."No.");
                ServiceInvoiceLine2.SetRange("Line No.", ServiceInvoiceLine."Line No.");
                ServiceInvoiceLine2.SetRange(Type, ServiceInvoiceLine.Type);
                ServiceInvoiceLine2.SetRange("No.", ServiceInvoiceLine."No.");
                ServiceInvoiceLine2.SetRange("Unit of Measure Code", ServiceInvoiceLine."Unit of Measure Code");
                if ServiceInvoiceLine2.Find('-') then
                    repeat
                        TotalQuantity := TotalQuantity + ServiceInvoiceLine2.Quantity;
                    until ServiceInvoiceLine2.Next = 0;
            until ServiceInvoiceHeader.Next = 0;
        ServiceShipmentLine.SetCurrentKey("Order No.", "Order Line No.");
        ServiceShipmentLine.SetRange("Order No.", "Service Invoice Header"."Order No.");
        ServiceShipmentLine.SetRange("Order Line No.", ServiceInvoiceLine."Line No.");
        ServiceShipmentLine.SetRange("Line No.", ServiceInvoiceLine."Line No.");
        ServiceShipmentLine.SetRange(Type, ServiceInvoiceLine.Type);
        ServiceShipmentLine.SetRange("No.", ServiceInvoiceLine."No.");
        ServiceShipmentLine.SetRange("Unit of Measure Code", ServiceInvoiceLine."Unit of Measure Code");
        ServiceShipmentLine.SetFilter(Quantity, '<>%1', 0);
        if ServiceShipmentLine.Find('-') then
            repeat
                if Abs(ServiceShipmentLine.Quantity) <= Abs(TotalQuantity - ServiceInvoiceLine.Quantity) then
                    TotalQuantity := TotalQuantity - ServiceShipmentLine.Quantity
                else begin
                    if Abs(ServiceShipmentLine.Quantity) > Abs(TotalQuantity) then ServiceShipmentLine.Quantity := TotalQuantity;
                    Quantity := ServiceShipmentLine.Quantity - (TotalQuantity - ServiceInvoiceLine.Quantity);
                    TotalQuantity := TotalQuantity - ServiceShipmentLine.Quantity;
                    ServiceInvoiceLine.Quantity := ServiceInvoiceLine.Quantity - Quantity;
                    if ServiceShipmentHeader.Get(ServiceShipmentLine."Document No.") then AddBufferEntry(ServiceInvoiceLine, Quantity, ServiceShipmentHeader."Posting Date");
                end;
            until (ServiceShipmentLine.Next = 0) or (TotalQuantity = 0);
    end;

    procedure AddBufferEntry(ServiceInvoiceLine: Record "Service Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date);
    begin
        ServiceShipmentBuffer.SetRange("Document No.", ServiceInvoiceLine."Document No.");
        ServiceShipmentBuffer.SetRange("Line No.", ServiceInvoiceLine."Line No.");
        ServiceShipmentBuffer.SetRange("Posting Date", PostingDate);
        if ServiceShipmentBuffer.Find('-') then begin
            ServiceShipmentBuffer.Quantity := ServiceShipmentBuffer.Quantity + QtyOnShipment;
            ServiceShipmentBuffer.Modify;
            exit;
        end;
        ServiceShipmentBuffer."Document No." := ServiceInvoiceLine."Document No.";
        ServiceShipmentBuffer."Line No." := ServiceInvoiceLine."Line No.";
        ServiceShipmentBuffer."Entry No." := NextEntryNo;
        ServiceShipmentBuffer.Type := ServiceInvoiceLine.Type;
        ServiceShipmentBuffer."No." := ServiceInvoiceLine."No.";
        ServiceShipmentBuffer.Quantity := QtyOnShipment;
        ServiceShipmentBuffer."Posting Date" := PostingDate;
        ServiceShipmentBuffer.Insert;
        NextEntryNo := NextEntryNo + 1
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20]);
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DeleteAll;
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FindFirst then exit;
        if not Customer.Get("Service Invoice Header"."Bill-to Customer No.") then exit;
        LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FindSet then begin
            repeat
                TempLineFeeNoteOnReportHist.Init;
                TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.Insert;
            until LineFeeNoteOnReportHist.Next = 0;
        end
        else begin
            //LineFeeNoteOnReportHist.SetRange("Language Code", Language.GetUserLanguage);//UPG
            if LineFeeNoteOnReportHist.FindSet then
                repeat
                    TempLineFeeNoteOnReportHist.Init;
                    TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.Insert;
                until LineFeeNoteOnReportHist.Next = 0;
        end;
    end;
}
