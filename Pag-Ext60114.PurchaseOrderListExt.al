pageextension 60114 "PurchaseOrderListExt" extends "Purchase Order List"
{
    layout
    {
        //Unsupported feature: Change Visible on "Status(Control 1102601003)". Please convert manually.
        //Unsupported feature: PropertyDeletion on ""Purchaser Code"(Control 99)". Please convert manually.
        //Unsupported feature: PropertyDeletion on ""Purchaser Code"(Control 99)". Please convert manually.
        //Unsupported feature: PropertyDeletion on "Status(Control 1102601003)". Please convert manually.
        //Unsupported feature: PropertyDeletion on "Status(Control 1102601003)". Please convert manually.
        moveafter("Buy-from Vendor Name"; "Purchaser Code")
        moveafter("Pay-to Contact"; Status)
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
