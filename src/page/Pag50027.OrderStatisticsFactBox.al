page 50027 "Order Statistics FactBox"
{
    // IMP1.01,04/12/16,ST: Created new page.
    Caption = 'Order Statistics';
    PageType = CardPart;
    SourceTable = "Sales Header";

    layout
    {
        area(content)
        {
            field("TotalAmount2[1]"; TotalAmount2[1])
            {
                ApplicationArea = All;
                AutoFormatExpression = Rec."Currency Code";
                AutoFormatType = 1;
                CaptionClass = GetCaptionClass(Text001, true);
                Editable = false;
            }
            field("TotalAdjCostLCY[1]"; TotalAdjCostLCY[1])
            {
                ApplicationArea = All;
                AutoFormatType = 1;
                Caption = 'Adjusted Cost (LCY)';
                Editable = false;
            }
            field("AdjProfitLCY[1]"; AdjProfitLCY[1])
            {
                ApplicationArea = All;
                AutoFormatType = 1;
                Caption = 'Adjusted Profit (LCY)';
                Editable = false;
            }
            field("AdjProfitPct[1]"; AdjProfitPct[1])
            {
                ApplicationArea = All;
                Caption = 'Adjusted Profit %';
                DecimalPlaces = 1: 1;
                Editable = false;
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
    begin
        Clear(SalesLine);
        Clear(TotalSalesLine);
        Clear(TotalSalesLineLCY);
        Clear(TotalAmount2);
        Clear(TotalAdjCostLCY);
        Clear(AdjProfitLCY);
        Clear(AdjProfitPct);
        for i:=1 to 3 do begin
            TempSalesLine.DeleteAll;
            Clear(TempSalesLine);
            Clear(SalesPost);
            SalesPost.GetSalesLines(Rec, TempSalesLine, i - 1);
            Clear(SalesPost);
            case i of 1: SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine1);
            2: SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine2);
            3: SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine3);
            end;
            SalesPost.SumSalesLinesTemp(Rec, TempSalesLine, i - 1, TotalSalesLine[i], TotalSalesLineLCY[i], VATAmount[i], VATAmountText[i], ProfitLCY[i], ProfitPct[i], TotalAdjCostLCY[i]);
            if i = 3 then TotalAdjCostLCY[i]:=TotalSalesLineLCY[i]."Unit Cost (LCY)";
            AdjProfitLCY[i]:=TotalSalesLineLCY[i].Amount - TotalAdjCostLCY[i];
            if TotalSalesLineLCY[i].Amount <> 0 then AdjProfitPct[i]:=Round(AdjProfitLCY[i] / TotalSalesLineLCY[i].Amount * 100, 0.1);
            if Rec."Prices Including VAT" then begin
                TotalAmount2[i]:=TotalSalesLine[i].Amount;
            end
            else
            begin
                TotalAmount2[i]:=TotalSalesLine[i]."Amount Including VAT";
            end;
        end;
        TempSalesLine.DeleteAll;
        Clear(TempSalesLine);
    end;
    var Text001: Label 'Total';
    TotalAmount2: array[3]of Decimal;
    TotalAdjCostLCY: array[3]of Decimal;
    AdjProfitLCY: array[3]of Decimal;
    AdjProfitPct: array[3]of Decimal;
    i: Integer;
    SalesSetup: Record "Sales & Receivables Setup";
    SalesPost: Codeunit "Sales-Post";
    TotalSalesLine: array[3]of Record "Sales Line";
    TotalSalesLineLCY: array[3]of Record "Sales Line";
    TempVATAmountLine1: Record "VAT Amount Line" temporary;
    TempVATAmountLine2: Record "VAT Amount Line" temporary;
    TempVATAmountLine3: Record "VAT Amount Line" temporary;
    TempVATAmountLine4: Record "VAT Amount Line" temporary;
    VATAmount: array[3]of Decimal;
    PrepmtTotalAmount: Decimal;
    PrepmtVATAmount: Decimal;
    PrepmtTotalAmount2: Decimal;
    VATAmountText: array[3]of Text[30];
    PrepmtVATAmountText: Text[30];
    ProfitLCY: array[3]of Decimal;
    ProfitPct: array[3]of Decimal;
    procedure ShowDetails()
    begin
    end;
    local procedure GetCaptionClass(FieldCaption: Text[100]; ReverseCaption: Boolean): Text[80]begin
        if Rec."Prices Including VAT" xor ReverseCaption then exit('2,1,' + FieldCaption);
        exit('2,0,' + FieldCaption);
    end;
}
