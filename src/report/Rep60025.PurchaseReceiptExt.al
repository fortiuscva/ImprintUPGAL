report 60025 "Purchase Receipt Ext"
{
    // version NAVNA14.00
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Purchase Receipt.rdl';
    CaptionML = ENU = 'Purchase Receipt', ESM = 'Recepción de compra', FRC = 'Réception d''achat', ENC = 'Purchase Receipt';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";
            RequestFilterHeadingML = ENU = 'Purchase Receipt', ESM = 'Recepción de compra', FRC = 'Réception d''achat', ENC = 'Purchase Receipt';

            column(No_PurchRcptHeader; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(CompanyAddr1; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddr5; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddress[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddress[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddress[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddress[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddress[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddress[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddress[7])
                    {
                    }
                    column(ExpRcptDate_PurchRcptHeader; "Purch. Rcpt. Header"."Expected Receipt Date")
                    {
                    }
                    column(ShipToAddr1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddr6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddr7; ShipToAddress[7])
                    {
                    }
                    column(BuyfrmVendNo_PurchRcptHeader; "Purch. Rcpt. Header"."Buy-from Vendor No.")
                    {
                    }
                    column(YourRef_PurchRcptHeader; "Purch. Rcpt. Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchRcptHeader; "Purch. Rcpt. Header"."No.")
                    {
                    }
                    column(DocDate_PurchRcptHeader; "Purch. Rcpt. Header"."Document Date")
                    {
                    }
                    column(CompanyAddr7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddr8; CompanyAddress[8])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddress[8])
                    {
                    }
                    column(ShipToAddr8; ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(OrderNo_PurchRcptHeader; "Purch. Rcpt. Header"."Order No.")
                    {
                    }
                    column(OrderDate_PurchRcptHeader; "Purch. Rcpt. Header"."Order Date")
                    {
                    }
                    column(myCopyNo; CopyNo)
                    {
                    }
                    column(FromCaption; FromCaptionLbl)
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
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(PurchaseReceiptCaption; PurchaseReceiptCaptionLbl)
                    {
                    }
                    column(PurchaseReceiptNumberCaption; PurchaseReceiptNumberCaptionLbl)
                    {
                    }
                    column(PurchaseReceiptDateCaption; PurchaseReceiptDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(PurchaseCaption; PurchaseCaptionLbl)
                    {
                    }
                    column(PODateCaption; PODateCaptionLbl)
                    {
                    }
                    column(LocationCodeCaption; LocationCodeCaptionLbl)
                    {
                    }
                    column(BinCodeCaption; BinCodeCaptionLbl)
                    {
                    }
                    dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");

                        column(ItemNumberToPrint_PurchRcptLine; ItemNumberToPrint)
                        {
                        }
                        column(UnitofMeasure_PurchRcptLine; "Unit of Measure")
                        {
                        }
                        column(Qty_PurchRcptLine; Quantity)
                        {
                        }
                        column(OrderedQty_PurchRcptLine; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(BackOrderedQty_PurchRcptLine; BackOrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(Desc_PurchRcptLine; Description)
                        {
                        }
                        column(PrintFooter_PurchRcptLine; PrintFooter)
                        {
                        }
                        column(LineNo_PurchRcptLine; "Line No.")
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
                        column(ReceivedCaption; ReceivedCaptionLbl)
                        {
                        }
                        column(OrderedCaption; OrderedCaptionLbl)
                        {
                        }
                        column(BackOrderedCaption; BackOrderedCaptionLbl)
                        {
                        }
                        column(LocationCode_PurchRcptLine; "Purch. Rcpt. Line"."Location Code")
                        {
                        }
                        column(BinCode_PurchRcptLine; "Purch. Rcpt. Line"."Bin Code")
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            OrderedQuantity := 0;
                            BackOrderedQuantity := 0;
                            if "Order No." = '' then
                                OrderedQuantity := Quantity
                            else if OrderLine.Get(1, "Order No.", "Order Line No.") then begin
                                OrderedQuantity := OrderLine.Quantity;
                                BackOrderedQuantity := OrderLine."Outstanding Quantity";
                            end
                            else begin
                                ReceiptLine.SetCurrentKey("Order No.", "Order Line No.");
                                ReceiptLine.SetRange("Order No.", "Order No.");
                                ReceiptLine.SetRange("Order Line No.", "Order Line No.");
                                ReceiptLine.Find('-');
                                repeat
                                    OrderedQuantity := OrderedQuantity + ReceiptLine.Quantity;
                                until 0 = ReceiptLine.Next;
                            end;
                            if Type.AsInteger() = 0 then begin
                                ItemNumberToPrint := '';
                                "Unit of Measure" := '';
                                OrderedQuantity := 0;
                                BackOrderedQuantity := 0;
                                Quantity := 0;
                            end
                            else if Type = Type::"G/L Account" then
                                ItemNumberToPrint := "Vendor Item No."
                            else
                                ItemNumberToPrint := "No.";
                            if OnLineNumber = NumberOfLines then PrintFooter := true;
                        end;

                        trigger OnPreDataItem();
                        begin
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
                        if not CurrReport.Preview then PurchaseRcptPrinted.Run("Purch. Rcpt. Header");
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
                if "Purchaser Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Purchaser Code");
                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");
                if "Buy-from Vendor No." = '' then begin
                    "Buy-from Vendor Name" := Text009;
                    "Ship-to Name" := Text009;
                end;
                FormatAddress.PurchRcptBuyFrom(BuyFromAddress, "Purch. Rcpt. Header");
                FormatAddress.PurchRcptShipTo(ShipToAddress, "Purch. Rcpt. Header");
                if LogInteraction then if not CurrReport.Preview then SegManagement.LogDocument(15, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
            end;

            trigger OnPreDataItem();
            begin
                if PrintCompany then
                    FormatAddress.Company(CompanyAddress, CompanyInformation)
                else
                    Clear(CompanyAddress);
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
            //LogInteraction:=SegManagement.FindInteractTmplCode(15) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Purch. Rcpt.") <> '';
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
        ShipmentMethod: Record "Shipment Method";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        ReceiptLine: Record "Purch. Rcpt. Line";
        OrderLine: Record "Purchase Line";
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        CompanyAddress: array[8] of Text[100];
        BuyFromAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        CopyTxt: Text[10];
        ItemNumberToPrint: Text[20];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        PurchaseRcptPrinted: Codeunit "Purch.Rcpt.-Printed";
        FormatAddress: Codeunit "Format Address";
        OrderedQuantity: Decimal;
        BackOrderedQuantity: Decimal;
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        Text000: TextConst ENU = 'COPY', ESM = 'COPIA', FRC = 'COPIER', ENC = 'COPY';
        Text009: TextConst ENU = 'VOID RECEIPT', ESM = 'ANULAR RECEPCIÊN', FRC = 'ANNULER RÉCEPTION', ENC = 'VOID RECEIPT';
        [InDataSet]
        LogInteractionEnable: Boolean;
        FromCaptionLbl: TextConst ENU = 'From:', ESM = 'De:', FRC = 'De :', ENC = 'From:';
        ReceiveByCaptionLbl: TextConst ENU = 'Receive By', ESM = 'Recibir por', FRC = 'Recevoir par', ENC = 'Receive By';
        VendorIDCaptionLbl: TextConst ENU = 'Vendor ID', ESM = 'Id. proveedor', FRC = 'Code de fournisseur', ENC = 'Vendor ID';
        ConfirmToCaptionLbl: TextConst ENU = 'Confirm To', ESM = 'Confirmar a', FRC = 'Confirmer à', ENC = 'Confirm To';
        BuyerCaptionLbl: TextConst ENU = 'Buyer', ESM = 'Comprador', FRC = 'Acheteur', ENC = 'Buyer';
        ShipCaptionLbl: TextConst ENU = 'Ship', ESM = 'Enviar', FRC = 'Livrer', ENC = 'Ship';
        ToCaptionLbl: TextConst ENU = 'To:', ESM = 'Para:', FRC = '‡ :', ENC = 'To:';
        PurchaseReceiptCaptionLbl: TextConst ENU = 'Purchase Receipt', ESM = 'Recepción de compra', FRC = 'Réception d''achat', ENC = 'Purchase Receipt';
        PurchaseReceiptNumberCaptionLbl: TextConst ENU = 'Purchase Receipt Number:', ESM = 'Número recepción de compra:', FRC = 'N° de réception d''achat :', ENC = 'Purchase Receipt Number:';
        PurchaseReceiptDateCaptionLbl: TextConst ENU = 'Purchase Receipt Date:', ESM = 'Fecha recepción de compra:', FRC = 'Date de réception d''achat :', ENC = 'Purchase Receipt Date:';
        PageCaptionLbl: TextConst ENU = 'Page:', ESM = 'Pág.:', FRC = 'Page :', ENC = 'Page:';
        ShipViaCaptionLbl: TextConst ENU = 'Ship Via', ESM = 'Envío a través de', FRC = 'Livrer par', ENC = 'Ship Via';
        PONumberCaptionLbl: TextConst ENU = 'P.O. Number', ESM = 'Número pedido compra', FRC = 'N° de bon de commande', ENC = 'P.O. Number';
        PurchaseCaptionLbl: TextConst ENU = 'Purchase', ESM = 'Compra', FRC = 'Achat', ENC = 'Purchase';
        PODateCaptionLbl: TextConst ENU = 'P.O. Date', ESM = 'Fecha pedido compra', FRC = 'Date du bon de commande', ENC = 'P.O. Date';
        ItemNoCaptionLbl: TextConst ENU = 'Item No.', ESM = 'Nº producto', FRC = 'N° d''article', ENC = 'Item No.';
        UnitCaptionLbl: TextConst ENU = 'Unit', ESM = 'Unidad', FRC = 'Unité', ENC = 'Unit';
        DescriptionCaptionLbl: TextConst ENU = 'Description', ESM = 'Descripción', FRC = 'Description', ENC = 'Description';
        ReceivedCaptionLbl: TextConst ENU = 'Received', ESM = 'Recibido', FRC = 'Reçu', ENC = 'Received';
        OrderedCaptionLbl: TextConst ENU = 'Ordered', ESM = 'Pedido', FRC = 'Commandé', ENC = 'Ordered';
        BackOrderedCaptionLbl: TextConst ENU = 'Back Ordered', ESM = 'Pedido pendiente', FRC = 'Commandé en retard', ENC = 'Back Ordered';
        LocationCodeCaptionLbl: Label 'Location Code';
        BinCodeCaptionLbl: Label 'Bin';
}
