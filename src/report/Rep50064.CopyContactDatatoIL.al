report 50064 "Copy Contact Data to IL"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Temp - Contact"; "Temp - Contact")
        {
            trigger OnAfterGetRecord()
            begin
                /*
                ContactRec.INIT;
                ContactRec.TRANSFERFIELDS("Temp - Contact");
                ContactRec.INSERT;
                */
                if ContactRec.Get("Temp - Contact"."No.")then begin
                    ContactRec."Company No.":=ContactRec."No.";
                    ContactRec.Modify;
                end;
            end;
            trigger OnPreDataItem()
            begin
                ContactRec.ChangeCompany('Imprint Enterprises');
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
    var ContactRec: Record Contact;
}
