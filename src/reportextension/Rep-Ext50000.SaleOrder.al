reportextension 50000 "SaleOrder" extends "Sales Order"
{
    dataset
    {
        add(SalesLine)
        {
        }
        modify(SalesLine)
        {
        trigger OnAfterAfterGetRecord()
        var
            myInt: Integer;
        begin
        end;
        }
    }
}
