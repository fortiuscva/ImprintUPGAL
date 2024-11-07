tableextension 60049 "ReturnShipmentHeaderExt" extends "Return Shipment Header"
{
    DataCaptionFields = "No.", "Buy-from Vendor Name";

    fields
    {
        field(50026; "Salesperson Code"; Code[10])
        {
            Description = 'IMP1.01';
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
    }
}
