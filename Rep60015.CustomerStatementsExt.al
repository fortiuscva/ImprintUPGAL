report 60015 "Customer Statements Ext"
{
    // version NAVNA14.06
    DefaultLayout = RDLC;
    RDLCLayout = './Customer Statements.rdl';
    CaptionML = ENU = 'Customer Statements', ESM = 'Estados de cuenta de cliente', FRC = 'Relevés client', ENC = 'Customer Statements';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Print Statements", "Date Filter";

            column(Customer_No_; "No.")
            {
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            dataitem(HeaderFooter; "Integer")
            {
                DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                column(CompanyInfo2Picture; CompanyInfo2.Picture)
                {
                }
                column(CompanyInfo1Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfoPicture; CompanyInfo3.Picture)
                {
                }
                column(CompanyAddress_1_; CompanyAddress[1])
                {
                }
                column(CompanyAddress_2_; CompanyAddress[2])
                {
                }
                column(CompanyAddress_3_; CompanyAddress[3])
                {
                }
                column(CompanyAddress_4_; CompanyAddress[4])
                {
                }
                column(CompanyAddress_5_; CompanyAddress[5])
                {
                }
                column(ToDate; ToDate)
                {
                }
                column(CompanyAddress_6_; CompanyAddress[6])
                {
                }
                column(Customer__No__; Customer."No.")
                {
                }
                column(CurrReport_PAGENO; CurrReport.PageNo)
                {
                }
                column(CustomerAddress_1_; CustomerAddress[1])
                {
                }
                column(CustomerAddress_2_; CustomerAddress[2])
                {
                }
                column(CustomerAddress_3_; CustomerAddress[3])
                {
                }
                column(CustomerAddress_4_; CustomerAddress[4])
                {
                }
                column(CustomerAddress_5_; CustomerAddress[5])
                {
                }
                column(CustomerAddress_6_; CustomerAddress[6])
                {
                }
                column(CustomerAddress_7_; CustomerAddress[7])
                {
                }
                column(CompanyAddress_7_; CompanyAddress[7])
                {
                }
                column(CompanyAddress_8_; CompanyAddress[8])
                {
                }
                column(CustomerAddress_8_; CustomerAddress[8])
                {
                }
                column(CurrencyDesc; CurrencyDesc)
                {
                }
                column(AgingMethod_Int; AgingMethod_Int)
                {
                }
                column(StatementStyle_Int; StatementStyle_Int)
                {
                }
                column(printfooter3ornot;(AgingMethod <> AgingMethod::None) and StatementComplete)
                {
                }
                column(DebitBalance; DebitBalance)
                {
                }
                column(CreditBalance;-CreditBalance)
                {
                }
                column(BalanceToPrint; BalanceToPrint)
                {
                }
                column(DebitBalance_Control22; DebitBalance)
                {
                }
                column(CreditBalance_Control23;-CreditBalance)
                {
                }
                column(BalanceToPrint_Control24; BalanceToPrint)
                {
                }
                column(AgingDaysText; AgingDaysText)
                {
                }
                column(AgingHead_1_; AgingHead[1])
                {
                }
                column(AgingHead_2_; AgingHead[2])
                {
                }
                column(AgingHead_3_; AgingHead[3])
                {
                }
                column(AgingHead_4_; AgingHead[4])
                {
                }
                column(AmountDue_1_; AmountDue[1])
                {
                }
                column(AmountDue_2_; AmountDue[2])
                {
                }
                column(AmountDue_3_; AmountDue[3])
                {
                }
                column(AmountDue_4_; AmountDue[4])
                {
                }
                column(TempAmountDue_1_; TempAmountDue[1])
                {
                }
                column(TempAmountDue_3_; TempAmountDue[3])
                {
                }
                column(TempAmountDue_2_; TempAmountDue[2])
                {
                }
                column(TempAmountDue_4_; TempAmountDue[4])
                {
                }
                column(HeaderFooter_Number; Number)
                {
                }
                column(STATEMENTCaption; STATEMENTCaptionLbl)
                {
                }
                column(Statement_Date_Caption; Statement_Date_CaptionLbl)
                {
                }
                column(Account_Number_Caption; Account_Number_CaptionLbl)
                {
                }
                column(Page_Caption; Page_CaptionLbl)
                {
                }
                column(RETURN_THIS_PORTION_OF_STATEMENT_WITH_YOUR_PAYMENT_Caption; RETURN_THIS_PORTION_OF_STATEMENT_WITH_YOUR_PAYMENT_CaptionLbl)
                {
                }
                column(Amount_RemittedCaption; Amount_RemittedCaptionLbl)
                {
                }
                column(TempCustLedgEntry__Document_No__Caption; TempCustLedgEntry__Document_No__CaptionLbl)
                {
                }
                column(TempCustLedgEntry__Posting_Date_Caption; TempCustLedgEntry__Posting_Date_CaptionLbl)
                {
                }
                column(GetTermsString_TempCustLedgEntry_Caption; GetTermsString_TempCustLedgEntry_CaptionLbl)
                {
                }
                column(TempCustLedgEntry__Document_Type_Caption; TempCustLedgEntry__Document_Type_CaptionLbl)
                {
                }
                column(TempCustLedgEntry__Remaining_Amount_Caption; TempCustLedgEntry__Remaining_Amount_CaptionLbl)
                {
                }
                column(TempCustLedgEntry__Remaining_Amount__Control47Caption; TempCustLedgEntry__Remaining_Amount__Control47CaptionLbl)
                {
                }
                column(BalanceToPrint_Control48Caption; BalanceToPrint_Control48CaptionLbl)
                {
                }
                column(Statement_BalanceCaption; Statement_BalanceCaptionLbl)
                {
                }
                column(Statement_BalanceCaption_Control25; Statement_BalanceCaption_Control25Lbl)
                {
                }
                column(Statement_Aging_Caption; Statement_Aging_CaptionLbl)
                {
                }
                column(Aged_amounts_Caption; Aged_amounts_CaptionLbl)
                {
                }
                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No."=FIELD("No."), "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter");
                    DataItemLinkReference = Customer;
                    DataItemTableView = SORTING("Customer No.", Open)WHERE(Open=CONST(true));

                    trigger OnAfterGetRecord();
                    begin
                        SetRange("Date Filter", 0D, ToDate);
                        CalcFields("Remaining Amount");
                        if "Remaining Amount" <> 0 then InsertTemp("Cust. Ledger Entry");
                    end;
                    trigger OnPreDataItem();
                    begin
                        if(AgingMethod = AgingMethod::None) and (StatementStyle = StatementStyle::Balance)then CurrReport.Break; // Optimization
                        // Find ledger entries which are open and posted before the statement date.
                        SetRange("Posting Date", 0D, ToDate);
                    end;
                }
                dataitem(AfterStmntDateEntry; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No."=FIELD("No."), "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter");
                    DataItemLinkReference = Customer;
                    DataItemTableView = SORTING("Customer No.", "Posting Date");

                    trigger OnAfterGetRecord();
                    begin
                        EntryApplicationMgt.GetAppliedCustEntries(TempAppliedCustLedgEntry, AfterStmntDateEntry, false);
                        TempAppliedCustLedgEntry.SetRange("Posting Date", 0D, ToDate);
                        if TempAppliedCustLedgEntry.Find('-')then repeat InsertTemp(TempAppliedCustLedgEntry);
                            until TempAppliedCustLedgEntry.Next = 0;
                    end;
                    trigger OnPreDataItem();
                    begin
                        if(AgingMethod = AgingMethod::None) and (StatementStyle = StatementStyle::Balance)then CurrReport.Break; // Optimization
                        // Find ledger entries which are posted after the statement date and eliminate
                        // their application to ledger entries posted before the statement date.
                        SetFilter("Posting Date", '%1..', ToDate + 1);
                    end;
                }
                dataitem("Balance Forward"; "Integer")
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                    column(FromDate___1; FromDate - 1)
                    {
                    }
                    column(BalanceToPrint_Control39; BalanceToPrint)
                    {
                    }
                    column(Balance_Forward_Number; Number)
                    {
                    }
                    column(Balance_ForwardCaption; Balance_ForwardCaptionLbl)
                    {
                    }
                    column(Bal_FwdCaption; Bal_FwdCaptionLbl)
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        if StatementStyle <> StatementStyle::Balance then CurrReport.Break;
                    end;
                    trigger OnPreDataItem();
                    begin
                        StatementStyle_Int:=StatementStyle;
                    end;
                }
                dataitem(OpenItem; "Integer")
                {
                    DataItemTableView = SORTING(Number);

                    column(TempCustLedgEntry__Document_No__; TempCustLedgEntry."Document No.")
                    {
                    }
                    column(TempCustLedgEntry__Posting_Date_; TempCustLedgEntry."Posting Date")
                    {
                    }
                    column(TempCustLedgEntry__Due_Date_; TempCustLedgEntry."Due Date")
                    {
                    }
                    column(TempCustLedgEntry__External_Document_No_; TempCustLedgEntry."External Document No.")
                    {
                    }
                    column(GetTermsString_TempCustLedgEntry_; GetTermsString(TempCustLedgEntry))
                    {
                    }
                    column(TempCustLedgEntry__Document_Type_; TempCustLedgEntry."Document Type")
                    {
                    /*  OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund',
                                           ESM = ' ,Pago,Factura,Nota crédito,Docs. interés,Recordatorio,Reembolso',
                                           FRC = ' ,Paiement,Facture,Note de crédit,Note de frais financiers,Rappel,Remboursement',
                                           ENC = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund'; */
                    }
                    column(TempCustLedgEntry__Remaining_Amount_; TempCustLedgEntry."Remaining Amount")
                    {
                    }
                    column(TempCustLedgEntry__Remaining_Amount__Control47;-TempCustLedgEntry."Remaining Amount")
                    {
                    }
                    column(BalanceToPrint_Control48; BalanceToPrint)
                    {
                    }
                    column(OpenItem_Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        if Number = 1 then TempCustLedgEntry.Find('-')
                        else
                            TempCustLedgEntry.Next;
                        TempCustLedgEntry.CalcFields("Remaining Amount");
                        if TempCustLedgEntry."Currency Code" <> Customer."Currency Code" then TempCustLedgEntry."Remaining Amount":=Round(CurrExchRate.ExchangeAmtFCYToFCY(TempCustLedgEntry."Posting Date", TempCustLedgEntry."Currency Code", Customer."Currency Code", TempCustLedgEntry."Remaining Amount"), Currency."Amount Rounding Precision");
                        if AgingMethod <> AgingMethod::None then begin
                            case AgingMethod of AgingMethod::"Due Date": AgingDate:=TempCustLedgEntry."Due Date";
                            AgingMethod::"Trans Date": AgingDate:=TempCustLedgEntry."Posting Date";
                            AgingMethod::"Doc Date": AgingDate:=TempCustLedgEntry."Document Date";
                            end;
                            i:=0;
                            while AgingDate < PeriodEndingDate[i + 1]do i:=i + 1;
                            if i = 0 then i:=1;
                            AmountDue[i]:=TempCustLedgEntry."Remaining Amount";
                            TempAmountDue[i]:=TempAmountDue[i] + AmountDue[i];
                        end;
                        if StatementStyle = StatementStyle::"Open Item" then begin
                            BalanceToPrint:=BalanceToPrint + TempCustLedgEntry."Remaining Amount";
                            if TempCustLedgEntry."Remaining Amount" >= 0 then DebitBalance:=DebitBalance + TempCustLedgEntry."Remaining Amount"
                            else
                                CreditBalance:=CreditBalance + TempCustLedgEntry."Remaining Amount";
                        end;
                    end;
                    trigger OnPreDataItem();
                    begin
                        if(not TempCustLedgEntry.Find('-')) or ((StatementStyle = StatementStyle::Balance) and (AgingMethod = AgingMethod::None))then CurrReport.Break;
                        SetRange(Number, 1, TempCustLedgEntry.Count);
                        TempCustLedgEntry.SetCurrentKey("Customer No.", "Posting Date");
                        TempCustLedgEntry.SetRange("Date Filter", 0D, ToDate);
                    end;
                }
                dataitem(CustLedgerEntry4; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No."=FIELD("No.");
                    DataItemLinkReference = Customer;
                    DataItemTableView = SORTING("Customer No.", "Posting Date");

                    column(CustLedgerEntry4__Document_No__; "Document No.")
                    {
                    }
                    column(CustLedgerEntry4__Posting_Date_; "Posting Date")
                    {
                    }
                    column(GetTermsString_CustLedgerEntry4_; GetTermsString(CustLedgerEntry4))
                    {
                    }
                    column(CustLedgerEntry4__Document_Type_; "Document Type")
                    {
                    }
                    column(CustLedgerEntry4_Amount; Amount)
                    {
                    }
                    column(Amount;-Amount)
                    {
                    }
                    column(BalanceToPrint_Control55; BalanceToPrint)
                    {
                    }
                    column(CustLedgerEntry4_Entry_No_; "Entry No.")
                    {
                    }
                    column(CustLedgerEntry4_Customer_No_; "Customer No.")
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        CalcFields(Amount, "Amount (LCY)");
                        if(Customer."Currency Code" = '') and ("Cust. Ledger Entry"."Currency Code" = '')then Amount:="Amount (LCY)"
                        else
                            Amount:=Round(CurrExchRate.ExchangeAmtFCYToFCY("Posting Date", "Currency Code", Customer."Currency Code", Amount), Currency."Amount Rounding Precision");
                        BalanceToPrint:=BalanceToPrint + Amount;
                        if Amount >= 0 then DebitBalance:=DebitBalance + Amount
                        else
                            CreditBalance:=CreditBalance + Amount;
                    end;
                    trigger OnPreDataItem();
                    begin
                        if StatementStyle <> StatementStyle::Balance then CurrReport.Break;
                        SetRange("Posting Date", FromDate, ToDate);
                    end;
                }
                dataitem(EndOfCustomer; "Integer")
                {
                    DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

                    column(StatementComplete; StatementComplete)
                    {
                    }
                    column(EndOfCustomer_Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        StatementComplete:=true;
                        if UpdateNumbers and (not CurrReport.Preview)then begin
                            Customer.Modify; // just update the Last Statement No
                            Commit;
                        end;
                    end;
                }
                trigger OnPreDataItem();
                begin
                    AgingMethod_Int:=AgingMethod;
                end;
            }
            trigger OnAfterGetRecord();
            begin
                //CurrReport.Language := Language.GetLanguageID("Language Code");
                CurrReport.Language:=Language.GetLanguageIdOrDefault("Language Code");
                DebitBalance:=0;
                CreditBalance:=0;
                Clear(AmountDue);
                Clear(TempAmountDue);
                Print:=false;
                if AllHavingBalance then begin
                    SetRange("Date Filter", 0D, ToDate);
                    CalcFields("Net Change");
                    Print:="Net Change" <> 0;
                end;
                if(not Print) and AllHavingEntries then begin
                    "Cust. Ledger Entry".Reset;
                    if StatementStyle = StatementStyle::Balance then begin
                        "Cust. Ledger Entry".SetCurrentKey("Customer No.", "Posting Date");
                        "Cust. Ledger Entry".SetRange("Posting Date", FromDate, ToDate);
                    end
                    else
                    begin
                        "Cust. Ledger Entry".SetCurrentKey("Customer No.", Open);
                        "Cust. Ledger Entry".SetRange("Posting Date", 0D, ToDate);
                        "Cust. Ledger Entry".SetRange(Open, true);
                    end;
                    "Cust. Ledger Entry".SetRange("Customer No.", "No.");
                    Print:="Cust. Ledger Entry".Find('-');
                end;
                if not Print then CurrReport.Skip;
                TempCustLedgEntry.DeleteAll;
                AgingDaysText:='';
                if AgingMethod <> AgingMethod::None then begin
                    AgingHead[1]:=CurrentTxt;
                    PeriodEndingDate[1]:=ToDate;
                    if AgingMethod = AgingMethod::"Due Date" then begin
                        PeriodEndingDate[2]:=PeriodEndingDate[1];
                        for i:=3 to 4 do PeriodEndingDate[i]:=CalcDate(PeriodCalculation, PeriodEndingDate[i - 1]);
                        AgingDaysText:=DaysOverdueTxt;
                        AgingHead[2]:=StrSubstNo(UpToDaysTxt, PeriodEndingDate[1] - PeriodEndingDate[3]);
                    end
                    else
                    begin
                        for i:=2 to 4 do PeriodEndingDate[i]:=CalcDate(PeriodCalculation, PeriodEndingDate[i - 1]);
                        AgingDaysText:=DaysOldTxt;
                        AgingHead[2]:=StrSubstNo(FromToDaysTxt, PeriodEndingDate[1] - PeriodEndingDate[2] + 1, PeriodEndingDate[1] - PeriodEndingDate[3]);
                    end;
                    PeriodEndingDate[5]:=0D;
                    AgingHead[3]:=StrSubstNo(FromToDaysTxt, PeriodEndingDate[1] - PeriodEndingDate[3] + 1, PeriodEndingDate[1] - PeriodEndingDate[4]);
                    AgingHead[4]:=StrSubstNo(OverDaysTxt, PeriodEndingDate[1] - PeriodEndingDate[4]);
                end;
                if "Currency Code" = '' then begin
                    Clear(Currency);
                    CurrencyDesc:='';
                end
                else
                begin
                    Currency.Get("Currency Code");
                    CurrencyDesc:=StrSubstNo(CurrencyDescTxt, Currency.Description);
                end;
                if StatementStyle = StatementStyle::Balance then begin
                    SetRange("Date Filter", 0D, FromDate - 1);
                    CalcFields("Net Change (LCY)");
                    if "Currency Code" = '' then BalanceToPrint:="Net Change (LCY)"
                    else
                        BalanceToPrint:=CurrExchRate.ExchangeAmtFCYToFCY(FromDate - 1, '', "Currency Code", "Net Change (LCY)");
                    SetRange("Date Filter");
                end
                else
                    BalanceToPrint:=0;
                // Update Statement Number so it can be printed on the document. However, defer actually updating the customer file until the statement is complete.
                if "Last Statement No." >= 9999 then "Last Statement No.":=1
                else
                    "Last Statement No.":="Last Statement No." + 1;
                // CurrReport.PageNo := 1;
                FormatAddress.Customer(CustomerAddress, Customer);
                StatementComplete:=false;
                if LogInteraction then if not CurrReport.Preview then SegManagement.LogDocument(7, Format("Last Statement No."), 0, 0, DATABASE::Customer, "No.", "Salesperson Code", '', StrSubstNo(LastStmtNoTxt, "Last Statement No."), '');
            end;
            trigger OnPreDataItem();
            begin
                // remove user-entered date filter; info now in FromDate & ToDate
                SetRange("Date Filter");
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options', ESM = 'Opciones', FRC = 'Options', ENC = 'Options';

                    field(AllHavingEntries; AllHavingEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Print All with Entries', ESM = 'Impr. todo con movs.', FRC = 'Imprimer tout avec écritures', ENC = 'Print All with Entries';
                        ToolTipML = ENU = 'Specifies if an account statement is included for all customers with entries by the end of the statement period, as specified in the date filter.', ESM = 'Especifica si se incluye un estado de cuenta para todos los clientes con movimientos al final del periodo del estado de cuenta según se especifica en el filtro de fechas.', FRC = 'Spécifie si un relevé de compte est inclus pour tous les clients présentant des écritures à la fin de la période du relevé, comme spécifié dans le filtre date.', ENC = 'Specifies if an account statement is included for all customers with entries by the end of the statement period, as specified in the date filter.';
                    }
                    field(AllHavingBalance; AllHavingBalance)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Print All with Balance', ESM = 'Impr. todo con saldo', FRC = 'Imprimer tout avec solde', ENC = 'Print All with Balance';
                        ToolTipML = ENU = 'Specifies if an account statement is included for all customers with a balance by the end of the statement period, as specified in the date filter.', ESM = 'Especifica si se incluye un estado de cuenta para todos los clientes que tengan saldo al final del periodo de estado de cuenta, según se especifica en el filtro de fechas.', FRC = 'Spécifie si un relevé de compte est inclus pour tous les clients présentant un solde à la fin de la période du relevé, comme spécifié dans le filtre date.', ENC = 'Specifies if an account statement is included for all customers with a balance by the end of the statement period, as specified in the date filter.';
                    }
                    field(UpdateNumbers; UpdateNumbers)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Update Statement No.', ESM = 'Actualiz. nº estado de cta. banco', FRC = 'N° de mise à jour relevé', ENC = 'Update Statement No.';
                        ToolTipML = ENU = 'Specifies if you want to update the Last Statement No. field on each customer card after it prints the customer''s statement. Do not select this check box if you are not using statement numbers, if you are just viewing the statements, or if you are printing statements which will not be sent to the customer.', ESM = 'Especifica si desea actualizar el campo Òlt. nº estado de cuenta de cada ficha cliente después de imprimir el estado de cuenta del cliente. Desactive la casilla si no va a usar números de estado de cuenta, si solo desea ver los estados de cuenta o si va a imprimir estados de cuenta que no se van a enviar a los clientes.', FRC = 'Spécifie si vous souhaitez mettre à jour le champ N° dernier relevé sur chaque fiche client une fois le relevé du client imprimé. Ne cochez pas cette case si vous n''utilisez pas de numéros de relevé, si vous vous contentez d''afficher les relevés ou si vous imprimez des relevés qui ne seront pas envoyés au client.', ENC = 'Specifies if you want to update the Last Statement No. field on each customer card after it prints the customer''s statement. Do not select this check box if you are not using statement numbers, if you are just viewing the statements, or if you are printing statements which will not be sent to the customer.';
                    }
                    field(PrintCompany; PrintCompany)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Print Company Address', ESM = 'Imprimir dir. empresa', FRC = 'Imprimer l''adresse de la compagnie', ENC = 'Print Company Address';
                        ToolTipML = ENU = 'Specifies if your company address is printed at the top of the sheet, because you do not use pre-printed paper. Leave this check box blank to omit your company''s address.', ESM = 'Especifica si en la parte superior de la hoja se debe imprimir la dirección de la empresa porque no usa papel preimpreso. Deje la casilla en blanco para omitir la dirección de la empresa.', FRC = 'Spécifie si l''adresse de votre compagnie est imprimée en haut de la feuille, car vous n''utilisez pas de papier préimprimé. Décochez cette case pour ne pas imprimer l''adresse de votre compagnie.', ENC = 'Specifies if your company address is printed at the top of the sheet, because you do not use pre-printed paper. Leave this check box blank to omit your company''s address.';
                    }
                    field(StatementStyle; StatementStyle)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Statement Style', ESM = 'Modelo estado de cuenta', FRC = 'Style du relevé', ENC = 'Statement Style';
                        OptionCaptionML = ENU = 'Open Item,Balance', ESM = 'Producto abierto,Saldo', FRC = 'Ouvrir l''article,Solde', ENC = 'Open Item,Balance';
                        ToolTipML = ENU = 'Specifies how to print the statement. Balance: Prints balance forward statements that list all entries made during the statement period that you specify in the date filter. Open Item: Prints open item statements that list all entries that are still open as of the date that you specify in the date filter.', ESM = 'Especifica cómo imprimir el estado de cuenta. Saldo: se imprimen los estados de cuenta de suma y sigue en los que se indican todos los movimientos del período de estado de cuenta que especifique en el filtro de fechas. Producto abierto: se imprimen los estados de cuenta de producto abierto en los que se indican todos los movimientos abiertos en la fecha que especifique en el filtro de fechas.', FRC = 'Spécifie comment imprimer le relevé. Solde : imprime les relevés de soldes reportés qui répertorient toutes les écritures pendant la période de relevé spécifiée dans le filtre date. Article ouvert : imprime les relevés d''articles ouverts qui répertorient toutes les écritures qui sont toujours ouvertes à la date spécifiée dans le filtre date.', ENC = 'Specifies how to print the statement. Balance: Prints balance forward statements that list all entries made during the statement period that you specify in the date filter. Open Item: Prints open item statements that list all entries that are still open as of the date that you specify in the date filter.';
                    }
                    field(AgingMethod; AgingMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Aged By', ESM = 'Vencido por', FRC = 'Classement chronologique par', ENC = 'Aged By';
                        OptionCaptionML = ENU = 'None,Due Date,Trans Date,Doc Date', ESM = 'Ninguno,Fecha vencimiento,Fecha trans.,Fecha doc.', FRC = 'Aucun,Date d''échéance,Date de transaction,Date doc.', ENC = 'None,Due Date,Trans Date,Doc Date';
                        ToolTipML = ENU = 'Specifies how aging is calculated. Due Date: Aging is calculated by the number of days that the transaction is overdue. Trans Date: Aging is calculated by the number of days since the transaction posting date. Document Date: Aging is calculated by the number of days since the document date.', ESM = 'Especifica cómo se calcula la antigüedad. Fecha de vencimiento: la antigüedad se calcula según el número de días desde que venció la transacción. Fecha transacción: la antigüedad se calcula según el número de días desde la fecha de registro de la transacción. Fecha emisión documento: la antigüedad se calcula según el número de días desde la fecha de emisión del documento.', FRC = 'Spécifie comment la chronologie est calculée. Date d''échéance : la chronologie est calculée en fonction du nombre de jours de retard de la transaction. Date de transaction : la chronologie est calculée en fonction du nombre de jours depuis la date de report de la transaction. Date document : la chronologie est calculée en fonction du nombre de jours depuis la date du document.', ENC = 'Specifies how aging is calculated. Due Date: Aging is calculated by the number of days that the transaction is overdue. Trans Date: Aging is calculated by the number of days since the transaction posting date. Document Date: Aging is calculated by the number of days since the document date.';
                    }
                    field(PeriodCalculation; PeriodCalculation)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Length of Aging Periods', ESM = 'Long. períodos antigüedad', FRC = 'Durée des périodes de ventilation chronologique', ENC = 'Length of Aging Periods';
                        ToolTipML = ENU = 'Specifies the length of each of the aging periods. For example, enter 30D to base aging on 30-day intervals.', ESM = 'Especifica la longitud de cada uno de los periodos de antigüedad. Por ejemplo, escriba 30D para basar la antigüedad en intervalos de 30 días.', FRC = 'Spécifie la longueur de chacune des périodes de ventilation chronologiques. Par exemple, entrez 30D pour baser la chronologie sur des intervalles de 30 jours.', ENC = 'Specifies the length of each of the aging periods. For example, enter 30D to base aging on 30-day intervals.';

                        trigger OnValidate();
                        begin
                            if(AgingMethod <> AgingMethod::None) and (Format(PeriodCalculation) = '')then Error(AgingPeriodLengthErr);
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Log Interaction', ESM = 'Log interacción', FRC = 'Journal interaction', ENC = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTipML = ENU = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.', ESM = 'Especifica si desea registrar las interacciones relacionadas con la persona de contacto implicada en la tabla Mov. log de interacción.', FRC = 'Spécifie si vous souhaitez enregistrer les interactions associées avec la personne de contact impliquée dans la table Écriture du journal d''interaction.', ENC = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.';
                    }
                    group(OutputOptions)
                    {
                        CaptionML = ENU = 'Output Options', ESM = 'Opciones de salida', FRC = 'Options sortie', ENC = 'Output Options';

                        field(ReportOutput; SupportedOutputMethod)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Report Output', ESM = 'Salida de informe', FRC = 'Sortie rapport', ENC = 'Report Output';
                            ToolTipML = ENU = 'Specifies the output of the scheduled report, such as PDF or Word.', ESM = 'Especifica el tipo del informe programado, como PDF o Word.', FRC = 'Spécifie la sortie du rapport programmé, par exemple PDF ou Word.', ENC = 'Specifies the output of the scheduled report, such as PDF or Word.';

                            trigger OnValidate();
                            begin
                                MapOutputMethod;
                            end;
                        }
                        field(OutputMethod; ChosenOutputMethod)
                        {
                            ApplicationArea = Basic, Suite;
                            Visible = false;
                        }
                    }
                    group(EmailOptions)
                    {
                        CaptionML = ENU = 'Email Options', ESM = 'Opciones de correo electrónico', FRC = 'Options de courriel', ENC = 'Email Options';
                        Visible = ShowPrintIfEmailIsMissing;

                        field(PrintMissingAddresses; PrintIfEmailIsMissing)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Print remaining statements', ESM = 'Imprimir estados de cuenta restantes', FRC = 'Imprimer relevés restants', ENC = 'Print remaining statements';
                            ToolTipML = ENU = 'Specifies that amounts that remain to be paid will be included.', ESM = 'Especifica que se incluirán los importes pendientes de pago.', FRC = 'Spécifie que les montants restant à payer seront inclus.', ENC = 'Specifies that amounts that remain to be paid will be included.';
                        }
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit();
        begin
            LogInteractionEnable:=true;
        end;
        trigger OnOpenPage();
        begin
            if(not AllHavingEntries) and (not AllHavingBalance)then AllHavingBalance:=true;
            LogInteraction:=SegManagement.FindInteractTmplCode(7) <> '';
            LogInteractionEnable:=LogInteraction;
            MapOutputMethod;
        end;
    }
    labels
    {
    }
    trigger OnPreReport();
    begin
        if(not AllHavingEntries) and (not AllHavingBalance)then Error(EntriesOrBalanceErr);
        if UpdateNumbers and CurrReport.Preview then Error(UpdStmtNmbrsPrintErr);
        FromDate:=Customer.GetRangeMin("Date Filter");
        ToDate:=Customer.GetRangeMax("Date Filter");
        if(StatementStyle = StatementStyle::Balance) and (FromDate = ToDate)then Error(DateFilterRangeErr);
        if(AgingMethod <> AgingMethod::None) and (Format(PeriodCalculation) = '')then Error(AgingPeriodLengthErr);
        if Format(PeriodCalculation) <> '' then Evaluate(PeriodCalculation, StrSubstNo(PeriodCalcTxt, PeriodCalculation));
        if PrintCompany then begin
            CompanyInformation.Get;
            FormatAddress.Company(CompanyAddress, CompanyInformation);
        end
        else
            Clear(CompanyAddress);
        // NA0005.begin
        CompanyInformation.Get;
        SalesSetup.Get;
        case SalesSetup."Logo Position on Documents" of SalesSetup."Logo Position on Documents"::"No Logo": ;
        SalesSetup."Logo Position on Documents"::Left: begin
            CompanyInfo3.Get;
            CompanyInfo3.CalcFields(Picture);
        end;
        SalesSetup."Logo Position on Documents"::Center: begin
            CompanyInfo1.Get;
            CompanyInfo1.CalcFields(Picture);
        end;
        SalesSetup."Logo Position on Documents"::Right: begin
            CompanyInfo2.Get;
            CompanyInfo2.CalcFields(Picture);
        end;
        end;
        if PrintCompany then FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
    end;
    var CompanyInformation: Record "Company Information";
    CompanyInfo1: Record "Company Information";
    CompanyInfo2: Record "Company Information";
    CompanyInfo3: Record "Company Information";
    SalesSetup: Record "Sales & Receivables Setup";
    Currency: Record Currency;
    CurrExchRate: Record "Currency Exchange Rate";
    Language: Codeunit Language;
    TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
    TempAppliedCustLedgEntry: Record "Cust. Ledger Entry" temporary;
    FormatAddress: Codeunit "Format Address";
    EntryApplicationMgt: Codeunit "Entry Application Management";
    SegManagement: Codeunit SegManagement;
    StatementStyle: Option "Open Item", Balance;
    AllHavingEntries: Boolean;
    AllHavingBalance: Boolean;
    UpdateNumbers: Boolean;
    AgingMethod: Option "None", "Due Date", "Trans Date", "Doc Date";
    PrintCompany: Boolean;
    PeriodCalculation: DateFormula;
    Print: Boolean;
    FromDate: Date;
    ToDate: Date;
    AgingDate: Date;
    LogInteraction: Boolean;
    CustomerAddress: array[8]of Text[100];
    CompanyAddress: array[8]of Text[100];
    BalanceToPrint: Decimal;
    DebitBalance: Decimal;
    CreditBalance: Decimal;
    AgingHead: array[4]of Text[20];
    AmountDue: array[4]of Decimal;
    AgingDaysText: Text[20];
    PeriodEndingDate: array[5]of Date;
    StatementComplete: Boolean;
    i: Integer;
    CurrencyDesc: Text[80];
    EntriesOrBalanceErr: TextConst ENU = 'You must select either All with Entries or All with Balance.', ESM = 'Seleccione Todo con movs. o Todo con saldo.', FRC = 'Vous devez choisir entre Tout avec écritures et Tout avec solde.', ENC = 'You must select either All with Entries or All with Balance.';
    UpdStmtNmbrsPrintErr: TextConst ENU = 'You must print statements if you want to update statement numbers.', ESM = 'Debe imprimir estados de cuenta si desea actualizar los nº de estado de cuenta.', FRC = 'Vous devez imprimer les relevés si vous voulez mettre à jour les numéros de relevés.', ENC = 'You must print statements if you want to update statement numbers.';
    DateFilterRangeErr: TextConst ENU = 'You must enter a range of dates (not just one date) in the Date Filter if you want to print Balance Forward Statements.', ESM = 'Debe especificar un intervalo de fechas (no solo una fecha) en el filtro de fecha si desea imprimir estados de cuenta de saldo acumulado.', FRC = 'Vous devez entrer une plage de dates (et pas une seule date) dans le filtre date si vous souhaitez imprimer les relevés de soldes reportés.', ENC = 'You must enter a range of dates (not just one date) in the Date Filter if you want to print Balance Forward Statements.';
    AgingPeriodLengthErr: TextConst ENU = 'You must enter a Length of Aging Periods if you select aging.', ESM = 'Seleccione una duración del período de antigüedad si selecciona Antigüedad.', FRC = 'Vous devez entrer la durée des périodes chronologiques si vous choisissez le classement chronologique.', ENC = 'You must enter a Length of Aging Periods if you select aging.';
    CurrentTxt: TextConst ENU = 'Current', ESM = 'Actual', FRC = 'Courant', ENC = 'Current';
    DaysOverdueTxt: TextConst ENU = 'Days overdue:', ESM = 'Días retraso:', FRC = 'Jours de retard:', ENC = 'Days overdue:';
    UpToDaysTxt: TextConst Comment = '%1 = a number of days overdue', ENU = 'Up To %1 Days', ESM = 'Hasta %1 días', FRC = 'Jusqu''à %1 jours', ENC = 'Up To %1 Days';
    FromToDaysTxt: TextConst Comment = '%1, %2 = a number of days overdue', ENU = '%1 - %2 Days', ESM = '%1 a %2 días', FRC = '%1-%2 jours', ENC = '%1 - %2 Days';
    DaysOldTxt: TextConst ENU = 'Days old:', ESM = 'Días:', FRC = 'Jours échus:', ENC = 'Days old:';
    OverDaysTxt: TextConst Comment = '%1 = a number of days overdue', ENU = 'Over %1 Days', ESM = 'Más de %1 días', FRC = 'Plus de %1 jours', ENC = 'Over %1 Days';
    LastStmtNoTxt: TextConst Comment = '%1 = Customer''s Last Statement No.', ENU = 'Statement %1', ESM = 'Estado de cuenta %1', FRC = 'Relevé %1', ENC = 'Statement %1';
    CurrencyDescTxt: TextConst Comment = '%1 = Currency name', ENU = '(All amounts are in %1)', ESM = '(Importes en %1)', FRC = '(Tous les montants sont en %1)', ENC = '(All amounts are in %1)';
    TempAmountDue: array[4]of Decimal;
    AgingMethod_Int: Integer;
    StatementStyle_Int: Integer;
    [InDataSet]
    LogInteractionEnable: Boolean;
    PeriodCalcTxt: TextConst Comment = '%1 = length of Aging Periods, dateformula', ENU = '<-%1>', ESM = '<-%1>', FRC = '<-%1>', ENC = '<-%1>';
    STATEMENTCaptionLbl: TextConst Comment = 'Page title.', ENU = 'STATEMENT', ESM = 'ESTADO DE CUENTA', FRC = 'RELEVÉ', ENC = 'STATEMENT';
    Statement_Date_CaptionLbl: TextConst ENU = 'Statement Date:', ESM = 'Fecha estado de cuenta banco:', FRC = 'Date du relevé :', ENC = 'Statement Date:';
    Account_Number_CaptionLbl: TextConst ENU = 'Account Number:', ESM = 'Número cuenta:', FRC = 'Numéro de compte :', ENC = 'Account Number:';
    Page_CaptionLbl: TextConst ENU = 'Page:', ESM = 'Pág.:', FRC = 'Page :', ENC = 'Page:';
    RETURN_THIS_PORTION_OF_STATEMENT_WITH_YOUR_PAYMENT_CaptionLbl: TextConst Comment = 'Part of page header.', ENU = 'RETURN THIS PORTION OF STATEMENT WITH YOUR PAYMENT.', ESM = 'DEVUELVA ESTA PARTE DEL ESTADO DE CUENTA CON SU PAGO.', FRC = 'RETOURNEZ CETTE PARTIE DU RELEVÉ AVEC VOTRE PAIEMENT.', ENC = 'RETURN THIS PORTION OF STATEMENT WITH YOUR PAYMENT.';
    Amount_RemittedCaptionLbl: TextConst ENU = 'Amount Remitted', ESM = 'Cantidad enviada', FRC = 'Montant remis', ENC = 'Amount Remitted';
    TempCustLedgEntry__Document_No__CaptionLbl: TextConst ENU = 'Document', ESM = 'Documento', FRC = 'Document', ENC = 'Document';
    TempCustLedgEntry__Posting_Date_CaptionLbl: TextConst ENU = 'Date', ESM = 'Fecha', FRC = 'Date', ENC = 'Date';
    GetTermsString_TempCustLedgEntry_CaptionLbl: TextConst ENU = 'Terms', ESM = 'Términos', FRC = 'Modalités', ENC = 'Terms';
    TempCustLedgEntry__Document_Type_CaptionLbl: TextConst ENU = 'Code', ESM = 'Código', FRC = 'Code', ENC = 'Code';
    TempCustLedgEntry__Remaining_Amount_CaptionLbl: TextConst ENU = 'Debits', ESM = 'Débitos', FRC = 'Débits', ENC = 'Debits';
    TempCustLedgEntry__Remaining_Amount__Control47CaptionLbl: TextConst ENU = 'Credits', ESM = 'Créditos', FRC = 'Crédits', ENC = 'Credits';
    BalanceToPrint_Control48CaptionLbl: TextConst ENU = 'Balance', ESM = 'Saldo', FRC = 'Solde', ENC = 'Balance';
    Statement_BalanceCaptionLbl: TextConst ENU = 'Statement Balance', ESM = 'Saldo estado de cta. banco', FRC = 'Solde du relevé', ENC = 'Statement Balance';
    Statement_BalanceCaption_Control25Lbl: TextConst ENU = 'Statement Balance', ESM = 'Saldo estado de cta. banco', FRC = 'Solde du relevé', ENC = 'Statement Balance';
    Statement_Aging_CaptionLbl: TextConst ENU = 'Statement Aging:', ESM = 'Vencimiento estado de cuenta:', FRC = 'Classement chronologique des relevés :', ENC = 'Statement Aging:';
    Aged_amounts_CaptionLbl: TextConst ENU = 'Aged amounts:', ESM = 'Importes vencidos:', FRC = 'Classement chronologique des montants :', ENC = 'Aged amounts:';
    Balance_ForwardCaptionLbl: TextConst ENU = 'Balance Forward', ESM = 'Saldo resumido', FRC = 'Solde reporté', ENC = 'Balance Forward';
    Bal_FwdCaptionLbl: TextConst ENU = 'Bal Fwd', ESM = 'Saldo resumido', FRC = 'Solde reporté', ENC = 'Bal Fwd';
    SupportedOutputMethod: Option Print, Preview, PDF, Email, Excel, XML;
    ChosenOutputMethod: Integer;
    PrintIfEmailIsMissing: Boolean;
    [InDataSet]
    ShowPrintIfEmailIsMissing: Boolean;
    procedure GetTermsString(var CustLedgerEntry: Record "Cust. Ledger Entry"): Text[250];
    var
        SalesInvHeader: Record "Sales Invoice Header";
        PaymentTerms: Record "Payment Terms";
    begin
        if(CustLedgerEntry."Document No." = '') or (CustLedgerEntry."Document Type" <> CustLedgerEntry."Document Type"::Invoice)then exit('');
        if SalesInvHeader.ReadPermission then if SalesInvHeader.Get(CustLedgerEntry."Document No.")then begin
                if PaymentTerms.Get(SalesInvHeader."Payment Terms Code")then begin
                    if PaymentTerms.Description <> '' then exit(PaymentTerms.Description);
                    exit(SalesInvHeader."Payment Terms Code");
                end;
                exit(SalesInvHeader."Payment Terms Code");
            end;
        if Customer."Payment Terms Code" <> '' then begin
            if PaymentTerms.Get(Customer."Payment Terms Code")then begin
                if PaymentTerms.Description <> '' then exit(PaymentTerms.Description);
                exit(Customer."Payment Terms Code");
            end;
            exit(Customer."Payment Terms Code");
        end;
        exit('');
    end;
    //[LineStart(1507)]
    local procedure InsertTemp(var CustLedgEntry: Record "Cust. Ledger Entry");
    begin
        if TempCustLedgEntry.Get(CustLedgEntry."Entry No.")then exit;
        TempCustLedgEntry:=CustLedgEntry;
        TempCustLedgEntry.Insert;
    end;
    //[LineStart(1515)]
    local procedure MapOutputMethod();
    var
        CustomLayoutReporting: Codeunit "Custom Layout Reporting";
    begin
        ShowPrintIfEmailIsMissing:=(SupportedOutputMethod = SupportedOutputMethod::Email);
        // Map the supported option (shown on the page) to the list of supported output methods
        // Most output methods map directly - Word/XML do not, however.
        case SupportedOutputMethod of SupportedOutputMethod::XML: ChosenOutputMethod:=CustomLayoutReporting.GetXMLOption;
        else
            ChosenOutputMethod:=SupportedOutputMethod;
        end;
    end;
}
