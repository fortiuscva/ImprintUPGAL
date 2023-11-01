pageextension 60110 "SalesCreditMemosExt" extends "Sales Credit Memos"
{
    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                rec.TESTFIELD("Ship-to County"); //IMP1.01
            end;
        }
    }
    trigger OnOpenPage()
    begin
        // ISS2.00 DFP =========================================================\
        rec.FilterSalesperson;
    // End =================================================================/
    end;
    var myInt: Integer;
}
