codeunit 50011 "TEMP"
{
    Permissions = TableData "Bank Account Ledger Entry"=rimd;

    trigger OnRun()
    begin
    /*WITH AC DO BEGIN
          REPEAT
            IF "Company Name" = 'TEST Imprint TEST' THEN BEGIN
              RENAME("User Security ID","Role ID",'Imprint Enterprises');
            END;
          UNTIL NEXT=0;
        END;
        */
    /*
        WITH PH DO BEGIN
          REPEAT
            FINDSET;
            CLEAR(SL);
            SL.SETRANGE(SL."Purchase Order No.","No.");
            IF SL.FINDFIRST THEN BEGIN
              SH.GET(SL."Document Type",SL."Document No.");
              "Your Reference" := SH."External Document No.";
              MODIFY;
            END;
          UNTIL NEXT=0;
        END;
        */
    /*
        WITH BLE DO BEGIN
          GET(12054);
          "External Document No." := 'WPO-0000823,CC';
          MODIFY;
        END;
        */
    end;
    var AC: Record "Access Control";
    PH: Record "Purchase Header";
    SL: Record "Sales Line";
    SH: Record "Sales Header";
    BLE: Record "Bank Account Ledger Entry";
    Item: Record Item;
}
