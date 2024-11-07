tableextension 60010 "InvoicePostBufferExt" extends "Invoice Post. Buffer"
{
    fields
    {
        modify("Global Dimension 1 Code")
        {
        TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        modify("Global Dimension 2 Code")
        {
        TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(50000; "Posting Date"; Date)
        {
        }
    }
}
