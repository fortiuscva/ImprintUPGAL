pageextension 60004 "GeneralLedgerEntriesExt" extends "General Ledger Entries"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Created Date"; Rec."Created Date")
            {
                ApplicationArea = All;
            }
            field("Created Time"; Rec."Created Time")
            {
                ApplicationArea = All;
            }
        }
    }
}
