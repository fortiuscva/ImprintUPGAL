tableextension 60001 "GLEntryExt" extends "G/L Entry"
{
    fields
    {
        field(50200; "Created Date"; Date)
        {
            Description = 'IMP1.01';
            Editable = false;
        }
        field(50201; "Created Time"; Time)
        {
            Description = 'IMP1.01';
            Editable = false;
        }
    }
}
