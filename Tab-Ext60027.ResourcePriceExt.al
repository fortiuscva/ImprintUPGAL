tableextension 60027 "ResourcePriceExt" extends "Resource Price"
{
    fields
    {
        field(50000; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            Description = 'ISS2.00';
            MinValue = 0;
        }
    }
}
