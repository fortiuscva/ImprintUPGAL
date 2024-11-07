pageextension 60026 "PurchaseOrderSubformExt" extends "Purchase Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Vendor Resource No."; Rec."Vendor Resource No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter(Control19)
        {
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
            }
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
            }
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: CodeModification on "OpenSalesOrderForm(PROCEDURE 5)". Please convert manually.
//procedure OpenSalesOrderForm();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    TestField("Sales Order No.");
    SalesHeader.SetRange("No.","Sales Order No.");
    SalesOrder.SetTableView(SalesHeader);
    SalesOrder.Editable := false;
    SalesOrder.Run;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    #2..5
    */
//end;
//Unsupported feature: CodeModification on "OpenSpecOrderSalesOrderForm(PROCEDURE 12)". Please convert manually.
//procedure OpenSpecOrderSalesOrderForm();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    TestField("Special Order Sales No.");
    SalesHeader.SetRange("No.","Special Order Sales No.");
    SalesOrder.SetTableView(SalesHeader);
    SalesOrder.Editable := false;
    SalesOrder.Run;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    #2..5
    */
//end;
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
