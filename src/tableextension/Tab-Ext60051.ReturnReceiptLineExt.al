tableextension 60051 "ReturnReceiptLineExt" extends "Return Receipt Line"
{
    fields
    {
        field(50000; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(50001; "Sell-to Customer Name"; Text[50])
        {
            Description = 'IMP1.01';
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
