tableextension 60047 "ServiceInvoiceHeaderExt" extends "Service Invoice Header"
{
    //Unsupported feature: Property Modification (Permissions) on ""Service Invoice Header"(Table 5992)".
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
        field(50003; "Customer PO No."; Code[35])
        {
            Description = 'IMP1.02';
            Editable = false;
        }
        field(50004; "Customer Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            Editable = false;
            TableRelation = "Payment Terms";
        }
        field(50005; "Amount Including VAT1"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Service Invoice Line"."Amount Including VAT" WHERE("Document No."=FIELD("No.")));
            Caption = 'Amount Including Tax';
            Description = 'IMP1.03';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; Amount1; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Service Invoice Line".Amount WHERE("Document No."=FIELD("No.")));
            Caption = 'Amount';
            Description = 'IMP1.05';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Service Date"; Date)
        {
            Description = 'IMP1.07';
            Editable = false;
        }
        field(50020; "Tax Exemption No."; Text[30])
        {
            Caption = 'Tax Exemption No.';
            Description = 'IMP1.04';
            Editable = false;
        }
        field(50021; "Tax Exempt Categories"; Text[50])
        {
            Description = 'IMP1.04';
            Editable = false;
        }
        field(50022; "CertCapture Exemption No."; Text[30])
        {
            Description = 'IMP1.06';
            Editable = false;
        }
        field(50026; "Expiration Date"; Date)
        {
            Description = 'IMP1.08';
        }
    }
}
