table 50011 "Shipping Account"
{
    Caption = 'Shipping Account';

    fields
    {
        field(1; "Ship-to No."; Code[20])
        {
            Caption = 'Ship-to No.';
            NotBlank = true;
            TableRelation = IF ("Ship-to Type" = CONST(Customer)) Customer
            ELSE
            IF ("Ship-to Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Ship-to Type" = CONST(Location)) Location;
        }
        field(2; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            NotBlank = true;
            TableRelation = "Shipping Agent";
        }
        field(3; "Ship-to Code"; Code[20])
        {
            Caption = 'Ship-to Code';
            TableRelation = IF ("Ship-to Type" = CONST(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Ship-to No."))
            ELSE
            IF ("Ship-to Type" = CONST(Vendor)) "Order Address".Code WHERE("Vendor No." = FIELD("Ship-to No."));
        }
        field(4; "Ship-to Type"; Option)
        {
            Caption = 'Ship-to Type';
            OptionCaption = 'Customer,Vendor,Bank,Contact,Resource,Employee,,Location';
            OptionMembers = Customer,Vendor,Bank,Contact,Resource,Employee,,Location;
        }
        field(11; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            NotBlank = true;

            trigger OnValidate()
            begin
                //TestShippingAccountNo("Account No.");
            end;
        }
        field(12; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(13; "Use Only for Ship-to No."; Boolean)
        {
            Caption = 'Use Only for Ship-to No.';

            trigger OnValidate()
            begin
                TestField("Ship-to Code", '');
            end;
        }
        field(14; "Shipping Insurance"; Option)
        {
            Caption = 'Shipping Insurance';
            OptionCaption = ' ,Never,Always';
            OptionMembers = " ",Never,Always;
        }
        field(15; "Default Account"; Boolean)
        {
            trigger OnValidate()
            begin
                // ISS2.00 03.05.14 DFP ============================================================\
                if "Default Account" then begin
                    ShippingAccount.Reset;
                    ShippingAccount.SetRange("Ship-to Type", Rec."Ship-to Type");
                    ShippingAccount.SetFilter("Ship-to No.", Rec."Ship-to No.");
                    ShippingAccount.SetFilter("Ship-to Code", Rec."Ship-to Code");
                    ShippingAccount.SetRange("Default Account", true);
                    ShippingAccount.SetFilter("Account No.", '<>' + Rec."Account No.");
                    if not ShippingAccount.IsEmpty then // Only one Accouint can be set to Default per Ship-to.
                        Error(ISSText001);
                end;
                // End =============================================================================/
            end;
        }
        field(21; "Third Party Name"; Text[50])
        {
            Caption = 'Third Party Name';
        }
        field(22; "Third Party Name 2"; Text[50])
        {
            Caption = 'Third Party Name 2';
        }
        field(23; "Third Party Address"; Text[50])
        {
            Caption = 'Third Party Address';
        }
        field(24; "Third Party Address 2"; Text[50])
        {
            Caption = 'Third Party Address 2';
        }
        field(25; "Third Party City"; Text[30])
        {
            Caption = 'Third Party City';
        }
        field(26; "Third Party Contact"; Text[50])
        {
            Caption = 'Third Party Contact';
        }
        field(27; "Third Party ZIP Code"; Code[20])
        {
            Caption = 'Third Party ZIP Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(28; "Third Party State"; Text[30])
        {
            Caption = 'Third Party State';
        }
        field(29; "Third Party Country Code"; Code[10])
        {
            Caption = 'Third Party Country Code';
            TableRelation = "Country/Region";
        }
        field(30; "Third Party Phone No."; Text[30])
        {
            Caption = 'Third Party Phone No.';
        }
        field(31; "Third Party Fax No."; Text[30])
        {
            Caption = 'Third Party Fax No.';
        }
        field(32; "Third Party Tax ID"; Code[15])
        {
            Caption = 'Third Party Tax ID';
        }
        field(50000; Notes; Text[250])
        {
        }
    }
    keys
    {
        key(Key1; "Ship-to Type", "Ship-to No.", "Ship-to Code", "Shipping Agent Code", "Account No.")
        {
        }
        key(Key2; "Shipping Agent Code", "Account No.")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Account No.", Description, "Shipping Agent Code")
        {
        }
    }
    var
        Customer: Record Customer;
        ShipToAddress: Record "Ship-to Address";
        Vendor: Record Vendor;
        OrderAddress: Record "Order Address";
        Location: Record Location;
        ShippingAgent: Record "Shipping Agent";
        ChangeOther: Boolean;
        ChangedFromOther: Boolean;
        Text001: Label 'Only one primary account per Shipping Agent.';
        Text003: Label 'Ship-to Type must be Customer.';
        ShippingSetupRetrieved: Boolean;
        Text004: Label 'No Shipping Accounts exist.';
        ShippingAccount: Record "Shipping Account";
        ISSText001: Label 'Only one Accouint can be set to Default per Ship-to.';
}
