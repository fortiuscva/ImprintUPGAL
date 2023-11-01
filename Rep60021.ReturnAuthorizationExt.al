report 60021 "Return Authorization Ext"
{
    // version NAVNA14.00
    DefaultLayout = RDLC;
    RDLCLayout = './Return Authorization.rdl';
    CaptionML = ENU = 'Return Authorization', ESM = 'Autorización de dev.', FRC = 'Autorisation du retour', ENC = 'Return Authorization';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")WHERE("Document Type"=CONST("Return Order"));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeadingML = ENU = 'Return Order', ESM = 'Devolución', FRC = 'Retour', ENC = 'Return Order';

            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No."=FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")WHERE("Document Type"=CONST("Return Order"));

                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No."=FIELD("Document No."), "Document Line No."=FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")WHERE("Document Type"=CONST("Return Order"), "Print On Return Authorization"=CONST(true));

                    trigger OnAfterGetRecord();
                    begin
                        TempSalesLine.Init;
                        TempSalesLine."Document Type":="Sales Header"."Document Type";
                        TempSalesLine."Document No.":="Sales Header"."No.";
                        TempSalesLine."Line No.":=HighestLineNo + 10;
                        HighestLineNo:=TempSalesLine."Line No.";
                        if StrLen(Comment) <= MaxStrLen(TempSalesLine.Description)then begin
                            TempSalesLine.Description:=Comment;
                            TempSalesLine."Description 2":='';
                        end
                        else
                        begin
                            SpacePointer:=MaxStrLen(TempSalesLine.Description) + 1;
                            while(SpacePointer > 1) and (Comment[SpacePointer] <> ' ')do SpacePointer:=SpacePointer - 1;
                            if SpacePointer = 1 then SpacePointer:=MaxStrLen(TempSalesLine.Description) + 1;
                            TempSalesLine.Description:=CopyStr(Comment, 1, SpacePointer - 1);
                            TempSalesLine."Description 2":=CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesLine."Description 2"));
                        end;
                        TempSalesLine.Insert;
                    end;
                }
                trigger OnAfterGetRecord();
                begin
                    TempSalesLine:="Sales Line";
                    TempSalesLine.Insert;
                    HighestLineNo:="Line No.";
                end;
                trigger OnPreDataItem();
                begin
                    TempSalesLine.Reset;
                    TempSalesLine.DeleteAll;
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No."=FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")WHERE("Document Type"=CONST("Return Order"), "Print On Return Authorization"=CONST(true), "Document Line No."=CONST(0));

                trigger OnAfterGetRecord();
                begin
                    TempSalesLine.Init;
                    TempSalesLine."Document Type":="Sales Header"."Document Type";
                    TempSalesLine."Document No.":="Sales Header"."No.";
                    TempSalesLine."Line No.":=HighestLineNo + 1000;
                    HighestLineNo:=TempSalesLine."Line No.";
                    if StrLen(Comment) <= MaxStrLen(TempSalesLine.Description)then begin
                        TempSalesLine.Description:=Comment;
                        TempSalesLine."Description 2":='';
                    end
                    else
                    begin
                        SpacePointer:=MaxStrLen(TempSalesLine.Description) + 1;
                        while(SpacePointer > 1) and (Comment[SpacePointer] <> ' ')do SpacePointer:=SpacePointer - 1;
                        if SpacePointer = 1 then SpacePointer:=MaxStrLen(TempSalesLine.Description) + 1;
                        TempSalesLine.Description:=CopyStr(Comment, 1, SpacePointer - 1);
                        TempSalesLine."Description 2":=CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesLine."Description 2"));
                    end;
                    TempSalesLine.Insert;
                end;
                trigger OnPreDataItem();
                begin
                    TempSalesLine.Init;
                    TempSalesLine."Document Type":="Sales Header"."Document Type";
                    TempSalesLine."Document No.":="Sales Header"."No.";
                    TempSalesLine."Line No.":=HighestLineNo + 1000;
                    HighestLineNo:=TempSalesLine."Line No.";
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                    column(CompanyAddress_1_; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress_2_; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress_3_; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress_4_; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress_5_; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress_6_; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress_1_; BillToAddress[1])
                    {
                    }
                    column(BillToAddress_2_; BillToAddress[2])
                    {
                    }
                    column(BillToAddress_3_; BillToAddress[3])
                    {
                    }
                    column(BillToAddress_4_; BillToAddress[4])
                    {
                    }
                    column(BillToAddress_5_; BillToAddress[5])
                    {
                    }
                    column(BillToAddress_6_; BillToAddress[6])
                    {
                    }
                    column(BillToAddress_7_; BillToAddress[7])
                    {
                    }
                    column(Sales_Header___Shipment_Date_; "Sales Header"."Shipment Date")
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
                    column(Sales_Header___Bill_to_Customer_No__; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Header___Your_Reference_; "Sales Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(Sales_Header___No__; "Sales Header"."No.")
                    {
                    }
                    column(Sales_Header___Document_Date_; "Sales Header"."Document Date")
                    {
                    }
                    column(CurrReport_PAGENO; CurrReport.PageNo)
                    {
                    }
                    column(CompanyAddress_7_; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress_8_; CompanyAddress[8])
                    {
                    }
                    column(BillToAddress_8_; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress_8_; ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethod_Description; ShipmentMethod.Description)
                    {
                    }
                    column(Sales_Header___Order_Date_; "Sales Header"."Order Date")
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(SalesHeaderExDocNo; "Sales Header"."External Document No.")
                    {
                    }
                    column(SoldCaption; SoldCaptionLbl)
                    {
                    }
                    column(To_Caption; To_CaptionLbl)
                    {
                    }
                    column(Ship_DateCaption; Ship_DateCaptionLbl)
                    {
                    }
                    column(Customer_IDCaption; Customer_IDCaptionLbl)
                    {
                    }
                    column(P_O__NumberCaption; P_O__NumberCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(To_Caption_Control89; To_Caption_Control89Lbl)
                    {
                    }
                    column(RETURN_AUTHORIZATIONCaption; RETURN_AUTHORIZATIONCaptionLbl)
                    {
                    }
                    column(Return_Authorization_Number_Caption; Return_Authorization_Number_CaptionLbl)
                    {
                    }
                    column(Return_Authorization_Date_Caption; Return_Authorization_Date_CaptionLbl)
                    {
                    }
                    column(Page_Caption; Page_CaptionLbl)
                    {
                    }
                    column(Ship_ViaCaption; Ship_ViaCaptionLbl)
                    {
                    }
                    column(P_O__DateCaption; P_O__DateCaptionLbl)
                    {
                    }
                    dataitem(SalesLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(TempSalesLine__No__; TempSalesLine."No.")
                        {
                        }
                        column(TempSalesLine__Unit_of_Measure_; TempSalesLine."Unit of Measure")
                        {
                        }
                        column(TempSalesLine_Quantity; TempSalesLine.Quantity)
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(TempSalesLine_Description_________TempSalesLine__Description_2_; TempSalesLine.Description + ' ' + TempSalesLine."Description 2")
                        {
                        }
                        column(SalesLine_Number; Number)
                        {
                        }
                        column(Item_No_Caption; Item_No_CaptionLbl)
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
                        trigger OnAfterGetRecord();
                        begin
                            OnLineNumber:=OnLineNumber + 1;
                            if OnLineNumber = 1 then TempSalesLine.Find('-')
                            else
                                TempSalesLine.Next;
                            if TempSalesLine.Type.AsInteger() = 0 then begin
                                TempSalesLine."No.":='';
                                TempSalesLine."Unit of Measure":='';
                                TempSalesLine."Line Amount":=0;
                                TempSalesLine."Inv. Discount Amount":=0;
                                TempSalesLine.Quantity:=0;
                            end
                            else if TempSalesLine.Type = TempSalesLine.Type::"G/L Account" then TempSalesLine."No.":='';
                        end;
                        trigger OnPreDataItem();
                        begin
                            NumberOfLines:=TempSalesLine.Count;
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber:=0;
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
                    CopyNo:=CopyNo + 1;
                    if CopyNo = 1 then // Original
 Clear(CopyTxt)
                    else
                        CopyTxt:=Text000;
                end;
                trigger OnPreDataItem();
                begin
                    NoLoops:=1 + Abs(NoCopies);
                    if NoLoops <= 0 then NoLoops:=1;
                    CopyNo:=0;
                end;
            }
            trigger OnAfterGetRecord();
            begin
                if PrintCompany then if RespCenter.Get("Responsibility Center")then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No.":=RespCenter."Phone No.";
                        CompanyInformation."Fax No.":=RespCenter."Fax No.";
                    end;
                //CurrReport.Language := Language.GetLanguageID("Language Code");
                CurrReport.Language:=Language.GetLanguageIdOrDefault("Language Code");
                if "Salesperson Code" = '' then Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");
                if "Payment Terms Code" = '' then Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");
                FormatAddress.SalesHeaderSellTo(BillToAddress, "Sales Header");
                FormatAddress.SalesHeaderShipTo(ShipToAddress, ShipToAddress, "Sales Header");
                if LogInteraction then if not CurrReport.Preview then begin
                        if "Bill-to Contact No." <> '' then SegManagement.LogDocument(18, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code", "Campaign No.", "Posting Description", '')
                        else
                            SegManagement.LogDocument(18, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
                    end;
            end;
            trigger OnPreDataItem();
            begin
                CompanyInformation.Get;
                if PrintCompany then FormatAddress.Company(CompanyAddress, CompanyInformation)
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

                    field(NoCopies; NoCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Number of Copies', ESM = 'Número de copias', FRC = 'Nombre de copies', ENC = 'Number of Copies';
                        ToolTipML = ENU = 'Specifies the number of copies of each document (in addition to the original) that you want to print.', ESM = 'Especifica el número de copias de cada documento (además del original) que desea imprimir.', FRC = 'Spécifie le nombre de copies de chaque document (en plus de l''original) que vous souhaitez imprimer.', ENC = 'Specifies the number of copies of each document (in addition to the original) that you want to print.';
                    }
                    field(PrintCompany; PrintCompany)
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
            LogInteractionEnable:=true;
        end;
        trigger OnOpenPage();
        begin
            /* reactivate when HQ comes up with a code number for return authorizations
            LogInteraction := SegManagement.FindInteractTmplCode(2) <> '';
            */
            LogInteractionEnable:=LogInteraction;
        end;
    }
    labels
    {
    }
    var ShipmentMethod: Record "Shipment Method";
    PaymentTerms: Record "Payment Terms";
    SalesPurchPerson: Record "Salesperson/Purchaser";
    CompanyInformation: Record "Company Information";
    TempSalesLine: Record "Sales Line" temporary;
    RespCenter: Record "Responsibility Center";
    Language: Codeunit Language;
    CompanyAddress: array[8]of Text[100];
    BillToAddress: array[8]of Text[100];
    ShipToAddress: array[8]of Text[100];
    CopyTxt: Text[10];
    PrintCompany: Boolean;
    NoCopies: Integer;
    NoLoops: Integer;
    CopyNo: Integer;
    NumberOfLines: Integer;
    OnLineNumber: Integer;
    HighestLineNo: Integer;
    SpacePointer: Integer;
    SalesPrinted: Codeunit "Sales-Printed";
    FormatAddress: Codeunit "Format Address";
    SegManagement: Codeunit SegManagement;
    Text000: TextConst ENU = 'COPY', ESM = 'COPIA', FRC = 'COPIER', ENC = 'COPY';
    LogInteraction: Boolean;
    TaxRegNo: Text[30];
    TaxRegLabel: Text[30];
    [InDataSet]
    LogInteractionEnable: Boolean;
    SoldCaptionLbl: TextConst ENU = 'Sold', ESM = 'Vendido', FRC = 'Vendu', ENC = 'Sold';
    To_CaptionLbl: TextConst ENU = 'To:', ESM = 'Para:', FRC = '‡ :', ENC = 'To:';
    Ship_DateCaptionLbl: TextConst ENU = 'Ship Date', ESM = 'Fecha envío', FRC = 'Date de livraison', ENC = 'Ship Date';
    Customer_IDCaptionLbl: TextConst ENU = 'Customer ID', ESM = 'Id. cliente', FRC = 'Code de client', ENC = 'Customer ID';
    P_O__NumberCaptionLbl: TextConst ENU = 'P.O. Number', ESM = 'Número pedido compra', FRC = 'N° de bon de commande', ENC = 'P.O. Number';
    SalesPersonCaptionLbl: TextConst ENU = 'SalesPerson', ESM = 'Vendedor', FRC = 'Représentant', ENC = 'SalesPerson';
    ShipCaptionLbl: TextConst ENU = 'Ship', ESM = 'Enviar', FRC = 'Livrer', ENC = 'Ship';
    To_Caption_Control89Lbl: TextConst ENU = 'To:', ESM = 'Para:', FRC = '‡ :', ENC = 'To:';
    RETURN_AUTHORIZATIONCaptionLbl: TextConst ENU = 'RETURN AUTHORIZATION', ESM = 'AUTORIZACIÊN DE DEV.', FRC = 'AUTORISATION DU RETOUR', ENC = 'RETURN AUTHORIZATION';
    Return_Authorization_Number_CaptionLbl: TextConst ENU = 'Return Authorization Number:', ESM = 'Número autorización de dev.:', FRC = 'N° d''autorisation du retour :', ENC = 'Return Authorization Number:';
    Return_Authorization_Date_CaptionLbl: TextConst ENU = 'Return Authorization Date:', ESM = 'Fecha autorización de dev.:', FRC = 'Date d''autorisation du retour :', ENC = 'Return Authorization Date:';
    Page_CaptionLbl: TextConst ENU = 'Page:', ESM = 'Pág.:', FRC = 'Page :', ENC = 'Page:';
    Ship_ViaCaptionLbl: TextConst ENU = 'Ship Via', ESM = 'Envío a través de', FRC = 'Livrer par', ENC = 'Ship Via';
    P_O__DateCaptionLbl: TextConst ENU = 'P.O. Date', ESM = 'Fecha pedido compra', FRC = 'Date du bon de commande', ENC = 'P.O. Date';
    Item_No_CaptionLbl: TextConst ENU = 'Item No.', ESM = 'Nº producto', FRC = 'N° d''article', ENC = 'Item No.';
    UnitCaptionLbl: TextConst ENU = 'Unit', ESM = 'Unidad', FRC = 'Unité', ENC = 'Unit';
    DescriptionCaptionLbl: TextConst ENU = 'Description', ESM = 'Descripción', FRC = 'Description', ENC = 'Description';
    QuantityCaptionLbl: TextConst ENU = 'Quantity', ESM = 'Cantidad', FRC = 'Quantité', ENC = 'Quantity';
}
