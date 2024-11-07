report 50040 "delet orphan contacts"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=CONST(1));

            trigger OnAfterGetRecord()
            begin
                Clear(Counter);
                ContactRecGbl.Reset;
                ContactRecGbl.SetRange(Type, ContactRecGbl.Type::Company);
                ContactRecGbl.SetRange("Company Name", '');
                ContactRecGbl.SetRange("Salesperson Code", '');
                if ContactRecGbl.FindSet then repeat Counter+=1;
                        ContactRecGbl.Delete(true);
                        Commit;
                        if Counter = 2000 then CurrReport.Break;
                    until ContactRecGbl.Next = 0;
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
    var ContactRecGbl: Record Contact;
    Counter: Integer;
}
