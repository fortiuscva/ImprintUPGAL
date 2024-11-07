tableextension 60008 "PurchaseHeaderExt" extends "Purchase Header"
{
    DataCaptionFields = "No.", "Buy-from Vendor Name";

    fields
    {
        field(50014; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            Description = 'ISS2.00';
            TableRelation = "Shipping Agent";
        }
        field(50015; "Third Party Shipping Acc. No."; Code[20])
        {
            Description = 'ISS2.00';
        }
        field(50026; "Salesperson Code"; Code[10])
        {
            Description = 'IMP1.02';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50030; "PO Sample"; Boolean)
        {
            Description = 'IMP1.01';
            Editable = false;
        }
        field(50031; "Demo Order"; Boolean)
        {
            Description = 'IMP1.02';
            Editable = false;
        }
        field(50032; "Project Order"; Boolean)
        {
            Description = 'IMP1.03';
        }
        field(50035; "Customer PO No."; Code[35])
        {
            Caption = 'Customer PO No.';
        }
        field(60030; "Ship-to Option"; Option)
        {
            Description = 'Location Code,Ship-to Code,Job Site';
            Editable = false;
            OptionMembers = "Location Code","Ship-to Code","Job Site";
        }
    }
    var
        SalesFilterMgt: Codeunit 50004;
        PurchLine: Record 39;

    PROCEDURE DefaultSalesperson(ValidateField: Boolean);
    BEGIN
        // ISS2.00 DFP =================================================\
        SalesFilterMgt.PHDefaultSalesperson(Rec, ValidateField);
        // End =========================================================/
    END;

    PROCEDURE RepairSalesLink(QuietMode: Boolean);
    VAR
        SalesLine: Record 37;
        LocalText001: label 'Non-existing Sales Order Links have been removed.';
        LinkRemoved: Boolean;
        LocalText002: label 'Sales Order Links have been verified.\\No changes were made.';
    BEGIN
        // ISS2.00 DFP =================================================\
        CLEAR(LinkRemoved);
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", Rec."Document Type");
        PurchLine.SETRANGE("Document No.", Rec."No.");
        IF PurchLine.FINDSET(FALSE) THEN
            REPEAT
                IF (PurchLine."Sales Order Line No." <> 0) AND (PurchLine."Outstanding Quantity" <> 0) THEN BEGIN
                    // Verify the Purchase Docuemnt Line exists
                    IF NOT SalesLine.GET(SalesLine."Document Type"::Order, PurchLine."Sales Order No.", PurchLine."Sales Order Line No.") THEN BEGIN
                        // Remove Link; it's dead
                        PurchLine."Sales Order No." := '';
                        PurchLine."Sales Order Line No." := 0;
                        PurchLine.MODIFY;
                        LinkRemoved := TRUE;
                    END;
                END;
            UNTIL PurchLine.NEXT = 0;
        IF NOT QuietMode THEN BEGIN
            IF LinkRemoved THEN // Non-existing Sales Order Links have been removed.
                MESSAGE(LocalText001)
            ELSE
                // Sales Order Links have been verified.\\No changes were made.
                MESSAGE(LocalText002);
        END;
        // End =========================================================/
    END;
}
