xmlport 50091 "Open AR Import"
{
    schema
    {
    textelement(Root)
    {
    tableelement(Integer;
    Integer)
    {
    AutoReplace = false;
    AutoSave = false;
    AutoUpdate = false;
    XmlName = 'CustLedger';

    textelement(xbilltocustno)
    {
    XmlName = 'BillCustNo';
    }
    textelement(xpostingdate)
    {
    XmlName = 'PostingDate';
    }
    textelement(xdoctype)
    {
    XmlName = 'DocType';
    }
    textelement(xdocno)
    {
    XmlName = 'DocNo';
    }
    textelement(xextdocno)
    {
    XmlName = 'ExtDocNo';
    }
    textelement(xdescription)
    {
    XmlName = 'Description';
    }
    textelement(xamount)
    {
    XmlName = 'Amount';
    }
    textelement(xremamount)
    {
    XmlName = 'RemAmount';
    }
    textelement(xselltocustno)
    {
    XmlName = 'SellToCust';
    }
    textelement(xsalespersoncode)
    {
    XmlName = 'SalespersonCode';
    }
    trigger OnAfterInitRecord()
    begin
        ClearVars;
    end;
    trigger OnBeforeInsertRecord()
    begin
        GenJnl.Init;
        GenJnl."Journal Template Name":=JnlTemplate;
        GenJnl."Journal Batch Name":=JnlBatch;
        GenJnl."Line No.":=NextLineNo;
        NextLineNo+=10000;
        GenJnl.Insert(true);
        Evaluate(GenJnl."Posting Date", xPostingDate);
        GenJnl.Validate("Posting Date");
        Evaluate(GenJnl."Document Type", xDocType);
        GenJnl.Validate("Document Type");
        GenJnl.Validate("Document No.", xDocNo);
        GenJnl.Validate("External Document No.", xExtDocNo);
        GenJnl.Validate("Account Type", GenJnl."Account Type"::Customer);
        GenJnl.Validate("Account No.", xBillToCustNo);
        GenJnl.Validate("Bal. Account Type", GenJnl."Bal. Account Type"::"G/L Account");
        GenJnl.Validate("Bal. Account No.", OpenARAccount);
        Evaluate(GenJnl.Amount, xRemAmount);
        GenJnl.Validate(Amount);
        Clear(OrigAmountText);
        if xAmount <> xRemAmount then OrigAmountText:=' (OrigAmt: ' + Format(xAmount) + ')';
        GenJnl.Validate(Description, CopyStr(xDescription + OrigAmountText, 1, 50));
        GenJnl.Modify(true);
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
        GenJnl.Reset;
        GenJnl.SetRange("Journal Template Name", JnlTemplate);
        GenJnl.SetRange("Journal Batch Name", JnlBatch);
        GenJnl.DeleteAll(true);
        NextLineNo:=10000;
    end;
    var GenJnl: Record "Gen. Journal Line";
    JnlTemplate: Label 'SALES';
    JnlBatch: Label 'ARIMPORT';
    NextLineNo: Integer;
    OpenARAccount: Label '11100';
    OrigAmountText: Text[50];
    procedure ClearVars()
    begin
        Clear(xBillToCustNo);
        Clear(xPostingDate);
        Clear(xDocType);
        Clear(xDocNo);
        Clear(xExtDocNo);
        Clear(xDescription);
        Clear(xAmount);
        Clear(xRemAmount);
        Clear(xSellToCustNo);
        Clear(xSalespersonCode);
    end;
}
