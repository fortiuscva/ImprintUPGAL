codeunit 50010 "TEMP Move Vebndor No"
{
    trigger OnRun()
    begin
        SalesLine.FindSet;
        repeat;
            if SalesLine."Salesperson Code" <> '' then begin
                SalesLine.TestField("Vendor No.", '');
                SalesLine."Vendor No.":=SalesLine."Salesperson Code";
                SalesLine."Salesperson Code":='';
                SalesLine.Modify;
            end;
        until SalesLine.Next = 0;
        Message('Vendor moved.');
    end;
    var SalesLine: Record "Sales Line";
}
