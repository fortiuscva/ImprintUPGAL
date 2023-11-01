pageextension 60007 "CustomerLedgerEntriesExt" extends "Customer Ledger Entries"
{
    layout
    {
        /* IMP1.01 Start
        addafter("Posting Date") 
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
            }
        } IMP1.01 End */
        addafter("Salesperson Code")
        {
            field("Lead Source Code"; Rec."Lead Source Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("On Hold")
        {
            field("Cust. Comments"; Rec."Cust. Comments")
            {
                ApplicationArea = All;
            }
        }
    }
}
