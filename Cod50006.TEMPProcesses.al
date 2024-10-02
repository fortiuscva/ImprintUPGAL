codeunit 50006 "TEMP Processes"
{
   //Testing 1 changes.
    trigger OnRun()
    begin
        ReceiptLine.Get('PR014985', 10000);
        ReceiptLine.TestField("No.", '130894');
        ReceiptLine."No.":='LB8501400SLIT';
        ReceiptLine.Modify;
        /*
        WITH Item DO BEGIN
          RESET;
          SETFILTER("Tax Group Code",'<>TAX');
          IF FINDSET(FALSE) THEN
            REPEAT
              IF ("Tax Group Code" <> 'TAX') AND ("Tax Group Code" <> 'NOTAX') AND ("Tax Group Code" <> '') THEN
                ERROR('Item %1 is %2',"No.","Tax Group Code");
            UNTIL NEXT = 0;
          MESSAGE('All Tax Groups ok.');
          //MODIFYALL("TEMP Proc 1",FALSE);
          //MODIFYALL("TEMP Proc 2",FALSE);
        
          {
          IF FINDSET(FALSE) THEN
            REPEAT
              TempItemCat.INIT;
              TempItemCat."Item No." := "No.";
              TempItemCat.Description := Description;
              TempItemCat."Item Import Code" := "Item Import Code";
              TempItemCat."Old Item Category Code" := "Item Category Code";
              TempItemCat.INSERT;
            UNTIL NEXT = 0;
          }
        END;
        */
        /*
        WITH Item DO BEGIN
          RESET;
          TotalCnt := COUNT;
          SETCURRENTKEY("TEMP Proc 2");
          //SETRANGE("TEMP Proc 1",FALSE);
          SETRANGE("TEMP Proc 2",TRUE);
          //MODIFYALL("TEMP Proc 2",FALSE);
          DoneCnt := COUNT;
          MESSAGE('Proc 2 Recs: ' + FORMAT(DoneCnt) + ' of ' + FORMAT(TotalCnt) +
                   '\\' + FORMAT(ROUND(DoneCnt / TotalCnt * 100,0.01)) + ' %');
        END;
        */
        /*
        WITH SalesLine DO BEGIN
          IF FINDSET(FALSE) THEN
            REPEAT
              UpdateProfit;
              MODIFY;
            UNTIL NEXT = 0;
        END;
        */
        /*
        WITH TDDetailImport DO BEGIN
          FINDSET(FALSE);
          REPEAT
            IF NOT TDImport.GET("Mfg. Part No. (Match)") THEN BEGIN
              TDImport."Mfg. Part No. (Match)" := "Mfg. Part No. (Match)";
              TDImport.INSERT;
            END;
          UNTIL NEXT = 0;
        END;
        */
        /*
        SalesHeader.MODIFYALL("Responsibility Center",'');
        SalesLine.MODIFYALL("Responsibility Center",'');
        */
        /*
        WITH SalesLine DO BEGIN
          GET("Document Type"::Order,'S01000613',10000);
          "Purchase Order No." := '';
          "Purch. Order Line No." := 0;
          MODIFY;
        
        END;
         */
        /*
       WITH Item DO BEGIN
         RESET;
         PBMgt.OpenProgressBar('Item',COUNT,TRUE,TRUE);
         PBMgt.SetIntervals(523,523);
         IF FINDSET THEN
           REPEAT
             PBMgt.UpdateProgressBar;
             "Mfg. Item No. (Match)" := ItemImportMgt.CreateMatchNo("Mfg. Item No.");
             MODIFY;
           UNTIL NEXT = 0;
       END;
       PBMgt.CloseProgressBar;
       */
        /*
        WITH ItemImportLine DO BEGIN
          RESET;
          PBMgt.OpenProgressBar('Item Import Line',COUNT,TRUE,TRUE);
          PBMgt.SetIntervals(500,500);
          IF FINDSET THEN
            REPEAT
              PBMgt.UpdateProgressBar;
              "NAV Item No." := "Mfg. Item No.";
              MODIFY;
            UNTIL NEXT = 0;
        END;
        PBMgt.CloseProgressBar;
        */
        /*
        WITH PRH DO BEGIN
          GET('');
          "No." := '1';
          MODIFY;
        END;
        */
        Message('Process complete.');
    end;
    var Item: Record Item;
    SalesHeader: Record "Sales Header";
    SalesLine: Record "Sales Line";
    ItemImportLine: Record "Item Import Line";
    PBMgt: Codeunit "Progress Bar Management";
    ItemImportMgt: Codeunit "Item Import Management";
    PRH: Record "Purch. Rcpt. Header";
    ReceiptLine: Record "Purch. Rcpt. Line";
    TDImport: Record "TEMP Tech Data";
    TDDetailImport: Record "TEMP Tech Data Detail";
    TempItemCat: Record "TEMP Item Category Check";
    TotalCnt: Integer;
    DoneCnt: Integer;
}
