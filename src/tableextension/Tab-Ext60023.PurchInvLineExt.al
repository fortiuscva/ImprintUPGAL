tableextension 60023 "PurchInvLineExt" extends "Purch. Inv. Line"
{
    fields
    {
        field(50000; "Vendor Resource No."; Code[30])
        {
            Description = 'ISS2.00';
        }
        field(50050; "Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Description = 'IMP1.01';
            TableRelation = Customer;
        }
        field(50051; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            Description = 'IMP1.01';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(50052; "Customer Name"; Text[50])
        {
            Description = 'IMP1.02';
            Editable = false;
        }
        field(60031; "Work Type Code"; Code[10])
        {
            TableRelation = "Work Type";

            trigger OnValidate()
            begin
            //DirchPurch
            end;
        }
        field(60032; "Sales Order No."; Code[20])
        {
            Description = 'Passed in CU90';
        }
        field(60033; "Purchase Order No."; Code[20])
        {
            Description = 'Original PO No.';
        }
        field(60034; "Ship-to Option"; Option)
        {
            Description = 'Location Code,Ship-to Code,Job Site';
            InitValue = "Ship-to Code";
            OptionCaption = 'Location Code,Ship-to Code,Job Site';
            OptionMembers = "Location Code", "Ship-to Code", "Job Site";
        }
    }
    keys
    {
        key(key100_; "Sales Order No.")
        {
        }
        key(key101_; "Buy-from Vendor No.", Type, "No.", "Posting Date")
        {
        }
    }
}
