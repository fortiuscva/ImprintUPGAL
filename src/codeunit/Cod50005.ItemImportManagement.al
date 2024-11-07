codeunit 50005 "Item Import Management"
{
    // Outstanding Items are labeled "TODO"
    // 
    // TODO: If Serial Tracking doesn't match, create dlog entry?
    // IMP1.01,03/15/17,SK: Added code in "ImportItem".
    // IMP1.02,10/02/19,ST: Modifications handled to skip updating item description when update happening through xmlport 50011/"Item Import (BlueStar)".
    //                       - Added new function "SetRunForBlueStart".
    //                       - Added Global Variables.
    //                       - Added code in function "ImportItem".
    trigger OnRun()
    begin
    end;

    var
        ImportSource: Record "Item Import Source";
        ImportHeader: Record "Item Import Header";
        ImportLine: Record "Item Import Line";
        DefaultsSetup: Record "Defaults Setup";
        InvSetup: Record "Inventory Setup";
        PBMgt: Codeunit "Progress Bar Management";
        CUInitialized: Boolean;
        MUoM: Label 'M';
        ItemNotFoundCode: Label 'NOTFOUND';
        ErrorBlankCode: Label 'REQFIELD';
        ErrorBlankText: Label 'Field %1 cannot be blank.';
        ErrorConvCode: Label 'CONV';
        ErrorConvText: Label '%1 conversion not found for value %2.';
        ErrorNotFoundCode: Label 'NOXREF';
        ErrorNotFoundText: Label 'No Item Vendor record found for %1';
        Text001: Label 'Item Import Management Codunit has not been initialized.';
        Text002: Label '%1 not found for Source %2 %3 %4.';
        NextLineNo: Integer;
        ErrorCount: Integer;
        Text003: Label '%1 Import %2 completed with %3 errors.';
        Text004: Label 'Importing %1 File...';
        "-IMP1.02-": Integer;
        RunForBlueStartVarGbl: Boolean;

    procedure Initialize(ImportSourceCode: Code[10]; PricingDateIn: Date; VendorNoIn: Code[20]; DescLock: Boolean)
    var
        ImportSource2: Record "Item Import Source";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        CUInitialized := true;
        DefaultsSetup.Get;
        DefaultsSetup.TestField("SN Item Tracking Code");
        DefaultsSetup.TestField("Unit of Measure Code");
        InvSetup.Get;
        InvSetup.TestField("Item Import Nos.");
        InvSetup.TestField("Item Nos.");
        ImportSource.Get(ImportSourceCode);
        ImportSource.TestField(Priority);
        if (ImportSource."Vendor No." = '') and (VendorNoIn <> '') then begin
            // Standard Import; see if there is a Vendor Record to override
            with ImportSource2 do begin
                ImportSource2.Reset;
                ImportSource2.SetRange("Vendor No.", VendorNoIn);
                if ImportSource2.FindFirst then ImportSource.Priority := ImportSource2.Priority;
            end;
            ImportSource."Vendor No." := VendorNoIn;
        end;
        ImportSource.TestField("Vendor No.");
        // Create the Import Document
        ImportHeader.Init;
        NoSeriesMgt.InitSeries(InvSetup."Item Import Nos.", '', WorkDate, ImportHeader."No.", ImportHeader."No. Series");
        ImportHeader."Import Date" := Today;
        ImportHeader."Import Time" := Time;
        ImportHeader."Import User ID" := UserId;
        ImportHeader."Item Import Source Code" := ImportSourceCode;
        ImportHeader."Vendor No." := ImportSource."Vendor No.";
        ImportHeader."Pricing Update Date" := PricingDateIn;
        ImportHeader."Description Lock" := DescLock;
        ImportHeader."Log Type" := InvSetup."Item Import Log Type";
        ImportHeader.Insert(true);
        NextLineNo := 1;
        // Importing %1 File...
        PBMgt.OpenWindow(StrSubstNo(Text004, Format(ImportSource."Import Layout")));
    end;

    procedure FinishImport()
    begin
        PBMgt.CloseWindow;
        // %1 Import %2 completed with %3 errors.
        Message(Text003, Format(ImportSource."Import Layout"), ImportHeader."No.", ErrorCount);
    end;

    procedure CheckCUInitialized()
    begin
        if not CUInitialized then // Item Import Management Codunit has not been initialized.
            Error(Text001);
    end;

    procedure CreateMatchNo(ItemNo: Code[40]) ItemNoMatch: Code[40]
    begin
        // This function strips extraneous characters from the Item No to allow for
        //    better matching between Vendors
        ItemNoMatch := ItemNo;
        ItemNoMatch := DelChr(ItemNoMatch, '=', '!@#$%^&*()<>');
        ItemNoMatch := DelChr(ItemNoMatch, '=', ' -_+=:;,./?~`');
        ItemNoMatch := DelChr(ItemNoMatch, '=', '"');
        ItemNoMatch := DelChr(ItemNoMatch, '=', '''');
    end;

    procedure OverwritePriorSource(PriorSourceCode: Code[10]): Boolean
    var
        PriorImportSource: Record "Item Import Source";
    begin
        CheckCUInitialized;
        if PriorSourceCode = '' then // Overwrite
            exit(true);
        PriorImportSource.Get(PriorSourceCode);
        PriorImportSource.TestField(Priority);
        exit(ImportSource.Priority <= PriorImportSource.Priority);
    end;

    procedure ItemChanged(Item1: Record Item; Item2: Record Item): Boolean
    begin
        CheckCUInitialized;
        if Item1.Description <> Item2.Description then exit(true);
        if Item1."Description 2" <> Item2."Description 2" then exit(true);
        if Item1."Base Unit of Measure" <> Item2."Base Unit of Measure" then exit(true);
        if Item1."Item Category Code" <> Item2."Item Category Code" then exit(true);
        /* 
      if "Product Group Code" <> Item2."Product Group Code" then
        exit(true);
        */
        //UPG  removed in bc14
        if Item1."Vendor No." <> Item2."Vendor No." then exit(true);
        if Item1."Item Tracking Code" <> Item2."Item Tracking Code" then exit(true);
        if Item1."Inventory Posting Group" <> Item2."Inventory Posting Group" then exit(true);
        if Item1."Gen. Prod. Posting Group" <> Item2."Gen. Prod. Posting Group" then exit(true);
        // No changes detected
        exit(false);
    end;

    procedure UpdatePurchPrice(VendorNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UoM: Code[10]; PriceStartDate: Date; PriceEndDate: Date; DirectUnitCost: Decimal) PricingUpdated: Boolean
    var
        PurchPrice: Record "Purchase Price";
    begin
        CheckCUInitialized;
        if DirectUnitCost = 0 then // No Price specified
            exit(false);
        PurchPrice.Reset;
        PurchPrice.SetRange("Item No.", ItemNo);
        PurchPrice.SetRange("Vendor No.", VendorNo);
        PurchPrice.SetFilter("Ending Date", '%1|>=%2', 0D, PriceStartDate);
        PurchPrice.SetFilter("Variant Code", '%1|%2', VariantCode, '');
        //IF NOT ShowAll THEN BEGIN
        PurchPrice.SetRange("Starting Date", 0D, PriceStartDate);
        PurchPrice.SetFilter("Currency Code", '%1', '');
        PurchPrice.SetFilter("Unit of Measure Code", '%1|%2', UoM, '');
        //END;
        if PurchPrice.FindLast then begin
            if PurchPrice."Direct Unit Cost" = DirectUnitCost then // Pricing has not changed
                exit(false);
            if PurchPrice."Starting Date" > (PriceStartDate - 1) then // Item already has pricing for current Pricing Date; skip this
                                                                      // TODO
                exit(false);
            if (PurchPrice."Ending Date" = 0D) or (PurchPrice."Ending Date" >= PriceStartDate) then begin
                PurchPrice.Validate("Ending Date", PriceStartDate - 1);
                PurchPrice.Modify(true);
            end;
        end;
        PurchPrice.Init;
        PurchPrice.Validate("Item No.", ItemNo);
        PurchPrice.Validate("Variant Code", VariantCode);
        PurchPrice.Validate("Unit of Measure Code", UoM);
        PurchPrice.Validate("Vendor No.", VendorNo);
        PurchPrice.Validate("Currency Code", '');
        PurchPrice.Validate("Starting Date", PriceStartDate);
        PurchPrice."Ending Date" := 0D;
        if PriceEndDate <> 0D then PurchPrice.Validate("Ending Date", PriceEndDate);
        PurchPrice.Validate("Direct Unit Cost", DirectUnitCost);
        PurchPrice.Validate("Minimum Quantity", 0);
        PurchPrice.Insert(true);
        exit(true);
    end;

    procedure UpdateItemVendor(VendorNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; VendorItemNo: Code[20])
    var
        ItemVendor: Record "Item Vendor";
    begin
        if VendorItemNo = '' then exit;
        if not ItemVendor.Get(VendorNo, ItemNo, VariantCode) then begin
            ItemVendor.Init;
            ItemVendor.Validate("Vendor No.", VendorNo);
            ItemVendor.Validate("Item No.", ItemNo);
            ItemVendor.Validate("Variant Code", VariantCode);
            ItemVendor.Insert(true);
        end;
        if ItemVendor."Vendor Item No." <> VendorItemNo then begin
            ItemVendor.Validate("Vendor Item No.", VendorItemNo);
            ItemVendor.Modify(true);
        end;
    end;

    procedure BreakDescription(FullDescr: Text[1000]; var Descr1: Text[50]; var Descr2: Text[50])
    begin
        Clear(Descr1);
        Clear(Descr2);
        if StrLen(FullDescr) <= 50 then begin
            Descr1 := FullDescr;
            exit;
        end;
        Descr1 := CopyStr(FullDescr, 1, 50);
        FullDescr := CopyStr(FullDescr, 51);
        if StrLen(FullDescr) <= 50 then begin
            Descr2 := FullDescr;
            exit;
        end;
        Descr2 := CopyStr(FullDescr, 1, 50);
    end;

    procedure ItemPosted(ItemNo: Code[20]): Boolean
    var
        ItemLedger: Record "Item Ledger Entry";
    begin
        // Returns TRUE if postings have occurred
        ItemLedger.Reset;
        ItemLedger.SetCurrentKey("Item No.");
        ItemLedger.SetRange("Item No.", ItemNo);
        exit(not ItemLedger.IsEmpty);
    end;

    procedure CreateItemUoM(ItemNo: Code[20]; UoM: Code[10]; QtyPer: Decimal)
    var
        ItemUoM: Record "Item Unit of Measure";
    begin
        if ItemUoM.Get(ItemNo, UoM) then begin
            ItemUoM.TestField("Qty. per Unit of Measure", QtyPer);
            exit;
        end;
        ItemUoM.Init;
        ItemUoM.Validate("Item No.", ItemNo);
        ItemUoM.Validate(Code, UoM);
        ItemUoM.Validate("Qty. per Unit of Measure", QtyPer);
        //VALIDATE("Std. Pack UPC/EAN Number",'');
        ItemUoM.Insert(true);
        Commit;
    end;

    procedure ConvertUoM(UoMIn: Code[10]) UoMOut: Code[10]
    var
        ImportUoMConversion: Record "Item Import UoM Conversion";
    begin
        CheckCUInitialized;
        if not ImportUoMConversion.Get(ImportSource.Code, UoMIn) then // %1 not found for Source %2 %3 %4.
            Error(Text002, ImportUoMConversion.TableCaption, ImportSource.Code, 'Unit of Measure', UoMIn);
        ImportUoMConversion.TestField("NAV Unit of Measure Code");
        exit(ImportUoMConversion."NAV Unit of Measure Code");
    end;

    procedure ConvertCategory(var ImportCatConversion: Record "Item Import Cat. Conversion"; Category1In: Code[100]; Category2In: Code[100]; Category3In: Code[100]) ConvFound: Boolean
    var
        CatMatch: Boolean;
    begin
        CheckCUInitialized;
        CatMatch := false;
        // First attempt to match all 3 Categories
        ImportCatConversion.Reset;
        ImportCatConversion.SetRange("Item Import Source Code", ImportSource.Code);
        ImportCatConversion.SetFilter("Import Category 1", '%1', UpperCase(Category1In));
        ImportCatConversion.SetFilter("Import Category 2", '%1', UpperCase(Category2In));
        ImportCatConversion.SetFilter("Import Category 3", '%1', UpperCase(Category3In));
        if ImportCatConversion.FindFirst then CatMatch := true;
        if not CatMatch then begin
            // Next attempt to match on 2 Categories
            ImportCatConversion.SetFilter("Import Category 3", '%1', '');
            if ImportCatConversion.FindFirst then CatMatch := true;
        end;
        if not CatMatch then begin
            // Next attempt to match on only 1 Category
            ImportCatConversion.SetFilter("Import Category 2", '%1', '');
            if ImportCatConversion.FindFirst then CatMatch := true;
        end;
        if CatMatch then begin
            ImportCatConversion.TestField("Item Category Code");
            exit(true);
        end
        else
            exit(false);
    end;

    procedure ImportItem(ImportBuffer: Record "Item Import Buffer")
    var
        Item: Record Item;
        ItemTemp: Record Item temporary;
        ImportCatConv: Record "Item Import Cat. Conversion";
        ImportNoOverride: Record "Item Import No. Override";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NAVItemNo: Code[20];
        PricingOnly: Boolean;
        Descr1: Text[50];
        Descr2: Text[50];
        UoM: Code[10];
        UoM2: Code[10];
        UoM3: Code[10];
        ItemTrackingCode: Code[10];
    begin
        CheckCUInitialized;
        // Changes to Import fields
        // If Pricing Import and Item is Blank set to NOTFOUND
        if ImportBuffer."Pricing Item Not Found" then ImportBuffer."Mfg. Item No." := ItemNotFoundCode;
        // Check for Item No Override
        ImportNoOverride.Reset;
        ImportNoOverride.SetCurrentKey("Item No. (Match)", "Vendor No.");
        ImportNoOverride.SetRange("Item No. (Match)", CreateMatchNo(ImportBuffer."Mfg. Item No."));
        ImportNoOverride.SetRange("Vendor No.", ImportHeader."Vendor No.");
        if ImportNoOverride.FindFirst then begin
            ImportNoOverride.TestField("Override Item No.");
            ImportBuffer."Mfg. Item No." := ImportNoOverride."Override Item No.";
        end;
        // If one Item No is blank default it to the other
        if (ImportBuffer."Mfg. Item No." = '') and (ImportBuffer."Vendor Item No." <> '') then ImportBuffer."Mfg. Item No." := ImportBuffer."Vendor Item No.";
        if (ImportBuffer."Vendor Item No." = '') and (ImportBuffer."Mfg. Item No." <> '') then ImportBuffer."Vendor Item No." := ImportBuffer."Mfg. Item No.";
        // TODO
        ImportBuffer."Mfg. Item No." := CopyStr(ImportBuffer."Mfg. Item No.", 1, 40);
        ImportBuffer."Vendor Item No." := CopyStr(ImportBuffer."Vendor Item No.", 1, 20);
        // Set NAV Item No
        if StrLen(ImportBuffer."Mfg. Item No.") <= 20 then
            NAVItemNo := ImportBuffer."Mfg. Item No."
        else begin
            // Pull NAV Item No from Series
            NAVItemNo := '';
        end;
        // Create Import Line
        ImportLine.Init;
        ImportLine."Document No." := ImportHeader."No.";
        ImportLine."Line No." := NextLineNo;
        NextLineNo += 1;
        // Check for Required Fields 1
        // Without Item No no point in going further
        if BlankField(ImportBuffer."Mfg. Item No.", ImportBuffer.FieldCaption("Mfg. Item No.")) then exit;
        // Init Variables
        PricingOnly := false;
        Clear(UoM);
        Item.Reset;
        Item.SetCurrentKey("Mfg. Item No. (Match)");
        //SETRANGE("Mfg. Item No. (Match)",CreateMatchNo(ImportBuffer."Mfg. Item No.")); //IMP1.01
        Item.SetRange("No.", ImportBuffer."Mfg. Item No."); //IMP1.01
        if Item.FindFirst then begin
            // Item exists; overwrite it?
            if (not OverwritePriorSource(Item."Item Import Code")) or (ImportBuffer."File Type" = ImportBuffer."File Type"::Price) then PricingOnly := true;
        end
        else begin
            if ImportBuffer."File Type" = ImportBuffer."File Type"::Price then begin
                ImportBuffer.Validate("Pricing Item Not Found", true);
                Item."No." := '';
            end
            else begin
                // New Item; create it
                Item.Init;
                Item."No." := NAVItemNo;
                Item."Mfg. Item No." := ImportBuffer."Mfg. Item No.";
                // NOTE: "Mfg. Item No. (Match)" gets filled OnInsert
                Item.Insert(true);
                ImportLine."Item Created" := true;
            end;
        end;
        ImportLine."NAV Item No." := Item."No.";
        ImportLine."Mfg. Item No." := Item."Mfg. Item No.";
        ImportLine."Vendor Item No." := ImportBuffer."Vendor Item No.";
        // Check for Required Fields 2
        if ImportBuffer."Pricing Item Not Found" then begin
            // No Item Vendor record found for %1
            SetError(ErrorNotFoundCode, StrSubstNo(ErrorNotFoundText, ImportBuffer."Vendor Item No."));
            exit;
        end;
        //IF BlankField("Unit of Measure Code",FIELDCAPTION("Unit of Measure Code")) THEN
        //  EXIT;
        if ImportBuffer."File Type" <> ImportBuffer."File Type"::Price then if BlankField(ImportBuffer.Description, ImportBuffer.FieldCaption(Description)) then exit;
        if ImportBuffer."File Type" = ImportBuffer."File Type"::Price then if BlankFieldDec(ImportBuffer."Unit Price", ImportBuffer.FieldCaption("Unit Price")) then exit;
        // Save original Item for later comparison
        ItemTemp := Item;
        if not PricingOnly then begin
            // This Import does NOT have priority
            // Break up and crop fields
            BreakDescription(ImportBuffer.Description, Descr1, Descr2);
            // Unit of Measure
            if Item."Base Unit of Measure" = '' then begin
                if ImportBuffer."Unit of Measure Code" <> '' then
                    UoM := ConvertUoM(ImportBuffer."Unit of Measure Code")
                else
                    UoM := DefaultsSetup."Unit of Measure Code";
                CreateItemUoM(Item."No.", UoM, 1);
                Item.Validate("Base Unit of Measure", UoM);
            end
            else
                // If already defined, use the existing Base
                UoM := Item."Base Unit of Measure";
            //IMP1.02 Start
            //Code Commented
            /*
            // Load fields
            IF Description <> Descr1 THEN
              VALIDATE(Description,Descr1);
            IF "Description 2" <> Descr2 THEN
              VALIDATE("Description 2",Descr2);
            */
            // Load fields
            if not RunForBlueStartVarGbl then begin
                if Item.Description <> Descr1 then Item.Validate(Description, Descr1);
                if Item."Description 2" <> Descr2 then Item.Validate("Description 2", Descr2);
            end
            else begin
                if not Item."Skip Bluestar Description" then begin
                    if Item.Description <> Descr1 then Item.Validate(Description, Descr1);
                    if Item."Description 2" <> Descr2 then Item.Validate("Description 2", Descr2);
                end;
            end;
            //IMP1.02 End
            //CreateItemUoM(Item."No.",UoM,1);
            //IF "Base Unit of Measure" = '' THEN
            //  VALIDATE("Base Unit of Measure",UoM)
            //ELSE
            //  TESTFIELD("Base Unit of Measure",UoM);
            if ImportSource."Pass Category" then begin
                Item.Validate("Item Category Code", ImportBuffer."Item Category Code");
                //Validate("Product Group Code", ImportBuffer."Product Group Code");//UPG  removed in bc14
            end
            else begin
                if ConvertCategory(ImportCatConv, ImportBuffer."Category 1", ImportBuffer."Category 2", ImportBuffer."Category 3") then begin
                    if Item."Item Category Code" <> ImportCatConv."Item Category Code" then Item.Validate("Item Category Code", ImportCatConv."Item Category Code");
                    /*

                        if "Product Group Code" <> ImportCatConv."Product Group Code" then
                            Validate("Product Group Code", ImportCatConv."Product Group Code");
                            */
                    //UPG  removed in bc14
                end;
            end;
            Item.Validate("Vendor No.", ImportSource."Vendor No.");
            // Handle Item Tracking
            Clear(ItemTrackingCode);
            if ImportBuffer."Serial Tracking" then ItemTrackingCode := DefaultsSetup."SN Item Tracking Code";
            if Item."Item Tracking Code" <> ItemTrackingCode then begin
                if not ItemPosted(Item."No.") then
                    Item.Validate("Item Tracking Code", Item."Item Tracking Code")
                else
                    // TODO
                    ;
            end;
            if ItemChanged(ItemTemp, Item) then begin
                // Item was changed
                if not ImportLine."Item Created" then ImportLine."Item Updated" := true;
                Item."Item Import Code" := ImportHeader."Item Import Source Code";
                Item."Item Import Date" := ImportHeader."Import Date";
                Item."Item Import Time" := ImportHeader."Import Time";
                Item.Modify(true);
            end;
        end
        else begin
            // This import does NOT have priority; check overrides
            if ImportHeader."Description Lock" then begin
                // This import overrides and locks  Description if set
                // Break up and crop fields
                BreakDescription(ImportBuffer.Description, Descr1, Descr2);
                /* DFP TEMP
                    IF Description <> Descr1 THEN
                      VALIDATE(Description,Descr1);
                    IF "Description 2" <> Descr2 THEN
                      VALIDATE("Description 2",Descr2);
                    "lock description" := true;

                    IF ItemChanged(ItemTemp,Item) THEN BEGIN
                      // Item was changed
                      IF NOT ImportLine."Item Created" THEN
                        ImportLine."Item Updated" := TRUE;

                      MODIFY(TRUE);
                    END;
                    */
            end;
        end;
        // Item Vendor
        UpdateItemVendor(ImportSource."Vendor No.", Item."No.", '', ImportBuffer."Vendor Item No.");
        // Import new pricing
        if UpdatePurchPrice(ImportSource."Vendor No.", Item."No.", '', Item."Base Unit of Measure", ImportHeader."Pricing Update Date", ImportBuffer."Pricing End Date", ImportBuffer."Unit Price") then // Pricing was updated
            ImportLine."Pricing Updated" := true;
        // Price per M
        if ImportBuffer."Price per M" <> 0 then begin
            CreateItemUoM(Item."No.", MUoM, 1000);
            if UpdatePurchPrice(ImportSource."Vendor No.", Item."No.", '', MUoM, ImportHeader."Pricing Update Date", ImportBuffer."Pricing End Date", ImportBuffer."Price per M") then // Pricing was updated
                ImportLine."Pricing Updated" := true;
        end;
        // UoM2
        if ImportBuffer."UoM2 Code" <> '' then begin
            UoM2 := ConvertUoM(ImportBuffer."UoM2 Code");
            CreateItemUoM(Item."No.", UoM2, ImportBuffer."UoM2 Qty. per UoM");
            if UpdatePurchPrice(ImportSource."Vendor No.", Item."No.", '', UoM2, ImportHeader."Pricing Update Date", ImportBuffer."Pricing End Date", ImportBuffer."UoM2 Price") then // Pricing was updated
                ImportLine."Pricing Updated" := true;
        end;
        // UoM3
        if ImportBuffer."UoM3 Code" <> '' then begin
            UoM3 := ConvertUoM(ImportBuffer."UoM3 Code");
            CreateItemUoM(Item."No.", UoM3, ImportBuffer."UoM3 Qty. per UoM");
            if UpdatePurchPrice(ImportSource."Vendor No.", Item."No.", '', UoM3, ImportHeader."Pricing Update Date", ImportBuffer."Pricing End Date", ImportBuffer."UoM3 Price") then // Pricing was updated
                ImportLine."Pricing Updated" := true;
        end;
        // Determine if Import Line should be written
        // Set the Line Type
        if ImportLine."Error Code" <> '' then
            ImportLine."Line Type" := ImportLine."Line Type"::Error
        else
            if (ImportLine."Pricing Updated" or ImportLine."Item Created" or ImportLine."Item Updated") then
                ImportLine."Line Type" := ImportLine."Line Type"::Update
            else
                ImportLine."Line Type" := ImportLine."Line Type"::"No Change";
        case ImportHeader."Log Type" of
            ImportHeader."Log Type"::Full:
                ImportLine.Insert;
            ImportHeader."Log Type"::"Errors & Updates":
                if ImportLine."Line Type" > ImportLine."Line Type"::"No Change" then
                    ImportLine.Insert;
            ImportHeader."Log Type"::"Errors Only":
                if ImportLine."Line Type" = ImportLine."Line Type"::Error then
                    ImportLine.Insert;
        end;
    end;

    procedure BlankField(ValueIn: Text[1000]; FieldNameIn: Text[50]): Boolean
    begin
        if ValueIn = '' then begin
            // Field %1 cannot be blank.
            SetError(ErrorBlankCode, StrSubstNo(ErrorBlankText, FieldNameIn));
            exit(true);
        end;
        exit(false);
    end;

    procedure BlankFieldDec(ValueIn: Decimal; FieldNameIn: Text[50]): Boolean
    begin
        if ValueIn = 0 then begin
            // Field %1 cannot be blank.
            SetError(ErrorBlankCode, StrSubstNo(ErrorBlankText, FieldNameIn));
            exit(true);
        end;
        exit(false);
    end;

    procedure SetError(ErrorCodeIn: Code[10]; ErrorTextIn: Text[1000])
    begin
        ImportLine."Error Code" := ErrorCodeIn;
        ImportLine."Error Message" := ErrorTextIn;
        ImportLine."Line Type" := ImportLine."Line Type"::Error;
        ImportLine.Insert;
        ErrorCount += 1;
    end;

    procedure "---IMP1.02---"()
    begin
    end;

    procedure SetRunForBlueStart(RunForBlueStartPar: Boolean)
    begin
        RunForBlueStartVarGbl := RunForBlueStartPar;
    end;
}
