tableextension 60048 "ServiceInvoiceLineExt" extends "Service Invoice Line"
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
    }
}
