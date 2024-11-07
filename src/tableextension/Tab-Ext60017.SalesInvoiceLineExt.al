tableextension 60017 "SalesInvoiceLineExt" extends "Sales Invoice Line"
{
    fields
    {
        field(50030; "Last Direct Cost"; Decimal)
        {
            Description = 'IMP1.01';
            Editable = false;
        }
        field(50200; "External Document No."; Code[35])
        {
            CalcFormula = Lookup("Sales Invoice Header"."External Document No." WHERE("No."=FIELD("Document No.")));
            Caption = 'Customer PO No.';
            Description = 'Changed Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60030; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
        }
        field(60031; "Direct Purchase"; Boolean)
        {
        }
        field(60032; "Ship-to Option"; Option)
        {
            OptionCaption = 'Location Code,Ship-to Code,Job Site';
            OptionMembers = Location, "Ship-to Code", "Job Site";
        }
        field(60033; "Ship-to Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE("Customer No."=FIELD("Sell-to Customer No."));
        }
        field(60034; "Special Order"; Boolean)
        {
        }
        field(60035; "Purchase Order No."; Code[20])
        {
        }
        field(60036; "Sales Order No."; Code[20])
        {
        }
        field(60037; "Purch. Line Discount %"; Decimal)
        {
            DecimalPlaces = 0: 5;
            MaxValue = 100;
        }
    }
    keys
    {
        key(key100_; "Sales Order No.")
        {
        }
        key(key101_; Type, "No.")
        {
        }
        key(key102_; "Sell-to Customer No.", Type, "No.", "Posting Date")
        {
        }
    }
}
