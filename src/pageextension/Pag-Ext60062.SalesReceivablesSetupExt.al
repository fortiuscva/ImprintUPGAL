pageextension 60062 "SalesReceivablesSetupExt" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Credit Warnings")
        {
            field("Over Due Grace Period"; Rec."Over Due Grace Period")
            {
                ApplicationArea = All;
            }
        }
        addafter("Quote Validity Calculation")
        {
            field("Suppress Shipment Doc. Print"; Rec."Suppress Shipment Doc. Print")
            {
                ApplicationArea = All;
            }
        }
        addafter("Return Order Nos.")
        {
            field("Repair Return Order Nos."; Rec."Repair Return Order Nos.")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
