report 50063 "Update Contact Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/Update Contact Details.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Temp - Contact"; "Temp - Contact")
        {
            DataItemTableView = SORTING("Territory Code") ORDER(Descending);

            trigger OnAfterGetRecord()
            begin
                /*
                    ContactNo := "Temp - Contact"."No."+'-MN';
                    RENAME(ContactNo);
                    */
            end;

            trigger OnPostDataItem()
            begin
                //COMMIT;
            end;
        }
        dataitem("Temp - Contact Business Rel."; "Temp - Contact Business Rel.")
        {
            DataItemTableView = SORTING("Business Relation Code") ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                ContactNo := "Temp - Contact Business Rel."."Contact No." + '-MN';
                Rename(ContactNo, "Temp - Contact Business Rel."."Business Relation Code");
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
    var
        ContactNo: Text[20];
}
