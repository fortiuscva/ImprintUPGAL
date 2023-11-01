tableextension 60002 "CustomerExt" extends Customer
{
    DataCaptionFields = "No.", Name;

    fields
    {
        field(50000; "AP Contact"; Text[50])
        {
            Description = 'ISS2.00';
        }
        field(50001; "AP Phone No."; Text[20])
        {
            Description = 'ISS2.00';
        }
        field(50005; "Date Created"; Text[12])
        {
            Description = 'ISS2.00';
        }
        field(50006; "Created Date"; Date)
        {
            Description = 'IMP1.02';
            Editable = false;
        }
        field(50007; "Created User ID"; Code[50])
        {
            Caption = 'Created User ID';
            Description = 'IMP1.03';
            TableRelation = "User Setup";
        }
        field(50010; "Stat. Profit (Expected)"; Decimal)
        {
            CalcFormula = Sum("Sales Statistic Entry"."Profit Amount" WHERE(Expected=CONST(true), "Sell-to Customer No."=FIELD("No."), "Posting Date"=FIELD("Date Filter")));
            Description = 'ISS2.00';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Stat. Profit (Posted)"; Decimal)
        {
            CalcFormula = Sum("Sales Statistic Entry"."Profit Amount" WHERE(Expected=CONST(false), "Sell-to Customer No."=FIELD("No."), "Posting Date"=FIELD("Date Filter")));
            Description = 'ISS2.00';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Stat. Sales (Expected)"; Decimal)
        {
            CalcFormula = Sum("Sales Statistic Entry"."Sales Amount" WHERE(Expected=CONST(true), "Sell-to Customer No."=FIELD("No."), "Posting Date"=FIELD("Date Filter")));
            Description = 'ISS2.00';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; "Stat. Sales (Posted)"; Decimal)
        {
            CalcFormula = Sum("Sales Statistic Entry"."Sales Amount" WHERE(Expected=CONST(false), "Sell-to Customer No."=FIELD("No."), "Posting Date"=FIELD("Date Filter")));
            Description = 'ISS2.00';
            Editable = false;
            FieldClass = FlowField;
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
        field(50017; "Last Credit Check Date"; Date)
        {
        }
        field(50018; "Tax Liable Entry Date"; Date)
        {
            Caption = 'Tax Liable Start Date';
        }
        field(50019; "Tax Exempt Categories"; Text[50])
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
        field(50026; "Blocked Reason Code"; Option)
        {
            OptionMembers = " ", Bankrupt, Collections, Inactive, "See Other Account", "Out of Business";
        }
        field(50030; "CertCapture Exemption No."; Text[30])
        {
        }
        field(50100; "Lead Source Code"; Code[10])
        {
            Description = 'ISS2.00';
            TableRelation = "Lead Source".Code;
        }
        field(50600; "Order Confirmation Email"; Text[80])
        {
            Description = 'IMP1.01';
        }
    }
    trigger OnInsert()
    var
    begin
        SetDefaults;
        "Created Date":=WORKDATE; //IMP1.02
        "Created User ID":=USERID; //IMP1.03
    end;
    var UserSetup: Record "User Setup";
    UserSetupFound: Boolean;
    PROCEDURE GetUserSetup()
    var
        myInt: Integer;
    begin
        // ISS2.00 DFP =================================================\
        IF UserSetupFound THEN EXIT;
        IF NOT UserSetup.GET(USERID)THEN CLEAR(UserSetup);
        UserSetupFound:=TRUE;
    // End =========================================================/
    end;
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
    PROCEDURE DefaultSalesperson(ValidateField: Boolean);
    BEGIN
        // ISS2.00 DFP =================================================\
        GetUserSetup;
        IF ValidateField THEN VALIDATE("Salesperson Code", UserSetup."Salespers./Purch. Code")
        ELSE
            "Salesperson Code":=UserSetup."Salespers./Purch. Code";
    // End =========================================================/
    END;
    PROCEDURE SetDefaults();
    VAR
        DefaultsSetup: Record 50016;
    BEGIN
        // ISS2.00 11.01.13 DFP ======================================================\
        IF NOT DefaultsSetup.GET THEN EXIT;
        VALIDATE("Customer Posting Group", DefaultsSetup."Customer Posting Group");
        VALIDATE("Gen. Bus. Posting Group", DefaultsSetup."C. Gen. Bus. Posting Group");
        VALIDATE("VAT Bus. Posting Group", DefaultsSetup."C. VAT Bus. Posting Group");
    // End =======================================================================/
    END;
}
