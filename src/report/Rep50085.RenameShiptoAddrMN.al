report 50085 "Rename Ship-to Addr. - MN"
{
    // IMP1.01,07/13/18,SK: Created new report to rename the Ship-to Address Code value with Customer No.
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            dataitem("Ship-to Address"; "Ship-to Address")
            {
                DataItemLink = "Customer No."=FIELD("No.");
                DataItemTableView = SORTING("Customer No.", Code)ORDER(Descending);

                trigger OnAfterGetRecord()
                begin
                    Clear(CustShipCodeVarGbl);
                    if Code <> '' then begin
                        CustShipCodeVarGbl:="Customer No." + Code;
                        Rename("Customer No.", CustShipCodeVarGbl);
                        CounterVar+=1;
                    end;
                end;
            }
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
        if CounterVar > 0 then Message('Renamed Successfully')
        else
            Message('Nothing to rename');
    end;
    var CustShipCodeVarGbl: Code[10];
    CounterVar: Integer;
}
