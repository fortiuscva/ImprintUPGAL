codeunit 50015 "TEMP Delete Items"
{
    trigger OnRun()
    begin
        Item.Reset;
        //Item.LOCKTABLE;
        //Item.SETFILTER("No.",'RB-MIT-1..');
        PBMgt.OpenProgressBar('Item', Item.Count, true, true);
        if Item.FindSet(false)then repeat PBMgt.UpdateProgressBar;
                DelItem:=true;
                ItemLedger.Reset;
                ItemLedger.SetCurrentKey("Item No.");
                ItemLedger.SetRange("Item No.", Item."No.");
                if not ItemLedger.IsEmpty then DelItem:=false;
                SalesLine.Reset;
                //SETCURRENTKEY("Item No.");
                SalesLine.SetRange("No.", Item."No.");
                if not SalesLine.IsEmpty then DelItem:=false;
                PurchLine.Reset;
                //SETCURRENTKEY("Item No.");
                PurchLine.SetRange("No.", Item."No.");
                if not PurchLine.IsEmpty then DelItem:=false;
                if DelItem then begin
                    Item.Delete(true);
                    DelCount+=1;
                end;
            until Item.Next = 0;
        PBMgt.CloseProgressBar;
        Message('%1 Items deleted.', DelCount);
    end;
    var Item: Record Item;
    ItemLedger: Record "Item Ledger Entry";
    PurchLine: Record "Purchase Line";
    SalesLine: Record "Sales Line";
    PBMgt: Codeunit "Progress Bar Management";
    DelCount: Integer;
    DelItem: Boolean;
}
