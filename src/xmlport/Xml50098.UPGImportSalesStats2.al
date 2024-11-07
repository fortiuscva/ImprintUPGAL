xmlport 50098 "UPG Import Sales Stats 2"
{
    Direction = Import;
    FieldDelimiter = '"';
    Format = VariableText;
    UseRequestPage = false;

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

    textelement(xNewCode)
    {
    }
    textelement(xCodeDel)
    {
    }
    textelement(xOldCode)
    {
    }
    textelement(xStartDate)
    {
    }
    textelement(xSales)
    {
    }
    textelement(xCost)
    {
    }
    textelement(xProfit)
    {
    }
    trigger OnAfterInitRecord()
    begin
        ClearVars;
    end;
    trigger OnBeforeInsertRecord()
    begin
        SalesStat."Entry No.":=NextEntryNo;
        NextEntryNo+=1;
        if NextEntryNo >= 5000 then Error('Too many entries for import.');
        if xCodeDel = 'FALSE' then SalesStat.Validate("Salesperson Code", xNewCode)
        else
            SalesStat."Salesperson Code":=xNewCode;
        Evaluate(SalesStat."Posting Date", xStartDate);
        Evaluate(SalesStat."Sales Amount", xSales);
        Evaluate(SalesStat."Cost Amount", xCost);
        Evaluate(SalesStat."Profit Amount", xProfit);
        SalesStat.Historical:=true;
        SalesStat.Insert;
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
    trigger OnPostXmlPort()
    begin
        Message('Import complete.');
    end;
    trigger OnPreXmlPort()
    begin
        NextEntryNo:=1;
    end;
    var NextEntryNo: Integer;
    procedure SetBlankToZero(var TextIn: Text[1000])
    begin
        if TextIn = '' then TextIn:='0';
    end;
    procedure ClearVars()
    begin
        Clear(xNewCode);
        Clear(xOldCode);
        Clear(xStartDate);
        Clear(xCodeDel);
        Clear(xSales);
        Clear(xCost);
        Clear(xProfit);
    end;
}
