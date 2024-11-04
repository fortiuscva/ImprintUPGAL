report 60001 "Cust. Statement"
{
    // version NAVW114.13
    DefaultLayout = RDLC;
    RDLCLayout = './Cust. Statement.rdl';
    CaptionML = ENU = 'Cust. Statement', ESM = 'Estado de cuenta', FRC = 'Relevé', ENC = 'Statement';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Print Statements", "Currency Filter";

            column(No_Cust; "No.")
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;

                column(CompanyInfo1Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfo2Picture; CompanyInfo2.Picture)
                {
                }
                column(CompanyInfo3Picture; CompanyInfo3.Picture)
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(PhoneNo_CompanyInfo; CompanyInfo."Phone No.")
                {
                }
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CompanyInfoEmail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(VATRegNo_CompanyInfo; CompanyInfo."VAT Registration No.")
                {
                }
                column(GiroNo_CompanyInfo; CompanyInfo."Giro No.")
                {
                }
                column(BankName_CompanyInfo; CompanyInfo."Bank Name")
                {
                }
                column(BankAccNo_CompanyInfo; CompanyInfo."Bank Account No.")
                {
                }
                column(No1_Cust; Customer."No.")
                {
                }
                column(TodayFormatted; Format(Today))
                {
                }
                column(StartDate; Format(StartDate))
                {
                }
                column(EndDate; Format(EndDate))
                {
                }
                column(LastStatmntNo_Cust; Format(Customer."Last Statement No."))
                {
                }
                column(CustAddr7; CustAddr[7])
                {
                }
                column(CustAddr8; CustAddr[8])
                {
                }
                column(CompanyAddr7; CompanyAddr[7])
                {
                }
                column(CompanyAddr8; CompanyAddr[8])
                {
                }
                column(StatementCaption; StatementCaptionLbl)
                {
                }
                column(PhoneNo_CompanyInfoCaption; PhoneNo_CompanyInfoCaptionLbl)
                {
                }
                column(VATRegNo_CompanyInfoCaption; VATRegNo_CompanyInfoCaptionLbl)
                {
                }
                column(GiroNo_CompanyInfoCaption; GiroNo_CompanyInfoCaptionLbl)
                {
                }
                column(BankName_CompanyInfoCaption; BankName_CompanyInfoCaptionLbl)
                {
                }
                column(BankAccNo_CompanyInfoCaption; BankAccNo_CompanyInfoCaptionLbl)
                {
                }
                column(No1_CustCaption; No1_CustCaptionLbl)
                {
                }
                column(StartDateCaption; StartDateCaptionLbl)
                {
                }
                column(EndDateCaption; EndDateCaptionLbl)
                {
                }
                column(LastStatmntNo_CustCaption; LastStatmntNo_CustCaptionLbl)
                {
                }
                column(PostDate_DtldCustLedgEntriesCaption; PostDate_DtldCustLedgEntriesCaptionLbl)
                {
                }
                column(DocNo_DtldCustLedgEntriesCaption; DtldCustLedgEntries.FieldCaption("Document No."))
                {
                }
                column(Desc_CustLedgEntry2Caption; CustLedgEntry2.FieldCaption(Description))
                {
                }
                column(DueDate_CustLedgEntry2Caption; DueDate_CustLedgEntry2CaptionLbl)
                {
                }
                column(RemainAmtCustLedgEntry2Caption; CustLedgEntry2.FieldCaption("Remaining Amount"))
                {
                }
                column(CustBalanceCaption; CustBalanceCaptionLbl)
                {
                }
                column(OriginalAmt_CustLedgEntry2Caption; CustLedgEntry2.FieldCaption("Original Amount"))
                {
                }
                column(CompanyInfoHomepageCaption; CompanyInfoHomepageCaptionLbl)
                {
                }
                column(CompanyInfoEmailCaption; CompanyInfoEmailCaptionLbl)
                {
                }
                column(DocDateCaption; DocDateCaptionLbl)
                {
                }
                column(Total_Caption2; Total_CaptionLbl)
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                dataitem(CurrencyLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    PrintOnlyIfDetail = true;

                    dataitem(CustLedgEntryHdr; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        column(Currency2Code_CustLedgEntryHdr; StrSubstNo(Text001, CurrencyCode3))
                        {
                        }
                        column(StartBalance; StartBalance)
                        {
                            AutoFormatExpression = Currency2.Code;
                            AutoFormatType = 1;
                        }
                        column(CurrencyCode3; CurrencyCode3)
                        {
                        }
                        column(CustBalance_CustLedgEntryHdr; CustBalance)
                        {
                        }
                        column(PrintLine; PrintLine)
                        {
                        }
                        column(DtldCustLedgEntryType; Format(DtldCustLedgEntries."Entry Type", 0, 2))
                        {
                        }
                        column(EntriesExists; EntriesExists)
                        {
                        }
                        column(IsNewCustCurrencyGroup; IsNewCustCurrencyGroup)
                        {
                        }
                        dataitem(DtldCustLedgEntries; "Detailed Cust. Ledg. Entry")
                        {
                            DataItemTableView = SORTING("Customer No.", "Posting Date", "Entry Type", "Currency Code");

                            column(PostDate_DtldCustLedgEntries; Format("Posting Date"))
                            {
                            }
                            column(DocNo_DtldCustLedgEntries; "Document No.")
                            {
                            }
                            column(Description; Description)
                            {
                            }
                            column(DueDate_DtldCustLedgEntries; Format(DueDate))
                            {
                            }
                            column(CurrCode_DtldCustLedgEntries; "Currency Code")
                            {
                            }
                            column(Amt_DtldCustLedgEntries; Amount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(RemainAmt_DtldCustLedgEntries; RemainingAmount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CustBalance; CustBalance)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Currency2Code; Currency2.Code)
                            {
                            }
                            trigger OnAfterGetRecord();
                            var
                                CustLedgerEntry: Record "Cust. Ledger Entry";
                            begin
                                if SkipReversedUnapplied(DtldCustLedgEntries) or (Amount = 0) then CurrReport.Skip;
                                RemainingAmount := 0;
                                PrintLine := true;
                                case "Entry Type" of
                                    "Entry Type"::"Initial Entry":
                                        begin
                                            CustLedgerEntry.Get("Cust. Ledger Entry No.");
                                            Description := CustLedgerEntry.Description;
                                            DueDate := CustLedgerEntry."Due Date";
                                            CustLedgerEntry.SetRange("Date Filter", 0D, EndDate);
                                            CustLedgerEntry.CalcFields("Remaining Amount");
                                            RemainingAmount := CustLedgerEntry."Remaining Amount";
                                        end;
                                    "Entry Type"::Application:
                                        begin
                                            DtldCustLedgEntries2.SetCurrentKey("Customer No.", "Posting Date", "Entry Type");
                                            DtldCustLedgEntries2.SetRange("Customer No.", "Customer No.");
                                            DtldCustLedgEntries2.SetRange("Posting Date", "Posting Date");
                                            DtldCustLedgEntries2.SetRange("Entry Type", "Entry Type"::Application);
                                            DtldCustLedgEntries2.SetRange("Transaction No.", "Transaction No.");
                                            DtldCustLedgEntries2.SetFilter("Currency Code", '<>%1', "Currency Code");
                                            if not DtldCustLedgEntries2.IsEmpty then begin
                                                Description := Text005;
                                                DueDate := 0D;
                                            end
                                            else
                                                PrintLine := false;
                                        end;
                                    "Entry Type"::"Payment Discount", "Entry Type"::"Payment Discount (VAT Excl.)", "Entry Type"::"Payment Discount (VAT Adjustment)", "Entry Type"::"Payment Discount Tolerance", "Entry Type"::"Payment Discount Tolerance (VAT Excl.)", "Entry Type"::"Payment Discount Tolerance (VAT Adjustment)":
                                        begin
                                            Description := Text006;
                                            DueDate := 0D;
                                        end;
                                    "Entry Type"::"Payment Tolerance", "Entry Type"::"Payment Tolerance (VAT Excl.)", "Entry Type"::"Payment Tolerance (VAT Adjustment)":
                                        begin
                                            Description := Text014;
                                            DueDate := 0D;
                                        end;
                                    "Entry Type"::"Appln. Rounding", "Entry Type"::"Correction of Remaining Amount":
                                        begin
                                            Description := Text007;
                                            DueDate := 0D;
                                        end;
                                end;
                                if PrintLine then begin
                                    CustBalance := CustBalance + Amount;
                                    IsNewCustCurrencyGroup := IsFirstPrintLine;
                                    IsFirstPrintLine := false;
                                    ClearCompanyPicture;
                                end;
                            end;

                            trigger OnPreDataItem();
                            begin
                                SetRange("Customer No.", Customer."No.");
                                SetRange("Posting Date", StartDate, EndDate);
                                SetRange("Currency Code", Currency2.Code);
                                if Currency2.Code = '' then begin
                                    GLSetup.TestField("LCY Code");
                                    CurrencyCode3 := GLSetup."LCY Code"
                                end
                                else
                                    CurrencyCode3 := Currency2.Code;
                                IsFirstPrintLine := true;
                            end;
                        }
                    }
                    dataitem(CustLedgEntryFooter; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        column(CurrencyCode3_CustLedgEntryFooter; CurrencyCode3)
                        {
                        }
                        column(Total_Caption; Total_CaptionLbl)
                        {
                        }
                        column(CustBalance_CustLedgEntryHdrFooter; CustBalance)
                        {
                            AutoFormatExpression = Currency2.Code;
                            AutoFormatType = 1;
                        }
                        column(EntriesExistsl_CustLedgEntryFooterCaption; EntriesExists)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            ClearCompanyPicture;
                        end;
                    }
                    dataitem(CustLedgEntry2; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Customer No." = FIELD("No.");
                        DataItemLinkReference = Customer;
                        DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date");

                        column(OverDueEntries; StrSubstNo(Text002, Currency2.Code))
                        {
                        }
                        column(RemainAmt_CustLedgEntry2; "Remaining Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PostDate_CustLedgEntry2; Format("Posting Date"))
                        {
                        }
                        column(DocNo_CustLedgEntry2; "Document No.")
                        {
                        }
                        column(Desc_CustLedgEntry2; Description)
                        {
                        }
                        column(DueDate_CustLedgEntry2; Format("Due Date"))
                        {
                        }
                        column(OriginalAmt_CustLedgEntry2; "Original Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                        }
                        column(CurrCode_CustLedgEntry2; "Currency Code")
                        {
                        }
                        column(PrintEntriesDue; PrintEntriesDue)
                        {
                        }
                        column(Currency2Code_CustLedgEntry2; Currency2.Code)
                        {
                        }
                        column(CurrencyCode3_CustLedgEntry2; CurrencyCode3)
                        {
                        }
                        column(CustNo_CustLedgEntry2; "Customer No.")
                        {
                        }
                        trigger OnAfterGetRecord();
                        var
                            CustLedgEntry: Record "Cust. Ledger Entry";
                        begin
                            if IncludeAgingBand then begin
                                if ("Posting Date" > EndDate) and ("Due Date" >= EndDate) then CurrReport.Skip;
                                if DateChoice = DateChoice::"Due Date" then if "Due Date" >= EndDate then CurrReport.Skip;
                            end;
                            CustLedgEntry := CustLedgEntry2;
                            CustLedgEntry.SetRange("Date Filter", 0D, EndDate);
                            CustLedgEntry.CalcFields("Remaining Amount");
                            "Remaining Amount" := CustLedgEntry."Remaining Amount";
                            if CustLedgEntry."Remaining Amount" = 0 then CurrReport.Skip;
                            if IncludeAgingBand and ("Posting Date" <= EndDate) then UpdateBuffer(Currency2.Code, GetDate("Posting Date", "Due Date"), "Remaining Amount");
                            if "Due Date" >= EndDate then CurrReport.Skip;
                            ClearCompanyPicture;
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not IncludeAgingBand then SetRange("Due Date", 0D, EndDate - 1);
                            SetRange("Currency Code", Currency2.Code);
                            if (not PrintEntriesDue) and (not IncludeAgingBand) then CurrReport.Break;
                        end;
                    }
                    trigger OnAfterGetRecord();
                    var
                        CustLedgerEntry: Record "Cust. Ledger Entry";
                    begin
                        if Number = 1 then Currency2.FindFirst;
                        repeat
                            if not IsFirstLoop then
                                IsFirstLoop := true
                            else if Currency2.Next = 0 then CurrReport.Break;
                            CustLedgerEntry.SetRange("Customer No.", Customer."No.");
                            CustLedgerEntry.SetRange("Posting Date", 0D, EndDate);
                            CustLedgerEntry.SetRange("Currency Code", Currency2.Code);
                            EntriesExists := not CustLedgerEntry.IsEmpty;
                        until EntriesExists;
                        Cust2 := Customer;
                        Cust2.SetRange("Date Filter", 0D, StartDate - 1);
                        Cust2.SetRange("Currency Filter", Currency2.Code);
                        Cust2.CalcFields("Net Change");
                        StartBalance := Cust2."Net Change";
                        CustBalance := Cust2."Net Change";
                    end;

                    trigger OnPreDataItem();
                    begin
                        Customer.CopyFilter("Currency Filter", Currency2.Code);
                    end;
                }
                dataitem(AgingBandLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                    column(AgingDate1; Format(AgingDate[1] + 1))
                    {
                    }
                    column(AgingDate2; Format(AgingDate[2]))
                    {
                    }
                    column(AgingDate21; Format(AgingDate[2] + 1))
                    {
                    }
                    column(AgingDate3; Format(AgingDate[3]))
                    {
                    }
                    column(AgingDate31; Format(AgingDate[3] + 1))
                    {
                    }
                    column(AgingDate4; Format(AgingDate[4]))
                    {
                    }
                    column(AgingBandEndingDate; StrSubstNo(Text011, AgingBandEndingDate, PeriodLength, SelectStr(DateChoice + 1, Text013)))
                    {
                    }
                    column(AgingDate41; Format(AgingDate[4] + 1))
                    {
                    }
                    column(AgingDate5; Format(AgingDate[5]))
                    {
                    }
                    column(AgingBandBufCol1Amt; AgingBandBuf."Column 1 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol2Amt; AgingBandBuf."Column 2 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol3Amt; AgingBandBuf."Column 3 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol4Amt; AgingBandBuf."Column 4 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol5Amt; AgingBandBuf."Column 5 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandCurrencyCode; AgingBandCurrencyCode)
                    {
                    }
                    column(beforeCaption; beforeCaptionLbl)
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        if Number = 1 then begin
                            ClearCompanyPicture;
                            if not AgingBandBuf.Find('-') then CurrReport.Break;
                        end
                        else if AgingBandBuf.Next = 0 then CurrReport.Break;
                        AgingBandCurrencyCode := AgingBandBuf."Currency Code";
                        if AgingBandCurrencyCode = '' then AgingBandCurrencyCode := GLSetup."LCY Code";
                    end;

                    trigger OnPreDataItem();
                    begin
                        if not IncludeAgingBand then CurrReport.Break;
                    end;
                }
            }
            trigger OnAfterGetRecord();
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
            begin
                AgingBandBuf.DeleteAll;
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                PrintLine := false;
                Cust2 := Customer;
                CopyFilter("Currency Filter", Currency2.Code);
                if PrintAllHavingBal then begin
                    if Currency2.Find('-') then
                        repeat
                            Cust2.SetRange("Date Filter", 0D, EndDate);
                            Cust2.SetRange("Currency Filter", Currency2.Code);
                            Cust2.CalcFields("Net Change");
                            PrintLine := Cust2."Net Change" <> 0;
                        until (Currency2.Next = 0) or PrintLine;
                end;
                if (not PrintLine) and PrintAllHavingEntry then begin
                    CustLedgerEntry.SetRange("Customer No.", "No.");
                    CustLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                    CopyFilter("Currency Filter", CustLedgerEntry."Currency Code");
                    PrintLine := not CustLedgerEntry.IsEmpty;
                end;
                if not PrintLine then CurrReport.Skip;
                FormatAddr.Customer(CustAddr, Customer);
                CurrReport.PageNo := 1;
                if not IsReportInPreviewMode then begin
                    LockTable;
                    Find;
                    "Last Statement No." := "Last Statement No." + 1;
                    Modify;
                    Commit;
                end
                else
                    "Last Statement No." := "Last Statement No." + 1;
                IsFirstLoop := false;
            end;

            trigger OnPreDataItem();
            begin
                VerifyDates;
                AgingBandEndingDate := EndDate;
                CalcAgingBandDates;
                CompanyInfo.Get;
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                Currency2.Code := '';
                Currency2.Insert;
                CopyFilter("Currency Filter", Currency.Code);
                if Currency.Find('-') then
                    repeat
                        Currency2 := Currency;
                        Currency2.Insert;
                    until Currency.Next = 0;
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

                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Start Date', ESM = 'Fecha inicial', FRC = 'Date de début', ENC = 'Start Date';
                        ToolTipML = ENU = 'Specifies the date from which the report or batch job processes information.', ESM = 'Especifica la fecha a partir de la cual el informe o el trabajo por lotes procesa la información.', FRC = 'Spécifie la date à partir de laquelle le rapport ou le traitement en lot traite les informations.', ENC = 'Specifies the date from which the report or batch job processes information.';
                    }
                    field("End Date"; EndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'End Date', ESM = 'Fecha final', FRC = 'Date de fin', ENC = 'End Date';
                        ToolTipML = ENU = 'Specifies the date to which the report or batch job processes information.', ESM = 'Especifica la fecha hasta la cual el informe o el trabajo por lotes procesa la información.', FRC = 'Spécifie la date jusqu''à laquelle le rapport ou le traitement en lot traite les informations.', ENC = 'Specifies the date to which the report or batch job processes information.';
                    }
                    field(ShowOverdueEntries; PrintEntriesDue)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Show Overdue Entries', ESM = 'Muestra movs. vencidos', FRC = 'Afficher les écritures en souffrance', ENC = 'Show Overdue Entries';
                        ToolTipML = ENU = 'Specifies if you want overdue entries to be shown separately for each currency.', ESM = 'Especifica si desea que los movimientos vencidos se muestren por separado por divisas.', FRC = 'Indique si vous souhaitez que les écritures dues soient affichées séparément pour chaque devise.', ENC = 'Specifies if you want overdue entries to be shown separately for each currency.';
                    }
                    group(Include)
                    {
                        CaptionML = ENU = 'Include', ESM = 'Incluye', FRC = 'Inclure', ENC = 'Include';

                        field(IncludeAllCustomerswithLE; PrintAllHavingEntry)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Include All Customers with Ledger Entries', ESM = 'Incluye todos los clientes con movs.', FRC = 'Inclure tous les clients ayant des écritures', ENC = 'Include All Customers with Ledger Entries';
                            MultiLine = true;
                            ToolTipML = ENU = 'Specifies if you want entries displayed for customers that have ledger entries at the end of the selected period.', ESM = 'Especifica si desea que se muestren los movimientos de los clientes que tienen movimientos contables al final del periodo seleccionado.', FRC = 'Indique si vous souhaitez que les écritures soient affichées pour les clients ayant des écritures à la fin de la période sélectionnée.', ENC = 'Specifies if you want entries displayed for customers that have ledger entries at the end of the selected period.';

                            trigger OnValidate();
                            begin
                                if not PrintAllHavingEntry then PrintAllHavingBal := true;
                            end;
                        }
                        field(IncludeAllCustomerswithBalance; PrintAllHavingBal)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Include All Customers with a Balance', ESM = 'Incluye todos los clientes con saldo', FRC = 'Inclure tous les clients ayant un solde', ENC = 'Include All Customers with a Balance';
                            MultiLine = true;
                            ToolTipML = ENU = 'Specifies if you want entries displayed for customers that have a balance at the end of the selected period.', ESM = 'Especifica si desea que se muestren los movimientos de los clientes que tienen saldo al final del periodo seleccionado.', FRC = 'Indique si vous souhaitez que les écritures soient affichées pour les clients avec un solde à la fin de la période sélectionnée.', ENC = 'Specifies if you want entries displayed for customers that have a balance at the end of the selected period.';

                            trigger OnValidate();
                            begin
                                if not PrintAllHavingBal then PrintAllHavingEntry := true;
                            end;
                        }
                        field(IncludeReversedEntries; PrintReversedEntries)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Include Reversed Entries', ESM = 'Incluir movs. revertidos', FRC = 'Inclure les écritures renversées', ENC = 'Include Reversed Entries';
                            ToolTipML = ENU = 'Specifies if you want to include reversed entries in the report.', ESM = 'Especifica si desea incluir movimientos revertidos en el informe.', FRC = 'Spécifie si vous souhaitez inclure les écritures inversées dans le rapport.', ENC = 'Specifies if you want to include reversed entries in the report.';
                        }
                        field(IncludeUnappliedEntries; PrintUnappliedEntries)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Include Unapplied Entries', ESM = 'Incluir movimientos no conciliados', FRC = 'Inclure écrit. non affect.', ENC = 'Include Unapplied Entries';
                            ToolTipML = ENU = 'Specifies if you want to include unapplied entries in the report.', ESM = 'Especifica si desea incluir movimientos no liquidados en el informe.', FRC = 'Spécifie si vous souhaitez inclure dans le rapport les écritures dont l''affectation a été annulée.', ENC = 'Specifies if you want to include unapplied entries in the report.';
                        }
                    }
                    group("Aging Band")
                    {
                        CaptionML = ENU = 'Aging Band', ESM = 'Rango antigüedad', FRC = 'Cumul', ENC = 'Aging Band';

                        field(IncludeAgingBand; IncludeAgingBand)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Include Aging Band', ESM = 'Incluye rango antigüedad', FRC = 'Inclure la bande chronologique', ENC = 'Include Aging Band';
                            ToolTipML = ENU = 'Specifies if you want an aging band to be included in the document. If you place a check mark here, you must also fill in the Aging Band Period Length and Aging Band by fields.', ESM = 'Especifica si desea incluir un rango de antigüedad en el documento. Si activa este campo, también debe rellenar los campos Longitud periodo rango antigüedad y Rango antigüedad por.', FRC = 'Spécifie si vous souhaitez qu''une bande chronologique soit incluse dans le document. Si vous cochez cette case, vous devez renseigner les champs Durée de période de la bande chronologique et Bande chronologique par.', ENC = 'Specifies if you want an aging band to be included in the document. If you place a check mark here, you must also fill in the Aging Band Period Length and Aging Band by fields.';
                        }
                        field(AgingBandPeriodLengt; PeriodLength)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Aging Band Period Length', ESM = 'Longitud periodo rango antigüedad', FRC = 'Durée de période de la bande chronologique', ENC = 'Aging Band Period Length';
                            ToolTipML = ENU = 'Specifies the length of each of the four periods in the aging band, for example, enter "1M" for one month. The most recent period will end on the last day of the period in the Date Filter field.', ESM = 'Especifica la duración de cada uno de los cuatro periodos del rango de antigüedad. Por ejemplo, introduzca "1M" para un mes. El periodo más reciente terminará el último día del periodo del campo Filtro fecha.', FRC = 'Spécifie la longueur de chacune des quatre périodes dans le bande chronologique ; par exemple, saisissez « 1M » pour un mois. La période la plus récente se termine le dernier jour de la période dans le champ Filtre date.', ENC = 'Specifies the length of each of the four periods in the aging band, for example, enter "1M" for one month. The most recent period will end on the last day of the period in the Date Filter field.';
                        }
                        field(AgingBandby; DateChoice)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Aging Band by', ESM = 'Rango antigüedad por', FRC = 'Bande chronologique par', ENC = 'Aging Band by';
                            OptionCaptionML = ENU = 'Due Date,Posting Date', ESM = 'Fecha vto.,Fecha registro', FRC = 'Date d''échéance,Date de report', ENC = 'Due Date,Posting Date';
                            ToolTipML = ENU = 'Specifies if the aging band will be calculated from the due date or from the posting date.', ESM = 'Especifica si el rango de antigüedad se calculará desde la fecha de vencimiento o desde la fecha de registro.', FRC = 'Spécifie si la bande chronologique est calculée à partir de la date d''échéance ou de la date de report.', ENC = 'Specifies if the aging band will be calculated from the due date or from the posting date.';
                        }
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Log Interaction', ESM = 'Log interacción', FRC = 'Journal interaction', ENC = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTipML = ENU = 'Specifies that interactions with the contact are logged.', ESM = 'Especifica que las interacciones con el contacto están registradas.', FRC = 'Spécifie que les interactions avec le contact sont enregistrées.', ENC = 'Specifies that interactions with the contact are logged.';
                    }
                }
                group("Output Options")
                {
                    CaptionML = ENU = 'Output Options', ESM = 'Opciones de salida', FRC = 'Options sortie', ENC = 'Output Options';

                    field(ReportOutput; SupportedOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Report Output', ESM = 'Salida de informe', FRC = 'Sortie rapport', ENC = 'Report Output';
                        OptionCaptionML = ENU = 'Print,Preview,PDF,Email,Excel,XML', ESM = 'Imprimir,Vista previa,PDF,Correo electrónico,Excel,XML', FRC = 'Imprimer,Aperçu,PDF,Courriel,Excel,XML', ENC = 'Print,Preview,PDF,Email,Excel,XML';
                        ToolTipML = ENU = 'Specifies the output of the scheduled report, such as PDF or Word.', ESM = 'Especifica el tipo del informe programado, como PDF o Word.', FRC = 'Spécifie la sortie du rapport programmé, par exemple PDF ou Word.', ENC = 'Specifies the output of the scheduled report, such as PDF or Word.';

                        trigger OnValidate();
                        var
                            CustomLayoutReporting: Codeunit "Custom Layout Reporting";
                        begin
                            ShowPrintIfEmailIsMissing := (SupportedOutputMethod = SupportedOutputMethod::Email);
                            case SupportedOutputMethod of
                                SupportedOutputMethod::Print:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPrintOption;
                                SupportedOutputMethod::Preview:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPreviewOption;
                                SupportedOutputMethod::PDF:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPDFOption;
                                SupportedOutputMethod::Email:
                                    ChosenOutputMethod := CustomLayoutReporting.GetEmailOption;
                                SupportedOutputMethod::Excel:
                                    ChosenOutputMethod := CustomLayoutReporting.GetExcelOption;
                                SupportedOutputMethod::XML:
                                    ChosenOutputMethod := CustomLayoutReporting.GetXMLOption;
                            end;
                        end;
                    }
                    field(ChosenOutput; ChosenOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Chosen Output', ESM = 'Salida elegida', FRC = 'Sortie choisie', ENC = 'Chosen Output';
                        ToolTipML = ENU = 'Specifies how to output the report, such as Print or Excel.', ESM = 'Especifica cómo producir el informe, como Imprimir o Excel.', FRC = 'Spécifie le mode de sortie du rapport, par exemple Imprimer ou Excel.', ENC = 'Specifies how to output the report, such as Print or Excel.';
                        Visible = false;
                    }
                    group(EmailOptions)
                    {
                        CaptionML = ENU = 'Email Options', ESM = 'Opciones de correo electrónico', FRC = 'Options de courriel', ENC = 'Email Options';
                        Visible = ShowPrintIfEmailIsMissing;

                        field(PrintMissingAddresses; PrintIfEmailIsMissing)
                        {
                            ApplicationArea = Basic, Suite;
                            CaptionML = ENU = 'Print Although Email is Missing', ESM = 'Imprimir aunque falte correo electrónico', FRC = 'Imprimer bien qu''il manque l''adresse de courriel', ENC = 'Print Although Email is Missing';
                            ToolTipML = ENU = 'Specifies if you want to print also the statements for customers that have not been set up with a send-to email address.', ESM = 'Especifica si desea imprimir también los estados de cuenta de los clientes que no se han configurado con una dirección de correo electrónico de envío.', FRC = 'Spécifie si vous souhaitez imprimer également les relevés des clients n''ayant pas été configurés avec une adresse de courriel de destinataire.', ENC = 'Specifies if you want to print also the statements for customers that have not been set up with a send-to email address.';
                        }
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage();
        begin
            InitRequestPageDataInternal;
        end;
    }
    labels
    {
    }
    trigger OnInitReport();
    begin
        GLSetup.Get;
        SalesSetup.Get;
        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo1.Get;
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo2.Get;
                    CompanyInfo2.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo3.Get;
                    CompanyInfo3.CalcFields(Picture);
                end;
        end;
        LogInteractionEnable := true;
    end;

    trigger OnPostReport();
    begin
        if LogInteraction and not IsReportInPreviewMode then
            if Customer.FindSet then
                repeat
                    SegManagement.LogDocument(7, Format(Customer."Last Statement No."), 0, 0, DATABASE::Customer, Customer."No.", Customer."Salesperson Code", '', Text003 + Format(Customer."Last Statement No."), '');
                until Customer.Next = 0;
    end;

    trigger OnPreReport();
    begin
        InitRequestPageDataInternal;
    end;

    var
        Text001: TextConst ENU = 'Entries %1', ESM = 'Movimientos %1', FRC = 'Écritures %1', ENC = 'Entries %1';
        Text002: TextConst ENU = 'Overdue Entries %1', ESM = 'Movs. vencidos %1', FRC = 'Écritures en souffrance %1', ENC = 'Overdue Entries %1';
        Text003: TextConst ENU = 'Statement ', ESM = 'Estado de cuenta ', FRC = 'Relevé ', ENC = 'Statement ';
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        Cust2: Record Customer;
        Currency: Record Currency;
        Currency2: Record Currency temporary;
        //Language: Record Language;
        Language: Codeunit Language;
        DtldCustLedgEntries2: Record "Detailed Cust. Ledg. Entry";
        AgingBandBuf: Record "Aging Band Buffer" temporary;
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        PrintAllHavingEntry: Boolean;
        PrintAllHavingBal: Boolean;
        PrintEntriesDue: Boolean;
        PrintUnappliedEntries: Boolean;
        PrintReversedEntries: Boolean;
        PrintLine: Boolean;
        LogInteraction: Boolean;
        EntriesExists: Boolean;
        StartDate: Date;
        EndDate: Date;
        DueDate: Date;
        CustAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        Description: Text[100];
        StartBalance: Decimal;
        CustBalance: Decimal;
        RemainingAmount: Decimal;
        CurrencyCode3: Code[10];
        Text005: TextConst ENU = 'Multicurrency Application', ESM = 'Aplicación multidivisa', FRC = 'Affectation multidevise', ENC = 'Multicurrency Application';
        Text006: TextConst ENU = 'Payment Discount', ESM = 'Descuento P.P.', FRC = 'Escompte de paiement', ENC = 'Payment Discount';
        Text007: TextConst ENU = 'Rounding', ESM = 'Redondeo', FRC = 'Arrondissement', ENC = 'Rounding';
        PeriodLength: DateFormula;
        PeriodLength2: DateFormula;
        DateChoice: Option "Due Date","Posting Date";
        AgingDate: array[5] of Date;
        Text008: TextConst ENU = 'You must specify the Aging Band Period Length.', ESM = 'Debe especificar la longitud periodo rango antigüedad.', FRC = 'Vous devez indiquer la durée de la période de la bande chronologique.', ENC = 'You must specify the Aging Band Period Length.';
        AgingBandEndingDate: Date;
        Text010: TextConst ENU = 'You must specify Aging Band Ending Date.', ESM = 'Debe especificar la fecha final del rango antigüedad.', FRC = 'Vous devez indiquer la date de fin de la bande chronologique', ENC = 'You must specify Aging Band Ending Date.';
        Text011: TextConst ENU = 'Aged Summary by %1 (%2 by %3)', ESM = 'Sumario por fecha de %1 (%2 por %3)', FRC = 'Sommaire classé chronologiquement par %1 (%2 par %3)', ENC = 'Aged Summary by %1 (%2 by %3)';
        IncludeAgingBand: Boolean;
        Text012: TextConst ENU = 'Period Length is out of range.', ESM = 'La longitud del periodo está fuera del rango.', FRC = 'La période ne correspond pas à l''intervalle défini.', ENC = 'Period Length is out of range.';
        AgingBandCurrencyCode: Code[20];
        Text013: TextConst ENU = 'Due Date,Posting Date', ESM = 'Fecha vto.,Fecha registro', FRC = 'Date d''échéance,Date de report', ENC = 'Due Date,Posting Date';
        Text014: TextConst ENU = 'Application Writeoffs', ESM = 'Application Writeoffs', FRC = 'Écarts d''affectation', ENC = 'Application Writeoffs';
        [InDataSet]
        LogInteractionEnable: Boolean;
        Text036: TextConst Comment = 'Negating the period length: %1 is the period length', ENU = '-%1', ESM = '-%1', FRC = '-%1', ENC = '-%1';
        StatementCaptionLbl: TextConst ENU = 'Statement', ESM = 'Estado de cuenta', FRC = 'Relevé', ENC = 'Statement';
        PhoneNo_CompanyInfoCaptionLbl: TextConst ENU = 'Phone No.', ESM = 'Nº teléfono', FRC = 'N° téléphone', ENC = 'Phone No.';
        VATRegNo_CompanyInfoCaptionLbl: TextConst ENU = 'Tax Registration No.', ESM = 'RFC/Curp', FRC = 'N° identif. intracomm.', ENC = 'GST/HST Registration No.';
        GiroNo_CompanyInfoCaptionLbl: TextConst ENU = 'Giro No.', ESM = 'Nº giro postal', FRC = 'N° CCP', ENC = 'Giro No.';
        BankName_CompanyInfoCaptionLbl: TextConst ENU = 'Bank', ESM = 'Banco', FRC = 'Banque', ENC = 'Bank';
        BankAccNo_CompanyInfoCaptionLbl: TextConst ENU = 'Account No.', ESM = 'Nº cuenta', FRC = 'N° de compte', ENC = 'Account No.';
        No1_CustCaptionLbl: TextConst ENU = 'Customer No.', ESM = 'Nº cliente', FRC = 'N° de client', ENC = 'Customer No.';
        StartDateCaptionLbl: TextConst ENU = 'Starting Date', ESM = 'Fecha inicial', FRC = 'Date début', ENC = 'Starting Date';
        EndDateCaptionLbl: TextConst ENU = 'Ending Date', ESM = 'Fecha final', FRC = 'Date fin', ENC = 'Ending Date';
        LastStatmntNo_CustCaptionLbl: TextConst ENU = 'Statement No.', ESM = 'Nº estado de cta. Banco', FRC = 'N° de relevé', ENC = 'Statement No.';
        PostDate_DtldCustLedgEntriesCaptionLbl: TextConst ENU = 'Posting Date', ESM = 'Fecha registro', FRC = 'Date de report', ENC = 'Posting Date';
        DueDate_CustLedgEntry2CaptionLbl: TextConst ENU = 'Due Date', ESM = 'Fecha vencimiento', FRC = 'Date d''échéance', ENC = 'Due Date';
        CustBalanceCaptionLbl: TextConst ENU = 'Running Total', ESM = 'Total acumulado', FRC = 'Total exécution', ENC = 'Running Total';
        beforeCaptionLbl: TextConst ENU = '..before', ESM = '...antes', FRC = '..avant', ENC = '..before';
        isInitialized: Boolean;
        CompanyInfoHomepageCaptionLbl: TextConst ENU = 'Home Page', ESM = 'Página principal', FRC = 'Page d''accueil', ENC = 'Home Page';
        CompanyInfoEmailCaptionLbl: TextConst ENU = 'Email', ESM = 'Correo electrónico', FRC = 'Courriel', ENC = 'Email';
        DocDateCaptionLbl: TextConst ENU = 'Document Date', ESM = 'Fecha emisión documento', FRC = 'Date document', ENC = 'Document Date';
        Total_CaptionLbl: TextConst ENU = 'Total', ESM = 'Total', FRC = 'Total', ENC = 'Total';
        BlankStartDateErr: TextConst ENU = 'Start Date must have a value.', ESM = 'La fecha inicial debe tener un valor.', FRC = 'Date début doit avoir une valeur.', ENC = 'Start Date must have a value.';
        BlankEndDateErr: TextConst ENU = 'End Date must have a value.', ESM = 'La fecha final debe tener un valor.', FRC = 'Date fin doit avoir une valeur.', ENC = 'End Date must have a value.';
        StartDateLaterTheEndDateErr: TextConst ENU = 'Start date must be earlier than End date.', ESM = 'La fecha inicial debe ser anterior a la fecha final.', FRC = 'Date début doit être antérieure à Date fin.', ENC = 'Start date must be earlier than End date.';
        IsFirstLoop: Boolean;
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page', ESM = 'Pág.', FRC = 'Page', ENC = 'Page';
        IsFirstPrintLine: Boolean;
        IsNewCustCurrencyGroup: Boolean;
        SupportedOutputMethod: Option Print,Preview,PDF,Email,Excel,XML;
        ChosenOutputMethod: Integer;
        PrintIfEmailIsMissing: Boolean;
        [InDataSet]
        ShowPrintIfEmailIsMissing: Boolean;
        FirstCustomerPrinted: Boolean;

    local procedure GetDate(PostingDate: Date; DueDate: Date): Date;
    begin
        if DateChoice = DateChoice::"Posting Date" then exit(PostingDate);
        exit(DueDate);
    end;

    local procedure CalcAgingBandDates();
    begin
        if not IncludeAgingBand then exit;
        if AgingBandEndingDate = 0D then Error(Text010);
        if Format(PeriodLength) = '' then Error(Text008);
        Evaluate(PeriodLength2, StrSubstNo(Text036, PeriodLength));
        AgingDate[5] := AgingBandEndingDate;
        AgingDate[4] := CalcDate(PeriodLength2, AgingDate[5]);
        AgingDate[3] := CalcDate(PeriodLength2, AgingDate[4]);
        AgingDate[2] := CalcDate(PeriodLength2, AgingDate[3]);
        AgingDate[1] := CalcDate(PeriodLength2, AgingDate[2]);
        if AgingDate[2] <= AgingDate[1] then Error(Text012);
    end;

    local procedure UpdateBuffer(CurrencyCode: Code[10]; Date: Date; Amount: Decimal);
    var
        I: Integer;
        GoOn: Boolean;
    begin
        AgingBandBuf.Init;
        AgingBandBuf."Currency Code" := CurrencyCode;
        if not AgingBandBuf.Find then AgingBandBuf.Insert;
        I := 1;
        GoOn := true;
        while (I <= 5) and GoOn do begin
            if Date <= AgingDate[I] then
                if I = 1 then begin
                    AgingBandBuf."Column 1 Amt." := AgingBandBuf."Column 1 Amt." + Amount;
                    GoOn := false;
                end;
            if Date <= AgingDate[I] then
                if I = 2 then begin
                    AgingBandBuf."Column 2 Amt." := AgingBandBuf."Column 2 Amt." + Amount;
                    GoOn := false;
                end;
            if Date <= AgingDate[I] then
                if I = 3 then begin
                    AgingBandBuf."Column 3 Amt." := AgingBandBuf."Column 3 Amt." + Amount;
                    GoOn := false;
                end;
            if Date <= AgingDate[I] then
                if I = 4 then begin
                    AgingBandBuf."Column 4 Amt." := AgingBandBuf."Column 4 Amt." + Amount;
                    GoOn := false;
                end;
            if Date <= AgingDate[I] then
                if I = 5 then begin
                    AgingBandBuf."Column 5 Amt." := AgingBandBuf."Column 5 Amt." + Amount;
                    GoOn := false;
                end;
            I := I + 1;
        end;
        AgingBandBuf.Modify;
    end;

    procedure SkipReversedUnapplied(var DtldCustLedgEntries: Record "Detailed Cust. Ledg. Entry"): Boolean;
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        if PrintReversedEntries and PrintUnappliedEntries then exit(false);
        if not PrintUnappliedEntries then if DtldCustLedgEntries.Unapplied then exit(true);
        if not PrintReversedEntries then begin
            CustLedgEntry.Get(DtldCustLedgEntries."Cust. Ledger Entry No.");
            if CustLedgEntry.Reversed then exit(true);
        end;
        exit(false);
    end;

    procedure InitializeRequest(NewPrintEntriesDue: Boolean; NewPrintAllHavingEntry: Boolean; NewPrintAllHavingBal: Boolean; NewPrintReversedEntries: Boolean; NewPrintUnappliedEntries: Boolean; NewIncludeAgingBand: Boolean; NewPeriodLength: Text[30]; NewDateChoice: Option; NewLogInteraction: Boolean; NewStartDate: Date; NewEndDate: Date);
    begin
        InitRequestPageDataInternal;
        PrintEntriesDue := NewPrintEntriesDue;
        PrintAllHavingEntry := NewPrintAllHavingEntry;
        PrintAllHavingBal := NewPrintAllHavingBal;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintUnappliedEntries := NewPrintUnappliedEntries;
        IncludeAgingBand := NewIncludeAgingBand;
        Evaluate(PeriodLength, NewPeriodLength);
        DateChoice := NewDateChoice;
        LogInteraction := NewLogInteraction;
        StartDate := NewStartDate;
        EndDate := NewEndDate;
    end;

    local procedure IsReportInPreviewMode(): Boolean;
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;

    procedure InitRequestPageDataInternal();
    begin
        if isInitialized then exit;
        isInitialized := true;
        if (not PrintAllHavingEntry) and (not PrintAllHavingBal) then PrintAllHavingBal := true;
        //LogInteraction:=SegManagement.FindInteractTmplCode(7) <> '';
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Stmnt.") <> '';
        LogInteractionEnable := LogInteraction;
        if Format(PeriodLength) = '' then Evaluate(PeriodLength, '<1M+CM>');
        PrintIfEmailIsMissing := (SupportedOutputMethod = SupportedOutputMethod::Email);
    end;

    local procedure VerifyDates();
    begin
        if StartDate = 0D then Error(BlankStartDateErr);
        if EndDate = 0D then Error(BlankEndDateErr);
        if StartDate > EndDate then Error(StartDateLaterTheEndDateErr);
    end;

    local procedure ClearCompanyPicture();
    begin
        if FirstCustomerPrinted then begin
            Clear(CompanyInfo.Picture);
            Clear(CompanyInfo1.Picture);
            Clear(CompanyInfo2.Picture);
            Clear(CompanyInfo3.Picture);
        end;
        FirstCustomerPrinted := true;
    end;
}
