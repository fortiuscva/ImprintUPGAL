report 50048 "Service Ticket"
{
    // <changelog>
    //   <add id="NA0000" dev="fpederse" date="2009-11-16" area="NA" feature="1"
    //     releaseversion="NAVNA7.00.00">Integration from main GDL Branch.</add>
    //   <add id="NA0001" dev="ALL-E" date="2010-05-14" area="NASALESTAX" feature="VSTF113568"
    //     releaseversion="NAVNA7.00">Service Quote report does not show Sales Tax information</add>
    // </changelog>
    // 
    // IMP1.01,05/16/18,SK: Created new report (Save As 5900)
    //                      Changed thelayout as user required.
    // IMP1.02,06/12/18,SK: Removed the "Travel Start" & "Travel End" lines at Page Footer scction in layout.
    // IMP1.03,02/28/2020,SK: Added "Salesperson" details into layout.
    //                        Added code at "Service Header - OnAfterGetRecord()" to get the value & declared global variable.
    DefaultLayout = RDLC;
    RDLCLayout = './Service Ticket.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Service Ticket';

    dataset
    {
        dataitem("Service Header"; "Service Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")WHERE("Document Type"=CONST(Order));
            RequestFilterFields = "No.", "Customer No.";

            column(Service_Header_Document_Type; "Document Type")
            {
            }
            column(Service_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo1_Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo2_Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(Service_Header___Contract_No__; "Service Header"."Contract No.")
                    {
                    }
                    column(Service_Header___Order_Time_; "Service Header"."Order Time")
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(Service_Header___Order_Date_; Format("Service Header"."Order Date"))
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(Service_Header__Status; "Service Header".Status)
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(Service_Header___No__; "Service Header"."No.")
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(CompanyAddr_7_; CompanyAddr[7])
                    {
                    }
                    column(CompanyAddr_8_; CompanyAddr[8])
                    {
                    }
                    column(CompanyAddr_6_; CompanyAddr[6])
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddr[5])
                    {
                    }
                    column(Service_Header___Bill_to_Name_; "Service Header"."Bill-to Name")
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(STRSUBSTNO_Text001_CopyText_; StrSubstNo(Text001, CopyText))
                    {
                    }
                    column(STRSUBSTNO_Text002_FORMAT_CurrReport_PAGENO__; StrSubstNo(Text002, Format(CurrReport.PageNo)))
                    {
                    }
                    column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
                    {
                    }
                    column(Service_Header___Phone_No__; "Service Header"."Phone No.")
                    {
                    }
                    column(Service_Header___E_Mail_; "Service Header"."E-Mail")
                    {
                    }
                    column(Service_Header__Description; "Service Header".Description)
                    {
                    }
                    column(PageCaption; StrSubstNo(Text002, ' '))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(Contract_No_Caption; Contract_No_CaptionLbl)
                    {
                    }
                    column(Service_Header___Order_Time_Caption; "Service Header".FieldCaption("Order Time"))
                    {
                    }
                    column(Service_Header___Order_Date_Caption; Service_Header___Order_Date_CaptionLbl)
                    {
                    }
                    column(Service_Header__StatusCaption; "Service Header".FieldCaption(Status))
                    {
                    }
                    column(Service_Header___No__Caption; "Service Header".FieldCaption("No."))
                    {
                    }
                    column(Invoice_toCaption; Invoice_toCaptionLbl)
                    {
                    }
                    column(CompanyInfo__Phone_No__Caption; CompanyInfo__Phone_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
                    {
                    }
                    column(Service_Header___Phone_No__Caption; Service_Header___Phone_No__CaptionLbl)
                    {
                    }
                    column(Service_Header___E_Mail_Caption; Service_Header___E_Mail_CaptionLbl)
                    {
                    }
                    column(Service_Header__DescriptionCaption; "Service Header".FieldCaption(Description))
                    {
                    }
                    column(Tax_Amt_Caption; Tax_Amt_CaptionLbl)
                    {
                    }
                    column(Subtotal_Caption; Subtotal_CaptionLbl)
                    {
                    }
                    column(ShipToAddr_6_; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddr_5_; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr_4_; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr_3_; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr_2_; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr_1_; ShipToAddr[1])
                    {
                    }
                    column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
                    {
                    }
                    column(Contact_Caption; Contact_CaptionLbl)
                    {
                    }
                    column(ContactName; ContactName)
                    {
                    }
                    column(ContactPhone; ContactPhone)
                    {
                    }
                    column(ResponseDate_ServiceHeader; "Service Header"."Response Date")
                    {
                    }
                    column(ResponseTime_ServiceHeader; Format("Service Header"."Response Time"))
                    {
                    }
                    column(ResponseDate_ServiceHeader_Caption; "Service Header".FieldCaption("Response Date"))
                    {
                    }
                    column(ResponseTime_ServiceHeader_Caption; "Service Header".FieldCaption("Response Time"))
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                        column(DimText; DimText)
                        {
                        }
                        column(DimText_Control11; DimText)
                        {
                        }
                        column(DimensionLoop1_Number; Number)
                        {
                        }
                        column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.Find('-')then CurrReport.Break;
                            end
                            else if not Continue then CurrReport.Break;
                            Clear(DimText);
                            Continue:=false;
                            repeat OldDimText:=DimText;
                                if DimText = '' then DimText:=StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText:=StrSubstNo('%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText)then begin
                                    DimText:=OldDimText;
                                    Continue:=true;
                                    exit;
                                end;
                            until DimSetEntry1.Next = 0;
                        end;
                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then CurrReport.Break;
                        end;
                    }
                    dataitem("Service Order Comment"; "Service Comment Line")
                    {
                        DataItemLink = "Table Subtype"=FIELD("Document Type"), "No."=FIELD("No.");
                        DataItemLinkReference = "Service Header";
                        DataItemTableView = SORTING("Table Name", "Table Subtype", "No.", Type, "Table Line No.", "Line No.")WHERE("Table Name"=CONST("Service Header"), Type=CONST(General));

                        column(Service_Order_Comment_Comment; Comment)
                        {
                        }
                        column(ServiceOrderComment_TabName; "Table Name")
                        {
                        }
                        column(Service_Order_Comment_Table_Subtype; "Table Subtype")
                        {
                        }
                        column(Service_Order_Comment_No_; "No.")
                        {
                        }
                        column(Service_Order_Comment_Type; Type)
                        {
                        }
                        column(Service_Order_Comment_Table_Line_No_; "Table Line No.")
                        {
                        }
                        column(Service_Order_Comment_Line_No_; "Line No.")
                        {
                        }
                    }
                    dataitem("Service Item Line"; "Service Item Line")
                    {
                        DataItemLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");
                        DataItemLinkReference = "Service Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        column(ItemNo_ServiceItemLine; "Service Item Line"."Item No.")
                        {
                        }
                        column(ItemNo_ServiceItemLine_Caption; "Service Item Line".FieldCaption("Item No."))
                        {
                        }
                        column(FaultCode_ServiceItemLine; "Service Item Line"."Fault Reason Code")
                        {
                        }
                        column(FaultCode_ServiceItemLine_Caption; "Service Item Line".FieldCaption("Fault Reason Code"))
                        {
                        }
                        column(Service_Item_Line___Line_No__; "Service Item Line"."Line No.")
                        {
                        }
                        column(Service_Item_Line__Serial_No__; "Serial No.")
                        {
                        }
                        column(Service_Item_Line_Description; Description)
                        {
                        }
                        column(Service_Item_Line_Description_2; "Description 2")
                        {
                        }
                        column(Service_Item_Line__Service_Item_No__; "Service Item No.")
                        {
                        }
                        column(Service_Item_Line__Service_Item_Group_Code_; "Service Item Group Code")
                        {
                        }
                        column(Service_Item_Line_Warranty; Format(Warranty))
                        {
                        }
                        column(Service_Item_Line__Loaner_No__; "Loaner No.")
                        {
                        }
                        column(Service_Item_Line__Repair_Status_Code_; "Repair Status Code")
                        {
                        }
                        column(Service_Item_Line__Service_Shelf_No__; "Service Shelf No.")
                        {
                        }
                        column(Service_Item_Line__Response_Time_; Format("Response Time"))
                        {
                        }
                        column(Service_Item_Line__Response_Date_; Format("Response Date"))
                        {
                        }
                        column(Service_Item_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Service_Item_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Service_Item_Line__Serial_No__Caption; FieldCaption("Serial No."))
                        {
                        }
                        column(Service_Item_Line_DescriptionCaption; FieldCaption(Description))
                        {
                        }
                        column(Service_Item_Line_Description_2_Caption; FieldCaption("Description 2"))
                        {
                        }
                        column(Service_Item_Line__Service_Item_No__Caption; FieldCaption("Service Item No."))
                        {
                        }
                        column(Service_Item_Line__Service_Item_Group_Code_Caption; FieldCaption("Service Item Group Code"))
                        {
                        }
                        column(Service_Item_Line_WarrantyCaption; CaptionClassTranslate(FieldCaption(Warranty)))
                        {
                        }
                        column(Service_Item_LinesCaption; Service_Item_LinesCaptionLbl)
                        {
                        }
                        column(Service_Item_Line__Loaner_No__Caption; FieldCaption("Loaner No."))
                        {
                        }
                        column(Service_Item_Line__Repair_Status_Code_Caption; FieldCaption("Repair Status Code"))
                        {
                        }
                        column(Service_Item_Line__Service_Shelf_No__Caption; FieldCaption("Service Shelf No."))
                        {
                        }
                        column(Service_Item_Line__Response_Date_Caption; Service_Item_Line__Response_Date_CaptionLbl)
                        {
                        }
                        column(Service_Item_Line__Response_Time_Caption; Service_Item_Line__Response_Time_CaptionLbl)
                        {
                        }
                        dataitem("Fault Comment"; "Service Comment Line")
                        {
                            DataItemLink = "Table Subtype"=FIELD("Document Type"), "No."=FIELD("Document No."), "Table Line No."=FIELD("Line No.");
                            DataItemTableView = SORTING("Table Name", "Table Subtype", "No.", Type, "Table Line No.", "Line No.")WHERE("Table Name"=CONST("Service Header"), Type=CONST(Fault));

                            column(Fault_Comment_Comment; Comment)
                            {
                            }
                            column(Fault_Comment_Table_Name; "Table Name")
                            {
                            }
                            column(Fault_Comment_Table_Subtype; "Table Subtype")
                            {
                            }
                            column(Fault_Comment_No_; "No.")
                            {
                            }
                            column(Fault_Comment_Type; Type)
                            {
                            }
                            column(Fault_Comment_Table_Line_No_; "Table Line No.")
                            {
                            }
                            column(Fault_Comment_Line_No_; "Line No.")
                            {
                            }
                            column(Fault_CommentsCaption; Fault_CommentsCaptionLbl)
                            {
                            }
                        }
                        dataitem("Resolution Comment"; "Service Comment Line")
                        {
                            DataItemLink = "Table Subtype"=FIELD("Document Type"), "No."=FIELD("Document No."), "Table Line No."=FIELD("Line No.");
                            DataItemTableView = SORTING("Table Name", "Table Subtype", "No.", Type, "Table Line No.", "Line No.")WHERE("Table Name"=CONST("Service Header"), Type=CONST(Resolution));

                            column(Resolution_Comment_Comment; Comment)
                            {
                            }
                            column(Resolution_Comment_Table_Name; "Table Name")
                            {
                            }
                            column(Resolution_Comment_Table_Subtype; "Table Subtype")
                            {
                            }
                            column(Resolution_Comment_No_; "No.")
                            {
                            }
                            column(Resolution_Comment_Type; Type)
                            {
                            }
                            column(Resolution_Comment_Table_Line_No_; "Table Line No.")
                            {
                            }
                            column(Resolution_Comment_Line_No_; "Line No.")
                            {
                            }
                            column(Resolution_CommentsCaption; Resolution_CommentsCaptionLbl)
                            {
                            }
                        }
                    }
                    dataitem("Service Line"; "Service Line")
                    {
                        DataItemLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");
                        DataItemLinkReference = "Service Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        column(Service_Line___Line_No__; "Service Line"."Line No.")
                        {
                        }
                        column(TotalAmt; TotalAmt)
                        {
                        }
                        column(TotalGrossAmt; TotalGrossAmt)
                        {
                        }
                        column(Service_Line__Service_Item_Serial_No__; "Service Item Serial No.")
                        {
                        }
                        column(Type_ServLine; Type)
                        {
                        }
                        column(UnitofMeasureCode_ServiceLine; "Service Line"."Unit of Measure Code")
                        {
                        }
                        column(Service_Line__No__; "No.")
                        {
                        }
                        column(Service_Line__Variant_Code_; "Variant Code")
                        {
                        }
                        column(Service_Line_Description; Description + ' ' + "Description 2")
                        {
                        }
                        column(Qty; Qty)
                        {
                        }
                        column(UnitPrice_ServLine; "Unit Price")
                        {
                        }
                        column(Service_Line__Line_Discount___; "Line Discount %")
                        {
                        }
                        column(Amt; Amt)
                        {
                        }
                        column(GrossAmt; GrossAmt)
                        {
                        }
                        column(Service_Line__Quantity_Consumed_; "Quantity Consumed")
                        {
                        }
                        column(Service_Line__Qty__to_Consume_; "Qty. to Consume")
                        {
                        }
                        column(Amt_Control63; Amt)
                        {
                        }
                        column(GrossAmt_Control65; GrossAmt)
                        {
                        }
                        column(Service_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Service_Line_Document_No_; "Document No.")
                        {
                        }
                        column(ServiceItemNo_ServiceLine; "Service Line"."Service Item No.")
                        {
                        }
                        column(ServiceItemNo_ServiceLine_Caption; FieldCaption("Service Item No."))
                        {
                        }
                        column(Service_Line__Service_Item_Serial_No__Caption; FieldCaption("Service Item Serial No."))
                        {
                        }
                        column(Service_Line__No__Caption; FieldCaption("No."))
                        {
                        }
                        column(Service_Line_TypeCaption; FieldCaption(Type))
                        {
                        }
                        column(Service_Line__Variant_Code_Caption; FieldCaption("Variant Code"))
                        {
                        }
                        column(Service_Line_DescriptionCaption; FieldCaption(Description))
                        {
                        }
                        column(QtyCaption; QtyCaptionLbl)
                        {
                        }
                        column(Service_LinesCaption; Service_LinesCaptionLbl)
                        {
                        }
                        column(Service_Line__Unit_Price_Caption; FieldCaption("Unit Price"))
                        {
                        }
                        column(Service_Line__Line_Discount___Caption; FieldCaption("Line Discount %"))
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(Gross_AmountCaption; Gross_AmountCaptionLbl)
                        {
                        }
                        column(Service_Line__Quantity_Consumed_Caption; FieldCaption("Quantity Consumed"))
                        {
                        }
                        column(Service_Line__Qty__to_Consume_Caption; FieldCaption("Qty. to Consume"))
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number)WHERE(Number=FILTER(1..));

                            column(DimText_Control13; DimText)
                            {
                            }
                            column(DimensionLoop2_Number; Number)
                            {
                            }
                            column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.Find('-')then CurrReport.Break;
                                end
                                else if not Continue then CurrReport.Break;
                                Clear(DimText);
                                Continue:=false;
                                repeat OldDimText:=DimText;
                                    if DimText = '' then DimText:=StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText:=StrSubstNo('%1, %2 %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText)then begin
                                        DimText:=OldDimText;
                                        Continue:=true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next = 0;
                            end;
                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then CurrReport.Break;
                                DimSetEntry2.SetRange("Dimension Set ID", "Service Line"."Dimension Set ID");
                            end;
                        }
                        trigger OnAfterGetRecord()
                        var
                            ExchangeFactor: Decimal;
                            SalesTaxCalculate: Codeunit "Sales Tax Calculate";
                            TempSalesTaxAmountLine: Record "Sales Tax Amount Line" temporary;
                        begin
                            if ShowQty = ShowQty::Quantity then begin
                                Qty:=Quantity;
                                Amt:="Line Amount";
                                // NA0001.begin
                                // GrossAmt := "Amount Including VAT";
                                if "Service Header"."Currency Factor" = 0 then ExchangeFactor:=1
                                else
                                    ExchangeFactor:="Service Header"."Currency Factor";
                                SalesTaxCalculate.StartSalesTaxCalculation;
                                SalesTaxCalculate.AddServiceLine("Service Line");
                                SalesTaxCalculate.EndSalesTaxCalculation("Posting Date");
                                SalesTaxCalculate.GetSalesTaxAmountLineTable(TempSalesTaxAmountLine);
                                //GrossAmt := Amt + TempSalesTaxAmountLine.GetTotalTaxAmount * ExchangeFactor; //IMP1.01
                                GrossAmt:=TempSalesTaxAmountLine.GetTotalTaxAmount * ExchangeFactor; //IMP1.01
                            // NA0001.end
                            end
                            else
                            begin
                                if "Quantity Invoiced" = 0 then CurrReport.Skip;
                                Qty:="Quantity Invoiced";
                                Amt:=Round((Qty * "Unit Price") * (1 - "Line Discount %" / 100));
                                GrossAmt:=(1 + "VAT %" / 100) * Amt;
                            end;
                            TotalAmt+=Amt;
                            TotalGrossAmt+=GrossAmt;
                        end;
                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CreateTotals(Amt, GrossAmt);
                            TotalAmt:=0;
                            TotalGrossAmt:=0;
                        end;
                    }
                    dataitem(Shipto; "Integer")
                    {
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                        column(Shipto_Number; Number)
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then CurrReport.Break;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText:=Text000;
                        OutputNo+=1;
                    end;
                //CurrReport.PageNo := 1;
                end;
                trigger OnPreDataItem()
                begin
                    NoOfLoops:=Abs(NoOfCopies) + 1;
                    if NoOfLoops <= 0 then NoOfLoops:=1;
                    CopyText:='';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo:=1;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                //CurrReport.Language := Language.GetLanguageID("Language Code");
                CurrReport.Language:=Language.GetLanguageIdOrDefault("Language Code");
                DimSetEntry1.SetRange("Dimension Set ID", "Service Header"."Dimension Set ID");
                if RespCenter.Get("Responsibility Center")then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyAddr[9]:='Phone No. ' + RespCenter."Phone No.";
                    CompanyAddr[10]:='Fax No. ' + RespCenter."Fax No.";
                    //CompanyInfo."Phone No." := RespCenter."Phone No.";
                    //CompanyInfo."Fax No." := RespCenter."Fax No.";
                    CompressArray(CompanyAddr);
                end
                else
                begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    CompanyAddr[1]:='';
                    CompanyAddr[9]:='Phone No. ' + CompanyInfo."Phone No.";
                    CompanyAddr[10]:='Fax No. ' + CompanyInfo."Fax No.";
                    CompressArray(CompanyAddr);
                end;
                //IMP1.03 Start
                if "Salesperson Code" = '' then Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");
                //IMP1.03 End
                FormatAddr.ServiceOrderSellto(CustAddr, "Service Header");
                ShowShippingAddr:="Service Header"."Ship-to Code" <> '';
                //IF ShowShippingAddr THEN BEGIN
                FormatAddr.ServiceOrderShipto(ShipToAddr, "Service Header");
                FormatAddr.FormatAddr(ShipToAddr, "Ship-to Name", "Ship-to Name 2", '', "Ship-to Address", "Ship-to Address 2", "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code");
                //END;
                Clear(ContactName);
                Clear(ContactPhone);
                ContactName:="Ship-to Contact";
                ContactPhone:="Ship-to Phone";
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

                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                        ApplicationArea = All;
                    }
                    field(ShowQty; ShowQty)
                    {
                        Caption = 'Amounts Based on';
                        OptionCaption = 'Quantity,Quantity Invoiced';
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
        CompanyInfo.Get;
        ServiceSetup.Get;
        case ServiceSetup."Logo Position on Documents" of ServiceSetup."Logo Position on Documents"::"No Logo": ;
        ServiceSetup."Logo Position on Documents"::Left: CompanyInfo.CalcFields(Picture);
        ServiceSetup."Logo Position on Documents"::Center: begin
            CompanyInfo1.Get;
            CompanyInfo1.CalcFields(Picture);
        end;
        ServiceSetup."Logo Position on Documents"::Right: begin
            CompanyInfo2.Get;
            CompanyInfo2.CalcFields(Picture);
        end;
        end;
        CompanyInfo.CalcFields(Picture);
    end;
    var Text000: Label 'COPY';
    Text001: Label 'Service Ticket %1';
    Text002: Label 'Page %1';
    CompanyInfo: Record "Company Information";
    CompanyInfo1: Record "Company Information";
    CompanyInfo2: Record "Company Information";
    ServiceSetup: Record "Service Mgt. Setup";
    RespCenter: Record "Responsibility Center";
    Language: Codeunit Language;
    DimSetEntry1: Record "Dimension Set Entry";
    DimSetEntry2: Record "Dimension Set Entry";
    FormatAddr: Codeunit 365;
    NoOfCopies: Integer;
    NoOfLoops: Integer;
    OutputNo: Integer;
    ShowInternalInfo: Boolean;
    Continue: Boolean;
    ShowShippingAddr: Boolean;
    CustAddr: array[8]of Text[50];
    ShipToAddr: array[8]of Text[50];
    CompanyAddr: array[10]of Text[50];
    CopyText: Text[30];
    DimText: Text[120];
    OldDimText: Text[120];
    Qty: Decimal;
    Amt: Decimal;
    ShowQty: Option Quantity, "Quantity Invoiced";
    GrossAmt: Decimal;
    TotalAmt: Decimal;
    TotalGrossAmt: Decimal;
    Contract_No_CaptionLbl: Label 'Contract No.';
    Service_Header___Order_Date_CaptionLbl: Label 'Order Date';
    Invoice_toCaptionLbl: Label 'Invoice to';
    CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
    CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
    Service_Header___Phone_No__CaptionLbl: Label 'Phone No.';
    Service_Header___E_Mail_CaptionLbl: Label 'E-Mail';
    Header_DimensionsCaptionLbl: Label 'Header Dimensions';
    Service_Item_LinesCaptionLbl: Label 'Service Item Lines';
    Service_Item_Line__Response_Date_CaptionLbl: Label 'Response Date';
    Service_Item_Line__Response_Time_CaptionLbl: Label 'Response Time';
    Fault_CommentsCaptionLbl: Label 'Fault Comments';
    Resolution_CommentsCaptionLbl: Label 'Resolution Comments';
    QtyCaptionLbl: Label 'Quantity';
    Service_LinesCaptionLbl: Label 'Service Lines';
    AmountCaptionLbl: Label 'Amount';
    Gross_AmountCaptionLbl: Label 'Gross Amount';
    TotalCaptionLbl: Label 'Total';
    Line_DimensionsCaptionLbl: Label 'Line Dimensions';
    Ship_to_AddressCaptionLbl: Label 'Ship-to Address';
    Tax_Amt_CaptionLbl: Label 'Tax Amount';
    Subtotal_CaptionLbl: Label 'Subtotal';
    ContactName: Code[50];
    ContactPhone: Text;
    Contact_CaptionLbl: Label 'Contact ';
    "-IMP1.03-": Integer;
    SalesPurchPerson: Record "Salesperson/Purchaser";
    SalesPersonCaptionLbl: Label 'SalesPerson';
    procedure InitializeRequest(ShowInternalInfoFrom: Boolean; ShowQtyFrom: Option)
    begin
        ShowInternalInfo:=ShowInternalInfoFrom;
        ShowQty:=ShowQtyFrom;
    end;
}
