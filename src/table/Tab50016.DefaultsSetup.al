table 50016 "Defaults Setup"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(100; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            Description = 'Customer';
            TableRelation = "Customer Posting Group";
        }
        field(103; "C. Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Description = 'Customer';
            TableRelation = "Gen. Business Posting Group";
        }
        field(105; "C. VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            Description = 'Customer';
            TableRelation = "VAT Business Posting Group";
        }
        field(200; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            Description = 'Vendor';
            TableRelation = "Vendor Posting Group";
        }
        field(203; "V. Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Description = 'Vendor';
            TableRelation = "Gen. Business Posting Group";
        }
        field(205; "V. VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            Description = 'Vendor';
            TableRelation = "VAT Business Posting Group";
        }
        field(400; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            Description = 'Item';
            TableRelation = "Inventory Posting Group";
        }
        field(403; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            Description = 'Item';
            TableRelation = "Gen. Product Posting Group";
        }
        field(405; "VAT Bus. Posting Gr. (Price)"; Code[10])
        {
            Caption = 'VAT Bus. Posting Gr. (Price)';
            Description = 'Item';
            TableRelation = "VAT Business Posting Group";
        }
        field(408; "Item Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            Description = 'Item';
            TableRelation = "Tax Group";
        }
        field(500; "R. Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            Description = 'Resource';
            TableRelation = "Gen. Product Posting Group";
        }
        field(503; "Resource Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            Description = 'Resource';
            TableRelation = "Tax Group";
        }
        field(506; "R. VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'Tax Prod. Posting Group';
            Description = 'Resource';
            TableRelation = "VAT Product Posting Group";
        }
        field(600; "SN Item Tracking Code"; Code[10])
        {
            Description = 'Item Import';
            TableRelation = "Item Tracking Code";
        }
        field(610; "Unit of Measure Code"; Code[10])
        {
            Description = 'Item Import';
            TableRelation = "Unit of Measure".Code;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UnitOfMeasure: Record "Unit of Measure";
            begin
            end;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }
    fieldgroups
    {
    }
}
