tableextension 60042 "ServiceLineExt" extends "Service Line"
{
    fields
    {
        field(50001; "Resource 1"; Code[20])
        {
            Caption = 'Resource 1';
            Description = 'IMP1.01';
            TableRelation = Resource;
        }
        field(50002; "Resource 2"; Code[20])
        {
            Caption = 'Resource 2';
            Description = 'IMP1.01';
            TableRelation = Resource;
        }
        modify("No.")
        {
        trigger OnAfterValidate()
        var
            ServHeader: Record "Service Header";
        begin
            ServHeader.get("Document Type", "Document No.");
            "Resource 1":=ServHeader."Resource 1"; //IMP1.01
            "Resource 2":=ServHeader."Resource 2"; //IMP1.01
        end;
        }
    }
}
