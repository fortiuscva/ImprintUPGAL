tableextension 60041 "ServiceItemLineExt" extends "Service Item Line"
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
        modify("Service Item No.")
        {
        trigger OnAfterValidate()
        var
            ServHeaderGRec: Record 5900;
        begin
            //IMP1.02 Start
            ServHeaderGRec.GET("Document Type", "Document No.");
            ServHeaderGRec.TESTFIELD("Ship-to Code");
            "Resource 1":=ServHeaderGRec."Resource 1"; //IMP1.01
            "Resource 2":=ServHeaderGRec."Resource 2"; //IMP1.01
        //IMP1.02 ENd
        end;
        }
    }
}
