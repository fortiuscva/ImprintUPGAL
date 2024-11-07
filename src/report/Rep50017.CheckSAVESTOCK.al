report 50017 "Check SAVE STOCK"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2004-04-21" area="BUG FIX"  request=""
    //     releaseversion="NAVNA4.00">Test for Blank Check number</add>
    //   <change id="NA0002" dev="ELYNCH" date="2004-04-21" area="BUG FIX W1"  request="US-61-566-3PJV"
    //     releaseversion="NAVNA4.00">Warning message that checks cannot be financially voided when Force Doc. Balance is
    //     set to No in the Journal Template.</change>
    //   <change id="NA0003" dev="ELYNCH" date="2004-04-21" area="BUG FIX W1"  request="HQ-29-463-9QS8"
    //     releaseversion="NAVNA4.00">Incorrect Text Constant used for error message if Cust or Vend is Blocked.
    //     </change>
    //   <change id="NA0004" dev="ELYNCH" date="2004-04-21" area="CHECKPRINT" feature="???"
    //     releaseversion="NAVNA4.00">Removed Currency code and line amounts and totalling in currency</change>
    //   <change id="NA0005" dev="ELYNCH" date="2004-04-22" area="CHECKPRINT" feature="???"
    //     releaseversion="NAVNA4.00">Request form prompt to commit each check, executes a Commit</change>
    //   <change id="NA0006" dev="ELYNCH" date="2004-04-22" area="CHECKPRINT" feature="???"
    //     releaseversion="NAVNA4.00">Check Ledger Description uses Customer or Vendor Name</change>
    //   <change id="NA0007" dev="ELYNCH" date="2004-04-22" area="CHECKPRINT" feature="???"
    //     releaseversion="NAVNA4.00">Use Document Date rather than Posting Date and for Vendors use External Document
    //     No. rather than Document No.</change>
    //   <change id="NA0008" dev="ELYNCH" date="2005-01-11" area="CHECKPRINT"  request="4075"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA4.00.01">Stub Information on the check wasn&apos;t showing
    //     Payment Discount in the case of a Payment Discount Tolerance.</change>
    //   <change id="NA0009" dev="ELYNCH" date="2005-03-14" area="CHECKPRINT"  request="7000"
    //     baseversion="NAVNA4.00" releaseversion="NAVNA4.00.01">Added Text Constant &apos;DOLLARS&apos; to print when
    //     there is no currency code.</change>
    //   <change id="NA0010" dev="ELYNCH" date="2005-11-29" area="CHECKPRINT"  request="1979"
    //     baseversion="NAVNA4.00.01" releaseversion="NAVNA4.00.02">Added code from W1 PS 1979.</change>
    //   <change id="NA0011" dev="ELYNCH" date="2005-11-29" area="CHECKPRINT"  request="13805"
    //     baseversion="NAVNA4.00.01" releaseversion="NAVNA4.00.02">SP1 improvement to CustUpdateAmounts.</change>
    //   <change id="NA0012" dev="JNOZZI" date="2006-06-15" area="CHECKPRINT" feature="286"
    //     baseversion="NAVNA4.00.02" releaseversion="NAVNA5.00">Call new Translation Codeunit, so that all North America
    //     languages are covered. Remove InitTextVariable, FormatNoText and AddToNoText functions. Also, align better with W1
    //     version for 5.00.</change>
    //   <change id="NA0013" dev="JNOZZI" date="2006-06-26" area="CHECKPRINT" feature="286"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Allow both the US Check Style and the Canadian Check Style
    //     to be printed using the same report.</change>
    //   <change id="NA0014" dev="MBAHADUR" date="2007-12-03" area="CHECKPRINT" feature="31622"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.01">Modify to Show Posting Description.</change>
    //   <change id="NA0015" dev="JNOZZI" date="2007-12-21" area="CHECKPRINT"  request="31873"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.01">Remove carry-forward totals from Check Stubs; they were
    //     causing actual check-stub lines to be dropped.</change>
    //   <change id="NA0016" dev="V-FRXUE" date="2008-06-20" area="CHECKPRINT" feature="NC14261"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA6.00">Report Transformation - Localized Reports Layout.
    //     </change>
    //   <change id="NA0017" dev="AUGMENTUM" date="2009-03-09" area="CHECKPRINT" feature="NC3720"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00.01">Report Transformation - change the print oreintation to
    //     remove the blank page</change>
    //   <change id="NA0018" dev="v-zhaleo" date="2011-01-27" area="CHECKPRINT" feature="TFS246104"
    //     baseversion="NAVNA6.00.01" releaseversion="NAVNA7.00">
    //     Issue exists with Payment Journal Processing when a mix of LCY Invoice
    //   </change>
    // </changelog>
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Check SAVE STOCK.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Check';
    Permissions = TableData "Bank Account" = m;

    dataset
    {
        dataitem(VoidGenJnlLine; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Posting Date";

            trigger OnAfterGetRecord()
            begin
                CheckManagement.VoidCheck(VoidGenJnlLine);
            end;

            trigger OnPreDataItem()
            begin
                IF CurrReport.PREVIEW THEN ERROR(Text000);
                IF UseCheckNo = '' THEN ERROR(Text001);
                //NA0001.begin
                IF INCSTR(UseCheckNo) = '' THEN ERROR(USText004);
                //NA0001.end
                IF TestPrint THEN CurrReport.BREAK;
                IF NOT ReprintChecks THEN CurrReport.BREAK;
                IF (GETFILTER("Line No.") <> '') OR (GETFILTER("Document No.") <> '') THEN ERROR(Text002, FIELDCAPTION("Line No."), FIELDCAPTION("Document No."));
                SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                SETRANGE("Check Printed", TRUE);
            end;
        }
        dataitem(TestGenJnlLine; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");

            trigger OnAfterGetRecord()
            begin
                // NA0013.begin
                IF Amount = 0 THEN CurrReport.SKIP;
                TESTFIELD("Bal. Account Type", "Bal. Account Type"::"Bank Account");
                IF "Bal. Account No." <> BankAcc2."No." THEN CurrReport.SKIP;
                CASE "Account Type" OF
                    "Account Type"::"G/L Account":
                        BEGIN
                            IF BankAcc2."Check Date Format" = BankAcc2."Check Date Format"::" " THEN ERROR(USText006, BankAcc2.FIELDCAPTION("Check Date Format"), BankAcc2.TABLECAPTION, BankAcc2."No.");
                            IF BankAcc2."Bank Communication" = BankAcc2."Bank Communication"::"S Spanish" THEN ERROR(USText007, BankAcc2.FIELDCAPTION("Bank Communication"), BankAcc2.TABLECAPTION, BankAcc2."No.");
                        END;
                    "Account Type"::Customer:
                        BEGIN
                            Cust.GET("Account No.");
                            IF Cust."Check Date Format" = Cust."Check Date Format"::" " THEN ERROR(USText006, Cust.FIELDCAPTION("Check Date Format"), Cust.TABLECAPTION, "Account No.");
                            IF Cust."Bank Communication" = Cust."Bank Communication"::"S Spanish" THEN ERROR(USText007, Cust.FIELDCAPTION("Bank Communication"), Cust.TABLECAPTION, "Account No.");
                        END;
                    "Account Type"::Vendor:
                        BEGIN
                            Vend.GET("Account No.");
                            IF Vend."Check Date Format" = Vend."Check Date Format"::" " THEN ERROR(USText006, Vend.FIELDCAPTION("Check Date Format"), Vend.TABLECAPTION, "Account No.");
                            IF Vend."Bank Communication" = Vend."Bank Communication"::"S Spanish" THEN ERROR(USText007, Vend.FIELDCAPTION("Bank Communication"), Vend.TABLECAPTION, "Account No.");
                        END;
                    "Account Type"::"Bank Account":
                        BEGIN
                            BankAcc.GET("Account No.");
                            IF BankAcc."Check Date Format" = BankAcc."Check Date Format"::" " THEN ERROR(USText006, BankAcc.FIELDCAPTION("Check Date Format"), BankAcc.TABLECAPTION, "Account No.");
                            IF BankAcc."Bank Communication" = BankAcc."Bank Communication"::"S Spanish" THEN ERROR(USText007, BankAcc.FIELDCAPTION("Bank Communication"), BankAcc.TABLECAPTION, "Account No.");
                        END;
                END;
                // NA0013.end
            end;

            trigger OnPreDataItem()
            begin
                //NA0016.BEGIN
                IF TestPrint THEN BEGIN
                    CompanyInfo.GET;
                    BankAcc2.GET(BankAcc2."No.");
                    BankCurrencyCode := BankAcc2."Currency Code";
                END;
                //NA0016.END;
                // NA0013.begin
                IF TestPrint THEN CurrReport.BREAK;
                CompanyInfo.GET;
                BankAcc2.GET(BankAcc2."No.");
                BankCurrencyCode := BankAcc2."Currency Code"; //NA0016
                IF BankAcc2."Country/Region Code" <> CompanyInfo."Country/Region Code" THEN CurrReport.BREAK;
                BankAcc2.TESTFIELD(Blocked, FALSE);
                COPY(VoidGenJnlLine);
                BankAcc2.GET(BankAcc2."No.");
                BankAcc2.TESTFIELD(Blocked, FALSE);
                SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                SETRANGE("Check Printed", FALSE);
                // NA0013.end
            end;
        }
        dataitem(GenJnlLine; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");

            column(JnlTemplateName_GenJnlLine; "Journal Template Name")
            {
            }
            column(JnlBatchName_GenJnlLine; "Journal Batch Name")
            {
            }
            column(LineNo_GenJnlLine; "Line No.")
            {
            }
            dataitem(CheckPages; "Integer")
            {
                DataItemTableView = SORTING(Number);

                column(CheckToAddr1; CheckToAddr[1])
                {
                }
                column(CheckDateTxt; FORMAT(CheckDateText))
                {
                }
                column(CheckNoTxt; CheckNoText)
                {
                }
                column(PreprintedStub; PreprintedStub)
                {
                }
                column(CheckNoTextCaption; CheckNoTextCaptionLbl)
                {
                }
                dataitem(PrintSettledLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 30;

                    column(LineAmt; LineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineDisc; LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmtLineDisc; LineAmount + LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(DocNo; DocNo)
                    {
                    }
                    column(DocDate; DocDate)
                    {
                    }
                    column(PostingDesc; PostingDesc)
                    {
                    }
                    column(PageNo; PageNo)
                    {
                    }
                    column(NetAmount; NetAmountLbl)
                    {
                    }
                    column(LineDiscountCaption; LineDiscountCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(DocNoCaption; DocNoCaptionLbl)
                    {
                    }
                    column(DocDateCaption; DocDateCaptionLbl)
                    {
                    }
                    column(PostingDescriptionCaption; PostingDescriptionCaptionLbl)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF NOT TestPrint THEN BEGIN
                            IF FoundLast THEN BEGIN
                                IF RemainingAmount <> 0 THEN BEGIN
                                    DocType := Text015;
                                    DocNo := '';
                                    ExtDocNo := '';
                                    DocDate := 0D;
                                    LineAmount := RemainingAmount;
                                    LineAmount2 := RemainingAmount;
                                    CurrentLineAmount := LineAmount2;
                                    LineDiscount := 0;
                                    RemainingAmount := 0;
                                    //NA0014.begin
                                    PostingDesc := CheckToAddr[1];
                                    //NA0014.end
                                END
                                ELSE
                                    CurrReport.BREAK;
                            END
                            ELSE
                                CASE ApplyMethod OF
                                    ApplyMethod::OneLineOneEntry:
                                        BEGIN
                                            CASE BalancingType OF
                                                BalancingType::Customer:
                                                    BEGIN
                                                        CustLedgEntry.RESET;
                                                        CustLedgEntry.SETCURRENTKEY("Document No.");
                                                        CustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                        CustLedgEntry.FIND('-');
                                                        CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                    END;
                                                BalancingType::Vendor:
                                                    BEGIN
                                                        VendLedgEntry.RESET;
                                                        VendLedgEntry.SETCURRENTKEY("Document No.");
                                                        VendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                        VendLedgEntry.FIND('-');
                                                        VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                    END;
                                            END;
                                            RemainingAmount := RemainingAmount - LineAmount2;
                                            CurrentLineAmount := LineAmount2;
                                            FoundLast := TRUE;
                                        END;
                                    ApplyMethod::OneLineID:
                                        BEGIN
                                            CASE BalancingType OF
                                                BalancingType::Customer:
                                                    BEGIN
                                                        CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                        FoundLast := (CustLedgEntry.NEXT = 0) OR (RemainingAmount <= 0);
                                                        IF FoundLast AND NOT FoundNegative THEN BEGIN
                                                            CustLedgEntry.SETRANGE(Positive, FALSE);
                                                            FoundLast := NOT CustLedgEntry.FIND('-');
                                                            FoundNegative := TRUE;
                                                        END;
                                                    END;
                                                BalancingType::Vendor:
                                                    BEGIN
                                                        VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                        FoundLast := (VendLedgEntry.NEXT = 0) OR (RemainingAmount <= 0);
                                                        IF FoundLast AND NOT FoundNegative THEN BEGIN
                                                            VendLedgEntry.SETRANGE(Positive, FALSE);
                                                            FoundLast := NOT VendLedgEntry.FIND('-');
                                                            FoundNegative := TRUE;
                                                        END;
                                                    END;
                                            END;
                                            RemainingAmount := RemainingAmount - LineAmount2;
                                            CurrentLineAmount := LineAmount2;
                                        END;
                                    ApplyMethod::MoreLinesOneEntry:
                                        BEGIN
                                            CurrentLineAmount := GenJnlLine2.Amount;
                                            LineAmount2 := CurrentLineAmount;
                                            IF GenJnlLine2."Applies-to ID" <> '' THEN ERROR(Text016);
                                            GenJnlLine2.TESTFIELD("Check Printed", FALSE);
                                            GenJnlLine2.TESTFIELD("Bank Payment Type", GenJnlLine2."Bank Payment Type"::"Computer Check");
                                            IF BankAcc2."Currency Code" <> GenJnlLine2."Currency Code" THEN ERROR(Text005);
                                            IF GenJnlLine2."Applies-to Doc. No." = '' THEN BEGIN
                                                DocType := Text015;
                                                DocNo := '';
                                                ExtDocNo := '';
                                                DocDate := 0D;
                                                LineAmount := CurrentLineAmount;
                                                LineDiscount := 0;
                                                //NA0014.begin
                                                PostingDesc := GenJnlLine2.Description;
                                                //NA0014.end
                                            END
                                            ELSE
                                                CASE BalancingType OF
                                                    BalancingType::"G/L Account":
                                                        BEGIN
                                                            DocType := FORMAT(GenJnlLine2."Document Type");
                                                            DocNo := GenJnlLine2."Document No.";
                                                            ExtDocNo := GenJnlLine2."External Document No.";
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                            //NA0014.begin
                                                            PostingDesc := GenJnlLine2.Description;
                                                            //NA0014.end
                                                        END;
                                                    BalancingType::Customer:
                                                        BEGIN
                                                            CustLedgEntry.RESET;
                                                            CustLedgEntry.SETCURRENTKEY("Document No.");
                                                            CustLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                            CustLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                            CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                            CustLedgEntry.FIND('-');
                                                            CustUpdateAmounts(CustLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        END;
                                                    BalancingType::Vendor:
                                                        BEGIN
                                                            VendLedgEntry.RESET;
                                                            IF GenJnlLine2."Source Line No." <> 0 THEN
                                                                VendLedgEntry.SETRANGE("Entry No.", GenJnlLine2."Source Line No.")
                                                            ELSE BEGIN
                                                                VendLedgEntry.SETCURRENTKEY("Document No.");
                                                                VendLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                                VendLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                                VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                            END;
                                                            VendLedgEntry.FIND('-');
                                                            VendUpdateAmounts(VendLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        END;
                                                    BalancingType::"Bank Account":
                                                        BEGIN
                                                            DocType := FORMAT(GenJnlLine2."Document Type");
                                                            DocNo := GenJnlLine2."Document No.";
                                                            ExtDocNo := GenJnlLine2."External Document No.";
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                            //NA0014.begin
                                                            PostingDesc := GenJnlLine2.Description;
                                                            //NA0014.end
                                                        END;
                                                END;
                                            FoundLast := GenJnlLine2.NEXT = 0;
                                        END;
                                END;
                            TotalLineAmount := TotalLineAmount + LineAmount2;
                            TotalLineDiscount := TotalLineDiscount + LineDiscount;
                        END
                        ELSE BEGIN
                            IF FoundLast THEN CurrReport.BREAK;
                            FoundLast := TRUE;
                            DocType := Text018;
                            DocNo := Text010;
                            ExtDocNo := Text010;
                            LineAmount := 0;
                            LineDiscount := 0;
                            //NA0014.begin
                            PostingDesc := '';
                            //NA0014.end
                        END;
                        //NA0016.BEGIN
                        IF DocNo = '' THEN CurrencyCode2 := GenJnlLine."Currency Code";
                        //NA0016.END
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT TestPrint THEN
                            IF FirstPage THEN BEGIN
                                FoundLast := TRUE;
                                CASE ApplyMethod OF
                                    ApplyMethod::OneLineOneEntry:
                                        FoundLast := FALSE;
                                    ApplyMethod::OneLineID:
                                        CASE BalancingType OF
                                            BalancingType::Customer:
                                                BEGIN
                                                    CustLedgEntry.RESET;
                                                    CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                                                    CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                    CustLedgEntry.SETRANGE(Open, TRUE);
                                                    CustLedgEntry.SETRANGE(Positive, TRUE);
                                                    CustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := NOT CustLedgEntry.FIND('-');
                                                    IF FoundLast THEN BEGIN
                                                        CustLedgEntry.SETRANGE(Positive, FALSE);
                                                        FoundLast := NOT CustLedgEntry.FIND('-');
                                                        FoundNegative := TRUE;
                                                    END
                                                    ELSE
                                                        FoundNegative := FALSE;
                                                END;
                                            BalancingType::Vendor:
                                                BEGIN
                                                    VendLedgEntry.RESET;
                                                    VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                                                    VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                    VendLedgEntry.SETRANGE(Open, TRUE);
                                                    VendLedgEntry.SETRANGE(Positive, TRUE);
                                                    VendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := NOT VendLedgEntry.FIND('-');
                                                    IF FoundLast THEN BEGIN
                                                        VendLedgEntry.SETRANGE(Positive, FALSE);
                                                        FoundLast := NOT VendLedgEntry.FIND('-');
                                                        FoundNegative := TRUE;
                                                    END
                                                    ELSE
                                                        FoundNegative := FALSE;
                                                END;
                                        END;
                                    ApplyMethod::MoreLinesOneEntry:
                                        FoundLast := FALSE;
                                END;
                            END
                            ELSE
                                FoundLast := FALSE;
                        // NA0016.BEGIN
                        IF DocNo = '' THEN CurrencyCode2 := GenJnlLine."Currency Code";
                        IF PreprintedStub THEN
                            TotalText := ''
                        ELSE
                            TotalText := Text019;
                        IF GenJnlLine."Currency Code" <> '' THEN
                            NetAmount := STRSUBSTNO(Text063, GenJnlLine."Currency Code")
                        ELSE BEGIN
                            GLSetup.GET;
                            NetAmount := STRSUBSTNO(Text063, GLSetup."LCY Code");
                        END;
                        PageNo := PageNo + 1;
                        //NA0016.END
                    end;
                }
                dataitem(PrintCheck; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;

                    column(PrnChkCheckDateTextCheckStyleUS; PrnChkCheckDateText[CheckStyle::US])
                    {
                    }
                    column(CommentLine1; PrnChkDescriptionLine[CheckStyle::US, 1])
                    {
                    }
                    column(PrnChkCheckToAddrCheckStyleUS2; PrnChkCheckToAddr[CheckStyle::US, 2])
                    {
                    }
                    column(PrnChkCheckToAddrCheckStyleUS3; PrnChkCheckToAddr[CheckStyle::US, 3])
                    {
                    }
                    column(PrnChkCompanyAddrCheckStyleUS4; PrnChkCompanyAddr[CheckStyle::US, 4])
                    {
                    }
                    column(PrnChkCompanyAddrCheckStyleUS5; PrnChkCompanyAddr[CheckStyle::US, 5])
                    {
                    }
                    column(PrnChkCheckNoTextCheckStyleUS; PrnChkCheckNoText[CheckStyle::US])
                    {
                    }
                    column(PrnChkCompanyAddrCheckStyleUS1; PrnChkCompanyAddr[CheckStyle::US, 1])
                    {
                    }
                    column(TotalLineAmt; TotalLineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalTxt; TotalText)
                    {
                    }
                    column(PrnChkCompanyAddrCheckStyleCA1; PrnChkCompanyAddr[CheckStyle::CA, 1])
                    {
                    }
                    column(PrnChkCompanyAddrCheckStyleCA3; PrnChkCompanyAddr[CheckStyle::CA, 3])
                    {
                    }
                    column(PrnChkCompanyAddrCheckStyleCA5; PrnChkCompanyAddr[CheckStyle::CA, 5])
                    {
                    }
                    column(PrnChkCommentLineCheckStyleCA1; PrnChkDescriptionLine[CheckStyle::CA, 1])
                    {
                    }
                    column(PrnChkCheckToAddrCheckStyleCA1; PrnChkCheckToAddr[CheckStyle::CA, 1])
                    {
                    }
                    column(PrnChkCheckToAddrCheckStyleCA3; PrnChkCheckToAddr[CheckStyle::CA, 3])
                    {
                    }
                    column(PrnChkCheckToAddrCheckStyleCA5; PrnChkCheckToAddr[CheckStyle::CA, 5])
                    {
                    }
                    column(PrnChkDateIndicatorCheckStyleCA; PrnChkDateIndicator[CheckStyle::CA])
                    {
                    }
                    column(PrnChkVoidTxtCheckStyleCA; PrnChkVoidText[CheckStyle::CA])
                    {
                    }
                    column(PrnChkCurrencyCodeCheckStyleUS; PrnChkCurrencyCode[CheckStyle::US])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(CheckNoText_PrintCheck; CheckNoText)
                    {
                    }
                    column(CheckDateTxt2; CheckDateText)
                    {
                    }
                    column(DateIndicator; DateIndicator)
                    {
                    }
                    column(CommentLine11; DescriptionLine[1])
                    {
                    }
                    column(CommentLine21; DescriptionLine[2])
                    {
                    }
                    column(CheckAmtTxt; DollarSignBefore + CheckAmountText + DollarSignAfter)
                    {
                    }
                    column(CurrencyCode; BankAcc."Currency Code")
                    {
                    }
                    column(CheckToAddr01; CheckToAddr[1])
                    {
                    }
                    column(CheckToAddr2; CheckToAddr[2])
                    {
                    }
                    column(CheckToAddr3; CheckToAddr[3])
                    {
                    }
                    column(CheckToAddr4; CheckToAddr[4])
                    {
                    }
                    column(CheckToAddr5; CheckToAddr[5])
                    {
                    }
                    column(VoidTxt; VoidText)
                    {
                    }
                    column(CheckStyleIndex; CheckStyleIndex)
                    {
                    }
                    column(BankCurrencyCode; BankCurrencyCode)
                    {
                    }
                    column(PageNo_PrintCheck; PageNo)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        Decimals: Decimal;
                    begin
                        IF NOT TestPrint THEN BEGIN
                            CheckLedgEntry.INIT;
                            CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                            CheckLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Document Type" := GenJnlLine."Document Type";
                            CheckLedgEntry."Document No." := UseCheckNo;
                            // NA0006.begin
                            // CheckLedgEntry.Description := Description;
                            // NA0006.end
                            // NA0006.begin
                            CheckLedgEntry.Description := CheckToAddr[1];
                            // NA0006.end
                            CheckLedgEntry."Bank Payment Type" := GenJnlLine."Bank Payment Type";
                            CheckLedgEntry."Bal. Account Type" := BalancingType;
                            CheckLedgEntry."Bal. Account No." := BalancingNo;
                            IF FoundLast THEN BEGIN
                                IF TotalLineAmount <= 0 THEN ERROR(Text020, UseCheckNo, TotalLineAmount);
                                CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Printed;
                                CheckLedgEntry.Amount := TotalLineAmount;
                            END
                            ELSE BEGIN
                                CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Voided;
                                CheckLedgEntry.Amount := 0;
                            END;
                            CheckLedgEntry."Check Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Check No." := UseCheckNo;
                            CheckManagement.InsertCheck(CheckLedgEntry, GenJnlLine.RecordId);
                            IF FoundLast THEN BEGIN
                                IF BankAcc2."Currency Code" <> '' THEN
                                    Currency.GET(BankAcc2."Currency Code")
                                ELSE
                                    Currency.InitRoundingPrecision;
                                Decimals := CheckLedgEntry.Amount - ROUND(CheckLedgEntry.Amount, 1, '<');
                                IF STRLEN(FORMAT(Decimals)) < STRLEN(FORMAT(Currency."Amount Rounding Precision")) THEN
                                    IF Decimals = 0 THEN
                                        CheckAmountText := FORMAT(CheckLedgEntry.Amount, 0, 0) + COPYSTR(FORMAT(0.01), 2, 1) + PADSTR('', STRLEN(FORMAT(Currency."Amount Rounding Precision")) - 2, '0')
                                    ELSE
                                        CheckAmountText := FORMAT(CheckLedgEntry.Amount, 0, 0) + PADSTR('', STRLEN(FORMAT(Currency."Amount Rounding Precision")) - STRLEN(FORMAT(Decimals)), '0')
                                ELSE
                                    CheckAmountText := FORMAT(CheckLedgEntry.Amount, 0, 0);
                                // NA0013.begin
                                IF CheckLanguage = 3084 THEN BEGIN // French
                                    DollarSignBefore := '';
                                    DollarSignAfter := Currency.Symbol;
                                END
                                ELSE BEGIN
                                    DollarSignBefore := Currency.Symbol;
                                    DollarSignAfter := ' ';
                                END;
                                // NA0013.end
                                // NA0012.begin
                                // FormatNoText(DescriptionLine,CheckLedgEntry.Amount,BankAcc2."Currency Code");
                                // NA0012.end
                                // NA0012.begin
                                IF NOT ChkTransMgt.FormatNoText(DescriptionLine, CheckLedgEntry.Amount, CheckLanguage, BankAcc2."Currency Code") THEN ERROR(DescriptionLine[1]);
                                // NA0012.end
                                VoidText := '';
                            END
                            ELSE BEGIN
                                CLEAR(CheckAmountText);
                                CLEAR(DescriptionLine);
                                TotalText := Text065;
                                DescriptionLine[1] := Text021;
                                DescriptionLine[2] := DescriptionLine[1];
                                VoidText := Text022;
                            END;
                        END
                        ELSE BEGIN
                            CheckLedgEntry.INIT;
                            CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                            CheckLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Document No." := UseCheckNo;
                            CheckLedgEntry.Description := Text023;
                            CheckLedgEntry."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check";
                            CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::"Test Print";
                            CheckLedgEntry."Check Date" := GenJnlLine."Posting Date";
                            CheckLedgEntry."Check No." := UseCheckNo;
                            CheckManagement.InsertCheck(CheckLedgEntry, GenJnlLine.RecordId);
                            CheckAmountText := Text024;
                            DescriptionLine[1] := Text025;
                            DescriptionLine[2] := DescriptionLine[1];
                            VoidText := Text022;
                        END;
                        ChecksPrinted := ChecksPrinted + 1;
                        FirstPage := FALSE;
                        //NA0016.BEGIN
                        CLEAR(PrnChkCompanyAddr);
                        CLEAR(PrnChkCheckToAddr);
                        CLEAR(PrnChkCheckNoText);
                        CLEAR(PrnChkCheckDateText);
                        CLEAR(PrnChkDescriptionLine);
                        CLEAR(PrnChkVoidText);
                        CLEAR(PrnChkDateIndicator);
                        CLEAR(PrnChkCurrencyCode);
                        CLEAR(PrnChkCheckAmountText);
                        COPYARRAY(PrnChkCompanyAddr[CheckStyle], CompanyAddr, 1);
                        COPYARRAY(PrnChkCheckToAddr[CheckStyle], CheckToAddr, 1);
                        PrnChkCheckNoText[CheckStyle] := CheckNoText;
                        PrnChkCheckDateText[CheckStyle] := CheckDateText;
                        COPYARRAY(PrnChkDescriptionLine[CheckStyle], DescriptionLine, 1);
                        PrnChkVoidText[CheckStyle] := VoidText;
                        PrnChkDateIndicator[CheckStyle] := DateIndicator;
                        PrnChkCurrencyCode[CheckStyle] := BankAcc2."Currency Code";
                        StartingLen := STRLEN(CheckAmountText);
                        IF CheckStyle = CheckStyle::US THEN
                            ControlLen := 27
                        ELSE
                            ControlLen := 29;
                        CheckAmountText := CheckAmountText + DollarSignBefore + DollarSignAfter;
                        Index := 0;
                        IF CheckAmountText = Text024 THEN BEGIN
                            IF STRLEN(CheckAmountText) < (ControlLen - 12) THEN BEGIN
                                REPEAT
                                    Index := Index + 1;
                                    CheckAmountText := INSSTR(CheckAmountText, '*', STRLEN(CheckAmountText) + 1);
                                UNTIL (Index = ControlLen) OR (STRLEN(CheckAmountText) >= (ControlLen - 12))
                            END;
                        END
                        ELSE BEGIN
                            IF STRLEN(CheckAmountText) < (ControlLen - 11) THEN BEGIN
                                REPEAT
                                    Index := Index + 1;
                                    CheckAmountText := INSSTR(CheckAmountText, '*', STRLEN(CheckAmountText) + 1);
                                UNTIL (Index = ControlLen) OR (STRLEN(CheckAmountText) >= (ControlLen - 11))
                            END;
                        END;
                        // ParagraphHandling.PadStrProportional(
                        // CheckAmountText + DollarSignBefore + DollarSignAfter,ControlLen,10,'*');
                        CheckAmountText := DELSTR(CheckAmountText, StartingLen + 1, STRLEN(DollarSignBefore + DollarSignAfter));
                        NewLen := STRLEN(CheckAmountText);
                        IF NewLen <> StartingLen THEN CheckAmountText := COPYSTR(CheckAmountText, StartingLen + 1) + COPYSTR(CheckAmountText, 1, StartingLen);
                        PrnChkCheckAmountText[CheckStyle] := DollarSignBefore + CheckAmountText + DollarSignAfter;
                        CheckStyleIndex := CheckStyle;
                        //NA0016.END
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    IF FoundLast THEN CurrReport.BREAK;
                    UseCheckNo := INCSTR(UseCheckNo);
                    IF NOT TestPrint THEN
                        CheckNoText := UseCheckNo
                    ELSE
                        CheckNoText := Text011;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT TestPrint THEN BEGIN
                        IF UseCheckNo <> GenJnlLine."Document No." THEN BEGIN
                            GenJnlLine3.RESET;
                            GenJnlLine3.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                            GenJnlLine3.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                            GenJnlLine3.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            GenJnlLine3.SETRANGE("Posting Date", GenJnlLine."Posting Date");
                            GenJnlLine3.SETRANGE("Document No.", UseCheckNo);
                            IF GenJnlLine3.FIND('-') THEN GenJnlLine3.FIELDERROR("Document No.", STRSUBSTNO(Text013, UseCheckNo));
                        END;
                        IF ApplyMethod <> ApplyMethod::MoreLinesOneEntry THEN BEGIN
                            GenJnlLine3 := GenJnlLine;
                            GenJnlLine3.TESTFIELD("Posting No. Series", '');
                            GenJnlLine3."Document No." := UseCheckNo;
                            GenJnlLine3."Check Printed" := TRUE;
                            GenJnlLine3.MODIFY;
                        END
                        ELSE BEGIN
                            "TotalLineAmount$" := 0; // NA0004
                            IF GenJnlLine2.FIND('-') THEN BEGIN
                                HighestLineNo := GenJnlLine2."Line No.";
                                REPEAT // NA0018.begin
                                    IF BankAcc2."Currency Code" <> GenJnlLine2."Currency Code" THEN ERROR(Text005);
                                    // NA0018.end
                                    IF GenJnlLine2."Line No." > HighestLineNo THEN HighestLineNo := GenJnlLine2."Line No.";
                                    GenJnlLine3 := GenJnlLine2;
                                    GenJnlLine3.TESTFIELD("Posting No. Series", '');
                                    GenJnlLine3."Bal. Account No." := '';
                                    GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::" ";
                                    GenJnlLine3."Document No." := UseCheckNo;
                                    GenJnlLine3."Check Printed" := TRUE;
                                    GenJnlLine3.VALIDATE(Amount);
                                    "TotalLineAmount$" := "TotalLineAmount$" + GenJnlLine3."Amount (LCY)"; // NA0004
                                    GenJnlLine3.MODIFY;
                                UNTIL GenJnlLine2.NEXT = 0;
                            END;
                            GenJnlLine3.RESET;
                            GenJnlLine3 := GenJnlLine;
                            GenJnlLine3.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                            GenJnlLine3.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            GenJnlLine3."Line No." := HighestLineNo;
                            IF GenJnlLine3.NEXT = 0 THEN
                                GenJnlLine3."Line No." := HighestLineNo + 10000
                            ELSE BEGIN
                                WHILE GenJnlLine3."Line No." = HighestLineNo + 1 DO BEGIN
                                    HighestLineNo := GenJnlLine3."Line No.";
                                    IF GenJnlLine3.NEXT = 0 THEN GenJnlLine3."Line No." := HighestLineNo + 20000;
                                END;
                                GenJnlLine3."Line No." := (GenJnlLine3."Line No." + HighestLineNo) DIV 2;
                            END;
                            GenJnlLine3.INIT;
                            GenJnlLine3.VALIDATE("Posting Date", GenJnlLine."Posting Date");
                            GenJnlLine3."Document Type" := GenJnlLine."Document Type";
                            GenJnlLine3."Document No." := UseCheckNo;
                            GenJnlLine3."Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                            GenJnlLine3.VALIDATE("Account No.", BankAcc2."No.");
                            IF BalancingType <> BalancingType::"G/L Account" THEN GenJnlLine3.Description := STRSUBSTNO(Text014, SELECTSTR(BalancingType + 1, Text062), BalancingNo);
                            GenJnlLine3.VALIDATE(Amount, -TotalLineAmount);
                            // NA0004.begin
                            IF TotalLineAmount <> "TotalLineAmount$" THEN GenJnlLine3.VALIDATE("Amount (LCY)", -"TotalLineAmount$");
                            // NA0004.end
                            GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::"Computer Check";
                            GenJnlLine3."Check Printed" := TRUE;
                            GenJnlLine3."Source Code" := GenJnlLine."Source Code";
                            GenJnlLine3."Reason Code" := GenJnlLine."Reason Code";
                            GenJnlLine3."Allow Zero-Amount Posting" := TRUE;
                            GenJnlLine3.INSERT;
                        END;
                    END;
                    BankAcc2."Last Check No." := UseCheckNo;
                    BankAcc2.MODIFY;
                    // NA0005.begin
                    // COMMIT;
                    // NA0005.end
                    // NA0005.begin
                    IF CommitEachCheck THEN BEGIN
                        COMMIT;
                        // NA0005.end
                        CLEAR(CheckManagement);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    FirstPage := TRUE;
                    FoundLast := FALSE;
                    TotalLineAmount := 0;
                    TotalLineDiscount := 0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                IF OneCheckPrVendor AND ("Currency Code" <> '') AND ("Currency Code" <> Currency.Code) THEN BEGIN
                    Currency.GET("Currency Code");
                    Currency.TESTFIELD("Conv. LCY Rndg. Debit Acc.");
                    Currency.TESTFIELD("Conv. LCY Rndg. Credit Acc.");
                END;
                IF NOT TestPrint THEN BEGIN
                    IF Amount = 0 THEN CurrReport.SKIP;
                    TESTFIELD("Bal. Account Type", "Bal. Account Type"::"Bank Account");
                    IF "Bal. Account No." <> BankAcc2."No." THEN CurrReport.SKIP;
                    IF ("Account No." <> '') AND ("Bal. Account No." <> '') THEN BEGIN
                        BalancingType := "Account Type";
                        BalancingNo := "Account No.";
                        RemainingAmount := Amount;
                        IF OneCheckPrVendor THEN BEGIN
                            ApplyMethod := ApplyMethod::MoreLinesOneEntry;
                            GenJnlLine2.RESET;
                            GenJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                            GenJnlLine2.SETRANGE("Journal Template Name", "Journal Template Name");
                            GenJnlLine2.SETRANGE("Journal Batch Name", "Journal Batch Name");
                            GenJnlLine2.SETRANGE("Posting Date", "Posting Date");
                            GenJnlLine2.SETRANGE("Document No.", "Document No.");
                            GenJnlLine2.SETRANGE("Account Type", "Account Type");
                            GenJnlLine2.SETRANGE("Account No.", "Account No.");
                            GenJnlLine2.SETRANGE("Bal. Account Type", "Bal. Account Type");
                            GenJnlLine2.SETRANGE("Bal. Account No.", "Bal. Account No.");
                            GenJnlLine2.SETRANGE("Bank Payment Type", "Bank Payment Type");
                            GenJnlLine2.FIND('-');
                            RemainingAmount := 0;
                        END
                        ELSE
                            IF "Applies-to Doc. No." <> '' THEN
                                ApplyMethod := ApplyMethod::OneLineOneEntry
                            ELSE
                                IF "Applies-to ID" <> '' THEN
                                    ApplyMethod := ApplyMethod::OneLineID
                                ELSE
                                    ApplyMethod := ApplyMethod::Payment;
                    END
                    ELSE
                        IF "Account No." = '' THEN
                            FIELDERROR("Account No.", Text004)
                        ELSE
                            FIELDERROR("Bal. Account No.", Text004);
                    CLEAR(CheckToAddr);
                    ContactText := '';
                    CLEAR(SalesPurchPerson);
                    CASE BalancingType OF
                        BalancingType::"G/L Account":
                            BEGIN
                                CheckToAddr[1] := Description;
                                // NA0012.begin
                                SetCheckPrintParams(BankAcc2."Check Date Format", BankAcc2."Check Date Separator", BankAcc2."Country/Region Code", BankAcc2."Bank Communication");
                                // NA0012.end
                            END;
                        BalancingType::Customer:
                            BEGIN
                                Cust.GET(BalancingNo);
                                IF Cust.Blocked = Cust.Blocked::All THEN ERROR(Text064, Cust.FIELDCAPTION(Blocked), Cust.Blocked, Cust.TABLECAPTION, Cust."No.");
                                Cust.Contact := '';
                                FormatAddr.Customer(CheckToAddr, Cust);
                                IF BankAcc2."Currency Code" <> "Currency Code" THEN ERROR(Text005);
                                IF Cust."Salesperson Code" <> '' THEN BEGIN
                                    ContactText := Text006;
                                    SalesPurchPerson.GET(Cust."Salesperson Code");
                                END;
                                // NA0012.begin
                                SetCheckPrintParams(Cust."Check Date Format", Cust."Check Date Separator", BankAcc2."Country/Region Code", Cust."Bank Communication");
                                // NA0012.end
                            END;
                        BalancingType::Vendor:
                            BEGIN
                                Vend.GET(BalancingNo);
                                IF Vend.Blocked IN [Vend.Blocked::All, Vend.Blocked::Payment] THEN ERROR(Text064, Vend.FIELDCAPTION(Blocked), Vend.Blocked, Vend.TABLECAPTION, Vend."No.");
                                Vend.Contact := '';
                                FormatAddr.Vendor(CheckToAddr, Vend);
                                IF BankAcc2."Currency Code" <> "Currency Code" THEN ERROR(Text005);
                                IF Vend."Purchaser Code" <> '' THEN BEGIN
                                    ContactText := Text007;
                                    SalesPurchPerson.GET(Vend."Purchaser Code");
                                END;
                                // NA0012.begin
                                SetCheckPrintParams(Vend."Check Date Format", Vend."Check Date Separator", BankAcc2."Country/Region Code", Vend."Bank Communication");
                                // NA0012.end
                            END;
                        BalancingType::"Bank Account":
                            BEGIN
                                BankAcc.GET(BalancingNo);
                                BankAcc.TESTFIELD(Blocked, FALSE);
                                BankAcc.Contact := '';
                                FormatAddr.BankAcc(CheckToAddr, BankAcc);
                                IF BankAcc2."Currency Code" <> BankAcc."Currency Code" THEN ERROR(Text008);
                                IF BankAcc."Our Contact Code" <> '' THEN BEGIN
                                    ContactText := Text009;
                                    SalesPurchPerson.GET(BankAcc."Our Contact Code");
                                END;
                                // NA0012.begin
                                SetCheckPrintParams(BankAcc."Check Date Format", BankAcc."Check Date Separator", BankAcc2."Country/Region Code", BankAcc."Bank Communication");
                                // NA0012.end
                            END;
                    END;
                    // NA0012.begin
                    // CheckDateText := FORMAT("Posting Date",0,4);
                    // NA0012.end
                    // NA0012.begin
                    CheckDateText := ChkTransMgt.FormatDate("Posting Date", CheckDateFormat, DateSeparator, CheckLanguage, DateIndicator);
                    // NA0012.end
                END
                ELSE BEGIN
                    IF ChecksPrinted > 0 THEN CurrReport.BREAK;
                    // NA0012.begin
                    SetCheckPrintParams(BankAcc2."Check Date Format", BankAcc2."Check Date Separator", BankAcc2."Country/Region Code", BankAcc2."Bank Communication");
                    // NA0012.end
                    BalancingType := BalancingType::Vendor;
                    BalancingNo := Text010;
                    CLEAR(CheckToAddr);
                    FOR i := 1 TO 5 DO CheckToAddr[i] := Text003;
                    ContactText := '';
                    CLEAR(SalesPurchPerson);
                    CheckNoText := Text011;
                    // NA0012.begin
                    // CheckDateText := Text012;
                    // NA0012.end
                    // NA0012.begin
                    IF CheckStyle = CheckStyle::CA THEN
                        CheckDateText := DateIndicator
                    ELSE
                        CheckDateText := Text010;
                    // NA0012.end
                END;
            end;

            trigger OnPreDataItem()
            begin
                COPY(VoidGenJnlLine);
                CompanyInfo.GET;
                IF NOT TestPrint THEN BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    BankAcc2.GET(BankAcc2."No.");
                    BankAcc2.TESTFIELD(Blocked, FALSE);
                    COPY(VoidGenJnlLine);
                    SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                    SETRANGE("Check Printed", FALSE);
                END
                ELSE BEGIN
                    CLEAR(CompanyAddr);
                    FOR i := 1 TO 5 DO CompanyAddr[i] := Text003;
                END;
                ChecksPrinted := 0;
                SETRANGE("Account Type", "Account Type"::"Fixed Asset");
                IF FIND('-') THEN FIELDERROR("Account Type");
                SETRANGE("Account Type");
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
                    Caption = 'Options';

                    field(BankAccount; BankAcc2."No.")
                    {
                        Caption = 'Bank Account';
                        TableRelation = "Bank Account";
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            InputBankAccount;
                        end;
                    }
                    field(LastCheckNo; UseCheckNo)
                    {
                        Caption = 'Last Check No.';
                        ApplicationArea = All;
                    }
                    field(OneCheckPrVendor; OneCheckPrVendor)
                    {
                        Caption = 'One Check per Vendor per Document No.';
                        MultiLine = true;
                        ApplicationArea = All;
                    }
                    field(ReprintChecks; ReprintChecks)
                    {
                        Caption = 'Reprint Checks';
                        ApplicationArea = All;
                    }
                    field(TestPrinting; TestPrint)
                    {
                        Caption = 'Test Print';
                        ApplicationArea = All;
                    }
                    field(PreprintedStub; PreprintedStub)
                    {
                        Caption = 'Preprinted Stub';
                        ApplicationArea = All;
                    }
                    field(CommitEachCheck; CommitEachCheck)
                    {
                        Caption = 'Commit Each Check';
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            IF BankAcc2."No." <> '' THEN BEGIN
                IF BankAcc2.GET(BankAcc2."No.") THEN
                    UseCheckNo := BankAcc2."Last Check No."
                ELSE BEGIN
                    BankAcc2."No." := '';
                    UseCheckNo := '';
                END;
            END;
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        // NA0012.begin
        // InitTextVariable;
        // NA0012.end
        //NA0002.begin
        GenJnlTemplate.GET(VoidGenJnlLine.GETFILTER("Journal Template Name"));
        IF NOT GenJnlTemplate."Force Doc. Balance" THEN IF NOT CONFIRM(USText001, TRUE) THEN ERROR(USText002);
        //NA0002.end
        //NA0016.BEGIN
        PageNo := 0;
        //NA0016.END
    end;

    var
        Text000: Label 'Preview is not allowed.';
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text006: Label 'Salesperson';
        Text007: Label 'Purchaser';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text009: Label 'Our Contact';
        Text010: Label 'XXXXXXXXXX';
        Text011: Label 'XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text015: Label 'Payment';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\must not be activated when Applies-to ID is specified in the journal lines.';
        Text018: Label 'XXX';
        Text019: Label 'Total';
        Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: Label 'NON-NEGOTIABLE';
        Text023: Label 'Test print';
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text030: Label ' is already applied to %1 %2 for customer %3.';
        Text031: Label ' is already applied to %1 %2 for vendor %3.';
        CompanyInfo: Record "Company Information";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        Cust: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAcc: Record "Bank Account";
        BankAcc2: Record "Bank Account";
        CheckLedgEntry: Record "Check Ledger Entry";
        Currency: Record Currency;
        GenJnlTemplate: Record "Gen. Journal Template";
        WindowsLang: Record "Windows Language";
        FormatAddr: Codeunit 365;
        CheckManagement: Codeunit CheckManagement;
        ChkTransMgt: Report "Check Translation Management";
        CompanyAddr: array[8] of Text[50];
        CheckToAddr: array[8] of Text[50];
        BalancingType: Option "G/L Account",Customer,Vendor,"Bank Account";
        BalancingNo: Code[20];
        ContactText: Text[30];
        CheckNoText: Text[30];
        CheckDateText: Text[30];
        CheckAmountText: Text[30];
        DescriptionLine: array[2] of Text[80];
        DocType: Text[30];
        DocNo: Text[30];
        ExtDocNo: Text[35];
        VoidText: Text[30];
        LineAmount: Decimal;
        LineDiscount: Decimal;
        TotalLineAmount: Decimal;
        "TotalLineAmount$": Decimal;
        TotalLineDiscount: Decimal;
        RemainingAmount: Decimal;
        CurrentLineAmount: Decimal;
        UseCheckNo: Code[20];
        FoundLast: Boolean;
        ReprintChecks: Boolean;
        TestPrint: Boolean;
        FirstPage: Boolean;
        OneCheckPrVendor: Boolean;
        FoundNegative: Boolean;
        CommitEachCheck: Boolean;
        ApplyMethod: Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted: Integer;
        HighestLineNo: Integer;
        PreprintedStub: Boolean;
        TotalText: Text[10];
        DocDate: Date;
        i: Integer;
        CurrencyCode2: Code[10];
        NetAmount: Text[30];
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        LineAmount2: Decimal;
        Text063: Label 'Net Amount %1';
        GLSetup: Record "General Ledger Setup";
        Text064: Label '%1 must not be %2 for %3 %4.';
        Text065: Label 'Subtotal';
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        USText001: Label 'Warning:  Checks cannot be financially voided when Force Doc. Balance is set to No in the Journal Template.  Do you want to continue anyway?';
        USText002: Label 'Process cancelled at user request.';
        USText004: Label 'Last Check No. must include at least one digit, so that it can be incremented.';
        USText005: Label '%1 language is not enabled. %2 is set up for checks in %1.';
        DateIndicator: Text[10];
        CheckDateFormat: Option " ","MM DD YYYY","DD MM YYYY","YYYY MM DD";
        CheckStyle: Option ,US,CA;
        CheckLanguage: Integer;
        DateSeparator: Option " ","-",".","/";
        DollarSignBefore: Code[5];
        DollarSignAfter: Code[5];
        PrnChkCompanyAddr: array[2, 8] of Text[50];
        PrnChkCheckToAddr: array[2, 8] of Text[50];
        PrnChkCheckNoText: array[2] of Text[30];
        PrnChkCheckDateText: array[2] of Text[30];
        PrnChkCheckAmountText: array[2] of Text[30];
        PrnChkDescriptionLine: array[2, 2] of Text[80];
        PrnChkVoidText: array[2] of Text[30];
        PrnChkDateIndicator: array[2] of Text[10];
        PrnChkCurrencyCode: array[2] of Code[10];
        USText006: Label 'You cannot use the <blank> %1 option with a Canadian style check. Please check %2 %3.';
        USText007: Label 'You cannot use the Spanish %1 option with a Canadian style check. Please check %2 %3.';
        PostingDesc: Text[50];
        CheckStyleIndex: Integer;
        BankCurrencyCode: Text[30];
        StartingLen: Integer;
        ControlLen: Integer;
        Index: Integer;
        NewLen: Integer;
        PageNo: Integer;
        CheckNoTextCaptionLbl: Label 'Check No.';
        NetAmountLbl: Label 'Net Amount';
        LineDiscountCaptionLbl: Label 'Discount';
        AmountCaptionLbl: Label 'Amount';
        DocNoCaptionLbl: Label 'Document No.';
        DocDateCaptionLbl: Label 'Document Date';
        PostingDescriptionCaptionLbl: Label 'Posting Description';

    local procedure CustUpdateAmounts(var CustLedgEntry2: Record "Cust. Ledger Entry"; RemainingAmount2: Decimal)
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR (ApplyMethod = ApplyMethod::MoreLinesOneEntry) THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY("Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Customer);
            GenJnlLine3.SETRANGE("Account No.", CustLedgEntry2."Customer No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", CustLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", CustLedgEntry2."Document No.");
            IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            ELSE
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
            IF CustLedgEntry2."Document Type" <> CustLedgEntry2."Document Type"::" " THEN IF GenJnlLine3.FIND('-') THEN GenJnlLine3.FIELDERROR("Applies-to Doc. No.", STRSUBSTNO(Text030, CustLedgEntry2."Document Type", CustLedgEntry2."Document No.", CustLedgEntry2."Customer No."));
        END;
        DocType := FORMAT(CustLedgEntry2."Document Type");
        DocNo := CustLedgEntry2."Document No.";
        ExtDocNo := CustLedgEntry2."External Document No.";
        // NA0007.begin
        // DocDate := CustLedgEntry2."Posting Date";
        // NA0007.end
        // NA0007.begin
        DocDate := CustLedgEntry2."Document Date";
        // NA0007.end
        //NA0014.begin
        PostingDesc := CustLedgEntry2.Description;
        //NA0014.end
        CurrencyCode2 := CustLedgEntry2."Currency Code";
        CustLedgEntry2.CALCFIELDS("Remaining Amount");
        LineAmount := -ABSMin(CustLedgEntry2."Remaining Amount" - CustLedgEntry2."Remaining Pmt. Disc. Possible" - CustLedgEntry2."Accepted Payment Tolerance", CustLedgEntry2."Amount to Apply");
        LineAmount2 := ROUND(ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount), Currency."Amount Rounding Precision");
        IF ((CustLedgEntry2."Document Type" IN [CustLedgEntry2."Document Type"::Invoice, CustLedgEntry2."Document Type"::"Credit Memo"]) AND (CustLedgEntry2."Remaining Pmt. Disc. Possible" <> 0) AND (CustLedgEntry2."Posting Date" <= CustLedgEntry2."Pmt. Discount Date")) OR CustLedgEntry2."Accepted Pmt. Disc. Tolerance" THEN BEGIN
            LineDiscount := -CustLedgEntry2."Remaining Pmt. Disc. Possible";
            IF CustLedgEntry2."Accepted Payment Tolerance" <> 0 THEN LineDiscount := LineDiscount - CustLedgEntry2."Accepted Payment Tolerance";
        END
        ELSE BEGIN
            IF RemainingAmount2 >= ROUND(-ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, CustLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision") THEN
                LineAmount2 := ROUND(-ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, CustLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision")
            ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount := ROUND(ExchangeAmt(CustLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code", LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    local procedure VendUpdateAmounts(var VendLedgEntry2: Record "Vendor Ledger Entry"; RemainingAmount2: Decimal)
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR (ApplyMethod = ApplyMethod::MoreLinesOneEntry) THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY("Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Vendor);
            GenJnlLine3.SETRANGE("Account No.", VendLedgEntry2."Vendor No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", VendLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", VendLedgEntry2."Document No.");
            IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            ELSE
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
            IF VendLedgEntry2."Document Type" <> VendLedgEntry2."Document Type"::" " THEN IF GenJnlLine3.FIND('-') THEN GenJnlLine3.FIELDERROR("Applies-to Doc. No.", STRSUBSTNO(Text031, VendLedgEntry2."Document Type", VendLedgEntry2."Document No.", VendLedgEntry2."Vendor No."));
        END;
        DocType := FORMAT(VendLedgEntry2."Document Type");
        DocNo := VendLedgEntry2."Document No.";
        ExtDocNo := VendLedgEntry2."External Document No.";
        // NA0007.begin
        // DocDate := VendLedgEntry2."Posting Date";
        // NA0007.end
        // NA0007.begin
        DocNo := ExtDocNo;
        DocDate := VendLedgEntry2."Document Date";
        // NA0007.end
        //NA0014.begin
        PostingDesc := VendLedgEntry2.Description;
        //NA0014.end
        CurrencyCode2 := VendLedgEntry2."Currency Code";
        VendLedgEntry2.CALCFIELDS("Remaining Amount");
        LineAmount := -ABSMin(VendLedgEntry2."Remaining Amount" - VendLedgEntry2."Remaining Pmt. Disc. Possible" - VendLedgEntry2."Accepted Payment Tolerance", VendLedgEntry2."Amount to Apply");
        LineAmount2 := ROUND(ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount), Currency."Amount Rounding Precision");
        IF ((VendLedgEntry2."Document Type" IN [VendLedgEntry2."Document Type"::Invoice, VendLedgEntry2."Document Type"::"Credit Memo"]) AND (VendLedgEntry2."Remaining Pmt. Disc. Possible" <> 0) AND (GenJnlLine."Posting Date" <= VendLedgEntry2."Pmt. Discount Date")) OR VendLedgEntry2."Accepted Pmt. Disc. Tolerance" THEN BEGIN
            LineDiscount := -VendLedgEntry2."Remaining Pmt. Disc. Possible";
            IF VendLedgEntry2."Accepted Payment Tolerance" <> 0 THEN LineDiscount := LineDiscount - VendLedgEntry2."Accepted Payment Tolerance";
        END
        ELSE BEGIN
            IF RemainingAmount2 >= ROUND(-(ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, VendLedgEntry2."Amount to Apply")), Currency."Amount Rounding Precision") THEN BEGIN
                LineAmount2 := ROUND(-(ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, VendLedgEntry2."Amount to Apply")), Currency."Amount Rounding Precision");
                LineAmount := ROUND(ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code", LineAmount2), Currency."Amount Rounding Precision");
            END
            ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount := ROUND(ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code", LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    procedure InitializeRequest(BankAcc: Code[20]; LastCheckNo: Code[20]; NewOneCheckPrVend: Boolean; NewReprintChecks: Boolean; NewTestPrint: Boolean; NewPreprintedStub: Boolean)
    begin
        IF BankAcc <> '' THEN
            IF BankAcc2.GET(BankAcc) THEN BEGIN
                UseCheckNo := LastCheckNo;
                OneCheckPrVendor := NewOneCheckPrVend;
                ReprintChecks := NewReprintChecks;
                TestPrint := NewTestPrint;
                PreprintedStub := NewPreprintedStub;
            END;
    end;

    procedure ExchangeAmt(PostingDate: Date; CurrencyCode: Code[10]; CurrencyCode2: Code[10]; Amount: Decimal) Amount2: Decimal
    begin
        IF (CurrencyCode <> '') AND (CurrencyCode2 = '') THEN
            Amount2 := CurrencyExchangeRate.ExchangeAmtLCYToFCY(PostingDate, CurrencyCode, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode))
        ELSE
            IF (CurrencyCode = '') AND (CurrencyCode2 <> '') THEN
                Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToLCY(PostingDate, CurrencyCode2, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode2))
            ELSE
                IF (CurrencyCode <> '') AND (CurrencyCode2 <> '') AND (CurrencyCode <> CurrencyCode2) THEN
                    Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(PostingDate, CurrencyCode2, CurrencyCode, Amount)
                ELSE
                    Amount2 := Amount;
    end;

    procedure ABSMin(Decimal1: Decimal; Decimal2: Decimal): Decimal
    begin
        IF ABS(Decimal1) < ABS(Decimal2) THEN EXIT(Decimal1);
        EXIT(Decimal2);
    end;

    procedure InputBankAccount()
    begin
        IF BankAcc2."No." <> '' THEN BEGIN
            BankAcc2.GET(BankAcc2."No.");
            BankAcc2.TESTFIELD("Last Check No.");
            UseCheckNo := BankAcc2."Last Check No.";
        END;
    end;

    local procedure SetCheckPrintParams(NewDateFormat: Option " ","MM DD YYYY","DD MM YYYY","YYYY MM DD"; NewDateSeparator: Option " ","-",".","/"; NewCountryCode: Code[10]; NewCheckLanguage: Option "E English","F French","S Spanish")
    begin
        // NA0012.begin
        CheckDateFormat := NewDateFormat;
        DateSeparator := NewDateSeparator;
        CASE NewCheckLanguage OF
            NewCheckLanguage::"E English":
                CheckLanguage := 4105;
            NewCheckLanguage::"F French":
                CheckLanguage := 3084;
            NewCheckLanguage::"S Spanish":
                CheckLanguage := 2058;
            ELSE
                CheckLanguage := 1033;
        END;
        /*
        CASE NewCountryCode OF
            CompanyInfo."Country/Region Code":
                BEGIN
                    CheckStyle := CheckStyle::US;
                    IF CheckLanguage = 4105 THEN
                        CheckLanguage := 1033;
                END;
            CompanyInfo."Country/Region Code":
                BEGIN
                    CheckStyle := CheckStyle::CA;
                    IF CheckLanguage = 1033 THEN
                        CheckLanguage := 4105;
                END;
            CompanyInfo."Country/Region Code":
                CheckStyle := CheckStyle::US;
            ELSE
                CheckStyle := CheckStyle::US;
        END;*/
        //UPG
        IF CheckLanguage <> WindowsLang."Language ID" THEN WindowsLang.GET(CheckLanguage);
        IF NOT WindowsLang."Globally Enabled" THEN BEGIN
            IF CheckLanguage = 4105 THEN
                CheckLanguage := 1033
            ELSE
                ERROR(USText005, WindowsLang.Name, CheckToAddr[1]);
        END;
        // NA0012.end
    end;
}
