tableextension 60009 "PurchaseLineExt" extends "Purchase Line"
{
    fields
    {
        field(50000; "Vendor Resource No."; Code[30])
        {
            Description = 'ISS2.00';

            trigger OnValidate()
            begin
                // ISS2.00 11.07.13 DFP ================================================\
                IF "Vendor Resource No." <> '' THEN BEGIN
                    TESTFIELD(Type, Type::Resource);
                    GetPurchHeader;
                    Res.RESET;
                    Res.SETCURRENTKEY("Vendor No.", "Vendor Resource No.");
                    Res.SETRANGE("Vendor No.", PurchHeader."Buy-from Vendor No.");
                    Res.SETRANGE("Vendor Resource No.", Rec."Vendor Resource No.");
                    IF NOT Res.FINDFIRST THEN // %1 not found for %2 %3 and %4 %5.
                        ERROR(ISSText001, Res.TABLECAPTION, Res.FIELDCAPTION("Vendor No."), Rec."Buy-from Vendor No.", Res.FIELDCAPTION("Vendor Resource No."), Rec."Vendor Resource No.");
                    Rec.VALIDATE("No.", Res."No.");
                END;
                // End =================================================================/
            end;
        }
        field(50050; "Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Description = 'IMP1.02';
            TableRelation = Customer;

            trigger OnValidate()
            var
                CustRecGbl: Record Customer;
            begin
                //IMP1.03 Start
                IF "Customer No." <> xRec."Customer No." THEN BEGIN
                    IF "Customer No." <> '' THEN BEGIN
                        CustRecGbl.GET("Customer No.");
                        "Customer Name" := CustRecGbl.Name;
                    END
                    ELSE
                        "Customer Name" := '';
                END;
                //IMP1.03 End
            end;
        }
        field(50051; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            Description = 'IMP1.02';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(50052; "Customer Name"; Text[50])
        {
            Description = 'IMP1.03';
            Editable = false;
        }
        field(60031; "Work Type Code"; Code[10])
        {
            TableRelation = "Work Type";

            trigger OnValidate()
            begin
            end;
        }
        field(60034; "Ship-to Option"; Option)
        {
            Description = 'Location Code,Ship-to Code,Job Site';
            InitValue = "Ship-to Code";
            OptionCaption = 'Location Code,Ship-to Code,Job Site';
            OptionMembers = "Location Code","Ship-to Code","Job Site";
        }
    }
    var
        SalesLineGRec: Record 37;
        Text50000: Label 'Update interrupted to respect the warning.';
        Text50001: label 'This is a drop shipment line and quantity on sales order line will also be changed. Do you want to proceed?';
        Text50002: label 'you cannot change to the quantity which is less than the shipped quantity on sales line.';
        Res: Record Resource;
        ResPriceT: Record "Resource Price";
        SalesLine: Record "Sales Line";
        PurchHeader: Record "Purchase Header";
        ISSText001: label '%1 not found for %2 %3 and %4 %5.';
}
