tableextension 60014 "SalesShipmentHeaderExt" extends "Sales Shipment Header"
{
    DataCaptionFields = "No.", "Sell-to Customer Name";

    fields
    {
        field(50015; "Third Party Shipping Acc. No."; Code[20])
        {
            trigger OnValidate()
            begin
            //TestShippingAccountNo("Account No.");
            end;
        }
        field(50018; "Tax Exempt Categories"; Text[50])
        {
            Description = 'IMP1.03';
            Editable = false;
        }
        field(50019; "CertCapture Exemption No."; Text[30])
        {
            Description = 'IMP1.05';
            Editable = false;
        }
        field(50021; "E-Mail Address"; Text[80])
        {
            Caption = 'E-Mail';
            Description = 'IMP1.01';
            ExtendedDatatype = EMail;
        }
        field(50030; "Repair Order"; Boolean)
        {
            Description = 'IMP1.02';
            Editable = false;
        }
        field(50036; "Expiration Date"; Date)
        {
            Description = 'IMP1.06';
        }
        field(50090; "Tax Exemption No."; Text[30])
        {
            Description = 'IMP1.04';
        }
        field(50100; "Lead Source Code"; Code[10])
        {
            Description = 'ISS2.00';
            TableRelation = "Lead Source".Code;
        }
    }
    keys
    {
        key("Document Date"; "Document Date")
        {
        }
    }
    PROCEDURE GetUserSetup();
    BEGIN
        // ISS2.00 DFP =================================================\
        IF UserSetupFound THEN EXIT;
        IF NOT UserSetup.GET(USERID)THEN CLEAR(UserSetup);
        UserSetupFound:=TRUE;
    // End =========================================================/
    END;
    PROCEDURE CheckSupervisor()SupervisorOut: Boolean;
    BEGIN
        // ISS2.00 DFP =================================================\
        GetUserSetup;
        EXIT(UserSetup."Sales Supervisor");
    // End =========================================================/
    END;
    PROCEDURE FilterSalesperson();
    BEGIN
        // ISS2.00 DFP =================================================\
        // Filters recordset to the User's Salesperson Filter
        GetUserSetup;
        IF(UserSetup."Salesperson Filter" = '') OR (UserSetup."Sales Supervisor")THEN EXIT;
        FILTERGROUP(2);
        SETFILTER("Salesperson Code", UserSetup."Salesperson Filter");
        FILTERGROUP(0);
    // End =========================================================/
    END;
    var UserSetup: Record 91;
    UserSetupFound: Boolean;
}
