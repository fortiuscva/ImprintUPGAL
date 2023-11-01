pageextension 60112 "SalesReturnOrderListExt" extends "Sales Return Order List"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Name")
        {
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
