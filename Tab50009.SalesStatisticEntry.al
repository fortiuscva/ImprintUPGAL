table 50009 "Sales Statistic Entry"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(4; Expected; Boolean)
        {
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = " ", "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order", "P. Invoice", "P. Cr. Memo";
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(10; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(15; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(20; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
        }
        field(25; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit"=CONST(false));
        }
        field(30; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(35; "Lead Source Code"; Code[10])
        {
            TableRelation = "Lead Source".Code;
        }
        field(40; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(70; "Sales Amount"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(80; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(90; "Profit Amount"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(150; Historical; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Document No.", "Posting Date")
        {
        }
        key(Key3; "Salesperson Code", "Posting Date")
        {
        }
        key(Key4; Expected, "Salesperson Code", "Posting Date")
        {
            SumIndexFields = "Sales Amount", "Cost Amount", "Profit Amount";
        }
        key(Key5; Expected, "Sell-to Customer No.", "Posting Date")
        {
            SumIndexFields = "Sales Amount", "Profit Amount";
        }
    }
    fieldgroups
    {
    }
}
