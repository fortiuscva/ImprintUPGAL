tableextension 60030 "SalesReceivablesSetupExt" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Suppress Shipment Doc. Print"; Boolean)
        {
            Description = 'ISS2.00';
        }
        field(50010; "Quote Text 1"; Text[250])
        {
            Description = 'ISS - UNUSED FOR NOW';
        }
        field(50011; "Quote Text 2"; Text[250])
        {
            Description = 'ISS - UNUSED FOR NOW';
        }
        field(50012; "Quote Text 3"; Text[250])
        {
            Description = 'ISS - UNUSED FOR NOW';
        }
        field(50013; "Quote Text 4"; Text[250])
        {
            Description = 'ISS - UNUSED FOR NOW';
        }
        field(50030; "Repair Return Order Nos."; Code[10])
        {
            Caption = 'Repair Return Order Nos.';
            Description = 'IMP1.01';
            TableRelation = "No. Series";
        }
        field(50040; "Over Due Grace Period"; DateFormula)
        {
            Description = 'IMP1.02';
        }
    }
}
