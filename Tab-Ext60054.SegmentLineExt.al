tableextension 60054 "SegmentLineExt" extends "Segment Line"
{
    fields
    {
        field(50000; "Description 1"; Text[200])
        {
        }
        modify("Interaction Template Code")
        {
        trigger OnAfterValidate()
        begin
            "Initiated By":="Initiated By"::Us; //IMP1.01
        end;
        }
    }
}
