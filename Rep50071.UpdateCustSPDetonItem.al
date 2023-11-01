report 50071 "Update Cust. & SP Det. on Item"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending)WHERE("Source Type"=CONST("Special Stock"));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Window.Update(1, "No.");
                ILERecGbl.Reset;
                ILERecGbl.SetCurrentKey("Entry No.");
                ILERecGbl.SetRange("Item No.", "No.");
                ILERecGbl.SetRange("Document Type", ILERecGbl."Document Type"::"Sales Shipment");
                if ILERecGbl.FindLast then begin
                    if SalShptHeadRecGbl.Get(ILERecGbl."Document No.")then begin
                        Item.Validate("Customer No.", SalShptHeadRecGbl."Sell-to Customer No.");
                        Item.Modify;
                    end;
                end;
            end;
            trigger OnPostDataItem()
            begin
                Window.Close;
            end;
            trigger OnPreDataItem()
            begin
                Window.Open('Processing Item No...####1############');
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
    var ILERecGbl: Record "Item Ledger Entry";
    SalShptHeadRecGbl: Record "Sales Shipment Header";
    Window: Dialog;
}
