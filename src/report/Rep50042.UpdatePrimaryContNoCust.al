report 50042 "Update Primary Cont. No. Cust."
{
    // IMP1.01,SP5696,03/21/17,SK: Created new report.
    Permissions = TableData Customer=rimd;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending)WHERE("Primary Contact No."=FILTER(''));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                ContBusRel.SetCurrentKey("Link to Table", "No.");
                ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::Customer);
                ContBusRel.SetRange("No.", "No.");
                if ContBusRel.FindFirst then begin
                    Cont.Reset;
                    Cont.SetRange("Company No.", ContBusRel."Contact No.");
                    Cont.SetRange(Name, Contact);
                    if Cont.FindSet then begin
                        Validate("Primary Contact No.", Cont."No.");
                        CountVarGbl+=1;
                        Modify;
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
    trigger OnPostReport()
    begin
        if CountVarGbl > 0 then Message('Updated Successfully');
    end;
    var ContBusRel: Record "Contact Business Relation";
    Cont: Record Contact;
    CountVarGbl: Integer;
}
