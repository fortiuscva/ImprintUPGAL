tableextension 60037 "SalesLineArchiveExt" extends "Sales Line Archive"
{
    fields
    {
        field(50030; "Last Direct Cost"; Decimal)
        {
            Description = 'IMP1.01';
            Editable = false;
        }
    }
}
