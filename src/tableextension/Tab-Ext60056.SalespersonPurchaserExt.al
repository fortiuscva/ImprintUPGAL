tableextension 60056 "SalespersonPurchaserExt" extends "Salesperson/Purchaser"
{
    fields
    {
    }
    procedure FilterSalesperson()
    var
        SalesFilterMgt: Codeunit "Sales Filter Management";
    begin
        // ISS2.00 02.21.14 DFP ==============================================================\
        SalesFilterMgt.SPFilterSalesperson(Rec);
    // End ===============================================================================/
    end;
    var myInt: Integer;
}
