report 60007 "Calculate Inventory Ext"
{
    // version NAVW114.06
    CaptionML = ENU = 'Calculate Inventory', ESM = 'Calcular inventario físico', FRC = 'Calculer l''inventaire', ENC = 'Calculate Inventory';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") WHERE(Type = CONST(Inventory), Blocked = CONST(false));
            RequestFilterFields = "No.", "Location Filter", "Bin Filter";

            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Filter"), "Location Code" = FIELD("Location Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");

                trigger OnAfterGetRecord();
                var
                    ItemVariant: Record "Item Variant";
                    ByBin: Boolean;
                    ExecuteLoop: Boolean;
                    InsertTempSKU: Boolean;
                begin
                    if not GetLocation("Location Code") then CurrReport.Skip;
                    if ColumnDim <> '' then TransferDim("Dimension Set ID");
                    if not "Drop Shipment" then ByBin := Location."Bin Mandatory" and not Location."Directed Put-away and Pick";
                    if not SkipCycleSKU("Location Code", "Item No.", "Variant Code") then
                        if ByBin then begin
                            if not TempSKU.Get("Location Code", "Item No.", "Variant Code") then begin
                                InsertTempSKU := false;
                                if "Variant Code" = '' then
                                    InsertTempSKU := true
                                else
                                    if ItemVariant.Get("Item No.", "Variant Code") then InsertTempSKU := true;
                                if InsertTempSKU then begin
                                    TempSKU."Item No." := "Item No.";
                                    TempSKU."Variant Code" := "Variant Code";
                                    TempSKU."Location Code" := "Location Code";
                                    TempSKU.Insert;
                                    ExecuteLoop := true;
                                end;
                            end;
                            if ExecuteLoop then begin
                                WhseEntry.SetRange("Item No.", "Item No.");
                                WhseEntry.SetRange("Location Code", "Location Code");
                                WhseEntry.SetRange("Variant Code", "Variant Code");
                                if WhseEntry.Find('-') then
                                    if WhseEntry."Entry No." <> OldWhseEntry."Entry No." then begin
                                        OldWhseEntry := WhseEntry;
                                        repeat
                                            WhseEntry.SetRange("Bin Code", WhseEntry."Bin Code");
                                            if not ItemBinLocationIsCalculated(WhseEntry."Bin Code") then begin
                                                WhseEntry.CalcSums("Qty. (Base)");
                                                UpdateBuffer(WhseEntry."Bin Code", WhseEntry."Qty. (Base)");
                                            end;
                                            WhseEntry.Find('+');
                                            Item.CopyFilter("Bin Filter", WhseEntry."Bin Code");
                                        until WhseEntry.Next = 0;
                                    end;
                            end;
                        end
                        else
                            UpdateBuffer('', Quantity);
                end;

                trigger OnPreDataItem();
                begin
                    WhseEntry.SetCurrentKey("Item No.", "Bin Code", "Location Code", "Variant Code");
                    Item.CopyFilter("Bin Filter", WhseEntry."Bin Code");
                    if ColumnDim = '' then
                        TempDimBufIn.SetRange("Table ID", DATABASE::Item)
                    else
                        TempDimBufIn.SetRange("Table ID", DATABASE::"Item Ledger Entry");
                    TempDimBufIn.SetRange("Entry No.");
                    TempDimBufIn.DeleteAll;
                end;
            }
            dataitem("Warehouse Entry"; "Warehouse Entry")
            {
                DataItemLink = "Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Filter"), "Location Code" = FIELD("Location Filter");

                trigger OnAfterGetRecord();
                begin
                    if not "Item Ledger Entry".IsEmpty then CurrReport.Skip; // Skip if item has any record in Item Ledger Entry.
                    Clear(QuantityOnHandBuffer);
                    QuantityOnHandBuffer."Item No." := "Item No.";
                    QuantityOnHandBuffer."Location Code" := "Location Code";
                    QuantityOnHandBuffer."Variant Code" := "Variant Code";
                    GetLocation("Location Code");
                    if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then QuantityOnHandBuffer."Bin Code" := "Bin Code";
                    OnBeforeQuantityOnHandBufferFindAndInsert(QuantityOnHandBuffer);
                    if not QuantityOnHandBuffer.Find then QuantityOnHandBuffer.Insert; // Insert a zero quantity line.
                end;
            }
            dataitem(ItemWithNoTransaction; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                trigger OnAfterGetRecord();
                begin
                    if IncludeItemWithNoTransaction then UpdateQuantityOnHandBuffer(Item."No.");
                end;
            }
            trigger OnAfterGetRecord();
            begin
                if not HideValidationDialog then Window.Update;
                TempSKU.DeleteAll;
            end;

            trigger OnPostDataItem();
            begin
                CalcPhysInvQtyAndInsertItemJnlLine;
            end;

            trigger OnPreDataItem();
            var
                ItemJnlTemplate: Record "Item Journal Template";
                ItemJnlBatch: Record "Item Journal Batch";
            begin
                if PostingDate = 0D then Error(Text000);
                ItemJnlTemplate.Get(ItemJnlLine."Journal Template Name");
                ItemJnlBatch.Get(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
                if NextDocNo = '' then begin
                    if ItemJnlBatch."No. Series" <> '' then begin
                        ItemJnlLine.SetRange("Journal Template Name", ItemJnlLine."Journal Template Name");
                        ItemJnlLine.SetRange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
                        if not ItemJnlLine.FindFirst then NextDocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", PostingDate, false);
                        ItemJnlLine.Init;
                    end;
                    if NextDocNo = '' then Error(Text001);
                end;
                NextLineNo := 0;
                if not HideValidationDialog then Window.Open(Text002, "No.");
                if not SkipDim then SelectedDim.GetSelectedDim(UserId, 3, REPORT::"Calculate Inventory", '', TempSelectedDim);
                QuantityOnHandBuffer.Reset;
                QuantityOnHandBuffer.DeleteAll;
                OnAfterItemOnPreDataItem(Item, ZeroQty, IncludeItemWithNoTransaction);
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

                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Posting Date', ESM = 'Fecha registro', FRC = 'Date de report', ENC = 'Posting Date';
                        ToolTipML = ENU = 'Specifies the date for the posting of this batch job. By default, the working date is entered, but you can change it.', ESM = 'Especifica la fecha de registro de este trabajo por lotes. La fecha de trabajo se especifica de forma predeterminada, pero es posible cambiarla.', FRC = 'Spécifie la date du report de ce traitement en lot. Par défaut, la date de travail est saisie, mais vous pouvez la modifier.', ENC = 'Specifies the date for the posting of this batch job. By default, the working date is entered, but you can change it.';

                        trigger OnValidate();
                        begin
                            ValidatePostingDate;
                        end;
                    }
                    field(DocumentNo; NextDocNo)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Document No.', ESM = 'Nº documento', FRC = 'N° de document', ENC = 'Document No.';
                        ToolTipML = ENU = 'Specifies the number of the document that is processed by the report or batch job.', ESM = 'Especifica el número del documento procesado por el informe o el trabajo por lotes.', FRC = 'Spécifie le numéro du document traité par le rapport ou le traitement en lot.', ENC = 'Specifies the number of the document that is processed by the report or batch job.';
                    }
                    field(ItemsNotOnInventory; ZeroQty)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Items Not on Inventory.', ESM = 'Incluir prods. sin invent.', FRC = 'Articles hors inventaire.', ENC = 'Items Not on Inventory.';
                        ToolTipML = ENU = 'Specifies if journal lines should be created for items that are not on inventory, that is, items where the value in the Qty. (Calculated) field is 0.', ESM = 'Especifica si deben crearse líneas del diario para los artículos que no están en el inventario; es decir, artículos en los que el valor del campo Existencias calculadas es 0.', FRC = 'Spécifie si des lignes journal doivent être créées pour les articles qui ne figurent pas dans l''inventaire, à savoir les articles dont la valeur du champ Quantité (calculée) est égale à 0.', ENC = 'Specifies if journal lines should be created for items that are not on inventory, that is, items where the value in the Qty. (Calculated) field is 0.';

                        trigger OnValidate();
                        begin
                            if not ZeroQty then IncludeItemWithNoTransaction := false;
                        end;
                    }
                    field(IncludeItemWithNoTransaction; IncludeItemWithNoTransaction)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Include Item without Transactions', ESM = 'Incluir artículo sin transacciones', FRC = 'Inclure l''article sans transactions', ENC = 'Include Item without Transactions';
                        ToolTipML = ENU = 'Specifies if journal lines should be created for items that are not on inventory and are not used in any transactions.', ESM = 'Especifica si deben crearse líneas del diario para los artículos que no están en el inventario y que no se usan en ninguna transacción.', FRC = 'Indique si les lignes journal doivent être créées pour les articles qui ne figurent pas dans l''inventaire et qui ne sont pas utilisés dans les transactions.', ENC = 'Specifies if journal lines should be created for items that are not on inventory and are not used in any transactions.';

                        trigger OnValidate();
                        begin
                            if not IncludeItemWithNoTransaction then exit;
                            if not ZeroQty then Error(ItemNotOnInventoryErr);
                        end;
                    }
                    field(ByDimensions; ColumnDim)
                    {
                        ApplicationArea = Dimensions;
                        CaptionML = ENU = 'By Dimensions', ESM = 'Por dimensiones', FRC = 'Par axe', ENC = 'By Dimensions';
                        Editable = false;
                        ToolTipML = ENU = 'Specifies the dimensions that you want the batch job to consider.', ESM = 'Especifica las dimensiones que desea que tenga en cuenta el proceso.', FRC = 'Spécifie les dimensions dont vous souhaitez que le traitement en lot tienne compte.', ENC = 'Specifies the dimensions that you want the batch job to consider.';

                        trigger OnAssistEdit();
                        begin
                            DimSelectionBuf.SetDimSelectionMultiple(3, REPORT::"Calculate Inventory", ColumnDim);
                        end;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage();
        begin
            if PostingDate = 0D then PostingDate := WorkDate;
            ValidatePostingDate;
            ColumnDim := DimSelectionBuf.GetDimSelectionText(3, REPORT::"Calculate Inventory", '');
        end;
    }
    labels
    {
    }
    trigger OnPreReport();
    begin
        if SkipDim then
            ColumnDim := ''
        else
            DimSelectionBuf.CompareDimText(3, REPORT::"Calculate Inventory", '', ColumnDim, Text003);
        ZeroQtySave := ZeroQty;
    end;

    var
        Text000: TextConst ENU = 'Enter the posting date.', ESM = 'Introduzca la fecha de registro.', FRC = 'Entrez la date de report.', ENC = 'Enter the posting date.';
        Text001: TextConst ENU = 'Enter the document no.', ESM = 'Introduzca el número de documento.', FRC = 'Entrez un numéro de document.', ENC = 'Enter the document no.';
        Text002: TextConst ENU = 'Processing items    #1##########', ESM = 'Procesando prods.   #1##########', FRC = 'Traitement des articles    #1##########', ENC = 'Processing items    #1##########';
        Text003: TextConst ENU = 'Retain Dimensions', ESM = 'Retener dimensiones', FRC = 'Conserver les dimensions', ENC = 'Retain Dimensions';
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        WhseEntry: Record "Warehouse Entry";
        QuantityOnHandBuffer: Record "Inventory Buffer" temporary;
        SourceCodeSetup: Record "Source Code Setup";
        DimSetEntry: Record "Dimension Set Entry";
        OldWhseEntry: Record "Warehouse Entry";
        TempSKU: Record "Stockkeeping Unit" temporary;
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        SelectedDim: Record "Selected Dimension";
        TempSelectedDim: Record "Selected Dimension" temporary;
        TempDimBufIn: Record "Dimension Buffer" temporary;
        TempDimBufOut: Record "Dimension Buffer" temporary;
        DimSelectionBuf: Record "Dimension Selection Buffer";
        Location: Record Location;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimBufMgt: Codeunit "Dimension Buffer Management";
        Window: Dialog;
        PostingDate: Date;
        CycleSourceType: Option " ",Item,SKU;
        PhysInvtCountCode: Code[10];
        NextDocNo: Code[20];
        NextLineNo: Integer;
        ZeroQty: Boolean;
        ZeroQtySave: Boolean;
        IncludeItemWithNoTransaction: Boolean;
        HideValidationDialog: Boolean;
        AdjustPosQty: Boolean;
        ItemTrackingSplit: Boolean;
        SkipDim: Boolean;
        ColumnDim: Text[250];
        PosQty: Decimal;
        NegQty: Decimal;
        ItemNotOnInventoryErr: TextConst ENU = 'Items Not on Inventory.', ESM = 'Incluir prods. sin invent.', FRC = 'Articles hors inventaire.', ENC = 'Items Not on Inventory.';

    procedure SetItemJnlLine(var NewItemJnlLine: Record "Item Journal Line");
    begin
        ItemJnlLine := NewItemJnlLine;
    end;

    local procedure ValidatePostingDate();
    begin
        ItemJnlBatch.Get(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
        if ItemJnlBatch."No. Series" = '' then
            NextDocNo := ''
        else begin
            NextDocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", PostingDate, false);
            Clear(NoSeriesMgt);
        end;
    end;

    local procedure InsertItemJnlLine(ItemNo: Code[20]; VariantCode2: Code[10]; DimEntryNo2: Integer; BinCode2: Code[20]; Quantity2: Decimal; PhysInvQuantity: Decimal);
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ReservEntry: Record "Reservation Entry";
        WhseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
        Bin: Record Bin;
        DimValue: Record "Dimension Value";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        DimMgt: Codeunit DimensionManagement;
        EntryType: Option "Negative Adjmt.","Positive Adjmt.";
        NoBinExist: Boolean;
        OrderLineNo: Integer;
    begin
        OnBeforeFunctionInsertItemJnlLine(ItemNo, VariantCode2, DimEntryNo2, BinCode2, Quantity2, PhysInvQuantity);
        if NextLineNo = 0 then begin
            ItemJnlLine.LockTable;
            ItemJnlLine.SetRange("Journal Template Name", ItemJnlLine."Journal Template Name");
            ItemJnlLine.SetRange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
            if ItemJnlLine.FindLast then NextLineNo := ItemJnlLine."Line No.";
            SourceCodeSetup.Get;
        end;
        NextLineNo := NextLineNo + 10000;
        if (Quantity2 <> 0) or ZeroQty then begin
            if (Quantity2 = 0) and Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then if not Bin.Get(Location.Code, BinCode2) then NoBinExist := true;
            ItemJnlLine.Init;
            ItemJnlLine."Line No." := NextLineNo;
            ItemJnlLine.Validate("Posting Date", PostingDate);
            if PhysInvQuantity >= Quantity2 then
                ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.")
            else
                ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.");
            ItemJnlLine.Validate("Document No.", NextDocNo);
            ItemJnlLine.Validate("Item No.", ItemNo);
            ItemJnlLine.Validate("Variant Code", VariantCode2);
            ItemJnlLine.Validate("Location Code", Location.Code);
            if not NoBinExist then
                ItemJnlLine.Validate("Bin Code", BinCode2)
            else
                ItemJnlLine.Validate("Bin Code", '');
            ItemJnlLine.Validate("Source Code", SourceCodeSetup."Phys. Inventory Journal");
            ItemJnlLine."Qty. (Phys. Inventory)" := PhysInvQuantity;
            ItemJnlLine."Phys. Inventory" := true;
            ItemJnlLine.Validate("Qty. (Calculated)", Quantity2);
            ItemJnlLine."Posting No. Series" := ItemJnlBatch."Posting No. Series";
            ItemJnlLine."Reason Code" := ItemJnlBatch."Reason Code";
            ItemJnlLine."Phys Invt Counting Period Code" := PhysInvtCountCode;
            ItemJnlLine."Phys Invt Counting Period Type" := CycleSourceType;
            if Location."Bin Mandatory" then ItemJnlLine."Dimension Set ID" := 0;
            ItemJnlLine."Shortcut Dimension 1 Code" := '';
            ItemJnlLine."Shortcut Dimension 2 Code" := '';
            ItemLedgEntry.Reset;
            ItemLedgEntry.SetCurrentKey("Item No.");
            ItemLedgEntry.SetRange("Item No.", ItemNo);
            if ItemLedgEntry.FindLast then
                ItemJnlLine."Last Item Ledger Entry No." := ItemLedgEntry."Entry No."
            else
                ItemJnlLine."Last Item Ledger Entry No." := 0;
            ItemJnlLine.Insert(true);
            OnAfterInsertItemJnlLine(ItemJnlLine);
            if Location.Code <> '' then
                if Location."Directed Put-away and Pick" then begin
                    WhseEntry.SetCurrentKey("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type");
                    WhseEntry.SetRange("Item No.", ItemJnlLine."Item No.");
                    WhseEntry.SetRange("Bin Code", Location."Adjustment Bin Code");
                    WhseEntry.SetRange("Location Code", ItemJnlLine."Location Code");
                    WhseEntry.SetRange("Variant Code", ItemJnlLine."Variant Code");
                    if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Positive Adjmt." then EntryType := EntryType::"Negative Adjmt.";
                    if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Negative Adjmt." then EntryType := EntryType::"Positive Adjmt.";
                    WhseEntry.SetRange("Entry Type", EntryType);
                    if WhseEntry.Find('-') then
                        repeat
                            WhseEntry.SetRange("Lot No.", WhseEntry."Lot No.");
                            WhseEntry.SetRange("Serial No.", WhseEntry."Serial No.");
                            WhseEntry.CalcSums("Qty. (Base)");
                            WhseEntry2.SetCurrentKey("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type");
                            WhseEntry2.CopyFilters(WhseEntry);
                            case EntryType of
                                EntryType::"Positive Adjmt.":
                                    WhseEntry2.SetRange("Entry Type", WhseEntry2."Entry Type"::"Negative Adjmt.");
                                EntryType::"Negative Adjmt.":
                                    WhseEntry2.SetRange("Entry Type", WhseEntry2."Entry Type"::"Positive Adjmt.");
                            end;
                            WhseEntry2.CalcSums("Qty. (Base)");
                            if Abs(WhseEntry2."Qty. (Base)") > Abs(WhseEntry."Qty. (Base)") then
                                WhseEntry."Qty. (Base)" := 0
                            else
                                WhseEntry."Qty. (Base)" := WhseEntry."Qty. (Base)" + WhseEntry2."Qty. (Base)";
                            if WhseEntry."Qty. (Base)" <> 0 then begin
                                if ItemJnlLine."Order Type" = ItemJnlLine."Order Type"::Production then OrderLineNo := ItemJnlLine."Order Line No.";
                                /*(CreateReservEntry.CreateReservEntryFor(
                                  DATABASE::"Item Journal Line",
                                  "Entry Type",
                                  "Journal Template Name",
                                  "Journal Batch Name",
                                  OrderLineNo,
                                  "Line No.",
                                  "Qty. per Unit of Measure",
                                  Abs(WhseEntry.Quantity),
                                  Abs(WhseEntry."Qty. (Base)"),
                                  WhseEntry."Serial No.",
                                  WhseEntry."Lot No.");*/
                                //UPG
                                if WhseEntry."Qty. (Base)" < 0 then // only Date on positive adjustments
                                    CreateReservEntry.SetDates(WhseEntry."Warranty Date", WhseEntry."Expiration Date");
                                CreateReservEntry.CreateEntry(ItemJnlLine."Item No.", ItemJnlLine."Variant Code", ItemJnlLine."Location Code", ItemJnlLine.Description, 0D, 0D, 0, ReservEntry."Reservation Status"::Prospect);
                            end;
                            WhseEntry.Find('+');
                            WhseEntry.SetRange("Lot No.");
                            WhseEntry.SetRange("Serial No.");
                        until WhseEntry.Next = 0;
                end;
            if ColumnDim = '' then DimEntryNo2 := CreateDimFromItemDefault;
            if DimBufMgt.GetDimensions(DimEntryNo2, TempDimBufOut) then begin
                TempDimSetEntry.Reset;
                TempDimSetEntry.DeleteAll;
                if TempDimBufOut.Find('-') then begin
                    repeat
                        DimValue.Get(TempDimBufOut."Dimension Code", TempDimBufOut."Dimension Value Code");
                        TempDimSetEntry."Dimension Code" := TempDimBufOut."Dimension Code";
                        TempDimSetEntry."Dimension Value Code" := TempDimBufOut."Dimension Value Code";
                        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                        if TempDimSetEntry.Insert then;
                        ItemJnlLine."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                        DimMgt.UpdateGlobalDimFromDimSetID(ItemJnlLine."Dimension Set ID", ItemJnlLine."Shortcut Dimension 1 Code", ItemJnlLine."Shortcut Dimension 2 Code");
                        ItemJnlLine.Modify;
                    until TempDimBufOut.Next = 0;
                    TempDimBufOut.DeleteAll;
                end;
            end;
        end;
        OnAfterFunctionInsertItemJnlLine(ItemNo, VariantCode2, DimEntryNo2, BinCode2, Quantity2, PhysInvQuantity, ItemJnlLine);
    end;

    local procedure InsertQuantityOnHandBuffer(ItemNo: Code[20]; LocationCode: Code[10]; VariantCode: Code[10]);
    begin
        QuantityOnHandBuffer.Reset;
        QuantityOnHandBuffer.SetRange("Item No.", ItemNo);
        QuantityOnHandBuffer.SetRange("Location Code", LocationCode);
        QuantityOnHandBuffer.SetRange("Variant Code", VariantCode);
        if not QuantityOnHandBuffer.FindFirst then begin
            QuantityOnHandBuffer.Reset;
            QuantityOnHandBuffer.Init;
            QuantityOnHandBuffer."Item No." := ItemNo;
            QuantityOnHandBuffer."Location Code" := LocationCode;
            QuantityOnHandBuffer."Variant Code" := VariantCode;
            QuantityOnHandBuffer."Bin Code" := '';
            QuantityOnHandBuffer."Dimension Entry No." := 0;
            QuantityOnHandBuffer.Insert(true);
        end;
    end;

    procedure InitializeRequest(NewPostingDate: Date; DocNo: Code[20]; ItemsNotOnInvt: Boolean; InclItemWithNoTrans: Boolean);
    begin
        PostingDate := NewPostingDate;
        NextDocNo := DocNo;
        ZeroQty := ItemsNotOnInvt;
        IncludeItemWithNoTransaction := InclItemWithNoTrans and ZeroQty;
        if not SkipDim then ColumnDim := DimSelectionBuf.GetDimSelectionText(3, REPORT::"Calculate Inventory", '');
    end;

    local procedure TransferDim(DimSetID: Integer);
    begin
        DimSetEntry.SetRange("Dimension Set ID", DimSetID);
        if DimSetEntry.Find('-') then begin
            repeat
                if TempSelectedDim.Get(UserId, 3, REPORT::"Calculate Inventory", '', DimSetEntry."Dimension Code") then InsertDim(DATABASE::"Item Ledger Entry", DimSetID, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
            until DimSetEntry.Next = 0;
        end;
    end;

    local procedure CalcWhseQty(AdjmtBin: Code[20]; var PosQuantity: Decimal; var NegQuantity: Decimal);
    var
        WhseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        WhseQuantity: Decimal;
        WhseSNRequired: Boolean;
        WhseLNRequired: Boolean;
        NoWhseEntry: Boolean;
        NoWhseEntry2: Boolean;
    begin
        AdjustPosQty := false;
        ItemTrackingMgt.CheckWhseItemTrkgSetup(QuantityOnHandBuffer."Item No.");
        ItemTrackingSplit := WhseSNRequired or WhseLNRequired;
        WhseEntry.SetCurrentKey("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type");
        WhseEntry.SetRange("Item No.", QuantityOnHandBuffer."Item No.");
        WhseEntry.SetRange("Location Code", QuantityOnHandBuffer."Location Code");
        WhseEntry.SetRange("Variant Code", QuantityOnHandBuffer."Variant Code");
        WhseEntry.CalcSums("Qty. (Base)");
        WhseQuantity := WhseEntry."Qty. (Base)";
        WhseEntry.SetRange("Bin Code", AdjmtBin);
        if WhseSNRequired then begin
            WhseEntry.SetRange("Entry Type", WhseEntry."Entry Type"::"Positive Adjmt.");
            WhseEntry.CalcSums("Qty. (Base)");
            PosQuantity := WhseQuantity - WhseEntry."Qty. (Base)";
            WhseEntry.SetRange("Entry Type", WhseEntry."Entry Type"::"Negative Adjmt.");
            WhseEntry.CalcSums("Qty. (Base)");
            NegQuantity := WhseQuantity - WhseEntry."Qty. (Base)";
            WhseEntry.SetRange("Entry Type", WhseEntry."Entry Type"::Movement);
            WhseEntry.CalcSums("Qty. (Base)");
            if WhseEntry."Qty. (Base)" <> 0 then begin
                if WhseEntry."Qty. (Base)" > 0 then
                    PosQuantity := PosQuantity + WhseQuantity - WhseEntry."Qty. (Base)"
                else
                    NegQuantity := NegQuantity - WhseQuantity - WhseEntry."Qty. (Base)";
            end;
            WhseEntry.SetRange("Entry Type", WhseEntry."Entry Type"::"Positive Adjmt.");
            if WhseEntry.Find('-') then begin
                repeat
                    WhseEntry.SetRange("Serial No.", WhseEntry."Serial No.");
                    WhseEntry2.Reset;
                    WhseEntry2.SetCurrentKey("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type");
                    WhseEntry2.CopyFilters(WhseEntry);
                    WhseEntry2.SetRange("Entry Type", WhseEntry2."Entry Type"::"Negative Adjmt.");
                    WhseEntry2.SetRange("Serial No.", WhseEntry."Serial No.");
                    if WhseEntry2.Find('-') then
                        repeat
                            PosQuantity := PosQuantity + 1;
                            NegQuantity := NegQuantity - 1;
                            NoWhseEntry := WhseEntry.Next = 0;
                            NoWhseEntry2 := WhseEntry2.Next = 0;
                        until NoWhseEntry2 or NoWhseEntry
                    else
                        AdjustPosQty := true;
                    if not NoWhseEntry and NoWhseEntry2 then AdjustPosQty := true;
                    WhseEntry.Find('+');
                    WhseEntry.SetRange("Serial No.");
                until WhseEntry.Next = 0;
            end;
        end
        else begin
            if WhseEntry.Find('-') then
                repeat
                    WhseEntry.SetRange("Lot No.", WhseEntry."Lot No.");
                    WhseEntry.CalcSums("Qty. (Base)");
                    if WhseEntry."Qty. (Base)" <> 0 then begin
                        if WhseEntry."Qty. (Base)" > 0 then
                            NegQuantity := NegQuantity - WhseEntry."Qty. (Base)"
                        else
                            PosQuantity := PosQuantity + WhseEntry."Qty. (Base)";
                    end;
                    WhseEntry.Find('+');
                    WhseEntry.SetRange("Lot No.");
                until WhseEntry.Next = 0;
            if PosQuantity <> WhseQuantity then PosQuantity := WhseQuantity - PosQuantity;
            if NegQuantity <> -WhseQuantity then NegQuantity := WhseQuantity + NegQuantity;
        end;
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    procedure InitializePhysInvtCount(PhysInvtCountCode2: Code[10]; CountSourceType2: Option " ",Item,SKU);
    begin
        PhysInvtCountCode := PhysInvtCountCode2;
        CycleSourceType := CountSourceType2;
    end;

    local procedure SkipCycleSKU(LocationCode: Code[10]; ItemNo: Code[20]; VariantCode: Code[10]): Boolean;
    var
        SKU: Record "Stockkeeping Unit";
    begin
        if CycleSourceType = CycleSourceType::Item then if SKU.ReadPermission then if SKU.Get(LocationCode, ItemNo, VariantCode) then exit(true);
        exit(false);
    end;

    local procedure GetLocation(LocationCode: Code[10]): Boolean;
    begin
        if LocationCode = '' then begin
            Clear(Location);
            exit(true);
        end;
        if Location.Code <> LocationCode then if not Location.Get(LocationCode) then exit(false);
        exit(true);
    end;

    local procedure UpdateBuffer(BinCode: Code[20]; NewQuantity: Decimal);
    var
        DimEntryNo: Integer;
    begin
        if not HasNewQuantity(NewQuantity) then exit;
        if BinCode = '' then begin
            if ColumnDim <> '' then TempDimBufIn.SetRange("Entry No.", "Item Ledger Entry"."Dimension Set ID");
            DimEntryNo := DimBufMgt.FindDimensions(TempDimBufIn);
            if DimEntryNo = 0 then DimEntryNo := DimBufMgt.InsertDimensions(TempDimBufIn);
        end;
        if RetrieveBuffer(BinCode, DimEntryNo) then begin
            QuantityOnHandBuffer.Quantity := QuantityOnHandBuffer.Quantity + NewQuantity;
            QuantityOnHandBuffer.Modify;
        end
        else begin
            QuantityOnHandBuffer.Quantity := NewQuantity;
            QuantityOnHandBuffer.Insert;
        end;
    end;

    local procedure RetrieveBuffer(BinCode: Code[20]; DimEntryNo: Integer): Boolean;
    begin
        QuantityOnHandBuffer.Reset;
        QuantityOnHandBuffer."Item No." := "Item Ledger Entry"."Item No.";
        QuantityOnHandBuffer."Variant Code" := "Item Ledger Entry"."Variant Code";
        QuantityOnHandBuffer."Location Code" := "Item Ledger Entry"."Location Code";
        QuantityOnHandBuffer."Dimension Entry No." := DimEntryNo;
        QuantityOnHandBuffer."Bin Code" := BinCode;
        OnRetrieveBufferOnBeforeFind(QuantityOnHandBuffer, "Item Ledger Entry");
        exit(QuantityOnHandBuffer.Find);
    end;

    local procedure HasNewQuantity(NewQuantity: Decimal): Boolean;
    begin
        exit((NewQuantity <> 0) or ZeroQty);
    end;

    local procedure ItemBinLocationIsCalculated(BinCode: Code[20]): Boolean;
    begin
        QuantityOnHandBuffer.Reset;
        QuantityOnHandBuffer.SetRange("Item No.", "Item Ledger Entry"."Item No.");
        QuantityOnHandBuffer.SetRange("Variant Code", "Item Ledger Entry"."Variant Code");
        QuantityOnHandBuffer.SetRange("Location Code", "Item Ledger Entry"."Location Code");
        QuantityOnHandBuffer.SetRange("Bin Code", BinCode);
        exit(QuantityOnHandBuffer.Find('-'));
    end;

    procedure SetSkipDim(NewSkipDim: Boolean);
    begin
        SkipDim := NewSkipDim;
    end;

    local procedure UpdateQuantityOnHandBuffer(ItemNo: Code[20]);
    var
        Location: Record Location;
        ItemVariant: Record "Item Variant";
    begin
        ItemVariant.SetRange("Item No.", Item."No.");
        Item.CopyFilter("Variant Filter", ItemVariant.Code);
        Item.CopyFilter("Location Filter", Location.Code);
        Location.SetRange("Use As In-Transit", false);
        if (Item.GetFilter("Location Filter") <> '') and Location.FindSet then
            repeat
                if (Item.GetFilter("Variant Filter") <> '') and ItemVariant.FindSet then
                    repeat
                        InsertQuantityOnHandBuffer(ItemNo, Location.Code, ItemVariant.Code);
                    until ItemVariant.Next = 0
                else
                    InsertQuantityOnHandBuffer(ItemNo, Location.Code, '');
            until Location.Next = 0
        else
            if (Item.GetFilter("Variant Filter") <> '') and ItemVariant.FindSet then
                repeat
                    InsertQuantityOnHandBuffer(ItemNo, '', ItemVariant.Code);
                until ItemVariant.Next = 0
            else
                InsertQuantityOnHandBuffer(ItemNo, '', '');
    end;

    local procedure CalcPhysInvQtyAndInsertItemJnlLine();
    begin
        QuantityOnHandBuffer.Reset;
        if QuantityOnHandBuffer.FindSet then begin
            repeat
                PosQty := 0;
                NegQty := 0;
                GetLocation(QuantityOnHandBuffer."Location Code");
                if Location."Directed Put-away and Pick" then CalcWhseQty(Location."Adjustment Bin Code", PosQty, NegQty);
                if (NegQty - QuantityOnHandBuffer.Quantity <> QuantityOnHandBuffer.Quantity - PosQty) or ItemTrackingSplit then begin
                    if PosQty = QuantityOnHandBuffer.Quantity then PosQty := 0;
                    if (PosQty <> 0) or AdjustPosQty then InsertItemJnlLine(QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.", QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, PosQty);
                    if NegQty = QuantityOnHandBuffer.Quantity then NegQty := 0;
                    if NegQty <> 0 then begin
                        if ((PosQty <> 0) or AdjustPosQty) and not ItemTrackingSplit then begin
                            NegQty := NegQty - QuantityOnHandBuffer.Quantity;
                            QuantityOnHandBuffer.Quantity := 0;
                            ZeroQty := true;
                        end;
                        if NegQty = -QuantityOnHandBuffer.Quantity then begin
                            NegQty := 0;
                            AdjustPosQty := true;
                        end;
                        InsertItemJnlLine(QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.", QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, NegQty);
                        ZeroQty := ZeroQtySave;
                    end;
                end
                else begin
                    PosQty := 0;
                    NegQty := 0;
                end;
                if (PosQty = 0) and (NegQty = 0) and not AdjustPosQty then InsertItemJnlLine(QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.", QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, QuantityOnHandBuffer.Quantity);
            until QuantityOnHandBuffer.Next = 0;
            QuantityOnHandBuffer.DeleteAll;
        end;
    end;

    local procedure CreateDimFromItemDefault() DimEntryNo: Integer;
    var
        DefaultDimension: Record "Default Dimension";
    begin
        DefaultDimension.SetRange("No.", QuantityOnHandBuffer."Item No.");
        DefaultDimension.SetRange("Table ID", DATABASE::Item);
        DefaultDimension.SetFilter("Dimension Value Code", '<>%1', '');
        if DefaultDimension.FindSet then
            repeat
                InsertDim(DATABASE::Item, 0, DefaultDimension."Dimension Code", DefaultDimension."Dimension Value Code");
            until DefaultDimension.Next = 0;
        DimEntryNo := DimBufMgt.InsertDimensions(TempDimBufIn);
        TempDimBufIn.SetRange("Table ID", DATABASE::Item);
        TempDimBufIn.DeleteAll;
    end;

    local procedure InsertDim(TableID: Integer; EntryNo: Integer; DimCode: Code[20]; DimValueCode: Code[20]);
    begin
        TempDimBufIn.Init;
        TempDimBufIn."Table ID" := TableID;
        TempDimBufIn."Entry No." := EntryNo;
        TempDimBufIn."Dimension Code" := DimCode;
        TempDimBufIn."Dimension Value Code" := DimValueCode;
        if TempDimBufIn.Insert then;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertItemJnlLine(var ItemJournalLine: Record "Item Journal Line");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterItemOnPreDataItem(var Item: Record Item; ZeroQty: Boolean; IncludeItemWithNoTransaction: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFunctionInsertItemJnlLine(ItemNo: Code[20]; VariantCode2: Code[10]; DimEntryNo2: Integer; BinCode2: Code[20]; Quantity2: Decimal; PhysInvQuantity: Decimal);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeQuantityOnHandBufferFindAndInsert(var InventoryBuffer: Record "Inventory Buffer");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFunctionInsertItemJnlLine(ItemNo: Code[20]; VariantCode2: Code[10]; DimEntryNo2: Integer; BinCode2: Code[20]; Quantity2: Decimal; PhysInvQuantity: Decimal; var ItemJournalLine: Record "Item Journal Line");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRetrieveBufferOnBeforeFind(var InventoryBuffer: Record "Inventory Buffer"; ItemLedgerEntry: Record "Item Ledger Entry");
    begin
    end;
}
