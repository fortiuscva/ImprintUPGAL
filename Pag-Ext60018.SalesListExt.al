pageextension 60018 "SalesListExt" extends "Sales List"
{
    trigger OnOpenPage()
    begin
        // ISS2.00 DFP =========================================================\
        Rec.FilterSalesperson;
    // End =================================================================/
    end;
}
