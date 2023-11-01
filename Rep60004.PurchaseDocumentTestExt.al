report 60004 "Purchase Document - Test Ext"
{
    // version NAVW114.00,NAVNA14.00
    // ISS2.00 02.10.14 DFP - Change to handle Sales Order already posted
    DefaultLayout = RDLC;
    RDLCLayout = './Purchase Document - Test.rdl';
    CaptionML = ENU = 'Purchase Document - Test', ESM = 'Documento compras - Prueba', FRC = 'Document d''achat - Test', ENC = 'Purchase Document - Test';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(<> Quote));
            RequestFilterFields = "Document Type", "No.";
            RequestFilterHeadingML = ENU = 'Purchase Document', ESM = 'Documento compra', FRC = 'Document achat', ENC = 'Purchase Document';

            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(STRSUBSTNO_Text018_PurchHeaderFilter_; StrSubstNo(Text018, PurchHeaderFilter))
            {
            }
            column(Summarize; Summarize)
            {
            }
            column(SalesTax; SalesTax)
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            column(Purchase_Header__Vendor_Invoice_No__; "Vendor Invoice No.")
            {
            }
            column(InvoiceAmount; InvoiceAmount)
            {
            }
            column(Purchase_Header__Currency_Code_; "Currency Code")
            {
            }
            column(Buy_from_Vendor_No______________Buy_from_Vendor_Name_; "Buy-from Vendor No." + ' - ' + "Buy-from Vendor Name")
            {
            }
            column(Purchase_Header__Buy_from_Address_; "Buy-from Address")
            {
            }
            column(Buy_from_City____________Buy_from_County___________Buy_from_Post_Code_; "Buy-from City" + ', ' + "Buy-from County" + ' ' + "Buy-from Post Code")
            {
            }
            column(Purchaser_Code____________Purchaser_Name; "Purchaser Code" + ' - ' + Purchaser.Name)
            {
            }
            column(Purchase_Header__Buy_from_Contact_; "Buy-from Contact")
            {
            }
            column(Purchase_Header__Posting_Description_; "Posting Description")
            {
            }
            column(Purchase_Header__Document_Date_; "Document Date")
            {
            }
            column(Purchase_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Purchase_Header__Due_Date_; "Due Date")
            {
            }
            column(Purchase_Header__Shipment_Method_Code_; "Shipment Method Code")
            {
            }
            column(Purchase_Header__Payment_Terms_Code_; "Payment Terms Code")
            {
            }
            column(Purchase_Header_Status; Status)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Purchase_Document___TestCaption; Purchase_Document___TestCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(Vendor_Invoice_No_Caption; Vendor_Invoice_No_CaptionLbl)
            {
            }
            column(Invoice_Amount_Excl__TaxCaption; Invoice_Amount_Excl__TaxCaptionLbl)
            {
            }
            column(Vendor_InformationCaption; Vendor_InformationCaptionLbl)
            {
            }
            column(PurchaserCaption; PurchaserCaptionLbl)
            {
            }
            column(ContactCaption; ContactCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Due_DateCaption; Due_DateCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Doc__DateCaption; Doc__DateCaptionLbl)
            {
            }
            column(ShipmentCaption; ShipmentCaptionLbl)
            {
            }
            column(TermsCaption; TermsCaptionLbl)
            {
            }
            column(StatusCaption; StatusCaptionLbl)
            {
            }
            dataitem(PageCounter; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                column(FORMAT_TODAY_0_4__Control1029001; Format(Today, 0, 4))
                {
                }
                column(TIME_Control1029002; Time)
                {
                }
                column(CompanyInformation_Name_Control1029003; COMPANYPROPERTY.DisplayName)
                {
                }
                column(CurrReport_PAGENO_Control1029005; CurrReport.PageNo)
                {
                }
                column(USERID_Control1029006; UserId)
                {
                }
                column(STRSUBSTNO_Text018_PurchHeaderFilter__Control7; StrSubstNo(Text018, PurchHeaderFilter))
                {
                }
                column(PurchHeaderFilter; PurchHeaderFilter)
                {
                }
                column(ReceiveInvoiceText; ReceiveInvoiceText)
                {
                }
                column(ShipInvoiceText; ShipInvoiceText)
                {
                }
                column(Purchase_Header___Sell_to_Customer_No__; "Purchase Header"."Sell-to Customer No.")
                {
                }
                column(ShipToAddr_1_; ShipToAddr[1])
                {
                }
                column(ShipToAddr_2_; ShipToAddr[2])
                {
                }
                column(ShipToAddr_3_; ShipToAddr[3])
                {
                }
                column(ShipToAddr_4_; ShipToAddr[4])
                {
                }
                column(ShipToAddr_5_; ShipToAddr[5])
                {
                }
                column(ShipToAddr_6_; ShipToAddr[6])
                {
                }
                column(ShipToAddr_7_; ShipToAddr[7])
                {
                }
                column(ShipToAddr_8_; ShipToAddr[8])
                {
                }
                column(FORMAT__Purchase_Header___Document_Type____________Purchase_Header___No__; Format("Purchase Header"."Document Type") + ' ' + "Purchase Header"."No.")
                {
                }
                column(BuyFromAddr_8_; BuyFromAddr[8])
                {
                }
                column(BuyFromAddr_7_; BuyFromAddr[7])
                {
                }
                column(BuyFromAddr_6_; BuyFromAddr[6])
                {
                }
                column(BuyFromAddr_5_; BuyFromAddr[5])
                {
                }
                column(BuyFromAddr_4_; BuyFromAddr[4])
                {
                }
                column(BuyFromAddr_3_; BuyFromAddr[3])
                {
                }
                column(BuyFromAddr_2_; BuyFromAddr[2])
                {
                }
                column(BuyFromAddr_1_; BuyFromAddr[1])
                {
                }
                column(Purchase_Header___Buy_from_Vendor_No__; "Purchase Header"."Buy-from Vendor No.")
                {
                }
                column(Purchase_Header___Document_Type_; Format("Purchase Header"."Document Type", 0, 2))
                {
                }
                column(Purchase_Header___VAT_Base_Discount___; "Purchase Header"."VAT Base Discount %")
                {
                }
                column(PricesInclVATtxt; PricesInclVATtxt)
                {
                }
                column(ShowItemChargeAssgnt; ShowItemChargeAssgnt)
                {
                }
                column(PurchHeaderDocTypeNo; PurchHeaderDocTypeNo)
                {
                }
                column(PayToAddr_1_; PayToAddr[1])
                {
                }
                column(PayToAddr_2_; PayToAddr[2])
                {
                }
                column(PayToAddr_3_; PayToAddr[3])
                {
                }
                column(PayToAddr_4_; PayToAddr[4])
                {
                }
                column(PayToAddr_5_; PayToAddr[5])
                {
                }
                column(PayToAddr_6_; PayToAddr[6])
                {
                }
                column(PayToAddr_7_; PayToAddr[7])
                {
                }
                column(PayToAddr_8_; PayToAddr[8])
                {
                }
                column(Purchase_Header___Pay_to_Vendor_No__; "Purchase Header"."Pay-to Vendor No.")
                {
                }
                column(Purchase_Header___Purchaser_Code_; "Purchase Header"."Purchaser Code")
                {
                }
                column(Purchase_Header___Your_Reference_; "Purchase Header"."Your Reference")
                {
                }
                column(Purchase_Header___Vendor_Posting_Group_; "Purchase Header"."Vendor Posting Group")
                {
                }
                column(Purchase_Header___Posting_Date_; Format("Purchase Header"."Posting Date"))
                {
                }
                column(Purchase_Header___Document_Date_; Format("Purchase Header"."Document Date"))
                {
                }
                column(Purchase_Header___Prices_Including_VAT_; "Purchase Header"."Prices Including VAT")
                {
                }
                column(Purchase_Header___Payment_Terms_Code_; "Purchase Header"."Payment Terms Code")
                {
                }
                column(Purchase_Header___Payment_Discount___; "Purchase Header"."Payment Discount %")
                {
                }
                column(Purchase_Header___Due_Date_; Format("Purchase Header"."Due Date"))
                {
                }
                column(Purchase_Header___Pmt__Discount_Date_; Format("Purchase Header"."Pmt. Discount Date"))
                {
                }
                column(Purchase_Header___Shipment_Method_Code_; "Purchase Header"."Shipment Method Code")
                {
                }
                column(Purchase_Header___Payment_Method_Code_; "Purchase Header"."Payment Method Code")
                {
                }
                column(Purchase_Header___Vendor_Order_No__; "Purchase Header"."Vendor Order No.")
                {
                }
                column(Purchase_Header___Vendor_Shipment_No__; "Purchase Header"."Vendor Shipment No.")
                {
                }
                column(Purchase_Header___Vendor_Invoice_No__; "Purchase Header"."Vendor Invoice No.")
                {
                }
                column(Purchase_Header___Vendor_Posting_Group__Control104; "Purchase Header"."Vendor Posting Group")
                {
                }
                column(Purchase_Header___Posting_Date__Control106; Format("Purchase Header"."Posting Date"))
                {
                }
                column(Purchase_Header___Document_Date__Control107; Format("Purchase Header"."Document Date"))
                {
                }
                column(Purchase_Header___Order_Date_; Format("Purchase Header"."Order Date"))
                {
                }
                column(Purchase_Header___Expected_Receipt_Date_; Format("Purchase Header"."Expected Receipt Date"))
                {
                }
                column(Purchase_Header___Prices_Including_VAT__Control212; "Purchase Header"."Prices Including VAT")
                {
                }
                column(Purchase_Header___Payment_Discount____Control14; "Purchase Header"."Payment Discount %")
                {
                }
                column(Purchase_Header___Payment_Terms_Code__Control18; "Purchase Header"."Payment Terms Code")
                {
                }
                column(Purchase_Header___Due_Date__Control19; Format("Purchase Header"."Due Date"))
                {
                }
                column(Purchase_Header___Pmt__Discount_Date__Control22; Format("Purchase Header"."Pmt. Discount Date"))
                {
                }
                column(Purchase_Header___Payment_Method_Code__Control30; "Purchase Header"."Payment Method Code")
                {
                }
                column(Purchase_Header___Shipment_Method_Code__Control33; "Purchase Header"."Shipment Method Code")
                {
                }
                column(Purchase_Header___Vendor_Shipment_No___Control34; "Purchase Header"."Vendor Shipment No.")
                {
                }
                column(Purchase_Header___Vendor_Invoice_No___Control35; "Purchase Header"."Vendor Invoice No.")
                {
                }
                column(Purchase_Header___Vendor_Posting_Group__Control110; "Purchase Header"."Vendor Posting Group")
                {
                }
                column(Purchase_Header___Posting_Date__Control112; Format("Purchase Header"."Posting Date"))
                {
                }
                column(Purchase_Header___Document_Date__Control113; Format("Purchase Header"."Document Date"))
                {
                }
                column(Purchase_Header___Prices_Including_VAT__Control214; "Purchase Header"."Prices Including VAT")
                {
                }
                column(Purchase_Header___Vendor_Cr__Memo_No__; "Purchase Header"."Vendor Cr. Memo No.")
                {
                }
                column(Purchase_Header___Applies_to_Doc__Type_; "Purchase Header"."Applies-to Doc. Type")
                {
                }
                column(Purchase_Header___Applies_to_Doc__No__; "Purchase Header"."Applies-to Doc. No.")
                {
                }
                column(Purchase_Header___Vendor_Posting_Group__Control128; "Purchase Header"."Vendor Posting Group")
                {
                }
                column(Purchase_Header___Posting_Date__Control130; Format("Purchase Header"."Posting Date"))
                {
                }
                column(Purchase_Header___Document_Date__Control131; Format("Purchase Header"."Document Date"))
                {
                }
                column(Purchase_Header___Prices_Including_VAT__Control216; "Purchase Header"."Prices Including VAT")
                {
                }
                column(PageCounter_Number; Number)
                {
                }
                column(Purchase_Document___TestCaption_Control1; Purchase_Document___TestCaption_Control1Lbl)
                {
                }
                column(CurrReport_PAGENO_Control1029005Caption; CurrReport_PAGENO_Control1029005CaptionLbl)
                {
                }
                column(Purchase_Header___Sell_to_Customer_No__Caption; "Purchase Header".FieldCaption("Sell-to Customer No."))
                {
                }
                column(Ship_toCaption; Ship_toCaptionLbl)
                {
                }
                column(Buy_fromCaption; Buy_fromCaptionLbl)
                {
                }
                column(Purchase_Header___Buy_from_Vendor_No__Caption; "Purchase Header".FieldCaption("Buy-from Vendor No."))
                {
                }
                column(Pay_toCaption; Pay_toCaptionLbl)
                {
                }
                column(Purchase_Header___Pay_to_Vendor_No__Caption; "Purchase Header".FieldCaption("Pay-to Vendor No."))
                {
                }
                column(Purchase_Header___Purchaser_Code_Caption; "Purchase Header".FieldCaption("Purchaser Code"))
                {
                }
                column(Purchase_Header___Your_Reference_Caption; "Purchase Header".FieldCaption("Your Reference"))
                {
                }
                column(Purchase_Header___Vendor_Posting_Group_Caption; "Purchase Header".FieldCaption("Vendor Posting Group"))
                {
                }
                column(Purchase_Header___Posting_Date_Caption; Purchase_Header___Posting_Date_CaptionLbl)
                {
                }
                column(Purchase_Header___Document_Date_Caption; Purchase_Header___Document_Date_CaptionLbl)
                {
                }
                column(Purchase_Header___Prices_Including_VAT_Caption; "Purchase Header".FieldCaption("Prices Including VAT"))
                {
                }
                column(Purchase_Header___Payment_Terms_Code_Caption; "Purchase Header".FieldCaption("Payment Terms Code"))
                {
                }
                column(Purchase_Header___Payment_Discount___Caption; "Purchase Header".FieldCaption("Payment Discount %"))
                {
                }
                column(Purchase_Header___Due_Date_Caption; Purchase_Header___Due_Date_CaptionLbl)
                {
                }
                column(Purchase_Header___Pmt__Discount_Date_Caption; Purchase_Header___Pmt__Discount_Date_CaptionLbl)
                {
                }
                column(Purchase_Header___Shipment_Method_Code_Caption; "Purchase Header".FieldCaption("Shipment Method Code"))
                {
                }
                column(Purchase_Header___Payment_Method_Code_Caption; "Purchase Header".FieldCaption("Payment Method Code"))
                {
                }
                column(Purchase_Header___Vendor_Order_No__Caption; "Purchase Header".FieldCaption("Vendor Order No."))
                {
                }
                column(Purchase_Header___Vendor_Shipment_No__Caption; "Purchase Header".FieldCaption("Vendor Shipment No."))
                {
                }
                column(Purchase_Header___Vendor_Invoice_No__Caption; "Purchase Header".FieldCaption("Vendor Invoice No."))
                {
                }
                column(Purchase_Header___Vendor_Posting_Group__Control104Caption; "Purchase Header".FieldCaption("Vendor Posting Group"))
                {
                }
                column(Purchase_Header___Posting_Date__Control106Caption; Purchase_Header___Posting_Date__Control106CaptionLbl)
                {
                }
                column(Purchase_Header___Document_Date__Control107Caption; Purchase_Header___Document_Date__Control107CaptionLbl)
                {
                }
                column(Purchase_Header___Order_Date_Caption; Purchase_Header___Order_Date_CaptionLbl)
                {
                }
                column(Purchase_Header___Expected_Receipt_Date_Caption; Purchase_Header___Expected_Receipt_Date_CaptionLbl)
                {
                }
                column(Purchase_Header___Prices_Including_VAT__Control212Caption; "Purchase Header".FieldCaption("Prices Including VAT"))
                {
                }
                column(Purchase_Header___Payment_Discount____Control14Caption; "Purchase Header".FieldCaption("Payment Discount %"))
                {
                }
                column(Purchase_Header___Payment_Terms_Code__Control18Caption; "Purchase Header".FieldCaption("Payment Terms Code"))
                {
                }
                column(Purchase_Header___Due_Date__Control19Caption; Purchase_Header___Due_Date__Control19CaptionLbl)
                {
                }
                column(Purchase_Header___Pmt__Discount_Date__Control22Caption; Purchase_Header___Pmt__Discount_Date__Control22CaptionLbl)
                {
                }
                column(Purchase_Header___Payment_Method_Code__Control30Caption; "Purchase Header".FieldCaption("Payment Method Code"))
                {
                }
                column(Purchase_Header___Shipment_Method_Code__Control33Caption; "Purchase Header".FieldCaption("Shipment Method Code"))
                {
                }
                column(Purchase_Header___Vendor_Shipment_No___Control34Caption; "Purchase Header".FieldCaption("Vendor Shipment No."))
                {
                }
                column(Purchase_Header___Vendor_Invoice_No___Control35Caption; "Purchase Header".FieldCaption("Vendor Invoice No."))
                {
                }
                column(Purchase_Header___Vendor_Posting_Group__Control110Caption; "Purchase Header".FieldCaption("Vendor Posting Group"))
                {
                }
                column(Purchase_Header___Posting_Date__Control112Caption; Purchase_Header___Posting_Date__Control112CaptionLbl)
                {
                }
                column(Purchase_Header___Document_Date__Control113Caption; Purchase_Header___Document_Date__Control113CaptionLbl)
                {
                }
                column(Purchase_Header___Prices_Including_VAT__Control214Caption; "Purchase Header".FieldCaption("Prices Including VAT"))
                {
                }
                column(Purchase_Header___Vendor_Cr__Memo_No__Caption; "Purchase Header".FieldCaption("Vendor Cr. Memo No."))
                {
                }
                column(Purchase_Header___Applies_to_Doc__Type_Caption; "Purchase Header".FieldCaption("Applies-to Doc. Type"))
                {
                }
                column(Purchase_Header___Applies_to_Doc__No__Caption; "Purchase Header".FieldCaption("Applies-to Doc. No."))
                {
                }
                column(Purchase_Header___Vendor_Posting_Group__Control128Caption; "Purchase Header".FieldCaption("Vendor Posting Group"))
                {
                }
                column(Purchase_Header___Posting_Date__Control130Caption; Purchase_Header___Posting_Date__Control130CaptionLbl)
                {
                }
                column(Purchase_Header___Document_Date__Control131Caption; Purchase_Header___Document_Date__Control131CaptionLbl)
                {
                }
                column(Purchase_Header___Prices_Including_VAT__Control216Caption; "Purchase Header".FieldCaption("Prices Including VAT"))
                {
                }
                dataitem(DimensionLoop1; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                    column(DimText; DimText)
                    {
                    }
                    column(DimensionLoop1_Number; Number)
                    {
                    }
                    column(DimText_Control163; DimText)
                    {
                    }
                    column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        if Number = 1 then begin
                            if not DimSetEntry1.FindFirst then CurrReport.Break;
                        end
                        else
                            if not Continue then CurrReport.Break;
                        DimText := '';
                        Continue := false;
                        repeat
                            OldDimText := DimText;
                            if DimText = '' then
                                DimText := StrSubstNo('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                            else
                                DimText := StrSubstNo('%1; %2 - %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                            if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                DimText := OldDimText;
                                Continue := true;
                                exit;
                            end;
                        until (DimSetEntry1.Next = 0);
                    end;

                    trigger OnPreDataItem();
                    begin
                        if not ShowDim then CurrReport.Break;
                    end;
                }
                dataitem(HeaderErrorCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);

                    column(ErrorText_Number_; ErrorText[Number])
                    {
                    }
                    column(HeaderErrorCounter_Number; Number)
                    {
                    }
                    column(ErrorText_Number_Caption; ErrorText_Number_CaptionLbl)
                    {
                    }
                    trigger OnPostDataItem();
                    begin
                        ErrorCounter := 0;
                    end;

                    trigger OnPreDataItem();
                    begin
                        SetRange(Number, 1, ErrorCounter);
                    end;
                }
                dataitem(CopyLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;

                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        column(Purchase_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Purchase_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Purchase_Line_Line_No_; "Line No.")
                        {
                        }
                        trigger OnPreDataItem();
                        begin
                            if Find('+') then OrigMaxLineNo := "Line No.";
                            CurrReport.Break;
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(QtyToHandleCaption; QtyToHandleCaption)
                        {
                        }
                        column(Purchase_Line__Type; Format("Purchase Line".Type))
                        {
                        }
                        column(Purchase_Line___Line_Amount_; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line___VAT_Identifier_; "Purchase Line"."VAT Identifier")
                        {
                        }
                        column(Purchase_Line___Allow_Invoice_Disc__; "Purchase Line"."Allow Invoice Disc.")
                        {
                        }
                        column(Purchase_Line___Line_Discount___; "Purchase Line"."Line Discount %")
                        {
                        }
                        column(Purchase_Line___Direct_Unit_Cost_; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line___Qty__to_Invoice_; "Purchase Line"."Qty. to Invoice")
                        {
                        }
                        column(QtyToHandle; QtyToHandle)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(Purchase_Line__Quantity; "Purchase Line".Quantity)
                        {
                        }
                        column(Purchase_Line__Description; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line___No__; "Purchase Line"."No.")
                        {
                        }
                        column(Purchase_Line___Line_No__; "Purchase Line"."Line No.")
                        {
                        }
                        column(Purchase_Line___Inv__Discount_Amount_; "Purchase Line"."Inv. Discount Amount")
                        {
                        }
                        column(AllowInvDisctxt; AllowInvDisctxt)
                        {
                        }
                        column(TempPurchLine__Inv__Discount_Amount_; -TempPurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TempPurchLine__Line_Amount_; TempPurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(TempPurchLine__Line_Amount____TempPurchLine__Inv__Discount_Amount_; TempPurchLine."Line Amount" - TempPurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TempPurchLine__Line_Amount____TempPurchLine__Inv__Discount_Amount____VATAmount; TempPurchLine."Line Amount" - TempPurchLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TempPurchLine__Line_Amount____TempPurchLine__Inv__Discount_Amount__Control224; TempPurchLine."Line Amount" - TempPurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumInvDiscountAmount; SumInvDiscountAmount)
                        {
                        }
                        column(SumLineAmount; SumLineAmount)
                        {
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control155; TotalInclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText_Control153; TotalExclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount___VATAmount; VATBaseAmount + VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_Control150; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(Purchase_Line___VAT_Identifier_Caption; "Purchase Line".FieldCaption("VAT Identifier"))
                        {
                        }
                        column(Purchase_Line___Allow_Invoice_Disc__Caption; "Purchase Line".FieldCaption("Allow Invoice Disc."))
                        {
                        }
                        column(Purchase_Line___Line_Discount___Caption; Purchase_Line___Line_Discount___CaptionLbl)
                        {
                        }
                        column(Direct_Unit_CostCaption; Direct_Unit_CostCaptionLbl)
                        {
                        }
                        column(Purchase_Line___Qty__to_Invoice_Caption; "Purchase Line".FieldCaption("Qty. to Invoice"))
                        {
                        }
                        column(Purchase_Line__QuantityCaption; "Purchase Line".FieldCaption(Quantity))
                        {
                        }
                        column(Purchase_Line__DescriptionCaption; "Purchase Line".FieldCaption(Description))
                        {
                        }
                        column(Purchase_Line___No__Caption; "Purchase Line".FieldCaption("No."))
                        {
                        }
                        column(Purchase_Line__TypeCaption; "Purchase Line".FieldCaption(Type))
                        {
                        }
                        column(TempPurchLine__Inv__Discount_Amount_Caption; TempPurchLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                            column(DimText_Control165; DimText)
                            {
                            }
                            column(DimensionLoop2_Number; Number)
                            {
                            }
                            column(DimText_Control167; DimText)
                            {
                            }
                            column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindFirst then CurrReport.Break;
                                end
                                else
                                    if not Continue then CurrReport.Break;
                                DimText := '';
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText := StrSubstNo('%1; %2 - %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until (DimSetEntry2.Next = 0);
                            end;

                            trigger OnPostDataItem();
                            begin
                                SumLineAmount := SumLineAmount + TempPurchLine."Line Amount";
                                SumInvDiscountAmount := SumInvDiscountAmount + TempPurchLine."Inv. Discount Amount";
                            end;

                            trigger OnPreDataItem();
                            begin
                                if not ShowDim then CurrReport.Break;
                            end;
                        }
                        dataitem(LineErrorCounter; "Integer")
                        {
                            DataItemTableView = SORTING(Number);

                            column(ErrorText_Number__Control103; ErrorText[Number])
                            {
                            }
                            column(LineErrorCounter_Number; Number)
                            {
                            }
                            column(ErrorText_Number__Control103Caption; ErrorText_Number__Control103CaptionLbl)
                            {
                            }
                            trigger OnPostDataItem();
                            begin
                                ErrorCounter := 0;
                            end;

                            trigger OnPreDataItem();
                            begin
                                SetRange(Number, 1, ErrorCounter);
                            end;
                        }
                        trigger OnAfterGetRecord();
                        var
                            TableID: array[10] of Integer;
                            No: array[10] of Code[20];
                            Fraction: Decimal;
                        begin
                            if Number = 1 then
                                TempPurchLine.Find('-')
                            else
                                TempPurchLine.Next;
                            "Purchase Line" := TempPurchLine;
                            if SalesTax and not HeaderTaxArea."Use External Tax Engine" then begin
                                SalesTaxCalculate.AddPurchLine("Purchase Line");
                            end;
                            if not "Purchase Header"."Prices Including VAT" and ("Purchase Line"."VAT Calculation Type" = "Purchase Line"."VAT Calculation Type"::"Full VAT") then TempPurchLine."Line Amount" := 0;
                            DimSetEntry2.SetRange("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            DimMgt.GetDimensionSet(TempDimSetEntry, "Purchase Line"."Dimension Set ID");
                            if "Purchase Line"."Document Type" in ["Purchase Line"."Document Type"::"Return Order", "Purchase Line"."Document Type"::"Credit Memo"] then begin
                                if "Purchase Line"."Document Type" = "Purchase Line"."Document Type"::"Credit Memo" then begin
                                    if ("Purchase Line"."Return Qty. to Ship" <> "Purchase Line".Quantity) and ("Purchase Line"."Return Shipment No." = '') then AddError(StrSubstNo(Text019, "Purchase Line".FieldCaption("Return Qty. to Ship"), "Purchase Line".Quantity));
                                    if "Purchase Line"."Qty. to Invoice" <> "Purchase Line".Quantity then AddError(StrSubstNo(Text019, "Purchase Line".FieldCaption("Qty. to Invoice"), "Purchase Line".Quantity));
                                end;
                                if "Purchase Line"."Qty. to Receive" <> 0 then AddError(StrSubstNo(Text040, "Purchase Line".FieldCaption("Qty. to Receive")));
                            end
                            else begin
                                if "Purchase Line"."Document Type" = "Purchase Line"."Document Type"::Invoice then begin
                                    if ("Purchase Line"."Qty. to Receive" <> "Purchase Line".Quantity) and ("Purchase Line"."Receipt No." = '') then AddError(StrSubstNo(Text019, "Purchase Line".FieldCaption("Qty. to Receive"), "Purchase Line".Quantity));
                                    if "Purchase Line"."Qty. to Invoice" <> "Purchase Line".Quantity then AddError(StrSubstNo(Text019, "Purchase Line".FieldCaption("Qty. to Invoice"), "Purchase Line".Quantity));
                                end;
                                if "Purchase Line"."Return Qty. to Ship" <> 0 then AddError(StrSubstNo(Text040, "Purchase Line".FieldCaption("Return Qty. to Ship")));
                            end;
                            if not "Purchase Header".Receive then "Purchase Line"."Qty. to Receive" := 0;
                            if not "Purchase Header".Ship then "Purchase Line"."Return Qty. to Ship" := 0;
                            if ("Purchase Line"."Document Type" = "Purchase Line"."Document Type"::Invoice) and ("Purchase Line"."Receipt No." <> '') then begin
                                "Purchase Line"."Quantity Received" := "Purchase Line".Quantity;
                                "Purchase Line"."Qty. to Receive" := 0;
                            end;
                            if ("Purchase Line"."Document Type" = "Purchase Line"."Document Type"::"Credit Memo") and ("Purchase Line"."Return Shipment No." <> '') then begin
                                "Purchase Line"."Return Qty. Shipped" := "Purchase Line".Quantity;
                                "Purchase Line"."Return Qty. to Ship" := 0;
                            end;
                            if "Purchase Header".Invoice then begin
                                if "Purchase Line"."Document Type" = "Purchase Line"."Document Type"::"Credit Memo" then
                                    MaxQtyToBeInvoiced := "Purchase Line"."Return Qty. to Ship" + "Purchase Line"."Return Qty. Shipped" - "Purchase Line"."Quantity Invoiced"
                                else
                                    MaxQtyToBeInvoiced := "Purchase Line"."Qty. to Receive" + "Purchase Line"."Quantity Received" - "Purchase Line"."Quantity Invoiced";
                                if Abs("Purchase Line"."Qty. to Invoice") > Abs(MaxQtyToBeInvoiced) then "Purchase Line"."Qty. to Invoice" := MaxQtyToBeInvoiced;
                            end
                            else
                                "Purchase Line"."Qty. to Invoice" := 0;
                            if "Purchase Header".Receive then begin
                                QtyToHandle := "Purchase Line"."Qty. to Receive";
                                QtyToHandleCaption := "Purchase Line".FieldCaption("Qty. to Receive");
                            end;
                            if "Purchase Header".Ship then begin
                                QtyToHandle := "Purchase Line"."Return Qty. to Ship";
                                QtyToHandleCaption := "Purchase Line".FieldCaption("Return Qty. to Ship");
                            end;
                            if "Purchase Line"."Gen. Prod. Posting Group" <> '' then begin
                                Clear(GenPostingSetup);
                                GenPostingSetup.Reset;
                                GenPostingSetup.SetRange("Gen. Bus. Posting Group", "Purchase Line"."Gen. Bus. Posting Group");
                                GenPostingSetup.SetRange("Gen. Prod. Posting Group", "Purchase Line"."Gen. Prod. Posting Group");
                                if not GenPostingSetup.FindLast then AddError(StrSubstNo(Text020, GenPostingSetup.TableCaption, "Purchase Line"."Gen. Bus. Posting Group", "Purchase Line"."Gen. Prod. Posting Group"));
                            end;
                            if "Purchase Line".Quantity <> 0 then begin
                                if "Purchase Line"."No." = '' then AddError(StrSubstNo(Text006, "Purchase Line".FieldCaption("No.")));
                                if "Purchase Line".Type.AsInteger() = 0 then AddError(StrSubstNo(Text006, "Purchase Line".FieldCaption(Type)));
                            end
                            else
                                if "Purchase Line".Amount <> 0 then AddError(StrSubstNo(Text021, "Purchase Line".FieldCaption(Amount), "Purchase Line".FieldCaption(Quantity)));
                            PurchLine := "Purchase Line";
                            TestJobFields(PurchLine);
                            if "Purchase Line"."Document Type" in ["Purchase Line"."Document Type"::"Return Order", "Purchase Line"."Document Type"::"Credit Memo"] then begin
                                PurchLine."Return Qty. to Ship" := -PurchLine."Return Qty. to Ship";
                                PurchLine."Qty. to Invoice" := -PurchLine."Qty. to Invoice";
                            end;
                            RemQtyToBeInvoiced := PurchLine."Qty. to Invoice";
                            case "Purchase Line"."Document Type" of
                                "Purchase Line"."Document Type"::"Return Order", "Purchase Line"."Document Type"::"Credit Memo":
                                    CheckShptLines("Purchase Line");
                                "Purchase Line"."Document Type"::Order, "Purchase Line"."Document Type"::Invoice:
                                    CheckRcptLines("Purchase Line");
                            end;
                            if ("Purchase Line".Type.AsInteger() >= "Purchase Line".Type::"G/L Account") and ("Purchase Line"."Qty. to Invoice" <> 0) then if GLSetup."VAT in Use" then if not GenPostingSetup.Get("Purchase Line"."Gen. Bus. Posting Group", "Purchase Line"."Gen. Prod. Posting Group") then AddError(StrSubstNo(Text020, GenPostingSetup.TableCaption, "Purchase Line"."Gen. Bus. Posting Group", "Purchase Line"."Gen. Prod. Posting Group"));
                            if "Purchase Line"."Prepayment %" > 0 then
                                if not "Purchase Line"."Prepayment Line" and ("Purchase Line".Quantity > 0) then begin
                                    Fraction := ("Purchase Line"."Qty. to Invoice" + "Purchase Line"."Quantity Invoiced") / "Purchase Line".Quantity;
                                    if Fraction > 1 then Fraction := 1;
                                    case true of
                                        (Fraction * "Purchase Line"."Line Amount" < "Purchase Line"."Prepmt Amt to Deduct") and ("Purchase Line"."Prepmt Amt to Deduct" <> 0):
                                            AddError(StrSubstNo(Text053, "Purchase Line".FieldCaption("Prepmt Amt to Deduct"), Round(Fraction * "Purchase Line"."Line Amount", GLSetup."Amount Rounding Precision")));
                                        (1 - Fraction) * "Purchase Line"."Line Amount" < "Purchase Line"."Prepmt. Amt. Inv." - "Purchase Line"."Prepmt Amt Deducted" - "Purchase Line"."Prepmt Amt to Deduct":
                                            AddError(StrSubstNo(Text054, "Purchase Line".FieldCaption("Prepmt Amt to Deduct"), Round("Purchase Line"."Prepmt. Amt. Inv." - "Purchase Line"."Prepmt Amt Deducted" - (1 - Fraction) * "Purchase Line"."Line Amount", GLSetup."Amount Rounding Precision")));
                                    end;
                                end;
                            if not "Purchase Line"."Prepayment Line" and ("Purchase Line"."Prepmt. Line Amount" > 0) then if "Purchase Line"."Prepmt. Line Amount" > "Purchase Line"."Prepmt. Amt. Inv." then AddError(StrSubstNo(Text042, "Purchase Line".FieldCaption("Prepmt. Line Amount")));
                            case "Purchase Line".Type of
                                "Purchase Line".Type::"G/L Account":
                                    begin
                                        if ("Purchase Line"."No." = '') and ("Purchase Line".Amount = 0) then exit;
                                        if "Purchase Line"."No." <> '' then
                                            if GLAcc.Get("Purchase Line"."No.") then begin
                                                if GLAcc.Blocked then AddError(StrSubstNo(Text007, GLAcc.FieldCaption(Blocked), false, GLAcc.TableCaption, "Purchase Line"."No."));
                                                if not GLAcc."Direct Posting" and ("Purchase Line"."Line No." <= OrigMaxLineNo) then AddError(StrSubstNo(Text007, GLAcc.FieldCaption("Direct Posting"), true, GLAcc.TableCaption, "Purchase Line"."No."));
                                            end
                                            else
                                                AddError(StrSubstNo(Text008, GLAcc.TableCaption, "Purchase Line"."No."));
                                    end;
                                "Purchase Line".Type::Item:
                                    begin
                                        if ("Purchase Line"."No." = '') and ("Purchase Line".Quantity = 0) then exit;
                                        if "Purchase Line"."No." <> '' then
                                            if Item.Get("Purchase Line"."No.") then begin
                                                if Item.Blocked then AddError(StrSubstNo(Text007, Item.FieldCaption(Blocked), false, Item.TableCaption, "Purchase Line"."No."));
                                                if Item."Costing Method" = Item."Costing Method"::Specific then
                                                    if Item.Reserve = Item.Reserve::Always then begin
                                                        "Purchase Line".CalcFields("Reserved Quantity");
                                                        if ("Purchase Line".Signed("Purchase Line".Quantity) < 0) and (Abs("Purchase Line"."Reserved Quantity") < Abs("Purchase Line"."Qty. to Receive")) then AddError(StrSubstNo(Text019, "Purchase Line".FieldCaption("Reserved Quantity"), "Purchase Line".Signed("Purchase Line"."Qty. to Receive")));
                                                    end;
                                            end
                                            else
                                                AddError(StrSubstNo(Text008, Item.TableCaption, "Purchase Line"."No."));
                                    end;
                                "Purchase Line".Type::"Fixed Asset":
                                    begin
                                        if ("Purchase Line"."No." = '') and ("Purchase Line".Quantity = 0) then exit;
                                        if "Purchase Line"."No." <> '' then
                                            if FA.Get("Purchase Line"."No.") then begin
                                                if FA.Blocked then AddError(StrSubstNo(Text007, FA.FieldCaption(Blocked), false, FA.TableCaption, "Purchase Line"."No."));
                                                if FA.Inactive then AddError(StrSubstNo(Text007, FA.FieldCaption(Inactive), false, FA.TableCaption, "Purchase Line"."No."));
                                            end
                                            else
                                                AddError(StrSubstNo(Text008, FA.TableCaption, "Purchase Line"."No."));
                                    end;
                            end;
                            if "Purchase Line"."Line No." > OrigMaxLineNo then begin
                                AddDimToTempLine("Purchase Line", TempDimSetEntry);
                                if not DimMgt.CheckDimIDComb("Purchase Line"."Dimension Set ID") then AddError(DimMgt.GetDimCombErr);
                                if not DimMgt.CheckDimValuePosting(TableID, No, "Purchase Line"."Dimension Set ID") then AddError(DimMgt.GetDimValuePostingErr);
                            end
                            else begin
                                if not DimMgt.CheckDimIDComb("Purchase Line"."Dimension Set ID") then AddError(DimMgt.GetDimCombErr);
                                //TableID[1]:=DimMgt.TypeToTableID3("Purchase Line".Type.AsInteger());
                                TableID[1] := DimMgt.PurchLineTypeToTableID("Purchase Line".Type);
                                No[1] := "Purchase Line"."No.";
                                TableID[2] := DATABASE::Job;
                                No[2] := "Purchase Line"."Job No.";
                                TableID[3] := DATABASE::"Work Center";
                                No[3] := "Purchase Line"."Work Center No.";
                                if not DimMgt.CheckDimValuePosting(TableID, No, "Purchase Line"."Dimension Set ID") then AddError(DimMgt.GetDimValuePostingErr);
                            end;
                            AllowInvDisctxt := Format("Purchase Line"."Allow Invoice Disc.");
                            totAmount := totAmount + "Purchase Line"."Line Amount";
                            AllowInvDisctxt := Format("Purchase Line"."Allow Invoice Disc.");
                            if Number = TempPurchLine.Count then begin
                                if SalesTax then begin
                                    if HeaderTaxArea."Use External Tax Engine" then
                                        SalesTaxCalculate.CallExternalTaxEngineForPurch("Purchase Header", true)
                                    else
                                        SalesTaxCalculate.EndSalesTaxCalculation("Purchase Header"."Posting Date");
                                    SalesTaxCalculate.GetSalesTaxAmountLineTable(SalesTaxAmountLine);
                                    VATAmount := SalesTaxAmountLine.GetTotalTaxAmountFCY;
                                    VATBaseAmount := SalesTaxAmountLine.GetTotalTaxBase;
                                end;
                                if SalesTax then
                                    TaxText := SalesTaxAmountLine.TaxAmountText
                                else
                                    TaxText := VATAmountLine.VATAmountText;
                            end
                        end;

                        trigger OnPreDataItem();
                        var
                            MoreLines: Boolean;
                        begin
                            MoreLines := TempPurchLine.Find('+');
                            while MoreLines and (TempPurchLine.Description = '') and (TempPurchLine."Description 2" = '') and (TempPurchLine."No." = '') and (TempPurchLine.Quantity = 0) and (TempPurchLine.Amount = 0) do MoreLines := TempPurchLine.Next(-1) <> 0;
                            if not MoreLines then CurrReport.Break;
                            TempPurchLine.SetRange("Line No.", 0, TempPurchLine."Line No.");
                            SetRange(Number, 1, TempPurchLine.Count);
                            SumLineAmount := 0;
                            SumInvDiscountAmount := 0;
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(VATAmountLine__VAT_Amount_; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control98; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control138; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control175; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control176; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control177; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control95; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control139; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control181; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control182; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control183; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control85; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control137; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control187; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control188; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control189; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounter_Number; Number)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control98Caption; VATAmountLine__VAT_Amount__Control98CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control138Caption; VATAmountLine__VAT_Base__Control138CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control176Caption; VATAmountLine__Inv__Disc__Base_Amount__Control176CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control175Caption; VATAmountLine__Line_Amount__Control175CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control177Caption; VATAmountLine__Invoice_Discount_Amount__Control177CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control139Caption; VATAmountLine__VAT_Base__Control139CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control137Caption; VATAmountLine__VAT_Base__Control137CaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem();
                        begin
                            SetRange(Number, 1, VATAmountLine.Count);
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control242; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control243; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT____Control244; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier__Control245; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATAmountLCY_Control246; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control247; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control249; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control250; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATCounterLCY_Number; Number)
                        {
                        }
                        column(VALVATAmountLCY_Control242Caption; VALVATAmountLCY_Control242CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control243Caption; VALVATBaseLCY_Control243CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT____Control244Caption; VATAmountLine__VAT____Control244CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier__Control245Caption; VATAmountLine__VAT_Identifier__Control245CaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control248; ContinuedCaption_Control248Lbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY := VATAmountLine.GetBaseLCY("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                            VALVATAmountLCY := VATAmountLine.GetAmountLCY("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem();
                        var
                            CurrExchRate: Record "Currency Exchange Rate";
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or ("Purchase Header"."Currency Code" = '') then CurrReport.Break;
                            SetRange(Number, 1, VATAmountLine.Count);
                            Clear(VALVATBaseLCY);
                            Clear(VALVATAmountLCY);
                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text050 + Text051
                            else
                                VALSpecLCYHeader := Text050 + Format(GLSetup."LCY Code");
                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            CurrExchRate."Relational Exch. Rate Amount" := CurrExchRate."Exchange Rate Amount" / "Purchase Header"."Currency Factor";
                            VALExchRate := StrSubstNo(Text052, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(SalesTaxCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(SalesTax_AND__SalesTaxAmountLine__Tax_Amount_____0_; SalesTax and (SalesTaxAmountLine."Tax Amount" <> 0))
                        {
                        }
                        column(Purchase_Header___Currency_Code________; ("Purchase Header"."Currency Code" <> ''))
                        {
                        }
                        column(SalesTaxAmountLine__Tax_Amount_; SalesTaxAmountLine."Tax Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesTaxAmountLine__Tax_Amount__Control1020000; SalesTaxAmountLine."Tax Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesTaxAmountLine__Tax_Area_Code_for_Key_; SalesTaxAmountLine."Tax Area Code for Key")
                        {
                            AutoFormatType = 1;
                        }
                        column(SalesTaxAmountLine__Tax_Base_Amount_; SalesTaxAmountLine."Tax Base Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(SalesTaxAmountLine__Inv__Disc__Base_Amount_; SalesTaxAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(SalesTaxAmountLine__Invoice_Discount_Amount_; SalesTaxAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatType = 1;
                        }
                        column(SalesTaxAmountLine__Tax___; SalesTaxAmountLine."Tax %")
                        {
                            AutoFormatType = 1;
                        }
                        column(SalesTaxAmountLine__Tax_Amount__Control1020011; SalesTaxAmountLine."Tax Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesTaxAmountLine__Tax_Amount__Control1020014; SalesTaxAmountLine."Tax Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesTaxAmountLine__Tax_Amount____ExchangeFactor; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Total______Purchase_Header___Currency_Code_; 'Total ' + "Purchase Header"."Currency Code")
                        {
                        }
                        column(SalesTaxCounter_Number; Number)
                        {
                        }
                        column(SalesTaxAmountLine__Tax_Area_Code_for_Key_Caption; SalesTaxAmountLine__Tax_Area_Code_for_Key_CaptionLbl)
                        {
                        }
                        column(SalesTaxAmountLine__Tax_Base_Amount_Caption; SalesTaxAmountLine__Tax_Base_Amount_CaptionLbl)
                        {
                        }
                        column(SalesTaxAmountLine__Tax_Amount__Control1020000Caption; SalesTaxAmountLine__Tax_Amount__Control1020000CaptionLbl)
                        {
                        }
                        column(SalesTaxAmountLine__Inv__Disc__Base_Amount_Caption; SalesTaxAmountLine__Inv__Disc__Base_Amount_CaptionLbl)
                        {
                        }
                        column(SalesTaxAmountLine__Invoice_Discount_Amount_Caption; SalesTaxAmountLine__Invoice_Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SalesTaxAmountLine__Tax___Caption; SalesTaxAmountLine__Tax___CaptionLbl)
                        {
                        }
                        column(Sales_Tax_AmountsCaption; Sales_Tax_AmountsCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control1020002; ContinuedCaption_Control1020002Lbl)
                        {
                        }
                        column(ContinuedCaption_Control1020007; ContinuedCaption_Control1020007Lbl)
                        {
                        }
                        column(TotalCaption_Control1020012; TotalCaption_Control1020012Lbl)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                SalesTaxAmountLine.Find('-')
                            else
                                SalesTaxAmountLine.Next;
                            if SalesTaxCountry = SalesTaxCountry::CA then
                                SalesTaxAmountLine."Tax Amount" := Round(SalesTaxAmountLine."Tax Amount", GLSetup."Amount Rounding Precision")
                            else begin
                                SalesTaxAmountLine."Tax Amount" += RemSalesTaxAmt;
                                RemSalesTaxAmt := SalesTaxAmountLine."Tax Amount" - Round(SalesTaxAmountLine."Tax Amount", GLSetup."Amount Rounding Precision");
                                SalesTaxAmountLine."Tax Amount" := Round(SalesTaxAmountLine."Tax Amount", GLSetup."Amount Rounding Precision");
                            end;
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not SalesTax then CurrReport.Break;
                            SetRange(Number, 1, SalesTaxAmountLine.Count);
                            SalesTaxAmountLine.Reset;
                            RemSalesTaxAmt := 0;
                        end;
                    }
                    dataitem("Item Charge Assignment (Purch)"; "Item Charge Assignment (Purch)")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No.");
                        DataItemLinkReference = "Purchase Line";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Document Line No.", "Line No.");

                        column(Item_Charge_Assignment__Purch___Qty__to_Assign_; "Qty. to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Amount_to_Assign_; "Amount to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Item_Charge_No__; "Item Charge No.")
                        {
                        }
                        column(PurchLine2_Description; PurchLine2.Description)
                        {
                        }
                        column(PurchLine2_Quantity; PurchLine2.Quantity)
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Item_No__; "Item No.")
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Qty__to_Assign__Control204; "Qty. to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Unit_Cost_; "Unit Cost")
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Amount_to_Assign__Control210; "Amount to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Qty__to_Assign__Control195; "Qty. to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Amount_to_Assign__Control196; "Amount to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Qty__to_Assign__Control191; "Qty. to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Amount_to_Assign__Control193; "Amount to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Purch__Document_Type; "Document Type")
                        {
                        }
                        column(Item_Charge_Assignment__Purch__Document_No_; "Document No.")
                        {
                        }
                        column(Item_Charge_Assignment__Purch__Document_Line_No_; "Document Line No.")
                        {
                        }
                        column(Item_Charge_Assignment__Purch__Line_No_; "Line No.")
                        {
                        }
                        column(Item_Charge_SpecificationCaption; Item_Charge_SpecificationCaptionLbl)
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Item_Charge_No__Caption; FieldCaption("Item Charge No."))
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Item_No__Caption; FieldCaption("Item No."))
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Qty__to_Assign__Control204Caption; FieldCaption("Qty. to Assign"))
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Unit_Cost_Caption; FieldCaption("Unit Cost"))
                        {
                        }
                        column(Item_Charge_Assignment__Purch___Amount_to_Assign__Control210Caption; FieldCaption("Amount to Assign"))
                        {
                        }
                        column(DescriptionCaption_Control227; DescriptionCaption_Control227Lbl)
                        {
                        }
                        column(PurchLine2_QuantityCaption; PurchLine2_QuantityCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control197; ContinuedCaption_Control197Lbl)
                        {
                        }
                        column(TotalCaption_Control194; TotalCaption_Control194Lbl)
                        {
                        }
                        column(ContinuedCaption_Control192; ContinuedCaption_Control192Lbl)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            if PurchLine2.Get("Document Type", "Document No.", "Document Line No.") then;
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not ShowItemChargeAssgnt then CurrReport.Break;
                        end;
                    }
                    trigger OnAfterGetRecord();
                    var
                        PurchPost: Codeunit "Purch.-Post";
                    begin
                        Clear(TempPurchLine);
                        Clear(PurchPost);
                        TempPurchLine.DeleteAll;
                        VATAmountLine.DeleteAll;
                        PurchPost.GetPurchLines("Purchase Header", TempPurchLine, 1);
                        TempPurchLine.CalcVATAmountLines(0, "Purchase Header", TempPurchLine, VATAmountLine);
                        TempPurchLine.UpdateVATOnLines(0, "Purchase Header", TempPurchLine, VATAmountLine);
                        VATAmount := VATAmountLine.GetTotalVATAmount;
                        VATBaseAmount := VATAmountLine.GetTotalVATBase;
                        VATDiscountAmount := VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                        if SalesTax then begin
                            SalesTaxAmountLine.DeleteAll;
                            SalesTaxCalculate.StartSalesTaxCalculation;
                        end;
                    end;
                }
                trigger OnAfterGetRecord();
                begin
                    PurchHeaderDocTypeNo := "Purchase Header"."Document Type".AsInteger();
                end;
            }
            trigger OnAfterGetRecord();
            var
                VendorMgt: Codeunit "Vendor Mgt.";
                TableID: array[10] of Integer;
                No: array[10] of Code[20];
            begin
                DimSetEntry1.SetRange("Dimension Set ID", "Purchase Header"."Dimension Set ID");
                FormatAddr.PurchHeaderPayTo(PayToAddr, "Purchase Header");
                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text004, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(Text005, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(Text031, GLSetup."LCY Code");
                    ExchangeFactor := 1;
                end
                else begin
                    TotalText := StrSubstNo(Text004, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text005, "Currency Code");
                    TotalExclVATText := StrSubstNo(Text031, "Currency Code");
                    ExchangeFactor := "Currency Factor";
                end;
                Invoice := InvOnNextPostReq;
                Receive := ReceiveShipOnNextPostReq;
                Ship := ReceiveShipOnNextPostReq;
                SalesTax := "Tax Area Code" <> '';
                if SalesTax then begin
                    HeaderTaxArea.Get("Tax Area Code");
                    SalesTaxCountry := HeaderTaxArea."Country/Region";
                end
                else
                    SalesTaxCountry := SalesTaxCountry::NoTax;
                VerifyBuyFromVend("Purchase Header");
                VerifyPayToVend("Purchase Header");
                PurchSetup.Get;
                VerifyPostingDate("Purchase Header");
                if "Document Date" <> 0D then if "Document Date" <> NormalDate("Document Date") then AddError(StrSubstNo(Text009, FieldCaption("Document Date")));
                case "Document Type" of
                    "Document Type"::Order:
                        Ship := false;
                    "Document Type"::Invoice:
                        begin
                            Receive := true;
                            Invoice := true;
                            Ship := false;
                        end;
                    "Document Type"::"Return Order":
                        Receive := false;
                    "Document Type"::"Credit Memo":
                        begin
                            Receive := false;
                            Invoice := true;
                            Ship := true;
                        end;
                end;
                if not (Receive or Invoice or Ship) then AddError(StrSubstNo(Text032, FieldCaption(Receive), FieldCaption(Invoice), FieldCaption(Ship)));
                if Invoice then begin
                    PurchLine.Reset;
                    PurchLine.SetRange("Document Type", "Document Type");
                    PurchLine.SetRange("Document No.", "No.");
                    PurchLine.SetFilter(Quantity, '<>0');
                    if "Document Type" in ["Document Type"::Order, "Document Type"::"Return Order"] then PurchLine.SetFilter("Qty. to Invoice", '<>0');
                    Invoice := PurchLine.Find('-');
                    if Invoice and (not Receive) and ("Document Type" = "Document Type"::Order) then begin
                        Invoice := false;
                        repeat
                            Invoice := PurchLine."Quantity Received" - PurchLine."Quantity Invoiced" <> 0;
                        until Invoice or (PurchLine.Next = 0);
                    end
                    else
                        if Invoice and (not Ship) and ("Document Type" = "Document Type"::"Return Order") then begin
                            Invoice := false;
                            repeat
                                Invoice := PurchLine."Return Qty. Shipped" - PurchLine."Quantity Invoiced" <> 0;
                            until Invoice or (PurchLine.Next = 0);
                        end;
                end;
                if Receive then begin
                    PurchLine.Reset;
                    PurchLine.SetRange("Document Type", "Document Type");
                    PurchLine.SetRange("Document No.", "No.");
                    PurchLine.SetFilter(Quantity, '<>0');
                    if "Document Type" = "Document Type"::Order then PurchLine.SetFilter("Qty. to Receive", '<>0');
                    PurchLine.SetRange("Receipt No.", '');
                    Receive := PurchLine.Find('-');
                end;
                if Ship then begin
                    PurchLine.Reset;
                    PurchLine.SetRange("Document Type", "Document Type");
                    PurchLine.SetRange("Document No.", "No.");
                    PurchLine.SetFilter(Quantity, '<>0');
                    if "Document Type" = "Document Type"::"Return Order" then PurchLine.SetFilter("Return Qty. to Ship", '<>0');
                    PurchLine.SetRange("Return Shipment No.", '');
                    Ship := PurchLine.Find('-');
                end;
                if not (Receive or Invoice or Ship) then AddError(Text012);
                if Invoice then begin
                    PurchLine.Reset;
                    PurchLine.SetRange("Document Type", "Document Type");
                    PurchLine.SetRange("Document No.", "No.");
                    PurchLine.SetFilter("Sales Order Line No.", '<>0');
                    if PurchLine.Find('-') then
                        repeat // ISS DFP 02.10.14 ===========================================================================================\
                               //SalesLine.GET(SalesLine."Document Type"::Order,PurchLine."Sales Order No.",PurchLine."Sales Order Line No.");
                               // Was causing errors if Sales Order was already Invoiced
                            if SalesLine.Get(SalesLine."Document Type"::Order, PurchLine."Sales Order No.", PurchLine."Sales Order Line No.") then begin
                                // End ========================================================================================================/
                                if Receive and Invoice and (PurchLine."Qty. to Invoice" <> 0) and (PurchLine."Qty. to Receive" <> 0) then AddError(Text013);
                                if Abs(PurchLine."Quantity Received" - PurchLine."Quantity Invoiced") < Abs(PurchLine."Qty. to Invoice") then PurchLine."Qty. to Invoice" := PurchLine."Quantity Received" - PurchLine."Quantity Invoiced";
                                if Abs(PurchLine.Quantity - (PurchLine."Qty. to Invoice" + PurchLine."Quantity Invoiced")) < Abs(SalesLine.Quantity - SalesLine."Quantity Invoiced") then AddError(StrSubstNo(Text014, PurchLine."Sales Order No."));
                                // ISS DFP 02.10.14 ===========================================================================================\
                            end;
                        // End ========================================================================================================/
                        until PurchLine.Next = 0;
                end;
                if Invoice then if not ("Document Type" in ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) then if "Due Date" = 0D then AddError(StrSubstNo(Text006, FieldCaption("Due Date")));
                if Receive and ("Receiving No." = '') then if ("Document Type" = "Document Type"::Order) or (("Document Type" = "Document Type"::Invoice) and PurchSetup."Receipt on Invoice") then if "Receiving No. Series" = '' then AddError(StrSubstNo(Text015, FieldCaption("Receiving No. Series")));
                if Ship and ("Return Shipment No." = '') then if ("Document Type" = "Document Type"::"Return Order") or (("Document Type" = "Document Type"::"Credit Memo") and PurchSetup."Return Shipment on Credit Memo") then if "Return Shipment No. Series" = '' then AddError(StrSubstNo(Text015, FieldCaption("Return Shipment No. Series")));
                if Invoice and ("Posting No." = '') then if "Document Type" in ["Document Type"::Order, "Document Type"::"Return Order"] then if "Posting No. Series" = '' then AddError(StrSubstNo(Text015, FieldCaption("Posting No. Series")));
                PurchLine.Reset;
                PurchLine.SetRange("Document Type", "Document Type");
                PurchLine.SetRange("Document No.", "No.");
                PurchLine.SetFilter("Sales Order Line No.", '<>0');
                if Receive then
                    if PurchLine.FindSet then
                        repeat
                            if SalesHeader."No." <> PurchLine."Sales Order No." then begin
                                // ISS DFP 02.10.14 ===========================================================================================\
                                //SalesHeader.GET(1,PurchLine."Sales Order No.");
                                // Was causing errors if Sales Order was already Invoiced
                                if SalesHeader.Get(1, PurchLine."Sales Order No.") then begin
                                    // End ========================================================================================================/
                                    SalesHeader.Get(1, PurchLine."Sales Order No.");
                                    if SalesHeader."Bill-to Customer No." = '' then AddError(StrSubstNo(Text016, SalesHeader.FieldCaption("Bill-to Customer No.")));
                                    if SalesHeader."Shipping No." = '' then if SalesHeader."Shipping No. Series" = '' then AddError(StrSubstNo(Text016, SalesHeader.FieldCaption("Shipping No. Series")));
                                    // ISS DFP 02.10.14 ===========================================================================================\
                                end;
                                // End ========================================================================================================/
                            end;
                        until PurchLine.Next = 0;
                if Invoice then
                    if "Document Type" in ["Document Type"::Order, "Document Type"::Invoice] then begin
                        if PurchSetup."Ext. Doc. No. Mandatory" and ("Vendor Invoice No." = '') then AddError(StrSubstNo(Text006, FieldCaption("Vendor Invoice No.")));
                    end
                    else
                        if PurchSetup."Ext. Doc. No. Mandatory" and ("Vendor Cr. Memo No." = '') then AddError(StrSubstNo(Text006, FieldCaption("Vendor Cr. Memo No.")));
                if "Vendor Invoice No." <> '' then begin
                    VendLedgEntry.SetCurrentKey("External Document No.");
                    VendorMgt.SetFilterForExternalDocNo(VendLedgEntry, "Document Type", "Vendor Invoice No.", "Pay-to Vendor No.", "Document Date");
                    if VendLedgEntry.FindFirst then AddError(StrSubstNo(Text017, "Document Type", "Vendor Invoice No."));
                end;
                if not DimMgt.CheckDimIDComb("Purchase Header"."Dimension Set ID") then AddError(DimMgt.GetDimCombErr);
                TableID[1] := DATABASE::Vendor;
                No[1] := "Pay-to Vendor No.";
                TableID[3] := DATABASE::"Salesperson/Purchaser";
                No[3] := "Purchaser Code";
                TableID[4] := DATABASE::Campaign;
                No[4] := "Campaign No.";
                TableID[5] := DATABASE::"Responsibility Center";
                No[5] := "Responsibility Center";
                if not DimMgt.CheckDimValuePosting(TableID, No, "Purchase Header"."Dimension Set ID") then AddError(DimMgt.GetDimValuePostingErr);
                PurchLine.Reset;
                PurchLine.SetRange("Document Type", "Document Type");
                PurchLine.SetRange("Document No.", "No.");
                InvoiceAmount := 0;
                if PurchLine.FindSet then
                    repeat
                        InvoiceAmount += PurchLine."Outstanding Amount";
                    until PurchLine.Next = 0;
                if Purchaser.Get("Purchaser Code") then;
                PricesInclVATtxt := Format("Purchase Header"."Prices Including VAT");
            end;

            trigger OnPreDataItem();
            begin
                PurchHeader.Copy("Purchase Header");
                PurchHeader.FilterGroup := 2;
                PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                if PurchHeader.FindFirst then begin
                    case true of
                        ReceiveShipOnNextPostReq and InvOnNextPostReq:
                            ReceiveInvoiceText := Text000;
                        ReceiveShipOnNextPostReq:
                            ReceiveInvoiceText := Text001;
                        InvOnNextPostReq:
                            ReceiveInvoiceText := Text002;
                    end;
                    ReceiveInvoiceText := StrSubstNo(Text003, ReceiveInvoiceText);
                end;
                PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::"Return Order");
                if PurchHeader.FindFirst then begin
                    case true of
                        ReceiveShipOnNextPostReq and InvOnNextPostReq:
                            ShipInvoiceText := Text028;
                        ReceiveShipOnNextPostReq:
                            ShipInvoiceText := Text029;
                        InvOnNextPostReq:
                            ShipInvoiceText := Text002;
                    end;
                    ShipInvoiceText := StrSubstNo(Text030, ShipInvoiceText);
                end;
                //CurrReport.NewPagePerRecord := not (Summarize);
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

                    group("Order/Credit Memo Posting")
                    {
                        CaptionML = ENU = 'Order/Credit Memo Posting', ESM = 'Registro Pedido/Nota crédito', FRC = 'Report commande/note de crédit', ENC = 'Order/Credit Memo Posting';

                        field(ReceiveShip; ReceiveShipOnNextPostReq)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Receive/Ship', ESM = 'Recibir/Enviar', FRC = 'Réceptionner/Livrer', ENC = 'Receive/Ship';
                            ToolTipML = ENU = 'Specifies whether you want to post the documents that are being tested as received/shipped, as invoiced or as received/shipped and invoiced. Select the check box next to each option that you want to select.', ESM = 'Especifica si desea registrar los documentos ya comprobados como recibidos/enviados, como facturados o como recibidos/enviados. Seleccione la casilla de verificación junto a cada una de sus opciones.', FRC = 'Spécifie si vous souhaitez reporter ou non les documents en cours de test comme étant reçus/livrés, facturés ou reçus/livrés et facturés. Activez la case à cocher en regard de l''option désirée.', ENC = 'Specifies whether you want to post the documents that are being tested as received/shipped, as invoiced or as received/shipped and invoiced. Select the check box next to each option that you want to select.';

                            trigger OnValidate();
                            begin
                                if not ReceiveShipOnNextPostReq then InvOnNextPostReq := true;
                            end;
                        }
                        field(Invoice; InvOnNextPostReq)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Invoice', ESM = 'Factura', FRC = 'Facture', ENC = 'Invoice';
                            ToolTipML = ENU = 'Specifies invoices to test before you post them, to check whether there are any posting dates missing, etc.', ESM = 'Especifica las facturas que se van a probar antes de registrarlas, para comprobar si faltan fechas de registro, etc.', FRC = 'Spécifie les factures à tester avant leur report pour vérifier si des dates de report sont manquantes, etc.', ENC = 'Specifies invoices to test before you post them, to check whether there are any posting dates missing, etc.';

                            trigger OnValidate();
                            begin
                                if not InvOnNextPostReq then ReceiveShipOnNextPostReq := true;
                            end;
                        }
                    }
                    field(ShowDim; ShowDim)
                    {
                        ApplicationArea = Dimensions;
                        CaptionML = ENU = 'Show Dimensions', ESM = 'Mostrar dimensiones', FRC = 'Afficher dimensions', ENC = 'Show Dimensions';
                        ToolTipML = ENU = 'Specifies if you want dimensions information for the journal lines to be included in the report.', ESM = 'Especifica si desea que se incluya en el informe la información de dimensiones de las líneas del diario.', FRC = 'Spécifie si vous souhaitez inclure des informations sur les dimensions pour les lignes journal dans le rapport.', ENC = 'Specifies if you want dimensions information for the journal lines to be included in the report.';
                    }
                    field(ShowItemChargeAssignment; ShowItemChargeAssgnt)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Show Item Charge Assgnt.', ESM = 'Mostrar asig. cargos prod.', FRC = 'Afficher affect. frais annexes', ENC = 'Show Item Charge Assgnt.';
                        ToolTipML = ENU = 'Specifies if you want the test report to show the item charge that has been assigned to the purchase document.', ESM = 'Especifica si desea que el informe de prueba muestre los cargos de producto asignados al documento de compra.', FRC = 'Spécifie si vous souhaitez que le rapport de test affiche les frais annexes affectés au document achat.', ENC = 'Specifies if you want the test report to show the item charge that has been assigned to the purchase document.';
                    }
                    field(Summary; Summarize)
                    {
                        CaptionML = ENU = 'Summary', ESM = 'Resumen', FRC = 'Sommaire', ENC = 'Summary';
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage();
        begin
            if not ReceiveShipOnNextPostReq and not InvOnNextPostReq then begin
                ReceiveShipOnNextPostReq := true;
                InvOnNextPostReq := true;
            end;
        end;
    }
    labels
    {
    }
    trigger OnInitReport();
    begin
        GLSetup.Get;
    end;

    trigger OnPreReport();
    begin
        PurchHeaderFilter := "Purchase Header".GetFilters;
    end;

    var
        Text000: TextConst ENU = 'Receive and Invoice', ESM = 'Recibir y facturar', FRC = 'Reception et facture', ENC = 'Receive and Invoice';
        Text001: TextConst ENU = 'Receive', ESM = 'Recepción', FRC = 'Recevoir', ENC = 'Receive';
        Text002: TextConst ENU = 'Invoice', ESM = 'Factura', FRC = 'Facture', ENC = 'Invoice';
        Text003: TextConst ENU = 'Order Posting: %1', ESM = 'Registro pedido: %1', FRC = 'Commande report: %1', ENC = 'Order Posting: %1';
        Text004: TextConst ENU = 'Total %1', ESM = 'Total %1', FRC = 'Total %1', ENC = 'Total %1';
        Text005: TextConst ENU = 'Total %1 Incl. Tax', ESM = 'Total de %1 con IVA', FRC = 'Total %1 TTC', ENC = 'Total %1 Incl. Tax';
        Text006: TextConst ENU = '%1 must be specified.', ESM = 'Se debe especificar %1.', FRC = '%1 doit être spécifié(e).', ENC = '%1 must be specified.';
        Text007: TextConst ENU = '%1 must be %2 for %3 %4.', ESM = '%1 debe ser %2 para %3 %4.', FRC = '%1 doit être %2 pour %3 %4.', ENC = '%1 must be %2 for %3 %4.';
        Text008: TextConst ENU = '%1 %2 does not exist.', ESM = 'No existe %1 %2.', FRC = '%1 %2 n''existe pas.', ENC = '%1 %2 does not exist.';
        Text009: TextConst ENU = '%1 must not be a closing date.', ESM = '%1 no debe ser una fecha de cierre.', FRC = '%1 ne doit pas être une date de fermeture.', ENC = '%1 must not be a closing date.';
        Text010: TextConst ENU = '%1 is not within your allowed range of posting dates.', ESM = '%1 no se encuentra en su rango permitido de fechas de registro.', FRC = '%1 ne se trouve pas dans la plage autorisée de dates de report.', ENC = '%1 is not within your allowed range of posting dates.';
        Text012: TextConst ENU = 'There is nothing to post.', ESM = 'No hay nada que registrar.', FRC = 'Il n''existe aucun élément à reporter.', ENC = 'There is nothing to post.';
        Text013: TextConst ENU = 'A drop shipment from a purchase order cannot be received and invoiced at the same time.', ESM = 'Un envío directo desde un pedido de compras no se puede recibir y facturar a la vez.', FRC = 'Une livraison directe d''un bon de commande ne peut être reçue et facturée à la fois.', ENC = 'A drop shipment from a purchase order cannot be received and invoiced at the same time.';
        Text014: TextConst ENU = 'Invoice sales order %1 before invoicing this purchase order.', ESM = 'Facture el pedido de venta %1 antes de facturar este pedido de compra.', FRC = 'Facturez le document de vente %1 avant de facturer ce bon de commande.', ENC = 'Invoice sales order %1 before invoicing this purchase order.';
        Text015: TextConst ENU = '%1 must be entered.', ESM = 'Se debe indicar %1.', FRC = '%1 doit être entré(e).', ENC = '%1 must be entered.';
        Text016: TextConst ENU = '%1 must be entered on the sales order header.', ESM = 'Se debe indicar %1 en el pedido de venta.', FRC = '%1 doit être entré sur l''en-tête du bon de commande.', ENC = '%1 must be entered on the sales order header.';
        Text017: TextConst ENU = 'Purchase %1 %2 already exists for this vendor.', ESM = 'Ya existe la compra %1 %2 para este proveedor.', FRC = 'Le document %1 achat %2 existe déjà pour ce fournisseur.', ENC = 'Purchase %1 %2 already exists for this vendor.';
        Text018: TextConst ENU = 'Purchase Document: %1', ESM = 'Documento compras: %1', FRC = 'Document achat: %1', ENC = 'Purchase Document: %1';
        Text019: TextConst ENU = '%1 must be %2.', ESM = '%1 debe ser %2.', FRC = '%1 doit être %2.', ENC = '%1 must be %2.';
        Text020: TextConst ENU = '%1 %2 %3 does not exist.', ESM = 'No existe %1 %2 %3.', FRC = '%1 %2 %3 n''existe pas.', ENC = '%1 %2 %3 does not exist.';
        Text021: TextConst ENU = '%1 must be 0 when %2 is 0.', ESM = '%1 debe ser 0 cuando %2 es 0.', FRC = '%1 doit être 0 lorsque %2 est 0.', ENC = '%1 must be 0 when %2 is 0.';
        Text022: TextConst ENU = 'The %1 on the receipt is not the same as the %1 on the purchase header.', ESM = 'En la recepción %1 no se corresponde con %1 en la cabecera compra.', FRC = 'Le %1 sur la réception n''est pas la même que le %1 sur l''en-tête d''achat.', ENC = 'The %1 on the receipt is not the same as the %1 on the purchase header.';
        Text023: TextConst ENU = '%1 must have the same sign as the receipt.', ESM = '%1 debe tener el mismo signo que la recepción.', FRC = '%1 doit être du même signe que la réception.', ENC = '%1 must have the same sign as the receipt.';
        Text025: TextConst ENU = '%1 must have the same sign as the return shipment.', ESM = '%1 debe tener el mismo signo que el envío devolución', FRC = '%1 doit avoir le même signe que la livraison retour.', ENC = '%1 must have the same sign as the return shipment.';
        Text028: TextConst ENU = 'Ship and Invoice', ESM = 'Enviar y facturar', FRC = 'Livrer et facturer', ENC = 'Ship and Invoice';
        Text029: TextConst ENU = 'Ship', ESM = 'Envío', FRC = 'Livrer', ENC = 'Ship';
        Text030: TextConst ENU = 'Return Order Posting: %1', ESM = 'Registrando devolución: %1', FRC = 'Report retour : %1', ENC = 'Return Order Posting: %1';
        Text031: TextConst ENU = 'Total %1 Excl. Tax', ESM = 'Total de %1 sin IVA', FRC = 'Total %1 HT', ENC = 'Total %1 Excl. Tax';
        Text032: TextConst ENU = 'Enter "Yes" in %1 and/or %2 and/or %3.', ESM = 'Introduzca "Sí" en %1 y/ó %2 y/ó %3.', FRC = 'Entrez "Oui" dans %1 et/ou %2 et/ou %3.', ENC = 'Enter "Yes" in %1 and/or %2 and/or %3.';
        Text033: TextConst ENU = 'Line %1 of the receipt %2, which you are attempting to invoice, has already been invoiced.', ESM = 'Línea %1 de la recepción %2,que está intentando facturar,ha sido ya facturado.', FRC = 'La ligne %1 de la réception %2, que vous essayez de facturer, a déjà été facturée.', ENC = 'Line %1 of the receipt %2, which you are attempting to invoice, has already been invoiced.';
        Text034: TextConst ENU = 'Line %1 of the return shipment %2, which you are attempting to invoice, has already been invoiced.', ESM = 'Línea %1 del envío dev. %2, que esta intentando facturar, ya se ha facturado.', FRC = 'La ligne %1 de la livraison retour %2, que vous essayez de facturer, a déjà été facturée.', ENC = 'Line %1 of the return shipment %2, which you are attempting to invoice, has already been invoiced.';
        Text036: TextConst ENU = 'The %1 on the return shipment is not the same as the %1 on the purchase header.', ESM = 'El %1 en el envío devolución no es el mismo que el %1 en la cabecera de compras.', FRC = 'Le %1 du document livraison retour n''est pas le même que le %1 de l''en-tête achat.', ENC = 'The %1 on the return shipment is not the same as the %1 on the purchase header.';
        Text037: TextConst ENU = 'The quantity you are attempting to invoice is greater than the quantity in receipt %1.', ESM = 'La cantidad que está intentando facturar es más grande que la de la recepción %1.', FRC = 'La quantité que vous essayez de facturer est supérieure à la quantité de la réception %1.', ENC = 'The quantity you are attempting to invoice is greater than the quantity in receipt %1.';
        Text038: TextConst ENU = 'The quantity you are attempting to invoice is greater than the quantity in return shipment %1.', ESM = 'La cant. que está intentando facturar es mayor que la cant. en envío dev. %1.', FRC = 'La quantité que vous essayez de facturer est supérieure à la quantité de la livraison retour %1.', ENC = 'The quantity you are attempting to invoice is greater than the quantity in return shipment %1.';
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line" temporary;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FA: Record "Fixed Asset";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ReturnShptLine: Record "Return Shipment Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        GenPostingSetup: Record "General Posting Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        SalesTaxAmountLine: Record "Sales Tax Amount Line" temporary;
        InvtPeriod: Record "Inventory Period";
        HeaderTaxArea: Record "Tax Area";
        Purchaser: Record "Salesperson/Purchaser";
        FormatAddr: Codeunit "Format Address";
        DimMgt: Codeunit DimensionManagement;
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        PayToAddr: array[8] of Text[100];
        BuyFromAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        PurchHeaderFilter: Text;
        ErrorText: array[99] of Text[250];
        DimText: Text[120];
        OldDimText: Text[75];
        ReceiveInvoiceText: Text[50];
        ShipInvoiceText: Text[50];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        QtyToHandleCaption: Text[30];
        MaxQtyToBeInvoiced: Decimal;
        RemQtyToBeInvoiced: Decimal;
        QtyToBeInvoiced: Decimal;
        QtyToHandle: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        ErrorCounter: Integer;
        OrigMaxLineNo: Integer;
        InvOnNextPostReq: Boolean;
        ReceiveShipOnNextPostReq: Boolean;
        ShowDim: Boolean;
        Continue: Boolean;
        ShowItemChargeAssgnt: Boolean;
        Text040: TextConst ENU = '%1 must be zero.', ESM = '%1 debe ser cero.', FRC = '%1 doit être égal(e) à zéro.', ENC = '%1 must be zero.';
        Text041: TextConst ENU = '%1 must not be %2 for %3 %4.', ESM = '%1 no debe ser %2 para %3 %4.', FRC = '%1 ne doit pas être %2 pour %3 %4.', ENC = '%1 must not be %2 for %3 %4.';
        Text042: TextConst ENU = '%1 must be completely preinvoiced before you can ship or invoice the line.', ESM = 'Se debe haber emitido una factura completa de %1 para poder enviar la línea o facturarla.', FRC = '%1 doit faire l''objet d''une facture préalable  complète avant que vous puissiez livrer ou facturer la ligne.', ENC = '%1 must be completely preinvoiced before you can ship or invoice the line.';
        Text050: TextConst ENU = 'Tax Amount Specification in ', ESM = 'Especificación de importe de IVA en', FRC = 'Détail TVA dans ', ENC = 'Tax Amount Specification in ';
        Text051: TextConst ENU = 'Local Currency', ESM = 'Divisa local', FRC = 'Devise locale', ENC = 'Local Currency';
        Text052: TextConst ENU = 'Exchange rate: %1/%2', ESM = 'Tipo cambio: %1/%2', FRC = 'Taux de change : %1/%2', ENC = 'Exchange rate: %1/%2';
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        SalesTax: Boolean;
        ExchangeFactor: Decimal;
        Text053: TextConst ENU = '%1 can at most be %2.', ESM = '%1 puede ser como mucho %2.', FRC = '%1 peut être au plus %2.', ENC = '%1 can at most be %2.';
        Text054: TextConst ENU = '%1 must be at least %2.', ESM = '%1 debe ser al menos %2.', FRC = '%1 doit être au moins %2.', ENC = '%1 must be at least %2.';
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        SumLineAmount: Decimal;
        SumInvDiscountAmount: Decimal;
        TaxText: Text[30];
        totAmount: Decimal;
        Summarize: Boolean;
        InvoiceAmount: Decimal;
        PurchHeaderDocTypeNo: Integer;
        SalesTaxCountry: Option US,CA,,,,,,,,,,,,NoTax;
        RemSalesTaxAmt: Decimal;
        CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page', ESM = 'Pág.', FRC = 'Page', ENC = 'Page';
        Purchase_Document___TestCaptionLbl: TextConst ENU = 'Purchase Document - Test', ESM = 'Documento compras - Prueba', FRC = 'Document d''achat - Test', ENC = 'Purchase Document - Test';
        Document_No_CaptionLbl: TextConst ENU = 'Document No.', ESM = 'Nº documento', FRC = 'N° de document', ENC = 'Document No.';
        Vendor_Invoice_No_CaptionLbl: TextConst ENU = 'Vendor Invoice No.', ESM = 'Nº factura proveedor', FRC = 'N° de facture fournisseur', ENC = 'Vendor Invoice No.';
        Invoice_Amount_Excl__TaxCaptionLbl: TextConst ENU = 'Invoice Amount Excl. Tax', ESM = 'Importe de la factura sin impuestos', FRC = 'Montant de la facture hors taxe', ENC = 'Invoice Amount Excl. Tax';
        Vendor_InformationCaptionLbl: TextConst ENU = 'Vendor Information', ESM = 'Información de proveedor', FRC = 'Informations fournisseur', ENC = 'Vendor Information';
        PurchaserCaptionLbl: TextConst ENU = 'Purchaser', ESM = 'Comprador', FRC = 'Acheteur', ENC = 'Purchaser';
        ContactCaptionLbl: TextConst ENU = 'Contact', ESM = 'Contacto', FRC = 'Contact', ENC = 'Contact';
        DescriptionCaptionLbl: TextConst ENU = 'Description', ESM = 'Descripción', FRC = 'Description', ENC = 'Description';
        Due_DateCaptionLbl: TextConst ENU = 'Due Date', ESM = 'Fecha vencimiento', FRC = 'Date d''échéance', ENC = 'Due Date';
        Posting_DateCaptionLbl: TextConst ENU = 'Posting Date', ESM = 'Fecha registro', FRC = 'Date de report', ENC = 'Posting Date';
        Doc__DateCaptionLbl: TextConst ENU = 'Doc. Date', ESM = 'Fecha documento', FRC = 'Date doc.', ENC = 'Doc. Date';
        ShipmentCaptionLbl: TextConst ENU = 'Shipment', ESM = 'Envío', FRC = 'Livraison', ENC = 'Shipment';
        TermsCaptionLbl: TextConst ENU = 'Terms', ESM = 'Términos', FRC = 'Modalités', ENC = 'Terms';
        StatusCaptionLbl: TextConst ENU = 'Status', ESM = 'Estado', FRC = 'État', ENC = 'Status';
        Purchase_Document___TestCaption_Control1Lbl: TextConst ENU = 'Purchase Document - Test', ESM = 'Documento compras - Prueba', FRC = 'Document d''achat - Test', ENC = 'Purchase Document - Test';
        CurrReport_PAGENO_Control1029005CaptionLbl: TextConst ENU = 'Page', ESM = 'Pág.', FRC = 'Page', ENC = 'Page';
        Ship_toCaptionLbl: TextConst ENU = 'Ship-to', ESM = 'Dirección envío', FRC = 'Destinataire', ENC = 'Ship-to';
        Buy_fromCaptionLbl: TextConst ENU = 'Buy-from', ESM = 'Dirección de compra', FRC = 'Fournisseur', ENC = 'Buy-from';
        Pay_toCaptionLbl: TextConst ENU = 'Pay-to', ESM = 'Dirección pago', FRC = 'Paiement', ENC = 'Pay-to';
        Purchase_Header___Posting_Date_CaptionLbl: TextConst ENU = 'Posting Date', ESM = 'Fecha registro', FRC = 'Date de report', ENC = 'Posting Date';
        Purchase_Header___Document_Date_CaptionLbl: TextConst ENU = 'Document Date', ESM = 'Fecha emisión documento', FRC = 'Date de document', ENC = 'Document Date';
        Purchase_Header___Due_Date_CaptionLbl: TextConst ENU = 'Due Date', ESM = 'Fecha vencimiento', FRC = 'Date d''échéance', ENC = 'Due Date';
        Purchase_Header___Pmt__Discount_Date_CaptionLbl: TextConst ENU = 'Pmt. Discount Date', ESM = 'Fecha dto. P.P.', FRC = 'Date d''escompte de paiement', ENC = 'Pmt. Discount Date';
        Purchase_Header___Posting_Date__Control106CaptionLbl: TextConst ENU = 'Posting Date', ESM = 'Fecha registro', FRC = 'Date de report', ENC = 'Posting Date';
        Purchase_Header___Document_Date__Control107CaptionLbl: TextConst ENU = 'Document Date', ESM = 'Fecha emisión documento', FRC = 'Date de document', ENC = 'Document Date';
        Purchase_Header___Order_Date_CaptionLbl: TextConst ENU = 'Order Date', ESM = 'Fecha pedido', FRC = 'Date commande', ENC = 'Order Date';
        Purchase_Header___Expected_Receipt_Date_CaptionLbl: TextConst ENU = 'Expected Receipt Date', ESM = 'Fecha recepción esperada', FRC = 'Date réception prévue', ENC = 'Expected Receipt Date';
        Purchase_Header___Due_Date__Control19CaptionLbl: TextConst ENU = 'Due Date', ESM = 'Fecha vencimiento', FRC = 'Date d''échéance', ENC = 'Due Date';
        Purchase_Header___Pmt__Discount_Date__Control22CaptionLbl: TextConst ENU = 'Pmt. Discount Date', ESM = 'Fecha dto. P.P.', FRC = 'Date d''escompte de paiement', ENC = 'Pmt. Discount Date';
        Purchase_Header___Posting_Date__Control112CaptionLbl: TextConst ENU = 'Posting Date', ESM = 'Fecha registro', FRC = 'Date de report', ENC = 'Posting Date';
        Purchase_Header___Document_Date__Control113CaptionLbl: TextConst ENU = 'Document Date', ESM = 'Fecha emisión documento', FRC = 'Date de document', ENC = 'Document Date';
        Purchase_Header___Posting_Date__Control130CaptionLbl: TextConst ENU = 'Posting Date', ESM = 'Fecha registro', FRC = 'Date de report', ENC = 'Posting Date';
        Purchase_Header___Document_Date__Control131CaptionLbl: TextConst ENU = 'Document Date', ESM = 'Fecha emisión documento', FRC = 'Date de document', ENC = 'Document Date';
        Header_DimensionsCaptionLbl: TextConst ENU = 'Header Dimensions', ESM = 'Dimensiones cabecera', FRC = 'Dimensions en-tête', ENC = 'Header Dimensions';
        ErrorText_Number_CaptionLbl: TextConst ENU = 'Warning!', ESM = 'Advertencia', FRC = 'Attention!', ENC = 'Warning!';
        AmountCaptionLbl: TextConst ENU = 'Amount', ESM = 'Importe', FRC = 'Montant', ENC = 'Amount';
        Purchase_Line___Line_Discount___CaptionLbl: TextConst ENU = 'Line Disc. %', ESM = '% descuento línea', FRC = '% escompte ligne', ENC = 'Line Disc. %';
        Direct_Unit_CostCaptionLbl: TextConst ENU = 'Direct Unit Cost', ESM = 'Costo unit. directo', FRC = 'Coût unitaire direct', ENC = 'Direct Unit Cost';
        TempPurchLine__Inv__Discount_Amount_CaptionLbl: TextConst ENU = 'Inv. Discount Amount', ESM = 'Importe dto. factura', FRC = 'Montant d''escompte sur facture', ENC = 'Inv. Discount Amount';
        SubtotalCaptionLbl: TextConst ENU = 'Subtotal', ESM = 'Subtotal', FRC = 'Sous-total', ENC = 'Subtotal';
        VATDiscountAmountCaptionLbl: TextConst ENU = 'Payment Discount on VAT', ESM = 'Descuento P.P. sobre IVA', FRC = 'Escompte de paiement sur TVA', ENC = 'Payment Discount on Tax';
        Line_DimensionsCaptionLbl: TextConst ENU = 'Line Dimensions', ESM = 'Dimensiones línea', FRC = 'Dimensions de la ligne', ENC = 'Line Dimensions';
        ErrorText_Number__Control103CaptionLbl: TextConst ENU = 'Warning!', ESM = 'Advertencia', FRC = 'Attention!', ENC = 'Warning!';
        VAT_Amount_SpecificationCaptionLbl: TextConst ENU = 'Tax Amount Specification', ESM = 'Especificación importe IVA', FRC = 'Spécification du montant de TVA', ENC = 'Tax Amount Specification';
        VATAmountLine__VAT_Amount__Control98CaptionLbl: TextConst ENU = 'Tax Amount', ESM = 'Importe IVA', FRC = 'Montant de TVA', ENC = 'Tax Amount';
        VATAmountLine__VAT_Base__Control138CaptionLbl: TextConst ENU = 'Tax Base', ESM = 'Base IVA', FRC = 'Base de TVA', ENC = 'Tax Base';
        VATAmountLine__VAT___CaptionLbl: TextConst ENU = 'Tax %', ESM = '% IVA', FRC = '% TVA', ENC = 'Tax %';
        VATAmountLine__VAT_Identifier_CaptionLbl: TextConst ENU = 'Tax Identifier', ESM = 'Identific. IVA', FRC = 'Identificateur de TVA', ENC = 'Tax Identifier';
        VATAmountLine__Inv__Disc__Base_Amount__Control176CaptionLbl: TextConst ENU = 'Invoice Discount Base Amount', ESM = 'Importe base descuento factura', FRC = 'Montant de base d''escompte de la facture', ENC = 'Invoice Discount Base Amount';
        VATAmountLine__Line_Amount__Control175CaptionLbl: TextConst ENU = 'Line Amount', ESM = 'Importe línea', FRC = 'Montant de la ligne', ENC = 'Line Amount';
        VATAmountLine__Invoice_Discount_Amount__Control177CaptionLbl: TextConst ENU = 'Invoice Discount Amount', ESM = 'Importe descuento factura', FRC = 'Montant d''escompte de la facture', ENC = 'Invoice Discount Amount';
        VATAmountLine__VAT_Base_CaptionLbl: TextConst ENU = 'Continued', ESM = 'Continuación', FRC = 'Suite', ENC = 'Continued';
        VATAmountLine__VAT_Base__Control139CaptionLbl: TextConst ENU = 'Continued', ESM = 'Continuación', FRC = 'Suite', ENC = 'Continued';
        VATAmountLine__VAT_Base__Control137CaptionLbl: TextConst ENU = 'Total', ESM = 'Total', FRC = 'Total', ENC = 'Total';
        VALVATAmountLCY_Control242CaptionLbl: TextConst ENU = 'Tax Amount', ESM = 'Importe IVA', FRC = 'Montant de TVA', ENC = 'Tax Amount';
        VALVATBaseLCY_Control243CaptionLbl: TextConst ENU = 'Tax Base', ESM = 'Base IVA', FRC = 'Base de TVA', ENC = 'Tax Base';
        VATAmountLine__VAT____Control244CaptionLbl: TextConst ENU = 'Tax %', ESM = '% IVA', FRC = '% TVA', ENC = 'Tax %';
        VATAmountLine__VAT_Identifier__Control245CaptionLbl: TextConst ENU = 'Tax Identifier', ESM = 'Identific. IVA', FRC = 'Identificateur de TVA', ENC = 'Tax Identifier';
        ContinuedCaptionLbl: TextConst ENU = 'Continued', ESM = 'Continuación', FRC = 'Suite', ENC = 'Continued';
        ContinuedCaption_Control248Lbl: TextConst ENU = 'Continued', ESM = 'Continuación', FRC = 'Suite', ENC = 'Continued';
        TotalCaptionLbl: TextConst ENU = 'Total', ESM = 'Total', FRC = 'Total', ENC = 'Total';
        SalesTaxAmountLine__Tax_Area_Code_for_Key_CaptionLbl: TextConst ENU = 'Tax Area Code', ESM = 'Cód. área impuesto', FRC = 'Code de région fiscale', ENC = 'Tax Area Code';
        SalesTaxAmountLine__Tax_Base_Amount_CaptionLbl: TextConst ENU = 'Tax Base Amount', ESM = 'Imp. base impos.', FRC = 'Montant de base de la taxe', ENC = 'Tax Base Amount';
        SalesTaxAmountLine__Tax_Amount__Control1020000CaptionLbl: TextConst ENU = 'Tax Amount', ESM = 'Imp. impto.', FRC = 'Montant de la taxe', ENC = 'Tax Amount';
        SalesTaxAmountLine__Inv__Disc__Base_Amount_CaptionLbl: TextConst ENU = 'Inv. Disc. Base Amount', ESM = 'Base descuento factura', FRC = 'Montant de base escompte facture', ENC = 'Inv. Disc. Base Amount';
        SalesTaxAmountLine__Invoice_Discount_Amount_CaptionLbl: TextConst ENU = 'Invoice Discount Amount', ESM = 'Importe descuento factura', FRC = 'Montant d''escompte de la facture', ENC = 'Invoice Discount Amount';
        SalesTaxAmountLine__Tax___CaptionLbl: TextConst ENU = 'Tax %', ESM = '% Impto.', FRC = '% taxe', ENC = 'Tax %';
        Sales_Tax_AmountsCaptionLbl: TextConst ENU = 'Sales Tax Amounts', ESM = 'Importes de impuestos ventas', FRC = 'Montants de taxe de vente', ENC = 'Sales Tax Amounts';
        ContinuedCaption_Control1020002Lbl: TextConst ENU = 'Continued', ESM = 'Continuación', FRC = 'Suite', ENC = 'Continued';
        ContinuedCaption_Control1020007Lbl: TextConst ENU = 'Continued', ESM = 'Continuación', FRC = 'Suite', ENC = 'Continued';
        TotalCaption_Control1020012Lbl: TextConst ENU = 'Total', ESM = 'Total', FRC = 'Total', ENC = 'Total';
        Item_Charge_SpecificationCaptionLbl: TextConst ENU = 'Item Charge Specification', ESM = 'Especificación cargos producto', FRC = 'Détail frais annexes', ENC = 'Item Charge Specification';
        DescriptionCaption_Control227Lbl: TextConst ENU = 'Description', ESM = 'Descripción', FRC = 'Description', ENC = 'Description';
        PurchLine2_QuantityCaptionLbl: TextConst ENU = 'Assignable Qty', ESM = 'Cantidad asignable', FRC = 'Qté affectable', ENC = 'Assignable Qty';
        ContinuedCaption_Control197Lbl: TextConst ENU = 'Continued', ESM = 'Continuación', FRC = 'Suite', ENC = 'Continued';
        TotalCaption_Control194Lbl: TextConst ENU = 'Total', ESM = 'Total', FRC = 'Total', ENC = 'Total';
        ContinuedCaption_Control192Lbl: TextConst ENU = 'Continued', ESM = 'Continuación', FRC = 'Suite', ENC = 'Continued';

    local procedure AddError(Text: Text[250]);
    begin
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
    end;

    local procedure CheckRcptLines(PurchLine2: Record "Purchase Line");
    var
        TempPostedDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        if Abs(RemQtyToBeInvoiced) > Abs(PurchLine2."Qty. to Receive") then begin
            PurchRcptLine.Reset;
            case PurchLine2."Document Type" of
                PurchLine2."Document Type"::Order:
                    begin
                        PurchRcptLine.SetCurrentKey("Order No.", "Order Line No.");
                        PurchRcptLine.SetRange("Order No.", PurchLine2."Document No.");
                        PurchRcptLine.SetRange("Order Line No.", PurchLine2."Line No.");
                    end;
                PurchLine2."Document Type"::Invoice:
                    begin
                        PurchRcptLine.SetRange("Document No.", PurchLine2."Receipt No.");
                        PurchRcptLine.SetRange("Line No.", PurchLine2."Receipt Line No.");
                    end;
            end;
            PurchRcptLine.SetFilter("Qty. Rcd. Not Invoiced", '<>0');
            if PurchRcptLine.Find('-') then
                repeat
                    DimMgt.GetDimensionSet(TempPostedDimSetEntry, PurchRcptLine."Dimension Set ID");
                    if not DimMgt.CheckDimIDConsistency(TempDimSetEntry, TempPostedDimSetEntry, DATABASE::"Purchase Line", DATABASE::"Purch. Rcpt. Line") then AddError(DimMgt.GetDocDimConsistencyErr);
                    if PurchRcptLine."Buy-from Vendor No." <> PurchLine2."Buy-from Vendor No." then AddError(StrSubstNo(Text022, PurchLine2.FieldCaption("Buy-from Vendor No.")));
                    if PurchRcptLine.Type <> PurchLine2.Type then AddError(StrSubstNo(Text022, PurchLine2.FieldCaption(Type)));
                    if PurchRcptLine."No." <> PurchLine2."No." then AddError(StrSubstNo(Text022, PurchLine2.FieldCaption("No.")));
                    if PurchRcptLine."Gen. Bus. Posting Group" <> PurchLine2."Gen. Bus. Posting Group" then AddError(StrSubstNo(Text022, PurchLine2.FieldCaption("Gen. Bus. Posting Group")));
                    if PurchRcptLine."Gen. Prod. Posting Group" <> PurchLine2."Gen. Prod. Posting Group" then AddError(StrSubstNo(Text022, PurchLine2.FieldCaption("Gen. Prod. Posting Group")));
                    if PurchRcptLine."Location Code" <> PurchLine2."Location Code" then AddError(StrSubstNo(Text022, PurchLine2.FieldCaption("Location Code")));
                    if PurchRcptLine."Job No." <> PurchLine2."Job No." then AddError(StrSubstNo(Text022, PurchLine2.FieldCaption("Job No.")));
                    if PurchLine."Qty. to Invoice" * PurchRcptLine.Quantity < 0 then AddError(StrSubstNo(Text023, PurchLine2.FieldCaption("Qty. to Invoice")));
                    QtyToBeInvoiced := RemQtyToBeInvoiced - PurchLine."Qty. to Receive";
                    if Abs(QtyToBeInvoiced) > Abs(PurchRcptLine.Quantity - PurchRcptLine."Quantity Invoiced") then QtyToBeInvoiced := PurchRcptLine.Quantity - PurchRcptLine."Quantity Invoiced";
                    RemQtyToBeInvoiced := RemQtyToBeInvoiced - QtyToBeInvoiced;
                    PurchRcptLine."Quantity Invoiced" := PurchRcptLine."Quantity Invoiced" + QtyToBeInvoiced;
                until (PurchRcptLine.Next = 0) or (Abs(RemQtyToBeInvoiced) <= Abs(PurchLine2."Qty. to Receive"))
            else
                AddError(StrSubstNo(Text033, PurchLine2."Receipt Line No.", PurchLine2."Receipt No."));
        end;
        if Abs(RemQtyToBeInvoiced) > Abs(PurchLine2."Qty. to Receive") then if PurchLine2."Document Type" = PurchLine2."Document Type"::Invoice then AddError(StrSubstNo(Text037, PurchLine2."Receipt No."))
    end;

    local procedure CheckShptLines(PurchLine2: Record "Purchase Line");
    var
        TempPostedDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        if Abs(RemQtyToBeInvoiced) > Abs(PurchLine2."Return Qty. to Ship") then begin
            ReturnShptLine.Reset;
            case PurchLine2."Document Type" of
                PurchLine2."Document Type"::"Return Order":
                    begin
                        ReturnShptLine.SetCurrentKey("Return Order No.", "Return Order Line No.");
                        ReturnShptLine.SetRange("Return Order No.", PurchLine2."Document No.");
                        ReturnShptLine.SetRange("Return Order Line No.", PurchLine2."Line No.");
                    end;
                PurchLine2."Document Type"::"Credit Memo":
                    begin
                        ReturnShptLine.SetRange("Document No.", PurchLine2."Return Shipment No.");
                        ReturnShptLine.SetRange("Line No.", PurchLine2."Return Shipment Line No.");
                    end;
            end;
            PurchRcptLine.SetFilter("Qty. Rcd. Not Invoiced", '<>0');
            if ReturnShptLine.Find('-') then
                repeat
                    DimMgt.GetDimensionSet(TempPostedDimSetEntry, ReturnShptLine."Dimension Set ID");
                    if not DimMgt.CheckDimIDConsistency(TempDimSetEntry, TempPostedDimSetEntry, DATABASE::"Purchase Line", DATABASE::"Return Shipment Line") then AddError(DimMgt.GetDocDimConsistencyErr);
                    if ReturnShptLine."Buy-from Vendor No." <> PurchLine2."Buy-from Vendor No." then AddError(StrSubstNo(Text036, PurchLine2.FieldCaption("Buy-from Vendor No.")));
                    if ReturnShptLine.Type <> PurchLine2.Type then AddError(StrSubstNo(Text036, PurchLine2.FieldCaption(Type)));
                    if ReturnShptLine."No." <> PurchLine2."No." then AddError(StrSubstNo(Text036, PurchLine2.FieldCaption("No.")));
                    if ReturnShptLine."Gen. Bus. Posting Group" <> PurchLine2."Gen. Bus. Posting Group" then AddError(StrSubstNo(Text036, PurchLine2.FieldCaption("Gen. Bus. Posting Group")));
                    if ReturnShptLine."Gen. Prod. Posting Group" <> PurchLine2."Gen. Prod. Posting Group" then AddError(StrSubstNo(Text036, PurchLine2.FieldCaption("Gen. Prod. Posting Group")));
                    if ReturnShptLine."Location Code" <> PurchLine2."Location Code" then AddError(StrSubstNo(Text036, PurchLine2.FieldCaption("Location Code")));
                    if ReturnShptLine."Job No." <> PurchLine2."Job No." then AddError(StrSubstNo(Text036, PurchLine2.FieldCaption("Job No.")));
                    if -PurchLine."Qty. to Invoice" * ReturnShptLine.Quantity < 0 then AddError(StrSubstNo(Text025, PurchLine2.FieldCaption("Qty. to Invoice")));
                    QtyToBeInvoiced := RemQtyToBeInvoiced - PurchLine."Return Qty. to Ship";
                    if Abs(QtyToBeInvoiced) > Abs(ReturnShptLine.Quantity - ReturnShptLine."Quantity Invoiced") then QtyToBeInvoiced := ReturnShptLine.Quantity - ReturnShptLine."Quantity Invoiced";
                    RemQtyToBeInvoiced := RemQtyToBeInvoiced - QtyToBeInvoiced;
                    ReturnShptLine."Quantity Invoiced" := ReturnShptLine."Quantity Invoiced" + QtyToBeInvoiced;
                until (ReturnShptLine.Next = 0) or (Abs(RemQtyToBeInvoiced) <= Abs(PurchLine2."Return Qty. to Ship"))
            else
                AddError(StrSubstNo(Text034, PurchLine2."Return Shipment Line No.", PurchLine2."Return Shipment No."));
        end;
        if Abs(RemQtyToBeInvoiced) > Abs(PurchLine2."Return Qty. to Ship") then if PurchLine2."Document Type" = PurchLine2."Document Type"::"Credit Memo" then AddError(StrSubstNo(Text038, PurchLine2."Return Shipment No."));
    end;

    procedure TestJobFields(var PurchLine: Record "Purchase Line");
    var
        Job: Record Job;
        JT: Record "Job Task";
    begin
        if PurchLine."Job No." = '' then exit;
        if (PurchLine.Type <> PurchLine.Type::"G/L Account") and (PurchLine.Type <> PurchLine.Type::Item) then exit;
        if (PurchLine."Document Type" <> PurchLine."Document Type"::Invoice) and (PurchLine."Document Type" <> PurchLine."Document Type"::"Credit Memo") then exit;
        if not Job.Get(PurchLine."Job No.") then
            AddError(StrSubstNo(Text053, Job.TableCaption, PurchLine."Job No."))
        else
            if Job.Blocked <> Job.Blocked::" " then
                AddError(StrSubstNo(Text041, Job.FieldCaption(Blocked), Job.Blocked, Job.TableCaption, PurchLine."Job No."));
        if PurchLine."Job Task No." = '' then
            AddError(StrSubstNo(Text006, PurchLine.FieldCaption("Job Task No.")))
        else
            if not JT.Get(PurchLine."Job No.", PurchLine."Job Task No.") then AddError(StrSubstNo(Text053, JT.TableCaption, PurchLine."Job Task No."))
    end;

    local procedure IsInvtPosting(): Boolean;
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.SetRange("Document Type", "Purchase Header"."Document Type");
        PurchLine.SetRange("Document No.", "Purchase Header"."No.");
        PurchLine.SetFilter(Type, '%1|%2', PurchLine.Type::Item, PurchLine.Type::"Charge (Item)");
        if PurchLine.IsEmpty then exit(false);
        if "Purchase Header".Receive then begin
            PurchLine.SetFilter("Qty. to Receive", '<>%1', 0);
            if not PurchLine.IsEmpty then exit(true);
        end;
        if "Purchase Header".Ship then begin
            PurchLine.SetFilter("Return Qty. to Ship", '<>%1', 0);
            if not PurchLine.IsEmpty then exit(true);
        end;
        if "Purchase Header".Invoice then begin
            PurchLine.SetFilter("Qty. to Invoice", '<>%1', 0);
            if not PurchLine.IsEmpty then exit(true);
        end;
    end;

    procedure AddDimToTempLine(PurchLine: Record "Purchase Line"; var TempDimSetEntry: Record "Dimension Set Entry")
    var
        SourceCodesetup: Record "Source Code Setup";
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    begin
        SourceCodesetup.Get();

        DimMgt.AddDimSource(DefaultDimSource, DimMgt.PurchLineTypeToTableID(PurchLine.Type), PurchLine."No.");
        DimMgt.AddDimSource(DefaultDimSource, Database::Job, PurchLine."Job No.");
        DimMgt.AddDimSource(DefaultDimSource, Database::"Responsibility Center", PurchLine."Responsibility Center");

        PurchLine."Shortcut Dimension 1 Code" := '';
        PurchLine."Shortcut Dimension 2 Code" := '';

        PurchLine."Dimension Set ID" :=
          DimMgt.GetDefaultDimID(DefaultDimSource, SourceCodesetup.Purchases, PurchLine."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 2 Code",
                PurchLine."Dimension Set ID", DATABASE::Vendor);

    end;

    procedure InitializeRequest(NewReceiveShipOnNextPostReq: Boolean; NewInvOnNextPostReq: Boolean; NewShowDim: Boolean; NewShowItemChargeAssgnt: Boolean);
    begin
        ReceiveShipOnNextPostReq := NewReceiveShipOnNextPostReq;
        InvOnNextPostReq := NewInvOnNextPostReq;
        ShowDim := NewShowDim;
        ShowItemChargeAssgnt := NewShowItemChargeAssgnt;
    end;

    local procedure VerifyBuyFromVend(PurchaseHeader: Record "Purchase Header");
    begin
        if PurchaseHeader."Buy-from Vendor No." = '' then
            AddError(StrSubstNo(Text006, PurchaseHeader.FieldCaption("Buy-from Vendor No.")))
        else begin
            if Vend.Get(PurchaseHeader."Buy-from Vendor No.") then begin
                if Vend."Privacy Blocked" then AddError(Vend.GetPrivacyBlockedGenericErrorText(Vend));
                if Vend.Blocked = Vend.Blocked::All then AddError(StrSubstNo(Text041, Vend.FieldCaption(Blocked), Vend.Blocked, Vend.TableCaption, PurchaseHeader."Buy-from Vendor No."));
            end
            else
                AddError(StrSubstNo(Text008, Vend.TableCaption, PurchaseHeader."Buy-from Vendor No."));
        end;
    end;

    local procedure VerifyPayToVend(PurchaseHeader: Record "Purchase Header");
    begin
        if PurchaseHeader."Pay-to Vendor No." = '' then
            AddError(StrSubstNo(Text006, PurchaseHeader.FieldCaption("Pay-to Vendor No.")))
        else
            if PurchaseHeader."Pay-to Vendor No." <> PurchaseHeader."Buy-from Vendor No." then begin
                if Vend.Get(PurchaseHeader."Pay-to Vendor No.") then begin
                    if Vend."Privacy Blocked" then AddError(Vend.GetPrivacyBlockedGenericErrorText(Vend));
                    if Vend.Blocked = Vend.Blocked::All then AddError(StrSubstNo(Text041, Vend.FieldCaption(Blocked), Vend.Blocked::All, Vend.TableCaption, PurchaseHeader."Pay-to Vendor No."));
                end
                else
                    AddError(StrSubstNo(Text008, Vend.TableCaption, PurchaseHeader."Pay-to Vendor No."));
            end;
    end;

    local procedure VerifyPostingDate(PurchaseHeader: Record "Purchase Header");
    var
        UserSetupManagement: Codeunit "User Setup Management";
        InvtPeriodEndDate: Date;
        TempErrorText: Text[250];
    begin
        if PurchaseHeader."Posting Date" = 0D then
            AddError(StrSubstNo(Text006, PurchaseHeader.FieldCaption("Posting Date")))
        else
            if PurchaseHeader."Posting Date" <> NormalDate(PurchaseHeader."Posting Date") then
                AddError(StrSubstNo(Text009, PurchaseHeader.FieldCaption("Posting Date")))
            else begin
                if not UserSetupManagement.TestAllowedPostingDate(PurchaseHeader."Posting Date", TempErrorText) then AddError(TempErrorText);
                if IsInvtPosting then begin
                    InvtPeriodEndDate := PurchaseHeader."Posting Date";
                    if not InvtPeriod.IsValidDate(InvtPeriodEndDate) then AddError(StrSubstNo(Text010, Format(PurchaseHeader."Posting Date")))
                end;
            end;
    end;
}
