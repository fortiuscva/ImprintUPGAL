query 50000 "Serial Numbers by Bin"
{
    // IMP1.01,08/17/20,ST: Enhancements to display Serial No's by bin code.
    //                        Created new page.
    Caption = 'Lot Numbers by Bin';
    OrderBy = Ascending(Bin_Code);

    elements
    {
    dataitem(Warehouse_Entry;
    "Warehouse Entry")
    {
    column(Location_Code;
    "Location Code")
    {
    }
    column(Item_No;
    "Item No.")
    {
    }
    column(Variant_Code;
    "Variant Code")
    {
    }
    column(Zone_Code;
    "Zone Code")
    {
    }
    column(Bin_Code;
    "Bin Code")
    {
    }
    column(Lot_No;
    "Lot No.")
    {
    }
    column(Serial_No;
    "Serial No.")
    {
    ColumnFilter = Serial_No=FILTER(<>'');
    }
    column(Sum_Qty_Base;
    "Qty. (Base)")
    {
    ColumnFilter = Sum_Qty_Base=FILTER(<>0);
    Method = Sum;
    }
    }
    }
}
