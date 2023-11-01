report 50062 "Copy Temp Contact"
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
                ContactBusRelRec.Reset;
                ContactBusRelRec.SetRange("Link to Table", ContactBusRelRec."Link to Table"::Customer);
                ContactBusRelRec.SetRange("No.", "Temp - Customer"."No.");
                if ContactBusRelRec.FindSet then repeat TempContactBusRelRec.Init;
                        TempContactBusRelRec.TransferFields(ContactBusRelRec);
                        TempContactBusRelRec.Insert;
                        if ContactRec.Get(ContactBusRelRec."Contact No.")then begin
                            if not TempContactRec.Get(ContactRec."No.")then begin
                                TempContactRec.Init;
                                TempContactRec.TransferFields(ContactRec);
                                TempContactRec.Insert;
                            end;
                        end;
                    until ContactBusRelRec.Next = 0;
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
    var Tempcustomer: Record "Temp - Customer";
    ContactRec: Record Contact;
    TempContactRec: Record "Temp - Contact";
    ContactBusRelRec: Record "Contact Business Relation";
    TempContactBusRelRec: Record "Temp - Contact Business Rel.";
}
