report 50066 "Update Primary Contact"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Temp - Customer"; "Temp - Customer")
        {
            trigger OnAfterGetRecord()
            begin
                CustGRec.ChangeCompany('Imprint Enterprises');
                if CustGRec.Get("Temp - Customer"."No.")then begin
                    if "Temp - Customer"."Primary Contact No." <> '' then begin
                        PrimaryContact:="Temp - Customer"."Primary Contact No." + '-MN';
                        CustGRec."Primary Contact No.":=PrimaryContact;
                        CustGRec.Modify;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var CustGRec: Record Customer;
    PrimaryContact: Code[20];
}
