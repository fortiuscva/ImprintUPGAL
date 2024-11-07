tableextension 60039 "PurchaseLineArchiveExt" extends "Purchase Line Archive"
{
    fields
    {
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
    }
    keys
    {
        key(key001; Type, "No.")
        {
        }
    }
}
