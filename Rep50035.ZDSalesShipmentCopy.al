report 50035 "ZD-Sales Shipment - Copy"
{
    // //IMP1.01   02-Jul-15   ST     -> Code added to "SalesShptLine - OnAfterGetRecord()" to print the Crosss Reference No.
    // 
    // IM1.02,SP4928,5/25/16,OAS: Print tracking #s.
    // IMP1.03, 09/01/23, SK: Added code to print External Tracking No. from Posted Packages and layout changes also.
    DefaultLayout = RDLC;
    RDLCLayout = './ZD-Sales Shipment - Copy.rdl';
    Caption = 'Sales Shipment';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Shipment';

            column(No_SalesShptHeader; "No.")
            {
            }
            column(LAXPostedPackageRecGbl_External_Tracking_No; LAXPostedPackageRecGbl."External Tracking No.")
            {
            }
            column(PrintLogo; PrintLogo)
            { }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Shipment), "Print On Shipment" = CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        //NA0005.begin
                        TempSalesShipmentLine.Init;
                        TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                        TempSalesShipmentLine."Line No." := HighestLineNo + 10;
                        HighestLineNo := TempSalesShipmentLine."Line No.";
                        if StrLen(Comment) <= MaxStrLen(TempSalesShipmentLine.Description) then begin
                            TempSalesShipmentLine.Description := Comment;
                            TempSalesShipmentLine."Description 2" := '';
                        end
                        else begin
                            SpacePointer := MaxStrLen(TempSalesShipmentLine.Description) + 1;
                            while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do SpacePointer := SpacePointer - 1;
                            if SpacePointer = 1 then SpacePointer := MaxStrLen(TempSalesShipmentLine.Description) + 1;
                            TempSalesShipmentLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                            TempSalesShipmentLine."Description 2" := CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesShipmentLine."Description 2"));
                        end;
                        TempSalesShipmentLine.Insert;
                        //NA0005.end
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    TempSalesShipmentLine := "Sales Shipment Line";
                    TempSalesShipmentLine.Insert;
                    // NA0008.begin
                    TempSalesShipmentLineAsm := "Sales Shipment Line";
                    TempSalesShipmentLineAsm.Insert;
                    // NA0008.end
                    HighestLineNo := "Line No.";
                end;

                trigger OnPostDataItem()
                var
                    PostedShipRec: Record "Posted Shipments";
                    FirstPackage: Boolean;
                begin
                    // IM1.02 - start
                    PostedShipRec.Reset;
                    PostedShipRec.SetRange("Sales Order Number", "Sales Shipment Header"."Order No.");
                    if PostedShipRec.FindSet then begin
                        FirstPackage := true;
                        repeat
                            TempSalesShipmentLine.Init;
                            TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                            TempSalesShipmentLine."Line No." := HighestLineNo + 1000;
                            if FirstPackage then
                                TempSalesShipmentLine.Description := 'Tracking No(s): ' + PostedShipRec."Tracking Number"
                            else
                                TempSalesShipmentLine.Description := '                ' + PostedShipRec."Tracking Number";
                            TempSalesShipmentLine."Description 2" := '';
                            HighestLineNo := TempSalesShipmentLine."Line No.";
                            TempSalesShipmentLine.Insert;
                            FirstPackage := false;
                        until PostedShipRec.Next = 0;
                    end;
                    // IM1.02 - end
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesShipmentLine.Reset;
                    TempSalesShipmentLine.DeleteAll;
                    // NA0008.begin
                    TempSalesShipmentLineAsm.Reset;
                    TempSalesShipmentLineAsm.DeleteAll;
                    // NA0008.end
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Shipment), "Print On Shipment" = CONST(true), "Document Line No." = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    TempSalesShipmentLine.Init;
                    TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                    TempSalesShipmentLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesShipmentLine."Line No.";
                    if StrLen(Comment) <= MaxStrLen(TempSalesShipmentLine.Description) then begin
                        TempSalesShipmentLine.Description := Comment;
                        TempSalesShipmentLine."Description 2" := '';
                    end
                    else begin
                        SpacePointer := MaxStrLen(TempSalesShipmentLine.Description) + 1;
                        while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do SpacePointer := SpacePointer - 1;
                        if SpacePointer = 1 then SpacePointer := MaxStrLen(TempSalesShipmentLine.Description) + 1;
                        TempSalesShipmentLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                        TempSalesShipmentLine."Description 2" := CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesShipmentLine."Description 2"));
                    end;
                    TempSalesShipmentLine.Insert;
                end;

                trigger OnPreDataItem()
                begin
                    //NA0005.begin
                    TempSalesShipmentLine.Init;
                    TempSalesShipmentLine."Document No." := "Sales Shipment Header"."No.";
                    TempSalesShipmentLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesShipmentLine."Line No.";
                    TempSalesShipmentLine.Insert;
                    //NA0005.end
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
                    column(BilltoCustNo_SalesShptHeader; "Sales Shipment Header"."Bill-to Customer No.")
                    {
                    }
                    column(YourRef_SalesShptHeader; "Sales Shipment Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ShptDate_SalesShptHeader; "Sales Shipment Header"."Shipment Date")
                    {
                    }
                    column(ThirdPartyShipAccount_SalesShptHeader; "Sales Shipment Header"."Third Party Shipping Acc. No.")
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
                    column(OrderDate_SalesShptHeader; "Sales Shipment Header"."Order Date")
                    {
                    }
                    column(OrderNo_SalesShptHeader; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(PackageTrackingNoText; PackageTrackingNoText)
                    {
                    }
                    column(ShippingAgentCodeText; ShippingAgentCodeText)
                    {
                    }
                    column(ShippingAgentCodeLabel; ShippingAgentCodeLabel)
                    {
                    }
                    column(PackageTrackingNoLabel; PackageTrackingNoLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(PageLoopNumber; Number)
                    {
                    }
                    column(BillCaption; BillCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
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
                    column(ShipmentCaption; ShipmentCaptionLbl)
                    {
                    }
                    column(ShipmentNumberCaption; ShipmentNumberCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(PODateCaption; PODateCaptionLbl)
                    {
                    }
                    column(OurOrderNoCaption; OurOrderNoCaptionLbl)
                    {
                    }
                    column(ThirdPartyShipCaption; ThirdPartyShipLbl)
                    {
                    }
                    column(Sales_Header___Order_Date_Caption; Sales_Header___Order_Date_CaptionLbl)
                    {
                    }
                    column(Sales_Header___No__Caption; Sales_Header___No__CaptionLbl)
                    {
                    }
                    column(ShippingInfo_SalesHeader; ShippingInfo)
                    {
                    }
                    column(ShippingInfoCaption; ShippingInfoLbl)
                    {
                    }
                    column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                    {
                    }
                    column(PaymentTerms_Description; PaymentTerms.Description)
                    {
                    }
                    column(CustomerNoCaption; Sales_Header___Sell_to_Customer_No__CaptionLbl)
                    {
                    }
                    column(CustomerNo; "Sales Shipment Header"."Sell-to Customer No.")
                    {
                    }
                    column(CusstomerPOCaption; PONumberCaptionLbl)
                    {
                    }
                    column(ShippingAgentcode_SalesShptHeader; "Sales Shipment Header"."Shipping Agent Code")
                    {
                    }
                    column(CustomerPONo_SalesShptHeader; "Sales Shipment Header"."External Document No.")
                    {
                    }
                    dataitem(SalesShptLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(SalesShptLineNumber; Number)
                        {
                        }
                        column(TempSalesShptLineNo; TempSalesShipmentLine."No.")
                        {
                        }
                        column(TempSalesShptLineUOM; TempSalesShipmentLine."Unit of Measure")
                        {
                        }
                        column(TempSalesShptLineQy; TempSalesShipmentLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(OrderedQuantity; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(BackOrderedQuantity; BackOrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesShptLineDesc; TempSalesShipmentLine.Description + ' ' + TempSalesShipmentLine."Description 2")
                        {
                        }
                        column(PackageTrackingText; PackageTrackingText)
                        {
                        }
                        column(AsmHeaderExists; AsmHeaderExists)
                        {
                        }
                        column(PrintFooter; PrintFooter)
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
                        column(ShippedCaption; ShippedCaptionLbl)
                        {
                        }
                        column(OrderedCaption; OrderedCaptionLbl)
                        {
                        }
                        column(BackOrderedCaption; BackOrderedCaptionLbl)
                        {
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number);

                            column(PostedAsmLineItemNo; BlanksForIndent + PostedAsmLine."No.")
                            {
                            }
                            column(PostedAsmLineDescription; BlanksForIndent + PostedAsmLine.Description)
                            {
                            }
                            column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                // NA0008.begin
                                if Number = 1 then
                                    PostedAsmLine.FindSet
                                else
                                    PostedAsmLine.Next;
                                // NA0008.end
                            end;

                            trigger OnPreDataItem()
                            begin
                                // NA0008.begin
                                if not DisplayAssemblyInformation then CurrReport.Break;
                                if not AsmHeaderExists then CurrReport.Break;
                                PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
                                SetRange(Number, 1, PostedAsmLine.Count);
                                // NA0008.end
                            end;
                        }
                        trigger OnAfterGetRecord()
                        var
                            SalesShipmentLine: Record "Sales Shipment Line";
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            if OnLineNumber = 1 then
                                TempSalesShipmentLine.Find('-')
                            else
                                TempSalesShipmentLine.Next;
                            OrderedQuantity := 0;
                            BackOrderedQuantity := 0;
                            if TempSalesShipmentLine."Order No." = '' then
                                OrderedQuantity := TempSalesShipmentLine.Quantity
                            else begin
                                if OrderLine.Get(1, TempSalesShipmentLine."Order No.", TempSalesShipmentLine."Order Line No.") then begin
                                    OrderedQuantity := OrderLine.Quantity;
                                    BackOrderedQuantity := OrderLine."Outstanding Quantity";
                                end
                                else begin
                                    ReceiptLine.SetCurrentKey("Order No.", "Order Line No.");
                                    ReceiptLine.SetRange("Order No.", TempSalesShipmentLine."Order No.");
                                    ReceiptLine.SetRange("Order Line No.", TempSalesShipmentLine."Order Line No.");
                                    ReceiptLine.Find('-');
                                    repeat
                                        OrderedQuantity := OrderedQuantity + ReceiptLine.Quantity;
                                    until 0 = ReceiptLine.Next;
                                end;
                            end;
                            if TempSalesShipmentLine.Type.AsInteger() = 0 then begin
                                OrderedQuantity := 0;
                                BackOrderedQuantity := 0;
                                TempSalesShipmentLine."No." := '';
                                TempSalesShipmentLine."Unit of Measure" := '';
                                TempSalesShipmentLine.Quantity := 0;
                            end
                            else
                                if TempSalesShipmentLine.Type = TempSalesShipmentLine.Type::"G/L Account" then TempSalesShipmentLine."No." := '';
                            //IMP1.01 Start
                            if TempSalesShipmentLine.Type = TempSalesShipmentLine.Type::Item then begin
                                /*                                     if "Cross-Reference No." <> '' then
                                                                                "No." := "Cross-Reference No."; */
                            end;
                            //IMP1.01 End
                            PackageTrackingText := '';
                            if (TempSalesShipmentLine."Package Tracking No." <> "Sales Shipment Header"."Package Tracking No.") and (TempSalesShipmentLine."Package Tracking No." <> '') and PrintPackageTrackingNos then PackageTrackingText := Text002 + ' ' + TempSalesShipmentLine."Package Tracking No.";
                            // NA0008.begin
                            if DisplayAssemblyInformation then
                                if TempSalesShipmentLineAsm.Get(TempSalesShipmentLine."Document No.", TempSalesShipmentLine."Line No.") then begin
                                    SalesShipmentLine.Get(TempSalesShipmentLine."Document No.", TempSalesShipmentLine."Line No.");
                                    AsmHeaderExists := SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader);
                                end;
                            // NA0008.end
                            //NA0006.begin
                            if OnLineNumber = NumberOfLines then PrintFooter := true;
                            //NA0006.end
                        end;

                        trigger OnPreDataItem()
                        begin
                            NumberOfLines := TempSalesShipmentLine.Count;
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then //SalesInvPrinted.RUN("Sales Invoice Header");//upg  Zetadocs  report
                            CurrReport.Break;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                end;

                trigger OnPreDataItem()
                var
                    Customer: Record 18;
                begin
                    NoLoops := 1 + ABS(NoCopies) + Customer."Invoice Copies";
                    IF NoLoops <= 0 THEN NoLoops := 1;
                    CopyNo := 0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if PrintCompany then
                    if RespCenter.Get("Responsibility Center") then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    end;
                //CurrReport.Language := Language.GetLanguageID("Language Code");
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                if "Salesperson Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");
                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");
                if "Payment Terms Code" = '' then
                    Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");
                // NA0002.begin
                if "Sell-to Customer No." = '' then begin
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                end;
                // NA0002.end
                // NA0003.begin
                if not Cust.Get("Sell-to Customer No.") then Clear(Cust);
                // NA0003.end
                FormatAddress.SalesShptBillTo(BillToAddress, BillToAddress, "Sales Shipment Header");
                FormatAddress.SalesShptShipTo(ShipToAddress, "Sales Shipment Header");
                ShippingAgentCodeLabel := '';
                ShippingAgentCodeText := '';
                PackageTrackingNoLabel := '';
                PackageTrackingNoText := '';
                if PrintPackageTrackingNos then begin
                    ShippingAgentCodeLabel := Text003;
                    ShippingAgentCodeText := "Sales Shipment Header"."Shipping Agent Code";
                    PackageTrackingNoLabel := Text001;
                    PackageTrackingNoText := "Sales Shipment Header"."Package Tracking No.";
                end;
                if LogInteraction then if not CurrReport.Preview then SegManagement.LogDocument(5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", ''); // NA0001
                TaxRegNo := '';
                TaxRegLabel := '';
                if "Tax Area Code" <> '' then begin
                    TaxArea.Get("Tax Area Code");
                    case TaxArea."Country/Region" of
                        TaxArea."Country/Region"::US:
                            ;
                        TaxArea."Country/Region"::CA:
                            begin
                                TaxRegNo := CompanyInformation."VAT Registration No.";
                                TaxRegLabel := CompanyInformation.FieldCaption("VAT Registration No.");
                            end;
                    end;
                end;
                // ISSx.xx 03.05.14 DRR - Added to get the Shipping Agent ========================\
                //CLEAR(ShippingInfo);
                //CLEAR(ShippingAccount);
                //ShippingAccount.SETRANGE("Ship-to Type",ShippingAccount."Ship-to Type"::Customer);
                //ShippingAccount.SETRANGE("Ship-to No.","Sell-to Customer No.");
                //ShippingAccount.SETRANGE("Ship-to Code","Ship-to Code");
                //ShippingAccount.SETRANGE("Shipping Agent Code","Shipping Agent Code");
                //IF ShippingAccount.FINDFIRST THEN BEGIN
                //ShippingInfo := ShippingAccount."Account No." + ' ' + ShippingAccount.Description;
                //END ELSE BEGIN
                //  ShippingInfo := "Shipping Agent Code";
                //END;
                // END ===========================================================================/
                Clear(ShippingInfo);
                Clear(ShippingAccount);
                ShippingAccount.SetRange("Ship-to Type", ShippingAccount."Ship-to Type"::Customer);
                ShippingAccount.SetRange("Ship-to No.", "Sell-to Customer No.");
                ShippingAccount.SetRange("Ship-to Code", "Ship-to Code");
                ShippingAccount.SetRange("Shipping Agent Code", "Shipping Agent Code");
                ShippingAccount.SetRange("Account No.", "Sales Shipment Header"."Third Party Shipping Acc. No.");
                if ShippingAccount.FindFirst then begin
                    ShippingInfo := ShippingAccount.Description;
                end;
                //IMP1.03 Start 
                LAXPostedPackageRecGbl.Reset();
                LAXPostedPackageRecGbl.SetRange("Source Type", 36);
                LAXPostedPackageRecGbl.SetRange("Source Subtype", 1, 2);
                LAXPostedPackageRecGbl.SetRange("Source ID", "Sales Shipment Header"."Order No.");
                if LAXPostedPackageRecGbl.FindFirst() then;
                //IMP1.03 End
            end;

            trigger OnPreDataItem()
            begin
                // NA0004.begin
                // CompanyInformation.GET;  // NA0001
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
                    field(PrintLogo; PrintLogo)
                    {
                        Caption = 'Print Logo Toggle';
                        ApplicationArea = All;
                    }
                    field(PrintPackageTrackingNos; PrintPackageTrackingNos)
                    {
                        Caption = 'Print Package Tracking Nos.';
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
    trigger OnInitReport()
    begin
        CompanyInfo.Get;
        SalesSetup.Get;
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
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then InitLogInteraction;
        // NA0004.begin
        CompanyInformation.Get;
        SalesSetup.Get;
        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                CompanyInformation.CalcFields(Picture);
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
    end;

    var
        OrderedQuantity: Decimal;
        BackOrderedQuantity: Decimal;
        ShipmentMethod: Record "Shipment Method";
        ReceiptLine: Record "Sales Shipment Line";
        OrderLine: Record "Sales Line";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesShipmentLine: Record "Sales Shipment Line" temporary;
        TempSalesShipmentLineAsm: Record "Sales Shipment Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        SalesShipmentPrinted: Codeunit "Sales Shpt.-Printed";
        FormatAddress: Codeunit "Format Address";
        PackageTrackingText: Text[50];
        PrintPackageTrackingNos: Boolean;
        PackageTrackingNoText: Text[50];
        PackageTrackingNoLabel: Text[50];
        ShippingAgentCodeText: Text[50];
        ShippingAgentCodeLabel: Text[50];
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        Text001: Label 'Tracking No.';
        Text002: Label 'Specific Tracking No.';
        Text003: Label 'Shipping Agent';
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        Text009: Label 'VOID SHIPMENT';
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        BillCaptionLbl: Label 'Sold To:';
        ToCaptionLbl: Label 'To:';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'Customer PO:';
        SalesPersonCaptionLbl: Label 'SalesPerson:';
        ShipCaptionLbl: Label 'Ship To:';
        ShipmentCaptionLbl: Label 'Shipment Confirmation';
        ShipmentNumberCaptionLbl: Label 'Shipment Number:';
        ShipmentDateCaptionLbl: Label 'Shipment Date:';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via:';
        PODateCaptionLbl: Label 'P.O. Date';
        OurOrderNoCaptionLbl: Label 'Our Order No.';
        ItemNoCaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'UOM';
        DescriptionCaptionLbl: Label 'Description';
        ShippedCaptionLbl: Label 'Shipped';
        OrderedCaptionLbl: Label 'Ordered';
        BackOrderedCaptionLbl: Label 'Awaiting Shipping';
        ThirdPartyShipLbl: Label '3rd Party Ship Acnt';
        Sales_Header___Order_Date_CaptionLbl: Label 'Order Date:';
        Sales_Header___No__CaptionLbl: Label 'Order Number:';
        ShippingInfoLbl: Label 'Shipping Instructions:';
        ShippingInfo: Text[250];
        ShippingAccount: Record "Shipping Account";
        Sales_Header___Sell_to_Customer_No__CaptionLbl: Label 'Customer No:';
        Sales_Header___Shipment_Date_CaptionLbl: Label 'Shipment Date:';
        PaymentTerms: Record "Payment Terms";
        PaymentTerms_DescriptionCaptionLbl: Label 'Terms:';
        Third: Integer;
        LAXPostedPackageRecGbl: Record "LAX Posted Package";
        PrintLogo: Boolean;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        // NA0008.begin
        if not UnitOfMeasure.Get(UOMCode) then exit(UOMCode);
        exit(UnitOfMeasure.Description);
        // NA0008.end
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        // NA0008.begin
        exit(PadStr('', 2, ' '));
        // NA0008.end
    end;
}
