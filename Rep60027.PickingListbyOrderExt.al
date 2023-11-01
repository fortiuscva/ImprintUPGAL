report 60027 "Picking List by Order Ext"
{
    // version NAVNA14.01
    DefaultLayout = RDLC;
    RDLCLayout = './Picking List by Order.rdlc';
    CaptionML = ENU = 'Picking List by Order', ESM = 'List. picking por ped.', FRC = 'Bordereau de prélèvement par commande', ENC = 'Picking List by Order';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord();
            begin
                TempLocation:=Location;
                TempLocation.Insert;
            end;
            trigger OnPreDataItem();
            begin
                TempLocation.Code:='';
                TempLocation.Name:=Text000;
                TempLocation.Insert;
                if not ReadPermission then CurrReport.Break;
            end;
        }
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")WHERE("Document Type"=CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.";

            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
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
                        DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

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
                        dataitem("Sales Line"; "Sales Line")
                        {
                            DataItemLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");
                            DataItemLinkReference = "Sales Header";
                            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")WHERE(Type=FILTER(Resource|Item), "Outstanding Quantity"=FILTER(<>0));
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
                            DecimalPlaces = 2: 5;
                            }
                            column(Sales_Line__Quantity_Shipped_; "Quantity Shipped")
                            {
                            DecimalPlaces = 2: 5;
                            }
                            column(Sales_Line__Outstanding_Quantity_; "Outstanding Quantity")
                            {
                            DecimalPlaces = 2: 5;
                            }
                            column(Sales_Line_Description; Description + "Description 2")
                            {
                            }
                            column(EmptyString;'')
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
                            dataitem("Tracking Specification"; "Tracking Specification")
                            {
                                DataItemLink = "Source ID"=FIELD("Document No."), "Source Ref. No."=FIELD("Line No.");
                                DataItemTableView = SORTING("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.")WHERE("Source Type"=CONST(37), "Source Subtype"=CONST("1"));

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
                                trigger OnAfterGetRecord();
                                begin
                                    if "Serial No." = '' then "Serial No.":="Lot No.";
                                end;
                            }
                            trigger OnAfterGetRecord();
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
                                case Type of Type::Item: begin
                                    Item.Get("No.");
                                    if Item."Item Tracking Code" <> '' then begin
                                        TrackSpec2.SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                                        TrackSpec2.SetRange("Source Type", DATABASE::"Sales Line");
                                        TrackSpec2.SetRange("Source Subtype", "Sales Line"."Document Type");
                                        TrackSpec2.SetRange("Source ID", "Sales Line"."Document No.");
                                        TrackSpec2.SetRange("Source Ref. No.", "Sales Line"."Line No.");
                                        AnySerialNos:=TrackSpec2.FindFirst;
                                    end
                                    else
                                        AnySerialNos:=false;
                                end;
                                Type::Resource: begin
                                    Resource.Get("No.");
                                end;
                                end;
                            end;
                            trigger OnPreDataItem();
                            begin
                                SetRange("Location Code", TempLocation.Code);
                            end;
                        }
                        dataitem("Sales Comment Line"; "Sales Comment Line")
                        {
                            DataItemLink = "No."=FIELD("No.");
                            DataItemLinkReference = "Sales Header";
                            DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")WHERE("Document Type"=CONST(Order), "Print On Pick Ticket"=CONST(true));

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
                        dataitem("<Sales Line Comment>"; "Sales Line")
                        {
                            DataItemLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");
                            DataItemLinkReference = "Sales Header";
                            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")WHERE(Type=CONST(" "), Description=FILTER(<>''));

                            column(Sales_Line_Comment; Description)
                            {
                            }
                            column(Sales_Line_Document_No_Comment; "Document No.")
                            {
                            }
                            column(Sales_Line_Line_Comment; "Line No.")
                            {
                            }
                        }
                    }
                    trigger OnAfterGetRecord();
                    begin
                    //CurrReport.PageNo := 1;
                    end;
                    trigger OnPreDataItem();
                    begin
                        SetRange(Number, 1, 1 + Abs(NoCopies));
                    end;
                }
                trigger OnAfterGetRecord();
                begin
                    if Number = 1 then TempLocation.Find('-')
                    else
                        TempLocation.Next;
                    if not AnySalesLinesThisLocation(TempLocation.Code)then CurrReport.Skip;
                end;
                trigger OnPreDataItem();
                begin
                    SetRange(Number, 1, TempLocation.Count);
                end;
            }
            trigger OnAfterGetRecord();
            begin
                if "Salesperson Code" = '' then Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");
                if "Shipment Method Code" = '' then Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");
                if "Payment Terms Code" = '' then Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");
                FormatAddress.SalesHeaderBillTo(Address, "Sales Header");
                FormatAddress.SalesHeaderShipTo(ShipToAddress, ShipToAddress, "Sales Header");
            //CurrReport.PageNo := 1;
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
                        CaptionML = ENU = 'Number of Copies', ESM = 'Número de copias', FRC = 'Nombre de copies', ENC = 'Number of Copies';
                        MaxValue = 9;
                        MinValue = 0;
                        ToolTipML = ENU = 'Specifies the number of copies to print of the document.', ESM = 'Especifica el número de copias del documento que se imprimirán.', FRC = 'Spécifie le nombre de copies du document à imprimer.', ENC = 'Specifies the number of copies to print of the document.';
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
    trigger OnPreReport();
    begin
        SalesSetup.Get;
        case SalesSetup."Logo Position on Documents" of SalesSetup."Logo Position on Documents"::"No Logo": ;
        SalesSetup."Logo Position on Documents"::Left: begin
            CompanyInfo.Get;
            CompanyInfo.CalcFields(Picture);
        end;
        SalesSetup."Logo Position on Documents"::Center: begin
            CompanyInfo1.Get;
            CompanyInfo1.CalcFields(Picture);
        end;
        SalesSetup."Logo Position on Documents"::Right: begin
            CompanyInfo2.Get;
            CompanyInfo2.CalcFields(Picture);
        end;
        end;
        // NA0001.end
        CompanyInformation.Get;
        if PrintCompany then FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
        // NA0003.end
        // ISS2.00 11.26.13 =================================================================\
        // Add Phone No
        if PrintCompany then;
        CustCU.AddLineToAddress(CompanyAddress, CompanyInformation."Phone No.");
    // End ==============================================================================/
    end;
    var CustCU: Codeunit 90000;
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
    Address: array[8]of Text[100];
    ShipToAddress: array[8]of Text[100];
    AnySerialNos: Boolean;
    NoCopies: Integer;
    Text000: TextConst ENU = 'No Location Code', ESM = 'Sin cód. almacén', FRC = 'Pas de code d''emplacement', ENC = 'No Location Code';
    EmptyStringCaptionLbl: TextConst ENU = 'Picked', ESM = 'Seleccionado', FRC = 'Ramassé', ENC = 'Picked';
    Sales_Header___Order_Date_CaptionLbl: TextConst ENU = 'Order Date:', ESM = 'Fecha pedido:', FRC = 'Date de commande :', ENC = 'Order Date:';
    Sales_Header___No__CaptionLbl: TextConst ENU = 'Order Number:', ESM = 'Número de pedido:', FRC = 'Numéro de commande :', ENC = 'Order Number:';
    CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page:', ESM = 'Pág.:', FRC = 'Page :', ENC = 'Page:';
    Sales_Line__Outstanding_Quantity_CaptionLbl: TextConst ENU = 'Back Ordered', ESM = 'Pedido pendiente', FRC = 'Commandé en retard', ENC = 'Back Ordered';
    Sales_Header___Sell_to_Customer_No__CaptionLbl: TextConst ENU = 'Customer No:', ESM = 'Nº cliente:', FRC = 'N° de client :', ENC = 'Customer No:';
    Sales_Header___Shipment_Date_CaptionLbl: TextConst ENU = 'Shipment Date:', ESM = 'Fecha envío:', FRC = 'Date de livraison :', ENC = 'Shipment Date:';
    SalesPurchPerson_NameCaptionLbl: TextConst ENU = 'Salesperson:', ESM = 'Vendedor:', FRC = 'Représentant :', ENC = 'Salesperson:';
    Sales_Line_QuantityCaptionLbl: TextConst ENU = 'Quantity Ordered', ESM = 'Cantidad pedida', FRC = 'Quantité commandée', ENC = 'Quantity Ordered';
    Ship_To_CaptionLbl: TextConst ENU = 'Ship To:', ESM = 'Enviar a:', FRC = 'Livrer à :', ENC = 'Ship To:';
    Picking_List_by_OrderCaptionLbl: TextConst ENU = 'PICK TICKET', ESM = 'List. picking por ped.', FRC = 'Bon de cueillette par commande', ENC = 'Picking List by Order';
    Sales_Line__No__CaptionLbl: TextConst ENU = 'Item No.', ESM = 'Nº producto', FRC = 'N° d''article', ENC = 'Item No.';
    ShipmentMethod_DescriptionCaptionLbl: TextConst ENU = 'Ship Via:', ESM = 'Envío a través de:', FRC = 'Livrer par :', ENC = 'Ship Via:';
    PaymentTerms_DescriptionCaptionLbl: TextConst ENU = 'Terms:', ESM = 'Términos:', FRC = 'Modalités :', ENC = 'Terms:';
    Item__Shelf_No__CaptionLbl: TextConst ENU = 'Shelf/Bin No.', ESM = 'Estante/Núm. ubicación', FRC = 'N° de tablette/zone', ENC = 'Shelf/Bin No.';
    TempLocation_CodeCaptionLbl: TextConst ENU = 'Location:', ESM = 'Almacén:', FRC = 'Emplacement :', ENC = 'Location:';
    Sold_To_CaptionLbl: TextConst ENU = 'Sold To:', ESM = 'Vendido a:', FRC = 'Vendu à :', ENC = 'Sold To:';
    CompanyInformation: Record "Company Information";
    UoM_Caption_Lbl: Label 'UoM';
    Resource: Record Resource;
    CompanyAddress: array[8]of Text[50];
    PrintCompany: Boolean;
    PONumberCaptionLbl: Label 'Customer PO:';
    procedure AnySalesLinesThisLocation(LocationCode: Code[10]): Boolean;
    var
        SalesLine2: Record "Sales Line";
    begin
        SalesLine2.SetCurrentKey(Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Document Type");
        SalesLine2.SetRange("Document Type", "Sales Header"."Document Type");
        SalesLine2.SetRange("Document No.", "Sales Header"."No.");
        SalesLine2.SetRange("Location Code", LocationCode);
        // TRO 11/26/13 - Comment out following SETRANGE to show pick list reports with 'Resource' lines
        SalesLine2.SetRange(Type, SalesLine2.Type::Item, SalesLine2.Type::Resource);
        exit(SalesLine2.FindFirst);
    end;
}
