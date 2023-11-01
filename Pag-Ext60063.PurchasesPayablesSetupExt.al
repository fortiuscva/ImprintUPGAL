pageextension 60063 "PurchasesPayablesSetupExt" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Order Nos.")
        {
            field("Sample Order Nos."; Rec."Sample Order Nos.")
            {
                ApplicationArea = All;
            }
            field("Demo Order Nos."; Rec."Demo Order Nos.")
            {
                ApplicationArea = All;
            }
            field("Project Order Nos."; Rec."Project Order Nos.")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
