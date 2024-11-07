tableextension 60006 "ItemExt" extends Item
{
    fields
    {
        field(50000; "Source Type"; Option)
        {
            Description = 'ISS2.00';
            OptionMembers = " ",Dropship,"Special Stock",Stock;
        }
        field(50005; "Category Updated"; Boolean)
        {
            Description = 'ISS for Update Process';
        }
        field(50010; "NEW Item Category Code"; Code[10])
        {
            Description = 'ISS TEMP';
            TableRelation = "TEMP NEW Item Categories";
        }
        field(50016; "Created Date"; Date)
        {
            Description = 'IMP1.02';
            Editable = false;
        }
        field(50020; "Item Import Code"; Code[10])
        {
            Description = 'ISS2.00';
            TableRelation = "Item Import Source";
        }
        field(50021; "Item Import Date"; Date)
        {
            Description = 'ISS2.00';
        }
        field(50022; "Item Import Time"; Time)
        {
            Description = 'ISS2.00';
        }
        field(50024; "Mfg. Item No."; Code[40])
        {
            Description = 'ISS2.00';

            trigger OnValidate()
            begin
                // ISS2.00 11.01.13 DFP ======================================================\
                IF ("Item Import Code" <> '') AND ("Mfg. Item No." <> xRec."Mfg. Item No.") THEN // %1 can not be changed.
                    ERROR(ISSText001, FIELDCAPTION("Mfg. Item No."));
                "Mfg. Item No. (Match)" := ItemImportMgt.CreateMatchNo("Mfg. Item No.");
                // End =======================================================================/
            end;
        }
        field(50025; "Mfg. Item No. (Match)"; Code[40])
        {
            Description = 'ISS2.00';
            Editable = false;
        }
        field(50026; "Inventory at Date"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"), "Lot No." = FIELD("Lot No. Filter"), "Serial No." = FIELD("Serial No. Filter"), "Posting Date" = FIELD("Date Filter")));
            Description = 'Same as Inventory Field with Date Filter Added';
            FieldClass = FlowField;
        }
        field(50050; "Customer No."; Code[20])
        {
            Description = 'IMP1.01';
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                //IMP1.01 Start
                //TESTFIELD("Source Type","Source Type"::Stock);
                IF "Customer No." <> xRec."Customer No." THEN BEGIN
                    IF "Customer No." <> '' THEN BEGIN
                        IF CustRecGbl.GET("Customer No.") THEN BEGIN
                            "Customer Name" := CustRecGbl.Name;
                            IF CustRecGbl."Salesperson Code" <> '' THEN
                                VALIDATE("Salesperson Code", CustRecGbl."Salesperson Code")
                            ELSE
                                VALIDATE("Salesperson Code", '');
                        END
                        ELSE
                            "Customer Name" := '';
                    END
                    ELSE BEGIN
                        "Customer Name" := '';
                        VALIDATE("Salesperson Code", '');
                    END;
                END;
                //IMP1.01 End
            end;
        }
        field(50051; "Customer Name"; Text[50])
        {
            Description = 'IMP1.01';
            Editable = false;
        }
        field(50052; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            Description = 'IMP1.01';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                //IMP1.01 Start
                //TESTFIELD("Source Type","Source Type"::Stock);
                IF "Salesperson Code" <> xRec."Salesperson Code" THEN BEGIN
                    IF "Salesperson Code" <> '' THEN BEGIN
                        IF SalespersonRecGbl.GET("Salesperson Code") THEN BEGIN
                            "Salesperson Name" := SalespersonRecGbl.Name;
                        END
                        ELSE
                            "Salesperson Name" := '';
                    END
                    ELSE
                        "Salesperson Name" := '';
                END;
                //IMP1.01 End
            end;
        }
        field(50053; "Salesperson Name"; Text[50])
        {
            Description = 'IMP1.01';
            Editable = false;
        }
        field(50054; "Qty. on Sales Return Order"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST("Return Order"), Type = CONST(Item), "No." = FIELD("No."), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"), "Shipment Date" = FIELD("Date Filter")));
            Description = 'IMP1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50055; "Qty. on Purch. Return Order"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST("Return Order"), Type = CONST(Item), "No." = FIELD("No."), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"), "Expected Receipt Date" = FIELD("Date Filter")));
            Description = 'IMP1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50060; "Skip Bluestar Description"; Boolean)
        {
            Description = 'IMP1.03';
        }
        field(50061; "Qty. On Sales Quotes"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST(Quote), Type = CONST(Item), "No." = FIELD("No."), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"), "Shipment Date" = FIELD("Date Filter")));
            Description = 'IMP1.04';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50210; "Lock Description"; Boolean)
        {
            Description = 'ISS2.00';
        }
        field(50230; "Lock Item Category"; Boolean)
        {
            Description = 'ISS2.00';
        }
        modify(Description)
        {
            trigger OnAfterValidate()
            begin
                // ISS2.00 DFP 07.26.13 =======================================================\
                IF CurrFieldNo <> 0 THEN IF Description <> xRec.Description THEN "Lock Description" := TRUE;
                // End ========================================================================/
            end;
        }
    }
    keys
    {
        key("Mfg. Item No. (Match)"; "Mfg. Item No. (Match)")
        {
        }
        key("Mfg. Item No.  "; "Mfg. Item No.")
        {
        }
    }
    var
        ItemImportMgt: Codeunit 50005;
        ISSText001: label '%1 can not be changed.';
        CustRecGbl: Record 18;
        SalespersonRecGbl: Record 13;

    trigger OnInsert()
    begin
        // ISS2.00 11.01.13 DFP ======================================================\
        "Mfg. Item No. (Match)" := ItemImportMgt.CreateMatchNo("Mfg. Item No.");
        SetDefaults;
        // End =======================================================================/
        "Created Date" := WORKDATE; //IMP1.02
    end;

    PROCEDURE SetDefaults();
    VAR
        DefaultsSetup: Record 50016;
    BEGIN
        // ISS2.00 11.01.13 DFP ======================================================\
        IF NOT DefaultsSetup.GET THEN EXIT;
        VALIDATE("Inventory Posting Group", DefaultsSetup."Inventory Posting Group");
        VALIDATE("Gen. Prod. Posting Group", DefaultsSetup."Gen. Prod. Posting Group");
        VALIDATE("VAT Bus. Posting Gr. (Price)", DefaultsSetup."VAT Bus. Posting Gr. (Price)");
        VALIDATE("Tax Group Code", DefaultsSetup."Item Tax Group Code");
        // End =======================================================================/
    END;
}
