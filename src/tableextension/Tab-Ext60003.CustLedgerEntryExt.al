tableextension 60003 "CustLedgerEntryExt" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50001; "Cust. Comments"; Text[30])
        {
            Description = 'IMP1.01';
        }
        field(50100; "Lead Source Code"; Code[10])
        {
            Description = 'ISS2.00';
            TableRelation = "Lead Source".Code;
        }
    }
}
