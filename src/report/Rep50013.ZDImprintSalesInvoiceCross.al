report 50013 "ZD-Imprint Sales Invoice Cross"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2004-04-07" area="REPORTS SR" feature="622"
    //     releaseversion="NAVUS3.70">NA Sales Document</add>
    //   <change id="NA0002" dev="JNOZZI" date="2004-08-02" area="BUG FIX"  request="US-538-480-4KZF"
    //     baseversion="NAVUS3.70" releaseversion="NAVNA4.00">Fixed bug where comment had a quantity ordered.</change>
    //   <change id="NA0003" dev="JNOZZI" date="2006-05-10" area="BUG FIX"  request="16629"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA4.00.03">Allow the printing of a blank &quot;voided&quot;
    //     invoice.</change>
    //   <change id="NA0004" dev="JNOZZI" date="2006-06-05" area="REPORTS SR" feature="337"
    //     baseversion="NAVNA4.00.03" releaseversion="NAVNA5.00">Implement the W1 Logo Position functionality.</change>
    //   <change id="NA0006" dev="JNOZZI" date="2007-12-20" area="NASALESTAX" feature="31197"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.01">Implement hooks to External Sales Tax Engine.</change>
    //   <change id="NA0007" dev="MBAHADUR" date="2007-12-10" area="REPORTS SR" feature="0003"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA5.00.01">modified sales comment line tableview property to
    //     support comment line feature.</change>
    //   <change id="NA0008" dev="JMALIK" date="2008-01-18" area="NASALESTAX" feature="31623"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA5.00.01">Show Prepayment Request on printed document if
    //     prepayment</change>
    //   <change id="NA0009" dev="V-JELI" date="2008-05-16" area="NASALESTAX" feature="37492"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA6.00">Change in handling Blank Tax Area on lines.</change>
    //   <change id="NA0010" dev="V-WQIAN" date="2008-06-04" area="REPORTS SR" feature="NC14261"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA6.00">Report Transformation - Local Report Layout.</change>
    //   <change id="NA0011" dev="V-JOOSTL" date="2009-04-23" area="REPORTS SR"  request="PS37379"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00.01">If header comments exist, an extra blank page is printed
    //     before the document.</change>
    //   <change id="NA0012" dev="V-STFENG" date="2009-05-13" area="REPORTS SR"  request="PS36734"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00.01">Company Logo does not appear on Reports in RTC</change>
    //   <add id="NA0013" dev="ALL-E" date="2010-11-15" area="MX" feature="VSTF202674"
    //     releaseversion="NA7.00">RFC and CURP data fields</add>
    //   <add id="NA0014" dev="hhjort" date="2011-03-30" area="XX" feature="VSTFS260459"
    //     releaseversion="NAVNA7.00">Kitting Report transformation of Sales Invoice
    //     (order confirmation), sales shipment and posted sales invoice for NA (include
    //     Assembly info)</add>
    //   <change id="NA0015" dev="hhjort" date="2011-04-07" area="XX" feature="VSTFS256949"
    //     baseversion="NAVNA7.00" releaseversion="NAVNA7.00">Correction: Blanks should be Text, not C
    //    ode</change>
    // </changelog>
    // 
    // IMP1.01,21-Jan-16,ST: Added Code "Sales Invoice Line - OnPostDataItem()" to print tracking package no's.
    // IMP1.02,02/20/18,SK: Added Veribage at Page Footer in layout as user required.
    // IMP1.03,03/13/18,SK: Adjusted the Page Footer section.
    // IMP1.04,04/02/18,SK: Added code to get Serial Number details & delcared global variables.
    // IMP1.05,08/13/21,SK: Set the Decimal places as 0:2 for UnitPriceToPrint.
    // IMP1.06,11/29/21,SK: Change the UnitPriceToPrint source expression to print Unit Price.
    // IMP1.07,03/06/23,SK: Added code at "Sales Invoice Line"-OnAfterGetRecord() and "Sales Invoice Header"-OnAfterGetRecord() and layout changes also.
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/ZD-Imprint Sales Invoice Cross.rdl';
    Caption = 'Imprint Sales Invoice with Cross-Reference';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Invoice';

            column(No_SalesInvHeader; "No.")
            {
            }
            column(LAXPostedPackageRecGbl_External_Tracking_No; LAXPostedPackageRecGbl."External Tracking No.")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                dataitem("Serial InvLine"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("Document No."), "Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) WHERE(Type = FILTER(Item));

                    trigger OnAfterGetRecord()
                    begin
                        //IMP1.04 Start
                        TempItemLedgEntry.Reset;
                        TempItemLedgEntry.DeleteAll;
                        TempTrackingSpecBuffer.Reset();
                        TempTrackingSpecBuffer.DeleteAll();
                        InvoiceRowID := '';
                        if Type = Type::Item then begin
                            InvoiceRowID := RowID1;
                            //IMP1.07 Start
                            //ItemTrackMgntCU.RetrieveILEFromPostedInv(TempItemLedgEntry, InvoiceRowID);
                            ItemTrackDocMgmt.RetrieveDocumentItemTracking(TempTrackingSpecBuffer, "Sales Invoice Header"."No.", DATABASE::"Sales Invoice Header", 0);
                            //IMP1.07 End
                        end;
                        TempTrackingSpecBuffer.Reset;
                        TempTrackingSpecBuffer.SetRange("Source ID", "Sales Invoice Line"."Document No.");
                        TempTrackingSpecBuffer.SetRange("Source Ref. No.", "Sales Invoice Line"."Line No.");
                        TempTrackingSpecBuffer.SetFilter("Serial No.", '<>%1', '');
                        if TempTrackingSpecBuffer.FindSet then begin
                            TempSalesInvoiceLine.Init;
                            TempSalesInvoiceLine."Document No." := "Sales Invoice Header"."No.";
                            TempSalesInvoiceLine."Line No." := HighestLineNo + 10;
                            HighestLineNo := TempSalesInvoiceLine."Line No.";
                            //IF TempItemLedgEntry."Serial No." <>'' THEN BEGIN
                            TempSalesInvoiceLine.Description := 'Serial Numbers:';
                            TempSalesInvoiceLine."Description 2" := '';
                            TempSalesInvoiceLine.Insert;
                            HighestLineNo := TempSalesInvoiceLine."Line No.";
                            repeat
                                with TempSalesInvoiceLine do begin
                                    TempSalesInvoiceLine.Init;
                                    TempSalesInvoiceLine."Document No." := "Sales Invoice Header"."No.";
                                    TempSalesInvoiceLine."Line No." := HighestLineNo + 1;
                                    HighestLineNo := TempSalesInvoiceLine."Line No.";
                                end;
                                if TempTrackingSpecBuffer."Serial No." <> '' then begin
                                    TempSalesInvoiceLine.Description := TempTrackingSpecBuffer."Serial No.";
                                    TempSalesInvoiceLine."Description 2" := '';
                                end;
                                TempSalesInvoiceLine.Insert;
                                HighestLineNo := TempSalesInvoiceLine."Line No.";
                            until TempTrackingSpecBuffer.Next = 0;
                        end;
                        //IMP1.04 End
                    end;
                }
                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"), "Print On Invoice" = CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        // NA0007- Begin
                        TempSalesInvoiceLine.Init;
                        TempSalesInvoiceLine."Document No." := "Sales Invoice Header"."No.";
                        TempSalesInvoiceLine."Line No." := HighestLineNo + 10;
                        HighestLineNo := TempSalesInvoiceLine."Line No.";
                        if StrLen(Comment) <= MaxStrLen(TempSalesInvoiceLine.Description) then begin
                            TempSalesInvoiceLine.Description := Comment;
                            TempSalesInvoiceLine."Description 2" := '';
                        end
                        else begin
                            SpacePointer := MaxStrLen(TempSalesInvoiceLine.Description) + 1;
                            while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do SpacePointer := SpacePointer - 1;
                            if SpacePointer = 1 then SpacePointer := MaxStrLen(TempSalesInvoiceLine.Description) + 1;
                            TempSalesInvoiceLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                            TempSalesInvoiceLine."Description 2" := CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesInvoiceLine."Description 2"));
                        end;
                        TempSalesInvoiceLine.Insert;
                        // NA0007 - End
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    TempSalesInvoiceLine := "Sales Invoice Line";
                    TempSalesInvoiceLine.Insert;
                    // NA0014.begin
                    TempSalesInvoiceLineAsm := "Sales Invoice Line";
                    TempSalesInvoiceLineAsm.Insert;
                    // NA0014.end
                    HighestLineNo := "Line No.";
                end;

                trigger OnPostDataItem()
                begin
                    //IMP1.01 Start
                    PostedShipRec.Reset;
                    PostedShipRec.SetRange("Sales Order Number", "Sales Invoice Header"."Order No.");
                    if PostedShipRec.FindSet then begin
                        FirstPackage := true;
                        repeat
                            TempSalesInvoiceLine.Init;
                            TempSalesInvoiceLine."Document No." := "Sales Invoice Header"."No.";
                            TempSalesInvoiceLine."Line No." := HighestLineNo + 1000;
                            if FirstPackage then
                                TempSalesInvoiceLine.Description := 'Tracking No(s): ' + PostedShipRec."Tracking Number"
                            else
                                TempSalesInvoiceLine.Description := '                ' + PostedShipRec."Tracking Number";
                            TempSalesInvoiceLine."Description 2" := '';
                            HighestLineNo := TempSalesInvoiceLine."Line No.";
                            TempSalesInvoiceLine.Insert;
                            FirstPackage := false;
                        until PostedShipRec.Next = 0;
                    end;
                    //IMP1.01 End
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesInvoiceLine.Reset;
                    TempSalesInvoiceLine.DeleteAll;
                    // NA0014.begin
                    TempSalesInvoiceLineAsm.Reset;
                    TempSalesInvoiceLineAsm.DeleteAll;
                    // NA0014.end
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"), "Print On Invoice" = CONST(true), "Document Line No." = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    TempSalesInvoiceLine.Init;
                    TempSalesInvoiceLine."Document No." := "Sales Invoice Header"."No.";
                    TempSalesInvoiceLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesInvoiceLine."Line No.";
                    if StrLen(Comment) <= MaxStrLen(TempSalesInvoiceLine.Description) then begin
                        TempSalesInvoiceLine.Description := Comment;
                        TempSalesInvoiceLine."Description 2" := '';
                    end
                    else begin
                        SpacePointer := MaxStrLen(TempSalesInvoiceLine.Description) + 1;
                        while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do SpacePointer := SpacePointer - 1;
                        if SpacePointer = 1 then SpacePointer := MaxStrLen(TempSalesInvoiceLine.Description) + 1;
                        TempSalesInvoiceLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                        TempSalesInvoiceLine."Description 2" := CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesInvoiceLine."Description 2"));
                    end;
                    TempSalesInvoiceLine.Insert;
                end;

                trigger OnPreDataItem()
                begin
                    // NA0007- Begin
                    TempSalesInvoiceLine.Init;
                    TempSalesInvoiceLine."Document No." := "Sales Invoice Header"."No.";
                    TempSalesInvoiceLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesInvoiceLine."Line No.";
                    TempSalesInvoiceLine.Insert;
                    // NA0007- End
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
                    column(CompanyInformationPicture; CompanyInfo3.Picture)
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
                    column(RemitToLabel; RemitToLabel)
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
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(ShptDate_SalesInvHeader; "Sales Invoice Header"."Shipment Date")
                    {
                    }
                    column(DueDate_SalesInvHeader; "Sales Invoice Header"."Due Date")
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
                    column(BilltoCustNo_SalesInvHeader; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(YourRef_SalesInvHeader; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(OrderDate_SalesInvHeader; "Sales Invoice Header"."Order Date")
                    {
                    }
                    column(OrderNo_SalesInvHeader; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(DocumentDate_SalesInvHeader; "Sales Invoice Header"."Document Date")
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
                    column(DocumentText; DocumentText)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(CustTaxIdentificationType; Format(Cust."Tax Identification Type"))
                    {
                    }
                    column(BillCaption; BillCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(ShipDateCaption; ShipDateCaptionLbl)
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
                    column(InvoiceNumberCaption; InvoiceNumberCaptionLbl)
                    {
                    }
                    column(InvoiceDateCaption; InvoiceDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    dataitem(SalesInvLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(DoNotPrintTheLine; DoNotPrintTheLine)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesInvoiceLineNo; TempSalesInvoiceLine."No.")
                        {
                        }
                        column(TempSalesInvoiceLineUOM; TempSalesInvoiceLine."Unit of Measure Code")
                        {
                        }
                        column(OrderedQuantity; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesInvoiceLineQty; TempSalesInvoiceLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; TempSalesInvoiceLine."Unit Price")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(LowDescriptionToPrint; LowDescriptionToPrint)
                        {
                        }
                        column(HighDescriptionToPrint; HighDescriptionToPrint)
                        {
                        }
                        column(TempSalesInvoiceLineDocNo; TempSalesInvoiceLine."Document No.")
                        {
                        }
                        column(TempSalesInvoiceLineLineNo; TempSalesInvoiceLine."Line No.")
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesInvoiceLineAmtTaxLiable; TempSalesInvoiceLine.Amount - TaxLiable)
                        {
                        }
                        column(TempSalesInvoiceLineAmtAmtExclInvDisc; TempSalesInvoiceLine.Amount - AmountExclInvDisc)
                        {
                        }
                        column(TempSalesInvoiceLineAmtInclVATAmount; TempSalesInvoiceLine."Amount Including VAT" - TempSalesInvoiceLine.Amount)
                        {
                        }
                        column(TempSalesInvoiceLineAmtInclVAT; TempSalesInvoiceLine."Amount Including VAT")
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
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
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
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number);

                            column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                            }
                            column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineNo; BlanksForIndent + TempPostedAsmLine."No.")
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                // NA0014.begin
                                if Number = 1 then
                                    TempPostedAsmLine.FindSet
                                else
                                    TempPostedAsmLine.Next;
                                // NA0014.end
                            end;

                            trigger OnPreDataItem()
                            begin
                                // NA0014.begin
                                Clear(TempPostedAsmLine);
                                SetRange(Number, 1, TempPostedAsmLine.Count);
                                // NA0014.end
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            Clear(DoNotPrintTheLine);
                            OnLineNumber := OnLineNumber + 1;
                            if OnLineNumber = 1 then
                                TempSalesInvoiceLine.Find('-')
                            else
                                TempSalesInvoiceLine.Next;
                            if (TempSalesInvoiceLine."No." <> '') and (TempSalesInvoiceLine.Quantity = 0) then DoNotPrintTheLine := true;
                            OrderedQuantity := 0;
                            if "Sales Invoice Header"."Order No." = '' then
                                OrderedQuantity := TempSalesInvoiceLine.Quantity
                            else begin
                                if OrderLine.Get(1, "Sales Invoice Header"."Order No.", TempSalesInvoiceLine."Line No.") then
                                    OrderedQuantity := OrderLine.Quantity
                                else begin
                                    ShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
                                    ShipmentLine.SetRange("Order Line No.", TempSalesInvoiceLine."Line No.");
                                    if ShipmentLine.Find('-') then //NA0002
                                        repeat
                                            OrderedQuantity := OrderedQuantity + ShipmentLine.Quantity;
                                        until 0 = ShipmentLine.Next;
                                end;
                            end;
                            DescriptionToPrint := TempSalesInvoiceLine.Description + ' ' + TempSalesInvoiceLine."Description 2";
                            if TempSalesInvoiceLine.Type.AsInteger() = 0 then begin
                                /*
                                IF OnLineNumber < NumberOfLines THEN BEGIN
                                  NEXT;
                                  if Type.AsInteger() = 0 THEN BEGIN
                                    DescriptionToPrint :=
                                      COPYSTR(DescriptionToPrint + ' ' + Description + ' ' + "Description 2",1,MAXSTRLEN(DescriptionToPrint));
                                    OnLineNumber := OnLineNumber + 1;
                                    SalesInvLine.NEXT;
                                  END ELSE
                                    NEXT(-1);
                                END;
                                */
                                TempSalesInvoiceLine."No." := '';
                                TempSalesInvoiceLine."Unit of Measure" := '';
                                TempSalesInvoiceLine.Amount := 0;
                                TempSalesInvoiceLine."Amount Including VAT" := 0;
                                TempSalesInvoiceLine."Inv. Discount Amount" := 0;
                                TempSalesInvoiceLine.Quantity := 0;
                            end
                            else
                                if TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::"G/L Account" then
                                    TempSalesInvoiceLine."No." := ''
                                else //B2BUPG >>
                                    if (TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::Item) and (TempSalesInvoiceLine."Item Reference No." <> '') then TempSalesInvoiceLine."No." := TempSalesInvoiceLine."Item Reference No.";
                            //B2BUPG <<
                            if TempSalesInvoiceLine."No." = '' then begin
                                HighDescriptionToPrint := DescriptionToPrint;
                                LowDescriptionToPrint := '';
                            end
                            else begin
                                HighDescriptionToPrint := '';
                                LowDescriptionToPrint := DescriptionToPrint;
                            end;
                            if TempSalesInvoiceLine.Amount <> TempSalesInvoiceLine."Amount Including VAT" then begin
                                TaxFlag := true;
                                TaxLiable := TempSalesInvoiceLine.Amount;
                            end
                            else begin
                                TaxFlag := false;
                                TaxLiable := 0;
                            end;
                            AmountExclInvDisc := TempSalesInvoiceLine.Amount + TempSalesInvoiceLine."Inv. Discount Amount";
                            if TempSalesInvoiceLine.Quantity = 0 then
                                UnitPriceToPrint := 0 // so it won't print
                            else
                                UnitPriceToPrint := Round(AmountExclInvDisc / TempSalesInvoiceLine.Quantity, 0.00001);
                            /*               if "Cross-Reference No." <> '' then
                                              "No." := "Cross-Reference No."; */
                            //NA0010.Begin
                            if OnLineNumber = NumberOfLines then PrintFooter := true;
                            //NA0010.end
                            // NA0014.begin
                            CollectAsmInformation(TempSalesInvoiceLine);
                            // NA0014.end
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CreateTotals(TaxLiable, AmountExclInvDisc, TempSalesInvoiceLine.Amount, TempSalesInvoiceLine."Amount Including VAT");
                            NumberOfLines := TempSalesInvoiceLine.Count;
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    // CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then SalesInvPrinted.Run("Sales Invoice Header");
                        CurrReport.Break;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + Abs(NoCopies) + Customer."Invoice Copies";
                    if NoLoops <= 0 then NoLoops := 1;
                    CopyNo := 0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if PrintCompany then begin
                    if RespCenter.Get("Responsibility Center") then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    end;
                end;
                //CurrReport.Language := Language.GetLanguageID("Language Code");
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                if "Salesperson Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");
                // NA0003.begin
                if not Customer.Get("Bill-to Customer No.") then begin
                    Clear(Customer);
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                end;
                // NA0003.end
                //NA0008.begin
                DocumentText := USText000;
                if "Prepayment Invoice" then DocumentText := USText001;
                //NA0008.end
                FormatAddress.SalesInvBillTo(BillToAddress, "Sales Invoice Header");
                FormatAddress.SalesInvShipTo(ShipToAddress, ShipToAddress, "Sales Invoice Header");
                if "Payment Terms Code" = '' then
                    Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");
                // NA0003.begin
                // Customer.GET("Bill-to Customer No.");
                // NA0003.end
                if LogInteraction then
                    if not CurrReport.Preview then begin
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code", "Campaign No.", "Posting Description", '')
                        else
                            SegManagement.LogDocument(4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
                    end;
                Clear(BreakdownTitle);
                Clear(BreakdownLabel);
                Clear(BreakdownAmt);
                TotalTaxLabel := Text008;
                // ISS2.00 11.18.13 DFP ===================================================\
                RemitToLabel := ISSText001;
                // End ====================================================================/
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
                    // NA0006.begin
                    if TaxArea."Use External Tax Engine" then
                        SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Sales Invoice Header", 0, "No.")
                    else begin
                        // NA0006.end
                        SalesTaxCalc.AddSalesInvoiceLines("No.");
                        SalesTaxCalc.EndSalesTaxCalculation("Posting Date");
                    end; // NA0006
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
                //IMP1.07 Start
                LAXPostedPackageRecGbl.Reset();
                LAXPostedPackageRecGbl.SetRange("Source Type", 36);
                LAXPostedPackageRecGbl.SetRange("Source Subtype", 1, 2);
                LAXPostedPackageRecGbl.SetRange("Source ID", "Sales Invoice Header"."Order No.");
                if LAXPostedPackageRecGbl.FindFirst() then;
                //IMP1.07 End
            end;

            trigger OnPreDataItem()
            begin
                // NA0004.begin
                // CompanyInformation.GET('');
                // IF PrintCompany THEN
                // FormatAddress.Company(CompanyAddress,CompanyInformation)
                // ELSE
                // CLEAR(CompanyAddress);
                // NA0004.end
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

                    field(NoCopies; NoCopies)
                    {
                        Caption = 'Number of Copies';
                        ApplicationArea = All;
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        Caption = 'Print Company Address';
                        ApplicationArea = All;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        Caption = 'Show Assembly Components';
                        ApplicationArea = All;
                    }
                    field("Print Logo"; PrintLogo)
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
        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        //--EQ7.0--
        //--EQ7.0--
    end;

    trigger OnPreReport()
    begin
        //--EQ7.0--
        //ZdSend.Initialize(CurrReport.OBJECTID(FALSE), CurrReport.PREVIEW);
        //--EQ7.0--
        ShipmentLine.SetCurrentKey("Order No.", "Order Line No.");
        if not CurrReport.UseRequestPage then InitLogInteraction;
        // NA0004.begin
        CompanyInformation.Get;
        SalesSetup.Get;
        // ISS2.00 DFP ==================================================================\
        if not PrintLogo then SalesSetup."Logo Position on Documents" := SalesSetup."Logo Position on Documents"::"No Logo";
        // End ==========================================================================/
        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo3.Get;
                    CompanyInfo3.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.Get;
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.Get;
                    CompanyInfo2.CalcFields(Picture);
                end;
        end;
        if PrintCompany then
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
        // NA0004.end
        // ISS2.00 11.26.13 =================================================================\
        // Add Phone No
        IF PrintCompany THEN //FormatAddress.AddLineToAddress(CompanyAddress,CompanyInformation."Phone No.");
            UpdateCodeGVar.AddLineToAddress(CompanyAddress, CompanyInformation."Phone No.");
        // End ==============================================================================/
        // ISS2.00 11.14.13 ==============================================\
        // Always print Remit-To Address
        //FormatAddress.CompanyRemit(CompanyAddressRemit, CompanyInformation)
        UpdateCodeGVar.CompanyRemit(CompanyAddressRemit, CompanyInformation) // End ===========================================================/
    end;

    var
        TaxLiable: Decimal;
        UpdateCodeGVar: Codeunit UpdateCode;
        OrderedQuantity: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        OrderLine: Record "Sales Line";
        ShipmentLine: Record "Sales Shipment Line";
        TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
        TempSalesInvoiceLineAsm: Record "Sales Invoice Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        DescriptionToPrint: Text[210];
        HighDescriptionToPrint: Text[210];
        LowDescriptionToPrint: Text[210];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        SalesInvPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        Text009: Label 'VOID INVOICE';
        DocumentText: Text[20];
        USText000: Label 'INVOICE';
        USText001: Label 'PREPAYMENT REQUEST';
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        BillCaptionLbl: Label 'Bill';
        ToCaptionLbl: Label 'To:';
        ShipViaCaptionLbl: Label 'Ship Via';
        ShipDateCaptionLbl: Label 'Ship Date';
        DueDateCaptionLbl: Label 'Due Date';
        TermsCaptionLbl: Label 'Terms';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'P.O. Number';
        PODateCaptionLbl: Label 'P.O. Date';
        OurOrderNoCaptionLbl: Label 'Our Order No.';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        InvoiceNumberCaptionLbl: Label 'Invoice Number:';
        InvoiceDateCaptionLbl: Label 'Invoice Date:';
        PageCaptionLbl: Label 'Page:';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ItemDescriptionCaptionLbl: Label 'Item/Description';
        UnitCaptionLbl: Label 'Unit';
        OrderQtyCaptionLbl: Label 'Order Qty';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Unit Price';
        TotalPriceCaptionLbl: Label 'Total Price';
        SubtotalCaptionLbl: Label 'Subtotal:';
        InvoiceDiscountCaptionLbl: Label 'Invoice Discount:';
        TotalCaptionLbl: Label 'Total:';
        AmountSubjecttoSalesTaxCaptionLbl: Label 'Amount Subject to Sales Tax';
        AmountExemptfromSalesTaxCaptionLbl: Label 'Amount Exempt from Sales Tax';
        PrintLogo: Boolean;
        CompanyAddressRemit: array[8] of Text[50];
        ISSText001: Label 'Remit To:';
        RemitToLabel: Text[50];
        "-IMP1.01-": Integer;
        PostedShipRec: Record "Posted Shipments";
        FirstPackage: Boolean;
        DoNotPrintTheLine: Boolean;
        "-IMP1.04-": Integer;
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        TempTrackingSpecBuffer: Record "Tracking Specification" temporary;
        InvoiceRowID: Text[250];
        ItemTrackMgntCU: Codeunit "Item Tracking Management";
        ItemTrackDocMgmt: Codeunit "Item Tracking Doc. Management";
        CUSTCU: Codeunit 90000;
        LAXPostedPackageRecGbl: Record "LAX Posted Package";

    procedure InitLogInteraction()
    begin
        //LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Inv.") <> '';
    end;

    procedure CollectAsmInformation(TempSalesInvoiceLine: Record "Sales Invoice Line" temporary)
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        // NA0014.begin
        TempPostedAsmLine.DeleteAll;
        if not DisplayAssemblyInformation then exit;
        if not TempSalesInvoiceLineAsm.Get(TempSalesInvoiceLine."Document No.", TempSalesInvoiceLine."Line No.") then exit;
        SalesInvoiceLine.Get(TempSalesInvoiceLineAsm."Document No.", TempSalesInvoiceLineAsm."Line No.");
        if SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item then exit;
        ValueEntry.SetCurrentKey("Document No.");
        ValueEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
        if not ValueEntry.FindSet then exit;
        repeat
            if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                if ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" then begin
                    SalesShipmentLine.Get(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) then begin
                        PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
                        if PostedAsmLine.FindSet then
                            repeat
                                TreatAsmLineBuffer(PostedAsmLine);
                            until PostedAsmLine.Next = 0;
                    end;
                end;
            end;
        until ValueEntry.Next = 0;
        // NA0014.end
    end;

    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        // NA0014.begin
        Clear(TempPostedAsmLine);
        TempPostedAsmLine.SetRange(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SetRange("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SetRange("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SetRange(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SetRange("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        if TempPostedAsmLine.FindFirst then begin
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.Modify;
        end
        else begin
            Clear(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.Insert;
        end;
        // NA0014.end
    end;

    procedure GetUOMText(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        // NA0014.begin
        if not UnitOfMeasure.Get(UOMCode) then exit(UOMCode);
        exit(UnitOfMeasure.Description);
        // NA0014.end
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        // NA0014.begin
        exit(PadStr('', 2, ' '));
        // NA0014.end
    end;
}
