codeunit 50001 "Sales Statistics Management"
{
    // Notes:
    //   If multi-currency is used, need to calculate Sales Amounts in Local Currency
    // 
    // Things to test:
    //   - Works properly with unposted Invoices/Credit Memos?
    //   - Partial Invoiced Sales Orders
    //   - Profit on Credit Memos correct?
    // 
    // Stats will be updated:
    //   - On Release
    //   - On Posting
    trigger OnRun()
    begin
        // Leave this line disabled; dangerous
        // If Posted Documents have been deleted Refresh will not be complete
        RefreshAllDocuments(true, true);
    end;

    var
        SalesStat: Record "Sales Statistic Entry";
        SalesStatTemp: Record "Sales Statistic Entry" temporary;
        NextTempEntryNo: Integer;

    procedure AccumulateStat(SalesLine: Record "Sales Line"; DocType: Integer; SalespersonCode: Code[20]; LeadSourceCode: Code[10])
    begin
        // Check for matching entry
        SalesStatTemp.Reset;
        SalesStatTemp.SetCurrentKey("Document No.");
        SalesStatTemp.SetRange("Document No.", SalesLine."Document No.");
        SalesStatTemp.SetRange("Document Type", DocType);
        SalesStatTemp.SetRange(Historical, false);
        if not SalesStatTemp.FindFirst then begin
            // Create new entry
            SalesStatTemp.Init;
            SalesStatTemp."Entry No." := NextTempEntryNo;
            NextTempEntryNo += 1;
            SalesStatTemp.Expected := (DocType <= SalesStatTemp."Document Type"::"Return Order");
            SalesStatTemp."Document No." := SalesLine."Document No.";
            SalesStatTemp."Document Type" := DocType;
            SalesStatTemp."Posting Date" := SalesLine."Shipment Date";
            SalesStatTemp."Bill-to Customer No." := SalesLine."Bill-to Customer No.";
            SalesStatTemp."Sell-to Customer No." := SalesLine."Sell-to Customer No.";
            SalesStatTemp."Location Code" := SalesLine."Location Code";
            SalesStatTemp."Salesperson Code" := SalespersonCode;
            SalesStatTemp."Item Category Code" := SalesLine."Item Category Code";
            SalesStatTemp."Lead Source Code" := LeadSourceCode;
            SalesStatTemp.Insert;
            SalesStatTemp."Sales Amount" += SalesLine.Amount;
            SalesStatTemp."Cost Amount" += (SalesLine."Unit Cost (LCY)" * SalesLine.Quantity);
            SalesStatTemp.Modify;
        end;
    end;

    procedure DeleteStats(DocType: Integer; DocNo: Code[20])
    begin
        SalesStat.Reset;
        SalesStat.SetCurrentKey("Document No.");
        SalesStat.SetRange("Document No.", DocNo);
        SalesStat.SetRange("Document Type", DocType);
        SalesStat.SetRange(Historical, false);
        if not SalesStat.IsEmpty then SalesStat.DeleteAll;
    end;

    procedure DeleteTempStats()
    begin
        SalesStatTemp.Reset;
        SalesStatTemp.DeleteAll;
        NextTempEntryNo := 1;
    end;

    procedure CommitTempStats()
    begin
        SalesStatTemp.Reset;
        if SalesStatTemp.FindSet(false) then
            repeat
                SalesStat := SalesStatTemp;
                SalesStat."Entry No." := NextStatEntryNo;
                SalesStat."Profit Amount" := SalesStat."Sales Amount" - SalesStat."Cost Amount";
                SalesStat.Insert;
            until SalesStatTemp.Next = 0;
    end;

    procedure NextStatEntryNo() EntryNo: Integer
    var
        SalesStatNext: Record "Sales Statistic Entry";
    begin
        SalesStatNext.Reset;
        if SalesStatNext.FindLast then
            exit(SalesStatNext."Entry No." + 1)
        else
            exit(1);
    end;

    procedure UpdateStatSalesDoc(SalesHeader: Record "Sales Header"; DelDoc: Boolean)
    var
        SalesStat: Record "Sales Statistic Entry";
        SalesLine: Record "Sales Line";
        UninvPercent: Decimal;
    begin
        // Delete any existing entries for this Document
        DeleteStats(SalesHeader."Document Type", SalesHeader."No.");
        // If deleting Doc then no need to calculate
        if DelDoc then exit;
        DeleteTempStats;
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet(false) then
            repeat // Only include uninvoiced
                Clear(UninvPercent);
                if SalesLine.Quantity <> 0 then UninvPercent := (SalesLine.Quantity - SalesLine."Quantity Invoiced") / SalesLine.Quantity;
                SalesLine.Amount := SalesLine.Amount * UninvPercent;
                SalesLine.Quantity := SalesLine.Quantity - SalesLine."Quantity Invoiced";
                if SalesLine."Document Type" in [SalesLine."Document Type"::"Credit Memo"] then begin
                    // Reverse Amounts for Credit Memos
                    SalesLine.Amount := -SalesLine.Amount;
                    SalesLine.Quantity := -SalesLine.Quantity;
                end;
                SalesLine."Shipment Date" := SalesHeader."Posting Date";
                AccumulateStat(SalesLine, SalesLine."Document Type", SalesHeader."Salesperson Code", SalesHeader."Lead Source Code");
            until SalesLine.Next = 0;
        CommitTempStats;
    end;

    procedure UpdateStatPostedInv(SalesInvHeader: Record "Sales Invoice Header")
    var
        SalesStat: Record "Sales Statistic Entry";
        SalesInvLine: Record "Sales Invoice Line";
        SalesLine: Record "Sales Line";
        DocType: Integer;
    begin
        DocType := SalesStat."Document Type"::"P. Invoice";
        // Delete any existing entries for this Document
        DeleteStats(DocType, SalesInvHeader."No.");
        DeleteTempStats;
        SalesInvLine.Reset;
        SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
        if SalesInvLine.FindSet(false) then
            repeat
                SalesLine.TransferFields(SalesInvLine);
                SalesLine."Shipment Date" := SalesInvHeader."Posting Date";
                AccumulateStat(SalesLine, DocType, SalesInvHeader."Salesperson Code", SalesInvHeader."Lead Source Code");
            until SalesInvLine.Next = 0;
        CommitTempStats;
    end;

    procedure UpdateStatPostedCrMemo(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        SalesStat: Record "Sales Statistic Entry";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesLine: Record "Sales Line";
        DocType: Integer;
    begin
        DocType := SalesStat."Document Type"::"P. Cr. Memo";
        // Delete any existing entries for this Document
        DeleteStats(DocType, SalesCrMemoHeader."No.");
        DeleteTempStats;
        SalesCrMemoLine.Reset;
        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        if SalesCrMemoLine.FindSet(false) then
            repeat
                SalesLine.TransferFields(SalesCrMemoLine);
                SalesLine."Shipment Date" := SalesCrMemoHeader."Posting Date";
                // Reverse Amounts for Credit Memos
                SalesLine.Amount := -SalesLine.Amount;
                SalesLine.Quantity := -SalesLine.Quantity;
                AccumulateStat(SalesLine, DocType, SalesCrMemoHeader."Salesperson Code", SalesCrMemoHeader."Lead Source Code");
            until SalesCrMemoLine.Next = 0;
        CommitTempStats;
    end;

    procedure RefreshAllDocuments(Expected: Boolean; Invoiced: Boolean)
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesHeader: Record "Sales Header";
        PBMgt: Codeunit "Progress Bar Management";
    begin
        //ERROR('Please enable function.');
        PBMgt.OpenWindow('Refreshing Statistics...');
        if Expected and Invoiced then begin
            SalesStat.Reset;
            SalesStat.SetRange(Historical, false);
            SalesStat.DeleteAll;
        end;
        if Invoiced then begin
            if not Expected then begin
                SalesStat.Reset;
                SalesStat.SetCurrentKey(Expected);
                SalesStat.SetRange(Expected, false);
                SalesStat.SetRange(Historical, false);
                SalesStat.DeleteAll;
            end;
            SalesInvHeader.Reset;
            if SalesInvHeader.FindSet(false) then
                repeat
                    UpdateStatPostedInv(SalesInvHeader);
                until SalesInvHeader.Next = 0;
            SalesCrMemoHeader.Reset;
            if SalesCrMemoHeader.FindSet(false) then
                repeat
                    UpdateStatPostedCrMemo(SalesCrMemoHeader);
                until SalesCrMemoHeader.Next = 0;
        end;
        if Expected then begin
            if not Invoiced then begin
                SalesStat.Reset;
                SalesStat.SetCurrentKey(Expected);
                SalesStat.SetRange(Expected, true);
                SalesStat.SetRange(Historical, false);
                SalesStat.DeleteAll;
            end;
            SalesHeader.Reset;
            if SalesHeader.FindSet(false) then
                repeat
                    if SalesHeader.Status = SalesHeader.Status::Released then UpdateStatSalesDoc(SalesHeader, false);
                until SalesHeader.Next = 0;
        end;
        PBMgt.CloseWindow;
        Message('Statistics have been refreshed.');
    end;
}
