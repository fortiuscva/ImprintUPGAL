report 50068 "Update Contact Details -person"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Update Contact Details -person.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Temp - Contact"; "Temp - Contact")
        {
            DataItemTableView = SORTING("Territory Code")ORDER(Descending)WHERE(Type=CONST(Person));

            trigger OnAfterGetRecord()
            begin
                /*
                ContactNo := "Temp - Contact"."No."+'-MN';
                RENAME(ContactNo);
                */
                "Temp - Contact"."Company No.":=("Temp - Contact"."Company No." + '-MN');
                "Temp - Contact".Modify;
            end;
            trigger OnPostDataItem()
            begin
            //COMMIT;
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
    var ContactNo: Text[20];
}
