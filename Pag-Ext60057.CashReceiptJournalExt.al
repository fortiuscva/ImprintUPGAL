pageextension 60057 "CashReceiptJournalExt" extends "Cash Receipt Journal"
{
    layout
    {
        addafter("Salespers./Purch. Code")
        {
            field("Lead Source Code"; Rec."Lead Source Code")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
