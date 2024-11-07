table 50007 "Imprint Cue"
{
    Caption = 'Sales Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Sales Quotes"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type"=FILTER(Quote), Status=FILTER(Open)));
            Caption = 'Sales Quotes - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Sales Orders"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type"=FILTER(Order), Status=FILTER(Open)));
            Caption = 'Sales Orders - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Sales Return Orders"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type"=FILTER("Return Order"), Status=FILTER(Open)));
            Caption = 'Sales Return Orders - All';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Sales Credit Memos"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type"=FILTER("Credit Memo"), Status=FILTER(Open)));
            Caption = 'Sales Credit Memos - All';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Partially Shipped"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type"=FILTER(Order), Status=FILTER(Released), Ship=FILTER(true), "Completely Shipped"=FILTER(false), "Shipment Date"=FIELD("Date Filter2")));
            Caption = 'Partially Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21; "Date Filter2"; Date)
        {
            Caption = 'Date Filter2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50000; "Purchase Orders"; Integer)
        {
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
