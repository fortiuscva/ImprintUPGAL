report 60011 "Cash Applied Ext"
{
    // version NAVNA14.00
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/Cash Applied.rdl';
    CaptionML = ENU = 'Cash Applied', ESM = 'Efectivo aplicado', FRC = 'Montant comptant affecté', ENC = 'Cash Applied';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Document Type", "Customer No.", "Posting Date") WHERE("Document Type" = CONST(Payment));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Global Dimension 2 Code", "Salesperson Code", "Customer No.";

            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(Time; Time)
            {
            }
            column(CompanyInfoName; CompanyInformation.Name)
            {
            }
            column(DocType_CustLedgEntry; "Cust. Ledger Entry"."Document Type")
            {
            }
            column(CustLedgerEntryFilterString; "Cust. Ledger Entry".TableName + ': ' + FilterString)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(GetTotalApplied; GetTotalApplied)
            {
            }
            column(GetTotalDiscounts; GetTotalDiscounts)
            {
            }
            column(TotalApplied; TotalApplied)
            {
            }
            column(CustNo_CustLedgerEntry; "Customer No.")
            {
            }
            column(CustomerName; Customer.Name)
            {
            }
            column(DocNo_CustLedgEntry; "Document No.")
            {
            }
            column(PostingDate_CustLedgEntry; "Posting Date")
            {
            }
            column(NegativeAmountLCY_CustLedgEntry; -"Amount (LCY)")
            {
            }
            column(NegativeAmtLCY_CustLedgEntry; -"Cust. Ledger Entry"."Amount (LCY)")
            {
            }
            column(TotalDiscounts; TotalDiscounts)
            {
            }
            column(TotalApplied_CustLedgEntry; -"Cust. Ledger Entry"."Amount (LCY)" - TotalApplied)
            {
            }
            column(TotalAmountt; TotalAmout)
            {
            }
            column(EntryNo_CustLedgEntry; "Entry No.")
            {
            }
            column(CashRecptAppliedCaption; CashRecptAppliedCaptionLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(PaymentCaption; PaymentCaptionLbl)
            {
            }
            column(AppliedToDocCaption; AppliedToDocCaptionLbl)
            {
            }
            column(DiscountDateCaption; DiscountDateCaptionLbl)
            {
            }
            column(DiscountTakenCaption; DiscountTakenCaptionLbl)
            {
            }
            column(AmountAppliedCaption; AmtAppliedCaptionLbl)
            {
            }
            column(AmtNotYetAppliedCaption; AmtNotYetAppliedCaptionLbl)
            {
            }
            column(NumberCaption; NumberCaptionLbl)
            {
            }
            column(PostDateCaption_CustLedgEntry; FieldCaption("Posting Date"))
            {
            }
            column(TypeCaption; TypeCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(AmountLCYCaption; AmountLCYCaptionLbl)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(ReportTotalsCaption; ReportTotalsCaptionLbl)
            {
            }
            dataitem(AppliedEntries; "Integer")
            {
                DataItemTableView = SORTING(Number);

                column(TempAppliedCustLedgEntryDocType; Format(TempAppliedCustLedgEntry."Document Type"))
                {
                }
                column(TempAppliedCustLedgEntryDocNo; TempAppliedCustLedgEntry."Document No.")
                {
                }
                column(TempAppliedCustLedgEntryDueDate; TempAppliedCustLedgEntry."Due Date")
                {
                }
                column(TempAppliedCustLedgEntryPmtDisDate; TempAppliedCustLedgEntry."Pmt. Discount Date")
                {
                }
                column(TempAppliedCustLedgEntryPmtDiscGivenLCY; TempAppliedCustLedgEntry."Pmt. Disc. Given (LCY)")
                {
                }
                column(TempAppliedCustLedgEntryAmttoApply; TempAppliedCustLedgEntry."Amount to Apply")
                {
                }
                column(CustLedgerEntryAmtLCYTotalApplied; -"Cust. Ledger Entry"."Amount (LCY)" - TotalApplied)
                {
                }
                trigger OnAfterGetRecord();
                begin
                    if Number = 1 then
                        TempAppliedCustLedgEntry.Find('-')
                    else
                        TempAppliedCustLedgEntry.Next;
                    TotalApplied := TotalApplied + TempAppliedCustLedgEntry."Amount to Apply";
                    TotalDiscounts := TotalDiscounts + TempAppliedCustLedgEntry."Pmt. Disc. Given (LCY)";
                    GetTotalApplied := GetTotalApplied + TempAppliedCustLedgEntry."Amount to Apply";
                    GetTotalDiscounts := GetTotalDiscounts + TempAppliedCustLedgEntry."Pmt. Disc. Given (LCY)";
                end;

                trigger OnPreDataItem();
                begin
                    TempAppliedCustLedgEntry.SetFilter("Salesperson Code", SalespersonFilterString);
                    SetRange(Number, 1, TempAppliedCustLedgEntry.Count);
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            }
            trigger OnAfterGetRecord();
            begin
                TotalApplied := 0;
                TotalDiscounts := 0;
                CalcFields("Amount (LCY)");
                EntryAppMgt.GetAppliedCustEntries(TempAppliedCustLedgEntry, "Cust. Ledger Entry", true);
                if OldCustomerno <> "Customer No." then begin
                    if not Customer.Get("Customer No.") then
                        Clear(Customer)
                    else
                        OldCustomerno := "Customer No.";
                end;
                TotalAmout := TotalAmout + "Amount (LCY)";
            end;

            trigger OnPreDataItem();
            begin
                Clear(TotalApplied);
                Clear(TotalDiscounts);
                //IMP1.01 Start
                //Base Code Commented
                /*
                    SETRANGE("Salesperson Code");
                    */
                //IMP1.01 End
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport();
    begin
        CompanyInformation.Get;
        FilterString := "Cust. Ledger Entry".GetFilters;
        SalespersonFilterString := "Cust. Ledger Entry".GetFilter("Salesperson Code");
    end;

    var
        FilterString: Text;
        SalespersonFilterString: Text;
        TotalApplied: Decimal;
        TotalDiscounts: Decimal;
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        TempAppliedCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        EntryAppMgt: Codeunit "Entry Application Management";
        OldCustomerno: Code[20];
        TotalAmout: Decimal;
        GetTotalApplied: Decimal;
        GetTotalDiscounts: Decimal;
        CashRecptAppliedCaptionLbl: TextConst ENU = 'Cash Receipts Applied', ESM = 'Recibos de cobro liquidados', FRC = 'Encaissements affectés', ENC = 'Cash Receipts Applied';
        PageNoCaptionLbl: TextConst ENU = 'Page', ESM = 'Pág.', FRC = 'Page', ENC = 'Page';
        PaymentCaptionLbl: TextConst ENU = 'Payment', ESM = 'Pago', FRC = 'Paiement', ENC = 'Payment';
        AppliedToDocCaptionLbl: TextConst ENU = 'Applied-To Document', ESM = 'Aplicado a documento', FRC = 'Document affecté à', ENC = 'Applied-To Document';
        DiscountDateCaptionLbl: TextConst ENU = 'Discount Date', ESM = 'Fecha descuento', FRC = 'Date d''escompte', ENC = 'Discount Date';
        DiscountTakenCaptionLbl: TextConst ENU = 'Discount Taken', ESM = 'Descuento realizado', FRC = 'Escompte pris', ENC = 'Discount Taken';
        AmtAppliedCaptionLbl: TextConst ENU = 'Amount Applied', ESM = 'Importe liquidado', FRC = 'Montant appliqué', ENC = 'Amount Applied';
        AmtNotYetAppliedCaptionLbl: TextConst ENU = 'Amount Not Yet Applied', ESM = 'Importe aún no liquidado', FRC = 'Montant non encore affecté', ENC = 'Amount Not Yet Applied';
        NumberCaptionLbl: TextConst ENU = 'Number', ESM = 'Número', FRC = 'Numéro', ENC = 'Number';
        TypeCaptionLbl: TextConst ENU = 'Type', ESM = 'Tipo', FRC = 'Type', ENC = 'Type';
        DueDateCaptionLbl: TextConst ENU = 'Due Date', ESM = 'Fecha vencimiento', FRC = 'Date d''échéance', ENC = 'Due Date';
        AmountLCYCaptionLbl: TextConst ENU = 'Payment Amount', ESM = 'Importe pago', FRC = 'Montant règlement', ENC = 'Payment Amount';
        CustomerCaptionLbl: TextConst ENU = 'Customer:', ESM = 'Cliente:', FRC = 'Client :', ENC = 'Customer:';
        ReportTotalsCaptionLbl: TextConst ENU = 'Report Totals', ESM = 'Totales de informe', FRC = 'Totaux de rapport', ENC = 'Report Totals';
}
