report 50075 "Delete IPT Items"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                Window.Update(1, "No.");
                ILERec.Reset;
                ILERec.SetRange("Item No.", "No.");
                if not ILERec.FindFirst then begin
                    if Delete(true)then Commit;
                end;
            end;
            trigger OnPostDataItem()
            begin
                Window.Close;
            end;
            trigger OnPreDataItem()
            begin
                //SETRANGE("Last Date Modified",0D,110114D);
                SetFilter("No.", '@IPT*');
                Window.Open('Processing Item No..####1###########');
            //ERROR('%1',COUNT);
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
    var ILERec: Record "Item Ledger Entry";
    Window: Dialog;
}
