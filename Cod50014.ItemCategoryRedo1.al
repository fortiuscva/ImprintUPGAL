codeunit 50014 "Item Category Redo 1"
{
    trigger OnRun()
    begin
        //RESET;
        //SETCURRENTKEY("TEMP Proc 1");
        //SETRANGE("TEMP Proc 1",FALSE);
        //FINDFIRST;
        //FirstItemNo := "No.";
        //COMMIT;
        Item.Reset;
        //SETFILTER("No.",FirstItemNo + '..');
        PBMgt.OpenProgressBar('Process 1', Item.Count, true, true);
        PBMgt.SetIntervals(867, 500);
        if Item.FindSet(false)then repeat PBMgt.UpdateProgressBar;
            /*IF NOT "TEMP Proc 1" THEN BEGIN

            // Set new field to old Cat
            CASE "Item Category Code" OF
              'DROPSHIP':   "Source Type" := "Source Type"::Dropship;
              'SPE STOCK':  "Source Type" := "Source Type"::"Special Stock";
              'STOCK':      "Source Type" := "Source Type"::Stock;
            END;

            // Move Product Group
            CreateNewItemCat("Item Category Code","Product Group Code");
            "NEW Item Category Code" := "Product Group Code";

            "Item Category Code" := '';
            "Product Group Code" := '';

            "TEMP Proc 1" := TRUE;

            MODIFY;

            END;
      */
            //IMPUPG
            until Item.Next = 0;
        PBMgt.CloseProgressBar;
        Message('Process 1 complete.');
    end;
    var Item: Record Item;
    ItemCat: Record "Item Category";
    //ProdGroup: Record "Product Group";//UPG Table removed
    NewItemCat: Record "TEMP NEW Item Categories";
    PBMgt: Codeunit "Progress Bar Management";
    SourceType: Option " ", Dropship, "Special Stock", Stock;
    FirstItemNo: Code[20];
    procedure CreateNewItemCat(OldItemCatCodeIn: Code[10]; OldProdGroupCodeIn: Code[10])
    begin
        if OldProdGroupCodeIn = '' then exit;
        if not NewItemCat.Get(OldProdGroupCodeIn)then begin
            /*
            if not ProdGroup.Get(OldItemCatCodeIn, OldProdGroupCodeIn) then
                Clear(ProdGroup);
                */
            //UPG Table removed
            NewItemCat.Init;
            NewItemCat.Code:=OldProdGroupCodeIn;
            // Description := ProdGroup.Description; //UPG Table removed
            NewItemCat."OLD Item Category Code":=OldItemCatCodeIn;
            NewItemCat.Insert;
        end;
    end;
}
