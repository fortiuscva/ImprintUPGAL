tableextension 60029 "ShiptoAddressExt" extends "Ship-to Address"
{
    DataCaptionFields = "Customer No.", Name, "Code";

    fields
    {
        field(50000; "Tax Exemption No."; Text[30])
        {
            Caption = 'Tax Exemption No.';
        }
        field(50006; "Created Date"; Date)
        {
            Description = 'IMP1.01';
            Editable = false;
        }
        field(50007; "Created User ID"; Code[50])
        {
            Caption = 'Created User ID';
            Description = 'IMP1.01';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(50014; "Tax Exempt Muti-State"; Boolean)
        {
        }
        field(50015; "Tax Exempt Entry Date"; Date)
        {
            Caption = 'Current Tax Exempt Start Date';
        }
        field(50016; "Tax Exempt Expiration Date"; Date)
        {
            Caption = 'Current Tax Exempt Expiration Date';
        }
        field(50017; "Tax Liable Entry Date"; Date)
        {
            Caption = 'Tax Liable Start Date';
        }
        field(50018; "Tax Exempt Categories"; Text[50])
        {
        }
        field(50020; "Verbally Confirmed"; Text[50])
        {
        }
        field(50021; "No Response"; Boolean)
        {
        }
        field(50022; "Refuse to Provide Info"; Boolean)
        {
        }
        field(50023; "Self Assessed"; Boolean)
        {
        }
        field(50024; "Self Assessed - Notes"; Text[50])
        {
        }
        field(50025; "First Tax Exempt Date on File"; Date)
        {
        }
        field(50030; "CertCapture Exemption No."; Text[30])
        {
        }
    }
}
