codeunit 50007 "Modify Items"
{
    
    trigger OnRun()
    begin
        /*
        //Item.MODIFYALL(Item."VAT Prod. Posting Group",'');
        
        Cust.MODIFYALL("Location Code",'AURORA');
        
        Shipto.MODIFYALL("Location Code",'AURORA');
        */
        UpdatePrinters('Check1;chec2,che3,ch4;ch5');
    end;
    var Item: Record Item;
    Cust: Record Customer;
    Shipto: Record "Ship-to Address";
    procedure UpdatePrinters(PrinterTxtVarPar: Text)
    var
        PrintTxtVarLcl: Text;
        SrchStr: Text;
        StopLoop: Boolean;
        NewStr: Text;
        Pos: Integer;
        CommaPos: Integer;
        ColonPos: Integer;
    begin
        PrintTxtVarLcl:=PrinterTxtVarPar;
        repeat Clear(StopLoop);
            Clear(NewStr);
            CommaPos:=StrPos(PrintTxtVarLcl, ',');
            ColonPos:=StrPos(PrintTxtVarLcl, ';');
            if(CommaPos = 0) and (ColonPos = 0)then Pos:=0
            else
            begin
                if(CommaPos < ColonPos)then begin
                    if CommaPos <> 0 then Pos:=CommaPos
                    else
                        Pos:=ColonPos end
                else
                begin
                    if ColonPos <> 0 then Pos:=ColonPos
                    else
                        Pos:=CommaPos;
                end;
            end;
            if Pos = 0 then begin
                NewStr:=CopyStr(PrintTxtVarLcl, 1, StrLen(PrintTxtVarLcl));
                StopLoop:=true;
            end
            else
            begin
                NewStr:=CopyStr(PrintTxtVarLcl, 1, Pos - 1);
                PrintTxtVarLcl:=DelStr(PrintTxtVarLcl, 1, Pos);
            end;
            Message('Pos %1 and New String %2 and %3', Pos, PrintTxtVarLcl, NewStr);
        until StopLoop;
    end;
}
