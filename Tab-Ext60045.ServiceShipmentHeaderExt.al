tableextension 60045 "ServiceShipmentHeaderExt" extends "Service Shipment Header"
{
    DataCaptionFields = "No.", Name;

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
        field(50020; "Tax Exemption No."; Text[30])
        {
            Caption = 'Tax Exemption No.';
            Description = 'IMP1.02';
            Editable = false;
        }
        field(50021; "Tax Exempt Categories"; Text[50])
        {
            Description = 'IMP1.02';
            Editable = false;
        }
    }
}
