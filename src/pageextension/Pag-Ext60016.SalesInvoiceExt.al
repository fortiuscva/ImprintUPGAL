pageextension 60016 "SalesInvoiceExt" extends "Sales Invoice"
{
    layout
    {
        addafter("Work Description")
        {
            field("Override Credit"; Rec."Override Credit")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Service Code")
        {
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = All;
            }
        }
        addlast("Foreign Trade")
        {
            group("E-ship")
            {
                field("Third Party Shipping Acc. No."; rec."Third Party Shipping Acc. No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
