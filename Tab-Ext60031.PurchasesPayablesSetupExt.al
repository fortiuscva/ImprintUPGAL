tableextension 60031 "PurchasesPayablesSetupExt" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50030; "Sample Order Nos."; Code[10])
        {
            Caption = 'Sample Order Nos.';
            Description = 'IMP1.01';
            TableRelation = "No. Series";
        }
        field(50031; "Demo Order Nos."; Code[10])
        {
            Description = 'IMP1.02';
            TableRelation = "No. Series";
        }
        field(50032; "Project Order Nos."; Code[10])
        {
            Description = 'IMP1.03';
            TableRelation = "No. Series";
        }
    }
}
