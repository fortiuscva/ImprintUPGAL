pageextension 60150 "Sales Quote List" extends "Sales Quotes"
{
    layout
    {
        modify("Document Date")
        {
            Visible = true;
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Setcurrentkey("Document Date");
        Rec.Ascending(false);
        if Rec.FindFirst() then;
    end;
}
