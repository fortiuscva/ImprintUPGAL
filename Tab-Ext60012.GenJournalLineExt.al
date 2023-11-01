tableextension 60012 "GenJournalLineExt" extends "Gen. Journal Line"
{
    fields
    {
        field(50100; "Lead Source Code"; Code[10])
        {
            Description = 'ISS2.00';
            TableRelation = "Lead Source".Code;
        }
    }
}
