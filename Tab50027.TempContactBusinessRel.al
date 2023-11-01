table 50027 "Temp - Contact Business Rel."
{
    Caption = 'Contact Business Relation';

    fields
    {
        field(1; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            NotBlank = true;
        }
        field(2; "Business Relation Code"; Code[10])
        {
            Caption = 'Business Relation Code';
            NotBlank = true;
            TableRelation = "Business Relation";

            trigger OnValidate()
            var
                RMSetup: Record "Marketing Setup";
                Cust: Record Customer;
                Vend: Record Vendor;
                BankAcc: Record "Bank Account";
            begin
            end;
        }
        field(3; "Link to Table"; Option)
        {
            Caption = 'Link to Table';
            OptionCaption = ' ,Customer,Vendor,Bank Account';
            OptionMembers = " ", Customer, Vendor, "Bank Account";
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF("Link to Table"=CONST(Customer))Customer
            ELSE IF("Link to Table"=CONST(Vendor))Vendor
            ELSE IF("Link to Table"=CONST("Bank Account"))"Bank Account";
        }
        field(5; "Business Relation Description"; Text[100])
        {
            CalcFormula = Lookup("Business Relation".Description WHERE(Code=FIELD("Business Relation Code")));
            Caption = 'Business Relation Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Contact Name"; Text[100])
        {
            CalcFormula = Lookup(Contact.Name WHERE("No."=FIELD("Contact No.")));
            Caption = 'Contact Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Contact No.", "Business Relation Code")
        {
        }
        key(Key2; "Link to Table", "No.")
        {
        }
        key(Key3; "Link to Table", "Contact No.")
        {
        }
        key(Key4; "Business Relation Code")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
    end;
    var Text000: Label '%1 %2 already has a %3 with %4 %5.';
    Text001: Label '%1 %2 is used when a %3 is linked with a %4.';
    Cont: Record Contact;
    procedure TouchContact(ContactNo: Code[20])
    begin
    end;
}
