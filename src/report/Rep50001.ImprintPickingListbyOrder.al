report 50001 "Imprint Picking List by Order"
{
    // <changelog>
    //   <add id="NA0000" dev="JNOZZI" date="2006-03-03" area="REPORTS IC" feature="615"
    //     releaseversion="NAVNA4.00">North American Picking List by Order Report.</add>
    //   <change id="NA0001" dev="JNOZZI" date="2006-03-03" area="REPORTS IC" feature="337"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA5.00">Implement the W1 Logo Position functionality.</change>
    //   <change id="NA0002" dev="JNOZZI" date="2006-03-03" area="KITTING" feature="PSCORS280"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Key change due to Kitting.</change>
    //   <change id="NA0003" dev="MBAHADUR" date="2007-12-10" area="REPORTS SR" feature="0003"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.01">modified sales comment line tableview property to
    //     support comment line feature.</change>
    //   <change id="NA0004" dev="V-STFANG" date="2008-05-22" area="REPORTS IC" feature="NC14261"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA6.00">Report Transformation - local Report Layout</change>
    //   <change id="NA0005" dev="JNOZZI" date="2009-01-14" area="REPORTS IC" feature="NC27046"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00.01">Fix minor problems (including bottom margin) on report.
    //     </change>
    // </changelog>
    // 
    // IMP1.01,SP591,06/20/17,ST: Added code to Sales Header - OnAfterGetRecord()
    // IMP1.02,10/02/20,ST: Enhancements to print new columns "Serializable" and change in captions.
    //                        - Added global variables, Text Constants.
    //                        - Added code in "Sales Line - OnAfterGetRecord()".
    //                        - Modified layout.
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/Imprint Picking List by Order.rdl';
    Caption = 'Picking List by Order';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord()
            begin
                TempLocation := Location;
                TempLocation.Insert;
            end;

            trigger OnPreDataItem()
            begin
                TempLocation.Code := '';
                TempLocation.Name := Text000;
                TempLocation.Insert;
                if not ReadPermission then CurrReport.Break;
            end;
        }
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";

            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "Sales Header"."No.")
            {
            }
            //column(BarCodedNo; '*' + "Sales Header"."No." + '*')
            column(BarCodedNo; NoBarCodeEncodedText)
            {
            }
            dataitem(LocationLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(CopyNo; "Integer")
                {
                    DataItemTableView = SORTING(Number);

                    dataitem(PageLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

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
                        column(CompanyAddress7; CompanyAddress[7])
                        {
                        }
                        column(CompanyAddress8; CompanyAddress[8])
                        {
                        }
                        column(CompanyInfo2_Picture; CompanyInfo2.Picture)
                        {
                        }
                        column(CompanyInfo1_Picture; CompanyInfo1.Picture)
                        {
                        }
                        column(CompanyInfo_Picture; CompanyInfo.Picture)
                        {
                        }
                        column(CurrReport_PAGENO; CurrReport.PageNo)
                        {
                        }
                        column(Sales_Header___No__; "Sales Header"."No.")
                        {
                        }
                        column(Sales_Header___Order_Date_; "Sales Header"."Order Date")
                        {
                        }
                        column(Sales_Header___Sell_to_Customer_No__; "Sales Header"."Sell-to Customer No.")
                        {
                        }
                        column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                        {
                        }
                        column(ShipToAddress_1_; ShipToAddress[1])
                        {
                        }
                        column(ShipToAddress_2_; ShipToAddress[2])
                        {
                        }
                        column(ShipToAddress_3_; ShipToAddress[3])
                        {
                        }
                        column(ShipToAddress_4_; ShipToAddress[4])
                        {
                        }
                        column(ShipToAddress_5_; ShipToAddress[5])
                        {
                        }
                        column(ShipToAddress_6_; ShipToAddress[6])
                        {
                        }
                        column(ShipToAddress_7_; ShipToAddress[7])
                        {
                        }
                        column(Sales_Header___Shipment_Date_; "Sales Header"."Shipment Date")
                        {
                        }
                        column(Address_1_; Address[1])
                        {
                        }
                        column(Address_2_; Address[2])
                        {
                        }
                        column(Address_3_; Address[3])
                        {
                        }
                        column(Address_4_; Address[4])
                        {
                        }
                        column(Address_5_; Address[5])
                        {
                        }
                        column(Address_6_; Address[6])
                        {
                        }
                        column(Address_7_; Address[7])
                        {
                        }
                        column(ShipmentMethod_Description; ShipmentMethod.Description)
                        {
                        }
                        column(PaymentTerms_Description; PaymentTerms.Description)
                        {
                        }
                        column(ShippingInfo_SalesHeader; ShippingInfo)
                        {
                        }
                        column(ShippingInfoCaption; ShippingInfoLbl)
                        {
                        }
                        column(TempLocation_Code; TempLocation.Code)
                        {
                        }
                        column(myCopyNo; CopyNo.Number)
                        {
                        }
                        column(LocationLoop_Number; LocationLoop.Number)
                        {
                        }
                        column(PageLoop_Number; Number)
                        {
                        }
                        column(EmptyStringCaption; EmptyStringCaptionLbl)
                        {
                        }
                        column(Sales_Header___Order_Date_Caption; Sales_Header___Order_Date_CaptionLbl)
                        {
                        }
                        column(Sales_Header___No__Caption; Sales_Header___No__CaptionLbl)
                        {
                        }
                        column(YourRef_SalesHeader; "Sales Header"."External Document No.")
                        {
                        }
                        column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                        {
                        }
                        column(Sales_Line__Outstanding_Quantity_Caption; Sales_Line__Outstanding_Quantity_CaptionLbl)
                        {
                        }
                        column(Sales_Line__Quantity_Shipped_Caption; "Sales Line".FieldCaption("Quantity Shipped"))
                        {
                        }
                        column(Sales_Header___Sell_to_Customer_No__Caption; Sales_Header___Sell_to_Customer_No__CaptionLbl)
                        {
                        }
                        column(Sales_Header___Shipment_Date_Caption; Sales_Header___Shipment_Date_CaptionLbl)
                        {
                        }
                        column(SalesPurchPerson_NameCaption; SalesPurchPerson_NameCaptionLbl)
                        {
                        }
                        column(Sales_Line_QuantityCaption; Sales_Line_QuantityCaptionLbl)
                        {
                        }
                        column(Ship_To_Caption; Ship_To_CaptionLbl)
                        {
                        }
                        column(Sales_Line__Unit_of_Measure_Caption; UoM_Caption_Lbl)
                        {
                        }
                        column(PONumberCaption; PONumberCaptionLbl)
                        {
                        }
                        column(Picking_List_by_OrderCaption; Picking_List_by_OrderCaptionLbl)
                        {
                        }
                        column(Sales_Line__No__Caption; Sales_Line__No__CaptionLbl)
                        {
                        }
                        column(ShipmentMethod_DescriptionCaption; ShipmentMethod_DescriptionCaptionLbl)
                        {
                        }
                        column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                        {
                        }
                        column(Item__Shelf_No__Caption; Item__Shelf_No__CaptionLbl)
                        {
                        }
                        column(TempLocation_CodeCaption; TempLocation_CodeCaptionLbl)
                        {
                        }
                        column(Sold_To_Caption; Sold_To_CaptionLbl)
                        {
                        }
                        column(QtyToShipCaption; QtyToShipCaptionLbl)
                        {
                        }
                        column(QtyOrSerialShippedCaption; QtyOrSerialShippedCaptionLbl)
                        {
                        }
                        column(SerializedCaption; SerializedCaptionLbl)
                        {
                        }
                        dataitem("Sales Line"; "Sales Line")
                        {
                            DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                            DataItemLinkReference = "Sales Header";
                            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE(Type = FILTER(Resource | Item | "G/L Account"), "Outstanding Quantity" = FILTER(<> 0));
                            RequestFilterFields = "Shipment Date";

                            column(Item__Shelf_No__; Item."Shelf No.")
                            {
                            }
                            column(Sales_Line__No__; "No.")
                            {
                            }
                            column(Sales_Line__Unit_of_Measure_; "Unit of Measure Code")
                            {
                            }
                            column(Sales_Line_Quantity; Quantity)
                            {
                                DecimalPlaces = 2 : 5;
                            }
                            column(Sales_Line__Quantity_Shipped_; "Quantity Shipped")
                            {
                                DecimalPlaces = 2 : 5;
                            }
                            column(Sales_Line__Outstanding_Quantity_; "Outstanding Quantity")
                            {
                                DecimalPlaces = 2 : 5;
                            }
                            column(Sales_Line_Description; Description + "Description 2")
                            {
                            }
                            column(EmptyString; '')
                            {
                            }
                            column(Sales_Line__Variant_Code_; "Variant Code")
                            {
                            }
                            column(myAnySerialNos; AnySerialNos)
                            {
                            }
                            column(Sales_Line_Document_Type; "Document Type")
                            {
                            }
                            column(Sales_Line_Document_No_; "Document No.")
                            {
                            }
                            column(Sales_Line_Line_No_; "Line No.")
                            {
                            }
                            column(Item_Inventory_Posting_Group; Item."Inventory Posting Group")
                            {
                            }
                            column(Sales_Line_Bin_Code; "Sales Line"."Bin Code")
                            {
                            }
                            column(Sales_Header_Shipping_Agent_Code; "Sales Header"."Shipping Agent Code")
                            {
                            }
                            column(Sales_Line__Quantity_to_Ship; "Qty. to Ship")
                            {
                            }
                            column(SerializedVarGbl; SerializedVarGbl)
                            {
                            }
                            dataitem("Tracking Specification"; "Tracking Specification")
                            {
                                DataItemLink = "Source ID" = FIELD("Document No."), "Source Ref. No." = FIELD("Line No.");
                                DataItemTableView = SORTING("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.") WHERE("Source Type" = CONST(37), "Source Subtype" = CONST("1"));

                                column(Tracking_Specification__Serial_No__; "Serial No.")
                                {
                                }
                                column(Tracking_Specification_Entry_No_; "Entry No.")
                                {
                                }
                                column(Tracking_Specification_Source_ID; "Source ID")
                                {
                                }
                                column(Tracking_Specification_Source_Ref__No_; "Source Ref. No.")
                                {
                                }
                                column(Tracking_Specification__Serial_No__Caption; FieldCaption("Serial No."))
                                {
                                }
                                trigger OnAfterGetRecord()
                                begin
                                    if "Serial No." = '' then "Serial No." := "Lot No.";
                                end;
                            }
                            trigger OnAfterGetRecord()
                            begin
                                // ISSx.xx 11.26.13 DRR - Added Case Statement for Resuorces =========================\
                                /*Item.GET("No.");
                                IF Item."Item Tracking Code" <> '' THEN
                                  WITH TrackSpec2 DO BEGIN
                                    SETCURRENTKEY(
                                      "Source ID","Source Type","Source Subtype","Source Batch Name","Source Prod. Order Line","Source Ref. No.");
                                    SETRANGE("Source Type",DATABASE::"Sales Line");
                                    SETRANGE("Source Subtype","Sales Line"."Document Type");
                                    SETRANGE("Source ID","Sales Line"."Document No.");
                                    SETRANGE("Source Ref. No.","Sales Line"."Line No.");
                                    AnySerialNos := FINDFIRST;
                                  END ELSE
                                  AnySerialNos := FALSE;
                                */
                                case Type of
                                    Type::Item:
                                        begin
                                            Item.Get("No.");
                                            if Item."Item Tracking Code" <> '' then begin
                                                TrackSpec2.SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                                                TrackSpec2.SetRange("Source Type", DATABASE::"Sales Line");
                                                TrackSpec2.SetRange("Source Subtype", "Sales Line"."Document Type");
                                                TrackSpec2.SetRange("Source ID", "Sales Line"."Document No.");
                                                TrackSpec2.SetRange("Source Ref. No.", "Sales Line"."Line No.");
                                                AnySerialNos := TrackSpec2.FindFirst;
                                            end
                                            else
                                                AnySerialNos := false;
                                            if "Sales Line"."Purchasing Code" = 'DROP' then "Sales Line"."Bin Code" := 'D/S';
                                        end;
                                    Type::Resource:
                                        begin
                                            Resource.Get("No.");
                                        end;
                                end;
                                //IMP1.01 Start
                                SerializedVarGbl := 'No';
                                ;
                                if Type = Type::Item then begin
                                    if ItemRecGbl.Get("No.") then if ItemRecGbl."Item Tracking Code" <> '' then SerializedVarGbl := 'Yes';
                                end;
                                //IMP1.01 End
                            end;

                            trigger OnPreDataItem()
                            begin
                                SetRange("Location Code", TempLocation.Code);
                            end;
                        }
                        dataitem("Sales Comment Line"; "Sales Comment Line")
                        {
                            DataItemLink = "No." = FIELD("No.");
                            DataItemLinkReference = "Sales Header";
                            DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Order), "Print On Pick Ticket" = CONST(true));

                            column(Sales_Comment_Line_Comment; Comment)
                            {
                            }
                            column(Sales_Comment_Line_Document_Type; "Document Type")
                            {
                            }
                            column(Sales_Comment_Line_No_; "No.")
                            {
                            }
                            column(Sales_Comment_Line_Document_Line_No_; "Document Line No.")
                            {
                            }
                            column(Sales_Comment_Line_Line_No_; "Line No.")
                            {
                            }
                        }
                    }
                    trigger OnAfterGetRecord()
                    begin
                        // CurrReport.PageNo := 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange(Number, 1, 1 + Abs(NoCopies));
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then
                        TempLocation.Find('-')
                    else
                        TempLocation.Next;
                    if not AnySalesLinesThisLocation(TempLocation.Code) then CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, TempLocation.Count);
                end;
            }
            trigger OnAfterGetRecord()
            Var
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                //CheckForCrLimitWarning; //IMP1.01UPG
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
                FormatAddress.SalesHeaderBillTo(Address, "Sales Header");
                FormatAddress.SalesHeaderShipTo(ShipToAddress, ShipToAddress, "Sales Header");
                PrintFooter := false;
                // CurrReport.PageNo := 1;
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
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
                BarcodeString := "No.";
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                NoBarCodeEncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
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
                        MaxValue = 9;
                        MinValue = 0;
                        ApplicationArea = All;
                    }
                    field(PrintCompany; PrintCompany)
                    {
                        Caption = 'Print Company';
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
    trigger OnPreReport()
    begin
        // NA0001.begin
        SalesSetup.Get;
        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo.Get;
                    CompanyInfo.CalcFields(Picture);
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
        // NA0001.end
        CompanyInformation.Get;
        if PrintCompany then
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
        // NA0003.end
        // ISS2.00 11.26.13 =================================================================\
        // Add Phone No
        IF PrintCompany THEN //FormatAddress.AddLineToAddress(CompanyAddress,CompanyInformation."Phone No.");
            UPdateCodeGvar.AddLineToAddress(CompanyAddress, CompanyInformation."Phone No.");
        // End ==============================================================================/
    end;

    var
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        Item: Record Item;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        TempLocation: Record Location temporary;
        TrackSpec2: Record "Tracking Specification";
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        FormatAddress: Codeunit "Format Address";
        Address: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        PrintFooter: Boolean;
        AnySerialNos: Boolean;
        NoCopies: Integer;
        Text000: Label 'No Location Code';
        EmptyStringCaptionLbl: Label 'Picked';
        Sales_Header___Order_Date_CaptionLbl: Label 'Order Date:';
        Sales_Header___No__CaptionLbl: Label 'Order Number:';
        CurrReport_PAGENOCaptionLbl: Label 'Page:';
        Sales_Line__Outstanding_Quantity_CaptionLbl: Label 'Back Ordered';
        Sales_Header___Sell_to_Customer_No__CaptionLbl: Label 'Customer No:';
        Sales_Header___Shipment_Date_CaptionLbl: Label 'Shipment Date:';
        SalesPurchPerson_NameCaptionLbl: Label 'Salesperson:';
        Sales_Line_QuantityCaptionLbl: Label 'Quantity Ordered';
        Ship_To_CaptionLbl: Label 'Ship To:';
        Picking_List_by_OrderCaptionLbl: Label 'PICK TICKET';
        Sales_Line__No__CaptionLbl: Label 'Item No.';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Ship Via:';
        PaymentTerms_DescriptionCaptionLbl: Label 'Terms:';
        Item__Shelf_No__CaptionLbl: Label 'Shelf/Bin No.';
        TempLocation_CodeCaptionLbl: Label 'Location:';
        Sold_To_CaptionLbl: Label 'Sold To:';
        CompanyInformation: Record "Company Information";
        UoM_Caption_Lbl: Label 'UoM';
        Resource: Record Resource;
        CompanyAddress: array[8] of Text[50];
        PrintCompany: Boolean;
        PONumberCaptionLbl: Label 'Customer PO:';
        ShippingInfo: Text[250];
        ShippingAgent: Record "Shipping Agent";
        ShippingInfoLbl: Label 'Shipping Instructions:';
        ShippingAccount: Record "Shipping Account";
        BinCodeGVar: Code[20];
        QtyToShipCaptionLbl: Label 'Qty. to Ship';
        "-IMP1.02-": Integer;
        SerializedVarGbl: Text;
        ItemRecGbl: Record Item;
        //"--IMP1.02--": 
        SerializedCaptionLbl: Label 'Serialized';
        QtyOrSerialShippedCaptionLbl: Label 'Qty/Serial Shipped';
        UPdateCodeGvar: Codeunit UpdateCode;
        NoBarCodeEncodedText: Text;

    procedure AnySalesLinesThisLocation(LocationCode: Code[10]): Boolean
    var
        SalesLine2: Record "Sales Line";
    begin
        // NA0002.begin
        // SETCURRENTKEY("Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code");
        // NA0002.end
        // NA0002.begin
        SalesLine2.SetCurrentKey(Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Document Type");
        // NA0002.end
        SalesLine2.SetRange("Document Type", "Sales Header"."Document Type");
        SalesLine2.SetRange("Document No.", "Sales Header"."No.");
        SalesLine2.SetRange("Location Code", LocationCode);
        // TRO 11/26/13 - Comment out following SETRANGE to show pick list reports with 'Resource' lines
        //SETRANGE(Type,Type::Item,Type::Resource);
        SalesLine2.SetRange(Type, SalesLine2.Type::"G/L Account", SalesLine2.Type::Resource);
        exit(SalesLine2.FindFirst);
    end;
}
