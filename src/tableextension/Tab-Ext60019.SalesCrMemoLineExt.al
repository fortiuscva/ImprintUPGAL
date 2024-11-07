tableextension 60019 "SalesCrMemoLineExt" extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50030; "Last Direct Cost"; Decimal)
        {
            Description = 'IMP1.01';
            Editable = false;
        }
        field(60033; "Ship-to Code"; Code[10])
        {
            Description = 'Passed in CU80';
            TableRelation = "Ship-to Address".Code WHERE("Customer No."=FIELD("Sell-to Customer No."));
        }
        field(60035; "Sales Invoice No."; Code[20])
        {
            Description = 'Passed in CU80';
        }
        field(60036; "Sales Order No."; Code[20])
        {
            Description = 'Entered on Sales Credit Memos';
        }
    }
    keys
    {
        key(key100_; Type, "No.")
        {
        }
    }
}
