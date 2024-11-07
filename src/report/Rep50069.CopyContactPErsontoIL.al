report 50069 "Copy Contact- PErson to IL"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Temp - Contact"; "Temp - Contact")
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending)WHERE(Type=CONST(Person));

            trigger OnAfterGetRecord()
            begin
                ContactRec.Init;
                ContactRec.TransferFields("Temp - Contact");
                ContactRec.Insert;
            /*
                IF ContactRec.GET("Temp - Contact"."No.") THEN BEGIN
                  ContactRec."Company No." := ContactRec."No.";
                  ContactRec.MODIFY;
                
                END;
                */
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
