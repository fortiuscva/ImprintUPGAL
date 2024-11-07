report 60003 "Copy Sales Document Ext"
{
    // version NAVW114.06
    // IMPRINT1.01,SP4079,3/20/15,Ak: Added new option to use Workdate.
    CaptionML = ENU = 'Copy Sales Document', ESM = 'Copiar doc. venta', FRC = 'Copier doc. ventes', ENC = 'Copy Sales Document';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
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

                    field(DocumentType; DocType)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Document Type', ESM = 'Tipo documento', FRC = 'Type de document', ENC = 'Document Type';
                        OptionCaptionML = ENU = 'Quote,Blanket Order,Order,Invoice,Return Order,Credit Memo,Posted Shipment,Posted Invoice,Posted Return Receipt,Posted Credit Memo,Arch. Quote,Arch. Order,Arch. Blanket Order,Arch. Return Order', ESM = 'Cotización,Pedido abierto,Pedido,Factura,Devolución,Nota de crédito,Envío registrado,Factura registrada,Histórico recep. devolución,Nota crédito regis.,Cotización archivada,Pedido arch.,Pedido abierto arch.,Devolución arch.', FRC = 'Devis,Commande permanente,Commande,Facture,Retour,Note de crédit,Livraison reportée,Facture reportée,Réception retour reportée,Note de crédit reportée,Devis archivé,Commande archivée,Commande permanente archivée,Retour archivé', ENC = 'Quote,Blanket Order,Order,Invoice,Return Order,Credit Memo,Posted Shipment,Posted Invoice,Posted Return Receipt,Posted Credit Memo,Arch. Quote,Arch. Order,Arch. Blanket Order,Arch. Return Order';
                        ToolTipML = ENU = 'Specifies the type of document that is processed by the report or batch job.', ESM = 'Especifica el tipo del documento procesado por el informe o el trabajo por lotes.', FRC = 'Spécifie le type de document traité par le rapport ou le traitement en lot.', ENC = 'Specifies the type of document that is processed by the report or batch job.';

                        trigger OnValidate();
                        begin
                            DocNo:='';
                            ValidateDocNo;
                        end;
                    }
                    field(DocumentNo; DocNo)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Document No.', ESM = 'Nº documento', FRC = 'N° de document', ENC = 'Document No.';
                        ShowMandatory = true;
                        ToolTipML = ENU = 'Specifies the number of the document that is processed by the report or batch job.', ESM = 'Especifica el número del documento procesado por el informe o el trabajo por lotes.', FRC = 'Spécifie le numéro du document traité par le rapport ou le traitement en lot.', ENC = 'Specifies the number of the document that is processed by the report or batch job.';

                        trigger OnLookup(var Text: Text): Boolean;
                        begin
                            LookupDocNo;
                        end;
                        trigger OnValidate();
                        begin
                            ValidateDocNo;
                        end;
                    }
                    field(DocNoOccurrence; DocNoOccurrence)
                    {
                        ApplicationArea = Suite;
                        BlankZero = true;
                        CaptionML = ENU = 'Doc. No. Occurrence', ESM = 'Ocurrencia Nº doc.', FRC = 'Occurrence n° doc.', ENC = 'Doc. No. Occurrence';
                        Editable = false;
                        ToolTipML = ENU = 'Specifies the number of times the No. value has been used in the number series.', ESM = 'Especifica el número de veces que se ha utilizado el valor "Nº" en los números de serie.', FRC = 'Spécifie le nombre de fois où la valeur N° a été utilisée dans la série de numéros.', ENC = 'Specifies the number of times the No. value has been used in the number series.';
                    }
                    field(DocVersionNo; DocVersionNo)
                    {
                        ApplicationArea = Suite;
                        BlankZero = true;
                        CaptionML = ENU = 'Version No.', ESM = 'Nº versión', FRC = 'N° version', ENC = 'Version No.';
                        Editable = false;
                        ToolTipML = ENU = 'Specifies the version of the document to be copied.', ESM = 'Especifica la versión del documento que se copiará.', FRC = 'Spécifie la version du document à copier.', ENC = 'Specifies the version of the document to be copied.';
                    }
                    field(SellToCustNo; FromSalesHeader."Sell-to Customer No.")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Sell-to Customer No.', ESM = 'Venta a-Nº cliente', FRC = 'N° client (débiteur)', ENC = 'Sell-to Customer No.';
                        Editable = false;
                        ToolTipML = ENU = 'Specifies the sell-to customer number that will appear on the new sales document.', ESM = 'Especifica el número de cliente de venta que aparecerá en el nuevo documento de venta.', FRC = 'Spécifie le numéro de débiteur qui figure sur le nouveau document vente.', ENC = 'Specifies the sell-to customer number that will appear on the new sales document.';
                    }
                    field(SellToCustName; FromSalesHeader."Sell-to Customer Name")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Sell-to Customer Name', ESM = 'Venta a-Nombre', FRC = 'Nom du client (débiteur)', ENC = 'Sell-to Customer Name';
                        Editable = false;
                        ToolTipML = ENU = 'Specifies the sell-to customer name that will appear on the new sales document.', ESM = 'Especifica el nombre del cliente de venta que aparecerá en el nuevo documento de venta.', FRC = 'Spécifie le nom de débiteur qui figure sur le nouveau document vente.', ENC = 'Specifies the sell-to customer name that will appear on the new sales document.';
                    }
                    field(IncludeHeader_Options; IncludeHeader)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Include Header', ESM = 'Incluir cabecera', FRC = 'Inclure en-tête', ENC = 'Include Header';
                        ToolTipML = ENU = 'Specifies if you also want to copy the information from the document header. When you copy quotes, if the posting date field of the new document is empty, the work date is used as the posting date of the new document.', ESM = 'Especifica si también desea copiar la información de la cabecera del documento. Al copiar cotizaciones, si el campo Fecha registro del nuevo documento está vacío, la fecha de trabajo se usa como la fecha de registro del nuevo documento.', FRC = 'Indique si vous souhaitez également copier les informations à partir de l''en-tête du document. Lorsque vous copiez des devis, si le champ de la date de report du nouveau document est vide, la date de travail est utilisée comme date de report du nouveau document.', ENC = 'Specifies if you also want to copy the information from the document header. When you copy quotes, if the posting date field of the new document is empty, the work date is used as the posting date of the new document.';
                        Visible = false;

                        trigger OnValidate();
                        begin
                            ValidateIncludeHeader;
                        end;
                    }
                    field(RecalculateLines; RecalculateLines)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Recalculate Lines', ESM = 'Recalcular líneas', FRC = 'Recalculer les lignes', ENC = 'Recalculate Lines';
                        Editable = false;
                        ToolTipML = ENU = 'Specifies that lines are recalculate and inserted on the sales document you are creating. The batch job retains the item numbers and item quantities but recalculates the amounts on the lines based on the customer information on the new document header. In this way, the batch job accounts for item prices and discounts that are specifically linked to the customer on the new header.', ESM = 'Especifica que las líneas se recalculan e insertan en el documento de venta que está creando. El proceso conserva los números y las cantidades de producto, pero vuelve a calcular los importes de las líneas según los datos de cliente que figuran en la cabecera del documento nuevo. De esta manera, el proceso incluye los precios y los descuentos de producto específicamente vinculados al cliente en la cabecera nueva.', FRC = 'Spécifie que les lignes sont recalculées et insérées dans le document vente que vous créez. Le traitement en lot conserve les numéros et les quantités d''article mais recalcule les montants sur les lignes en fonction des informations client du nouvel en-tête. Ainsi, le traitement en lot tient compte des prix et des escomptes propres au client mentionné dans le nouvel en-tête.', ENC = 'Specifies that lines are recalculate and inserted on the sales document you are creating. The batch job retains the item numbers and item quantities but recalculates the amounts on the lines based on the customer information on the new document header. In this way, the batch job accounts for item prices and discounts that are specifically linked to the customer on the new header.';

                        trigger OnValidate();
                        begin
                            if(DocType = DocType::"Posted Shipment") or (DocType = DocType::"Posted Return Receipt")then RecalculateLines:=true;
                        end;
                    }
                    field(useworkdate; useworkdate)
                    {
                        Caption = 'Use Work Date as Document Date';
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
            if DocNo <> '' then begin
                case DocType of DocType::Quote: if FromSalesHeader.Get(FromSalesHeader."Document Type"::Quote, DocNo)then;
                DocType::"Blanket Order": if FromSalesHeader.Get(FromSalesHeader."Document Type"::"Blanket Order", DocNo)then;
                DocType::Order: if FromSalesHeader.Get(FromSalesHeader."Document Type"::Order, DocNo)then;
                DocType::Invoice: if FromSalesHeader.Get(FromSalesHeader."Document Type"::Invoice, DocNo)then;
                DocType::"Return Order": if FromSalesHeader.Get(FromSalesHeader."Document Type"::"Return Order", DocNo)then;
                DocType::"Credit Memo": if FromSalesHeader.Get(FromSalesHeader."Document Type"::"Credit Memo", DocNo)then;
                DocType::"Posted Shipment": if FromSalesShptHeader.Get(DocNo)then FromSalesHeader.TransferFields(FromSalesShptHeader);
                DocType::"Posted Invoice": if FromSalesInvHeader.Get(DocNo)then FromSalesHeader.TransferFields(FromSalesInvHeader);
                DocType::"Posted Return Receipt": if FromReturnRcptHeader.Get(DocNo)then FromSalesHeader.TransferFields(FromReturnRcptHeader);
                DocType::"Posted Credit Memo": if FromSalesCrMemoHeader.Get(DocNo)then FromSalesHeader.TransferFields(FromSalesCrMemoHeader);
                DocType::"Arch. Order": if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::Order, DocNo, DocNoOccurrence, DocVersionNo)then FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                DocType::"Arch. Quote": if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::Quote, DocNo, DocNoOccurrence, DocVersionNo)then FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                DocType::"Arch. Blanket Order": if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::"Blanket Order", DocNo, DocNoOccurrence, DocVersionNo)then FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                DocType::"Arch. Return Order": if FromSalesHeaderArchive.Get(FromSalesHeaderArchive."Document Type"::"Return Order", DocNo, DocNoOccurrence, DocVersionNo)then FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                end;
                if FromSalesHeader."No." = '' then DocNo:='';
            end;
            ValidateDocNo;
            OnAfterOpenPage;
        end;
        trigger OnQueryClosePage(CloseAction: Action): Boolean;
        begin
            if CloseAction = ACTION::OK then if DocNo = '' then Error(DocNoNotSerErr)end;
    }
    labels
    {
    }
    trigger OnPreReport();
    begin
        SalesSetup.Get;
        CopyDocMgt.SetProperties(IncludeHeader, RecalculateLines, false, false, false, SalesSetup."Exact Cost Reversing Mandatory", false);
        UpdateCodeGvar.setdocdate(useworkdate);
        CopyDocMgt.SetArchDocVal(DocNoOccurrence, DocVersionNo);
        OnPreReportOnBeforeCopySalesDoc(CopyDocMgt);
        CopyDocMgt.CopySalesDoc(DocType, DocNo, SalesHeader);
    end;
    var SalesHeader: Record "Sales Header";
    FromSalesHeader: Record "Sales Header";
    FromSalesShptHeader: Record "Sales Shipment Header";
    FromSalesInvHeader: Record "Sales Invoice Header";
    FromReturnRcptHeader: Record "Return Receipt Header";
    FromSalesCrMemoHeader: Record "Sales Cr.Memo Header";
    FromSalesHeaderArchive: Record "Sales Header Archive";
    SalesSetup: Record "Sales & Receivables Setup";
    CopyDocMgt: Codeunit "Copy Document Mgt.";
    //DocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
    DocType: Enum "Sales Document Type From";
    DocNo: Code[20];
    IncludeHeader: Boolean;
    RecalculateLines: Boolean;
    Text000: TextConst ENU = 'The price information may not be reversed correctly, if you copy a %1. If possible copy a %2 instead or use %3 functionality.', ESM = 'Es posible que la información sobre el precio no se revierta correctamente si copia un documento de %1. Si es posible, copie un documento de %2 en su lugar o utilice la funcionalidad %3.', FRC = 'L''information sur le prix ne peut être inversée correctement si vous copiez un %1. Si possible, copiez plutôt un %2 ou utilisez la fonctionnalité %3.', ENC = 'The price information may not be reversed correctly, if you copy a %1. If possible copy a %2 instead or use %3 functionality.';
    Text001: TextConst ENU = 'Undo Shipment', ESM = 'Deshacer envío', FRC = 'Annuler livraison', ENC = 'Undo Shipment';
    Text002: TextConst ENU = 'Undo Return Receipt', ESM = 'Deshacer recep. devoluc.', FRC = 'Annuler réception retour', ENC = 'Undo Return Receipt';
    Text003: TextConst ENU = 'Quote,Blanket Order,Order,Invoice,Return Order,Credit Memo,Posted Shipment,Posted Invoice,Posted Return Receipt,Posted Credit Memo', ESM = 'Cotización,Pedido abierto,Pedido,Factura,Devolución,Nota crédito,Remisión venta regis.,Factura regis.,Histórico recep. dev.,Nota crédito regis.', FRC = 'Devis,Commande permanente,Commande,Facture,Retour,Note de crédit,Livraison reportée,Facture reportée,Réception de retour reportée,Note de crédit reportée', ENC = 'Quote,Blanket Order,Order,Invoice,Return Order,Credit Memo,Posted Shipment,Posted Invoice,Posted Return Receipt,Posted Credit Memo';
    DocNoOccurrence: Integer;
    DocVersionNo: Integer;
    DocNoNotSerErr: TextConst ENU = 'Select a document number to continue, or choose Cancel to close the page.', ESM = 'Seleccione un número de documento para continuar o elija Cancelar para cerrar la página.', FRC = 'Sélectionnez un numéro de document pour continuer ou choisissez Annuler pour fermer la page.', ENC = 'Select a document number to continue, or choose Cancel to close the page.';
    useworkdate: Boolean;
    UpdateCodeGvar: Codeunit UpdateCode;
    procedure SetSalesHeader(var NewSalesHeader: Record "Sales Header");
    begin
        NewSalesHeader.TestField("No.");
        SalesHeader:=NewSalesHeader;
    end;
    local procedure ValidateDocNo();
    var
        DocType2: Option Quote, "Blanket Order", "Order", Invoice, "Return Order", "Credit Memo", "Posted Shipment", "Posted Invoice", "Posted Return Receipt", "Posted Credit Memo";
    begin
        if DocNo = '' then begin
            FromSalesHeader.Init;
            DocNoOccurrence:=0;
            DocVersionNo:=0;
        end
        else if FromSalesHeader."No." = '' then begin
                FromSalesHeader.Init;
                case DocType of DocType::Quote, DocType::"Blanket Order", DocType::Order, DocType::Invoice, DocType::"Return Order", DocType::"Credit Memo": FromSalesHeader.Get(CopyDocMgt.GetSalesDocumentType(DocType), DocNo);
                DocType::"Posted Shipment": begin
                    FromSalesShptHeader.Get(DocNo);
                    FromSalesHeader.TransferFields(FromSalesShptHeader);
                    if SalesHeader."Document Type" in[SalesHeader."Document Type"::"Return Order", SalesHeader."Document Type"::"Credit Memo"]then begin
                        DocType2:=DocType2::"Posted Invoice";
                        Message(Text000, SelectStr(1 + DocType, Text003), SelectStr(1 + DocType2, Text003), Text001);
                    end;
                end;
                DocType::"Posted Invoice": begin
                    FromSalesInvHeader.Get(DocNo);
                    FromSalesHeader.TransferFields(FromSalesInvHeader);
                end;
                DocType::"Posted Return Receipt": begin
                    FromReturnRcptHeader.Get(DocNo);
                    FromSalesHeader.TransferFields(FromReturnRcptHeader);
                    if SalesHeader."Document Type" in[SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]then begin
                        DocType2:=DocType2::"Posted Credit Memo";
                        Message(Text000, SelectStr(1 + DocType, Text003), SelectStr(1 + DocType2, Text003), Text002);
                    end;
                end;
                DocType::"Posted Credit Memo": begin
                    FromSalesCrMemoHeader.Get(DocNo);
                    FromSalesHeader.TransferFields(FromSalesCrMemoHeader);
                end;
                DocType::"Arch. Quote", DocType::"Arch. Order", DocType::"Arch. Blanket Order", DocType::"Arch. Return Order": begin
                    if not FromSalesHeaderArchive.Get(CopyDocMgt.GetSalesDocumentType(DocType), DocNo, DocNoOccurrence, DocVersionNo)then begin
                        FromSalesHeaderArchive.SetRange("No.", DocNo);
                        if FromSalesHeaderArchive.FindLast then begin
                            DocNoOccurrence:=FromSalesHeaderArchive."Doc. No. Occurrence";
                            DocVersionNo:=FromSalesHeaderArchive."Version No.";
                        end;
                    end;
                    FromSalesHeader.TransferFields(FromSalesHeaderArchive);
                end;
                end;
            end;
        FromSalesHeader."No.":='';
        IncludeHeader:=(DocType in[DocType::"Posted Invoice", DocType::"Posted Credit Memo"]) and ((DocType = DocType::"Posted Credit Memo") <> (SalesHeader."Document Type" in[SalesHeader."Document Type"::"Return Order", SalesHeader."Document Type"::"Credit Memo"])) and (SalesHeader."Bill-to Customer No." in[FromSalesHeader."Bill-to Customer No.", '']);
        OnBeforeValidateIncludeHeader(IncludeHeader);
        ValidateIncludeHeader;
        OnAfterValidateIncludeHeader(IncludeHeader, RecalculateLines);
    end;
    local procedure LookupDocNo();
    begin
        OnBeforeLookupDocNo(SalesHeader);
        case DocType of DocType::Quote, DocType::"Blanket Order", DocType::Order, DocType::Invoice, DocType::"Return Order", DocType::"Credit Memo": LookupSalesDoc;
        DocType::"Posted Shipment": LookupPostedShipment;
        DocType::"Posted Invoice": LookupPostedInvoice;
        DocType::"Posted Return Receipt": LookupPostedReturn;
        DocType::"Posted Credit Memo": LookupPostedCrMemo;
        DocType::"Arch. Quote", DocType::"Arch. Order", DocType::"Arch. Blanket Order", DocType::"Arch. Return Order": LookupSalesArchive;
        end;
        ValidateDocNo;
    end;
    local procedure LookupSalesDoc();
    begin
        FromSalesHeader.FilterGroup:=0;
        FromSalesHeader.SetRange("Document Type", CopyDocMgt.GetSalesDocumentType(DocType));
        if SalesHeader."Document Type" = CopyDocMgt.GetSalesDocumentType(DocType)then FromSalesHeader.SetFilter("No.", '<>%1', SalesHeader."No.");
        FromSalesHeader.FilterGroup:=2;
        FromSalesHeader."Document Type":=CopyDocMgt.GetSalesDocumentType(DocType);
        FromSalesHeader."No.":=DocNo;
        if(DocNo = '') and (SalesHeader."Sell-to Customer No." <> '')then if FromSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.")then begin
                FromSalesHeader."Sell-to Customer No.":=SalesHeader."Sell-to Customer No.";
                if FromSalesHeader.Find('=><')then;
            end;
        if PAGE.RunModal(0, FromSalesHeader) = ACTION::LookupOK then DocNo:=FromSalesHeader."No.";
    end;
    local procedure LookupSalesArchive();
    begin
        FromSalesHeaderArchive.Reset;
        FromSalesHeaderArchive.FilterGroup:=0;
        FromSalesHeaderArchive.SetRange("Document Type", CopyDocMgt.GetSalesDocumentType(DocType));
        FromSalesHeaderArchive.FilterGroup:=2;
        FromSalesHeaderArchive."Document Type":=CopyDocMgt.GetSalesDocumentType(DocType);
        FromSalesHeaderArchive."No.":=DocNo;
        FromSalesHeaderArchive."Doc. No. Occurrence":=DocNoOccurrence;
        FromSalesHeaderArchive."Version No.":=DocVersionNo;
        if(DocNo = '') and (SalesHeader."Sell-to Customer No." <> '')then if FromSalesHeaderArchive.SetCurrentKey("Document Type", "Sell-to Customer No.")then begin
                FromSalesHeaderArchive."Sell-to Customer No.":=SalesHeader."Sell-to Customer No.";
                if FromSalesHeaderArchive.Find('=><')then;
            end;
        if PAGE.RunModal(0, FromSalesHeaderArchive) = ACTION::LookupOK then begin
            DocNo:=FromSalesHeaderArchive."No.";
            DocNoOccurrence:=FromSalesHeaderArchive."Doc. No. Occurrence";
            DocVersionNo:=FromSalesHeaderArchive."Version No.";
            RequestOptionsPage.Update(false);
        end;
    end;
    local procedure LookupPostedShipment();
    begin
        FromSalesShptHeader."No.":=DocNo;
        if(DocNo = '') and (SalesHeader."Sell-to Customer No." <> '')then if FromSalesShptHeader.SetCurrentKey("Sell-to Customer No.")then begin
                FromSalesShptHeader."Sell-to Customer No.":=SalesHeader."Sell-to Customer No.";
                if FromSalesShptHeader.Find('=><')then;
            end;
        if PAGE.RunModal(0, FromSalesShptHeader) = ACTION::LookupOK then DocNo:=FromSalesShptHeader."No.";
    end;
    local procedure LookupPostedInvoice();
    begin
        FromSalesInvHeader."No.":=DocNo;
        if(DocNo = '') and (SalesHeader."Sell-to Customer No." <> '')then if FromSalesInvHeader.SetCurrentKey("Sell-to Customer No.")then begin
                FromSalesInvHeader."Sell-to Customer No.":=SalesHeader."Sell-to Customer No.";
                if FromSalesInvHeader.Find('=><')then;
            end;
        FromSalesInvHeader.FilterGroup(2);
        FromSalesInvHeader.SetRange("Prepayment Invoice", false);
        FromSalesInvHeader.FilterGroup(0);
        if PAGE.RunModal(0, FromSalesInvHeader) = ACTION::LookupOK then DocNo:=FromSalesInvHeader."No.";
    end;
    local procedure LookupPostedCrMemo();
    begin
        FromSalesCrMemoHeader."No.":=DocNo;
        if(DocNo = '') and (SalesHeader."Sell-to Customer No." <> '')then if FromSalesCrMemoHeader.SetCurrentKey("Sell-to Customer No.")then begin
                FromSalesCrMemoHeader."Sell-to Customer No.":=SalesHeader."Sell-to Customer No.";
                if FromSalesCrMemoHeader.Find('=><')then;
            end;
        FromSalesCrMemoHeader.FilterGroup(2);
        FromSalesCrMemoHeader.SetRange("Prepayment Credit Memo", false);
        FromSalesCrMemoHeader.FilterGroup(0);
        if PAGE.RunModal(0, FromSalesCrMemoHeader) = ACTION::LookupOK then DocNo:=FromSalesCrMemoHeader."No.";
    end;
    local procedure LookupPostedReturn();
    begin
        FromReturnRcptHeader."No.":=DocNo;
        if(DocNo = '') and (SalesHeader."Sell-to Customer No." <> '')then if FromReturnRcptHeader.SetCurrentKey("Sell-to Customer No.")then begin
                FromReturnRcptHeader."Sell-to Customer No.":=SalesHeader."Sell-to Customer No.";
                if FromReturnRcptHeader.Find('=><')then;
            end;
        if PAGE.RunModal(0, FromReturnRcptHeader) = ACTION::LookupOK then DocNo:=FromReturnRcptHeader."No.";
    end;
    local procedure ValidateIncludeHeader();
    begin
        RecalculateLines:=(DocType in[DocType::"Posted Shipment", DocType::"Posted Return Receipt"]) or not IncludeHeader;
    end;
    procedure InitializeRequest(NewDocType: Option; NewDocNo: Code[20]; NewIncludeHeader: Boolean; NewRecalcLines: Boolean);
    begin
        DocType:=NewDocType;
        DocNo:=NewDocNo;
        IncludeHeader:=NewIncludeHeader;
        RecalculateLines:=NewRecalcLines;
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterOpenPage();
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateIncludeHeader(var IncludeHeader: Boolean; var RecalculateLines: Boolean);
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeLookupDocNo(var SalesHeader: Record "Sales Header");
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateIncludeHeader(var DoIncludeHeader: Boolean);
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnPreReportOnBeforeCopySalesDoc(var CopyDocumentMgt: Codeunit "Copy Document Mgt.");
    begin
    end;
}
