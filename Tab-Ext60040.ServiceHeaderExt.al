tableextension 60040 "ServiceHeaderExt" extends "Service Header"
{
    //Unsupported feature: Property Modification (Permissions) on ""Service Header"(Table 5900)".
    DataCaptionFields = "No.", Name, Description;

    fields
    {
        field(50001; "Resource 1"; Code[20])
        {
            Caption = 'Resource 1';
            Description = 'IMP1.01';
            TableRelation = Resource;

            trigger OnValidate()
            begin
                //IMP1.01 Start
                IF "Resource 1" <> xRec."Resource 1" THEN BEGIN
                    RecreateServLines(FIELDCAPTION("Resource 1"));
                    CheckandUpdateServItemLines;
                END;
            //IMP1.01 End
            end;
        }
        field(50002; "Resource 2"; Code[20])
        {
            Caption = 'Resource 2';
            Description = 'IMP1.01';
            TableRelation = Resource;

            trigger OnValidate()
            begin
                //IMP1.01 Start
                IF "Resource 2" <> xRec."Resource 2" THEN BEGIN
                    RecreateServLines(FIELDCAPTION("Resource 2"));
                    CheckandUpdateServItemLines;
                END;
            //IMP1.01 Endd
            end;
        }
        field(50003; "Customer PO No."; Code[35])
        {
            Description = 'IMP1.02';
        }
        field(50004; "Customer Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            Editable = false;
            TableRelation = "Payment Terms";
        }
        field(50021; "Tax Exempt Categories"; Text[50])
        {
            Description = 'IMP1.03';
        }
        field(50022; "CertCapture Exemption No."; Text[30])
        {
            Description = 'IMP1.04';
            Editable = false;
        }
        field(50026; "Expiration Date"; Date)
        {
            Description = 'IMP1.05';
        }
        modify("Ship-to Code")
        {
        trigger OnAfterValidate()
        var
            ShiptoAddr: Record 222;
            cust: Record Customer;
        begin
            if "Ship-to Code" <> '' then begin //B2BUPG1.0
                ShiptoAddr.GET("Customer No.", "Ship-to Code");
                cust.Get("Customer No.");
                //IMP1.03 Start
                "Tax Exemption No.":=ShiptoAddr."Tax Exemption No.";
                "Tax Exempt Categories":=ShiptoAddr."Tax Exempt Categories";
                //IMP1.03 End
                "Expiration Date":=ShiptoAddr."Tax Exempt Expiration Date"; //IMP1.05
                //IMP1.04 STart
                IF ShiptoAddr."CertCapture Exemption No." <> '' THEN "CertCapture Exemption No.":=ShiptoAddr."CertCapture Exemption No."
                ELSE
                    "CertCapture Exemption No.":=Cust."CertCapture Exemption No.";
            //IMP1.04 End
            end; //B2BUPG1.0
        end;
        }
    }
    PROCEDURE CheckandUpdateServItemLines();
    var
        ServItemLine: Record "Service Item Line";
    BEGIN
        ServItemLine.RESET;
        ServItemLine.SETRANGE("Document Type", "Document Type");
        ServItemLine.SETRANGE("Document No.", "No.");
        IF ServItemLine.FINDSET THEN BEGIN
            REPEAT ServItemLine."Resource 1":="Resource 1";
                ServItemLine."Resource 2":="Resource 2";
                ServItemLine.MODIFY;
            UNTIL ServItemLine.NEXT = 0;
        END;
    END;
}
