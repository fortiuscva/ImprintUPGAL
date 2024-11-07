report 60006 "Get Sales Orders Ext"
{
    //IMP1.01, 04/06/23, SK: Replaced the code as per suggestions by MS version 22.0.
    // version NAVW114.22
    CaptionML = ENU = 'Get Sales Orders', ESM = 'Tomar pedidos venta', FRC = 'Extraire documents de vente', ENC = 'Get Sales Orders';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order), Type = CONST(Item), "Purch. Order Line No." = CONST(0), "Outstanding Quantity" = FILTER(<> 0));
            RequestFilterFields = "Document No.", "Sell-to Customer No.", "No.";
            RequestFilterHeadingML = ENU = 'Sales Order Line', ESM = 'Línea de pedido de venta', FRC = 'Ligne de document de vente', ENC = 'Sales Order Line';

            trigger OnAfterGetRecord();
            begin
                if ("Purchasing Code" = '') and (SpecOrder <> 1) then
                    if "Drop Shipment" then begin
                        LineCount := LineCount + 1;
                        Window.Update(1, LineCount);
                        InsertReqWkshLine("Sales Line");
                    end;
                if "Purchasing Code" <> '' then
                    if PurchasingCode.Get("Purchasing Code") then
                        if PurchasingCode."Drop Shipment" and (SpecOrder <> 1) then begin
                            LineCount := LineCount + 1;
                            Window.Update(1, LineCount);
                            InsertReqWkshLine("Sales Line");
                        end
                        else
                            if PurchasingCode."Special Order" and ("Special Order Purchase No." = '') and (SpecOrder <> 0) then begin
                                LineCount := LineCount + 1;
                                Window.Update(1, LineCount);
                                InsertReqWkshLine("Sales Line");
                            end;
            end;

            trigger OnPostDataItem();
            begin
                if LineCount = 0 then Error(Text001);
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

                    field(GetDim; GetDim)
                    {
                        ApplicationArea = Dimensions;
                        CaptionML = ENU = 'Retrieve dimensions from', ESM = 'Recuperar dimensiones de', FRC = 'Récupérer les dimensions de', ENC = 'Retrieve dimensions from';
                        OptionCaptionML = ENU = 'Item,Sales Line', ESM = 'Producto,Línea ventas', FRC = 'Article,Ligne vente', ENC = 'Item,Sales Line';
                        ToolTipML = ENU = 'Specifies the source of dimensions that will be copied in the batch job. Dimensions can be copied exactly as they were used on a sales line or can be copied from the items used on a sales line.', ESM = 'Especifica el origen de las dimensiones que se copiarán al trabajo por lotes. Las dimensiones pueden copiarse tal y como se usaron en una línea de venta o desde los productos utilizados en una línea de venta.', FRC = 'Spécifie l''origine des dimensions à copier dans le traitement en lot. Les dimensions peuvent être copiées telles qu''elles étaient utilisées sur une ligne vente, ou copiées à partir des articles utilisés sur une ligne vente.', ENC = 'Specifies the source of dimensions that will be copied in the batch job. Dimensions can be copied exactly as they were used on a sales line or can be copied from the items used on a sales line.';
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
        ReqWkshTmpl.Get(ReqLine."Worksheet Template Name");
        ReqWkshName.Get(ReqLine."Worksheet Template Name", ReqLine."Journal Batch Name");
        ReqLine.SetRange("Worksheet Template Name", ReqLine."Worksheet Template Name");
        ReqLine.SetRange("Journal Batch Name", ReqLine."Journal Batch Name");
        ReqLine.LockTable;
        if ReqLine.FindLast then begin
            ReqLine.Init;
            LineNo := ReqLine."Line No.";
        end;
        Window.Open(Text000);
    end;

    var
        Text000: TextConst ENU = 'Processing sales lines  #1######', ESM = 'Procesando líns. venta  #1######', FRC = 'Lignes de ventes en traitement  #1######', ENC = 'Processing sales lines  #1######';
        Text001: TextConst ENU = 'There are no sales lines to retrieve.', ESM = 'No hay líneas venta para transferir.', FRC = 'Il n''y aucune ligne à trouver.', ENC = 'There are no sales lines to retrieve.';
        ReqWkshTmpl: Record "Req. Wksh. Template";
        ReqWkshName: Record "Requisition Wksh. Name";
        ReqLine: Record "Requisition Line";
        SalesHeader: Record "Sales Header";
        PurchasingCode: Record Purchasing;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        UOMMgt: Codeunit "Unit of Measure Management";
        Window: Dialog;
        LineCount: Integer;
        SpecOrder: Integer;
        GetDim: Option Item,"Sales Line";
        LineNo: Integer;

    procedure SetReqWkshLine(NewReqLine: Record "Requisition Line"; SpecialOrder: Integer);
    begin
        ReqLine := NewReqLine;
        SpecOrder := SpecialOrder;
    end;

    local procedure InsertReqWkshLine(SalesLine: Record "Sales Line");
    begin
        ReqLine.Reset;
        ReqLine.SetCurrentKey(Type, "No.");
        ReqLine.SetRange(Type, "Sales Line".Type);
        ReqLine.SetRange("No.", "Sales Line"."No.");
        ReqLine.SetRange("Sales Order No.", "Sales Line"."Document No.");
        ReqLine.SetRange("Sales Order Line No.", "Sales Line"."Line No.");
        if ReqLine.FindFirst then exit;
        LineNo := LineNo + 10000;
        Clear(ReqLine);
        //ReqLine.SetDropShipment(SalesLine."Drop Shipment"); //IMP1.01
        ReqLine.Init;
        ReqLine."Worksheet Template Name" := ReqWkshName."Worksheet Template Name";
        ReqLine."Journal Batch Name" := ReqWkshName.Name;
        ReqLine."Line No." := LineNo;
        ReqLine.Validate(Type, SalesLine.Type);
        ReqLine."Location Code" := SalesLine."Location Code";
        ReqLine.Validate("No.", SalesLine."No.");
        ReqLine."Variant Code" := SalesLine."Variant Code";
        ReqLine."Drop Shipment" := "Sales Line"."Drop Shipment"; //IMP1.01
        ReqLine.Validate("Location Code");
        ReqLine."Bin Code" := SalesLine."Bin Code";
        // ISS2.00 09.06.13 DFP ===========================================================================\
        if SalesLine."Vendor No." <> '' then ReqLine.Validate("Vendor No.", SalesLine."Vendor No.");
        Message(ReqLine."Vendor No.");
        // End ============================================================================================/
        // Drop Shipment means replenishment by purchase only
        if (ReqLine."Replenishment System" <> ReqLine."Replenishment System"::Purchase) and SalesLine."Drop Shipment" then ReqLine.Validate("Replenishment System", ReqLine."Replenishment System"::Purchase);
        ReqLine.Validate("Unit of Measure Code", SalesLine."Unit of Measure Code");
        ReqLine.Validate(Quantity, Round(SalesLine."Outstanding Quantity" * SalesLine."Qty. per Unit of Measure" / ReqLine."Qty. per Unit of Measure", UOMMgt.QtyRndPrecision));
        ReqLine."Sales Order No." := SalesLine."Document No.";
        ReqLine."Sales Order Line No." := SalesLine."Line No.";
        ReqLine."Sell-to Customer No." := SalesLine."Sell-to Customer No.";
        SalesHeader.Get(1, SalesLine."Document No.");
        if SpecOrder <> 1 then ReqLine."Ship-to Code" := SalesHeader."Ship-to Code";
        ReqLine."Item Category Code" := SalesLine."Item Category Code";
        ReqLine.Nonstock := SalesLine.Nonstock;
        ReqLine."Action Message" := ReqLine."Action Message"::New;
        ReqLine."Purchasing Code" := SalesLine."Purchasing Code";
        // Backward Scheduling
        ReqLine."Due Date" := SalesLine."Shipment Date";
        ReqLine."Ending Date" := LeadTimeMgt.PlannedEndingDate(ReqLine."No.", ReqLine."Location Code", ReqLine."Variant Code", ReqLine."Due Date", ReqLine."Vendor No.", ReqLine."Ref. Order Type");
        ReqLine.CalcStartingDate('');
        ReqLine.UpdateDescription;
        ReqLine.UpdateDatetime;
        OnBeforeInsertReqWkshLine(ReqLine, SalesLine, SpecOrder);
        ReqLine.Insert;
        ItemTrackingMgt.CopyItemTracking(SalesLine.RowID1, ReqLine.RowID1, true);
        if GetDim = GetDim::"Sales Line" then begin
            ReqLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
            ReqLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
            ReqLine."Dimension Set ID" := SalesLine."Dimension Set ID";
            ReqLine.Modify;
        end;
        OnAfterInsertReqWkshLine(ReqLine, SalesLine);
    end;

    procedure InitializeRequest(NewRetrieveDimensionsFrom: Option);
    begin
        GetDim := NewRetrieveDimensionsFrom;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertReqWkshLine(var ReqLine: Record "Requisition Line"; SalesLine: Record "Sales Line");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertReqWkshLine(var ReqLine: Record "Requisition Line"; SalesLine: Record "Sales Line"; SpecOrder: Integer);
    begin
    end;
}
