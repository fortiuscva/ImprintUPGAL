report 50044 "Update SalesPerson in Cont."
{
    // IMP1.01,SP5696,03/21/17,SK: Created new report.
    Permissions = TableData Contact=rimd;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Contact; Contact)
        {
            DataItemTableView = SORTING("Salesperson Code")ORDER(Ascending);
            RequestFilterFields = "Salesperson Code";

            trigger OnAfterGetRecord()
            begin
                Contact."Salesperson Code":='';
                CountVarGbl+=1;
                Modify;
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
    trigger OnPostReport()
    begin
        if CountVarGbl > 0 then Message('updated successfully');
    end;
    trigger OnPreReport()
    begin
        FilterStringVarGbl:=Contact.GetFilters;
        if FilterStringVarGbl = '' then Error('Please enter the filter');
    end;
    var FilterStringVarGbl: Text;
    CountVarGbl: Integer;
}
