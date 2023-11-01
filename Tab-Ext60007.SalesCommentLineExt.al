tableextension 60007 "SalesCommentLineExt" extends "Sales Comment Line"
{
    fields
    {
        //Unsupported feature: Property Modification (OptionString) on ""Document Type"(Field 1)".
        field(50000; "Copy to Purch. Order"; Boolean)
        {
            Description = 'ISS2.00';
        }
    }
}
