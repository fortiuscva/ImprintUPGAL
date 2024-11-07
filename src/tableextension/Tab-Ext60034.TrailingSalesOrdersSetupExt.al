tableextension 60034 "TrailingSalesOrdersSetupExt" extends "Trailing Sales Orders Setup"
{
    fields
    {
        field(50000; "Salesperson Filter"; Text[200])
        {
            TableRelation = "Salesperson/Purchaser";
            ValidateTableRelation = false;
        }
        field(50001; "Stat. Chart Salesperson Change"; Boolean)
        {
            Description = 'Allow change SP Filter';
        }
        field(50005; "Show Sales"; Option)
        {
            OptionMembers = All, Posted, Expected;
        }
    }
    PROCEDURE SetShowSales(ShowSales: Integer);
    BEGIN
        // ISS DFP =====================================\
        "Show Sales":=ShowSales;
        MODIFY;
    // End =========================================/
    END;
}
