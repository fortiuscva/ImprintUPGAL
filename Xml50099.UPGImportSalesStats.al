xmlport 50099 "UPG Import Sales Stats"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement(salesstat;
    "Sales Statistic Entry")
    {
    AutoReplace = false;
    AutoSave = false;
    AutoUpdate = false;
    XmlName = 'SalesStat';

    textelement(xSPName)
    {
    }
    textelement(xSPCode)
    {
    }
    textelement(xProfit0901)
    {
    }
    textelement(xProfit0902)
    {
    }
    textelement(xProfit0903)
    {
    }
    textelement(xProfit0904)
    {
    }
    textelement(xProfit0905)
    {
    }
    textelement(xProfit0906)
    {
    }
    textelement(xProfit0907)
    {
    }
    textelement(xProfit0908)
    {
    }
    textelement(xProfit0909)
    {
    }
    textelement(xProfit0910)
    {
    }
    textelement(xProfit0911)
    {
    }
    textelement(xProfit0912)
    {
    }
    textelement(xProfit1001)
    {
    }
    textelement(xProfit1002)
    {
    }
    textelement(xProfit1003)
    {
    }
    textelement(xProfit1004)
    {
    }
    textelement(xProfit1005)
    {
    }
    textelement(xProfit1006)
    {
    }
    textelement(xProfit1007)
    {
    }
    textelement(xProfit1008)
    {
    }
    textelement(xProfit1009)
    {
    }
    textelement(xProfit1010)
    {
    }
    textelement(xProfit1011)
    {
    }
    textelement(xProfit1012)
    {
    }
    textelement(xProfit1101)
    {
    }
    textelement(xProfit1102)
    {
    }
    textelement(xProfit1103)
    {
    }
    textelement(xProfit1104)
    {
    }
    textelement(xProfit1105)
    {
    }
    textelement(xProfit1106)
    {
    }
    textelement(xProfit1107)
    {
    }
    textelement(xProfit1108)
    {
    }
    textelement(xProfit1109)
    {
    }
    textelement(xProfit1110)
    {
    }
    textelement(xProfit1111)
    {
    }
    textelement(xProfit1112)
    {
    }
    textelement(xProfit1201)
    {
    }
    textelement(xProfit1202)
    {
    }
    textelement(xProfit1203)
    {
    }
    textelement(xProfit1204)
    {
    }
    textelement(xProfit1205)
    {
    }
    textelement(xProfit1206)
    {
    }
    textelement(xProfit1207)
    {
    }
    textelement(xProfit1208)
    {
    }
    textelement(xProfit1209)
    {
    }
    textelement(xProfit1210)
    {
    }
    textelement(xProfit1211)
    {
    }
    textelement(xProfit1212)
    {
    }
    trigger OnAfterInitRecord()
    begin
        ClearVars;
    end;
    trigger OnBeforeInsertRecord()
    begin
        if xSPCode <> '' then SalesPerson.Get(xSPCode);
        CreateEntry(20090101D, xProfit0901);
        CreateEntry(20090201D, xProfit0902);
        CreateEntry(20090301D, xProfit0903);
        CreateEntry(20090401D, xProfit0904);
        CreateEntry(20090501D, xProfit0905);
        CreateEntry(20090601D, xProfit0906);
        CreateEntry(20090701D, xProfit0907);
        CreateEntry(20090801D, xProfit0908);
        CreateEntry(20090901D, xProfit0909);
        CreateEntry(20091001D, xProfit0910);
        CreateEntry(20091101D, xProfit0911);
        CreateEntry(20091201D, xProfit0912);
        CreateEntry(20100101D, xProfit1001);
        CreateEntry(20100201D, xProfit1002);
        CreateEntry(20100301D, xProfit1003);
        CreateEntry(20100401D, xProfit1004);
        CreateEntry(20100501D, xProfit1005);
        CreateEntry(20100601D, xProfit1006);
        CreateEntry(20100701D, xProfit1007);
        CreateEntry(20100801D, xProfit1008);
        CreateEntry(20100901D, xProfit1009);
        CreateEntry(20101001D, xProfit1010);
        CreateEntry(20101101D, xProfit1011);
        CreateEntry(20101201D, xProfit1012);
        CreateEntry(20110101D, xProfit1101);
        CreateEntry(20110201D, xProfit1102);
        CreateEntry(20110301D, xProfit1103);
        CreateEntry(20110401D, xProfit1104);
        CreateEntry(20110501D, xProfit1105);
        CreateEntry(20110601D, xProfit1106);
        CreateEntry(20110701D, xProfit1107);
        CreateEntry(20110801D, xProfit1108);
        CreateEntry(20110901D, xProfit1109);
        CreateEntry(20111001D, xProfit1110);
        CreateEntry(20111101D, xProfit1111);
        CreateEntry(20111201D, xProfit1112);
        CreateEntry(20120101D, xProfit1201);
        CreateEntry(20120201D, xProfit1202);
        CreateEntry(20120301D, xProfit1203);
        CreateEntry(20120401D, xProfit1204);
        CreateEntry(20120501D, xProfit1205);
        CreateEntry(20120601D, xProfit1206);
        CreateEntry(20120701D, xProfit1207);
        CreateEntry(20120801D, xProfit1208);
        CreateEntry(20120901D, xProfit1209);
        CreateEntry(20121001D, xProfit1210);
        CreateEntry(20121101D, xProfit1211);
        CreateEntry(20121201D, xProfit1212);
    end;
    }
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
    trigger OnPreXmlPort()
    begin
        SalesStat.LockTable;
        if SalesStat.FindLast then NextEntryNo:=SalesStat."Entry No." + 1
        else
            NextEntryNo:=1;
    end;
    var SalesPerson: Record "Salesperson/Purchaser";
    NextEntryNo: Integer;
    procedure ClearVars()
    begin
        Clear(xSPName);
        Clear(xSPCode);
        Clear(xProfit0901);
        Clear(xProfit0902);
        Clear(xProfit0903);
        Clear(xProfit0904);
        Clear(xProfit0905);
        Clear(xProfit0906);
        Clear(xProfit0907);
        Clear(xProfit0908);
        Clear(xProfit0909);
        Clear(xProfit0910);
        Clear(xProfit0911);
        Clear(xProfit0912);
        Clear(xProfit1001);
        Clear(xProfit1002);
        Clear(xProfit1003);
        Clear(xProfit1004);
        Clear(xProfit1005);
        Clear(xProfit1006);
        Clear(xProfit1007);
        Clear(xProfit1008);
        Clear(xProfit1009);
        Clear(xProfit1010);
        Clear(xProfit1011);
        Clear(xProfit1012);
        Clear(xProfit1101);
        Clear(xProfit1102);
        Clear(xProfit1103);
        Clear(xProfit1104);
        Clear(xProfit1105);
        Clear(xProfit1106);
        Clear(xProfit1107);
        Clear(xProfit1108);
        Clear(xProfit1109);
        Clear(xProfit1110);
        Clear(xProfit1111);
        Clear(xProfit1112);
        Clear(xProfit1201);
        Clear(xProfit1202);
        Clear(xProfit1203);
        Clear(xProfit1204);
        Clear(xProfit1205);
        Clear(xProfit1206);
        Clear(xProfit1207);
        Clear(xProfit1208);
        Clear(xProfit1209);
        Clear(xProfit1210);
        Clear(xProfit1211);
        Clear(xProfit1212);
    end;
    procedure CreateEntry(DateIn: Date; ProfitIn: Text[100])
    var
        ProfitDec: Decimal;
    begin
        if ProfitIn = '' then ProfitIn:='0';
        Evaluate(ProfitDec, ProfitIn);
        if ProfitDec = 0 then exit;
        SalesStat.Init;
        SalesStat."Entry No.":=NextEntryNo;
        NextEntryNo+=1;
        SalesStat.Expected:=false;
        SalesStat."Posting Date":=DateIn;
        SalesStat."Salesperson Code":=xSPCode;
        SalesStat."Profit Amount":=ProfitDec;
        SalesStat.Historical:=true;
        SalesStat.Insert;
    end;
}
