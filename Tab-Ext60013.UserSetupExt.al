tableextension 60013 "UserSetupExt" extends "User Setup"
{
    fields
    {
        field(50000; "Stat. Chart Salesperson Change"; Boolean)
        {
            Description = 'ISS2.00';
        }
        field(50001; "Edit Accounts Payable Contacts"; Boolean)
        {
            Description = 'IMP1.01';
        }
        field(50010; "Sales Supervisor"; Boolean)
        {
            Description = 'ISS2.00';
        }
        field(50011; "Salesperson Filter"; Code[250])
        {
            Description = 'ISS2.00';
            TableRelation = "Salesperson/Purchaser";
            ValidateTableRelation = false;
        }
    }
}
