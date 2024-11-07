report 50072 "Update Sell-to Name Ret. Rcpt"
{
    // IMP1.01,02/08/17,SK: Created New report.
    Permissions = TableData "Return Receipt Line"=rm;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Return Receipt Line"; "Return Receipt Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")WHERE("Sell-to Customer No."=FILTER(<>''));
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord()
            begin
                if CustRecGbl.Get("Sell-to Customer No.")then begin
                    "Sell-to Customer Name":=CustRecGbl.Name;
                    Modify;
                    CounterGbl:=CounterGbl + 1;
                    Window.Update(1, "Document No.");
                    Window.Update(2, Round(CounterGbl / CounterTotalGbl * 10000, 1));
                end;
            end;
            trigger OnPostDataItem()
            begin
                Window.Close;
            end;
            trigger OnPreDataItem()
            begin
                CounterTotalGbl:=Count;
                Window.Open(Text001);
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
        if CounterGbl > 0 then Message('Updated Successfully');
    end;
    var CustRecGbl: Record Customer;
    CounterGbl: Integer;
    Text001: Label 'Posting orders  #1########## @2@@@@@@@@@@@@@';
    CounterTotalGbl: Integer;
    Window: Dialog;
}
