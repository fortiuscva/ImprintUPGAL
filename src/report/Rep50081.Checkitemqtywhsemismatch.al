report 50081 "Check item qty  whse mismatch"
{
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/Check item qty  whse mismatch.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            column(itemno; Item."No.")
            {
            }
            column(itemqty; Item.Inventory)
            {
            }
            column(whseqty; whseentry."Qty. (Base)")
            {
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields(Item.Inventory);
                Clear(whseentry);
                whseentry.Reset;
                whseentry.SetCurrentKey("Item No.");
                whseentry.SetRange("Item No.", "No.");
                whseentry.CalcSums(whseentry."Qty. (Base)");
                if whseentry."Qty. (Base)" = Item.Inventory then CurrReport.Skip;
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
        whseentry: Record "Warehouse Entry";
}
