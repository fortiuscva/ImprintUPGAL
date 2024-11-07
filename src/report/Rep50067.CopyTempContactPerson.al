report 50067 "Copy Temp Contact - Person"
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
                if ContactBusRelRec.FindSet then repeat ContactRec.SetCurrentKey("Company Name", "Company No.", Type, Name);
                        ContactRec.SetRange("Company No.", ContactBusRelRec."Contact No.");
                        ContactRec.SetRange(Type, ContactRec.Type::Person);
                        if ContactRec.FindSet then repeat TempContactRec.Init;
                                TempContactRec.TransferFields(ContactRec);
                                TempContactRec.Insert;
                            until ContactRec.Next = 0;
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
