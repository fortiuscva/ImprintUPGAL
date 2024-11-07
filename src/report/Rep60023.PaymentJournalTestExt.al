report 60023 "Payment Journal - Test Ext"
{
    // version NAVNA14.03
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Payment Journal - Test.rdl';
    CaptionML = ENU = 'Payment Journal - Test', ESM = 'Diario de pagos - Test', FRC = 'Journal des paiements - Test', ENC = 'Payment Journal - Test';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Gen. Journal Batch"; "Gen. Journal Batch")
        {
            DataItemTableView = SORTING("Journal Template Name", Name);

            column(Gen__Journal_Batch_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Gen__Journal_Batch_Name; Name)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;

                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(CompanyInformation_Name; CompanyInformation.Name)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PageNo)
                {
                }
                column(USERID; UserId)
                {
                }
                column(Gen__Journal_Batch___Journal_Template_Name_; "Gen. Journal Batch"."Journal Template Name")
                {
                }
                column(Gen__Journal_Batch__Name; "Gen. Journal Batch".Name)
                {
                }
                column(TIME; Time)
                {
                }
                column(Gen__Journal_Line__TABLECAPTION__________GenJnlLineFilter; "Gen. Journal Line".TableCaption + ': ' + GenJnlLineFilter)
                {
                }
                column(USText001; USText001)
                {
                }
                column(GenJnlLineFilter; GenJnlLineFilter)
                {
                }
                column(GenJnlTemplate_Force_Doc_Balance; GenJnlTemplate."Force Doc. Balance")
                {
                }
                column(Integer_Number; Number)
                {
                }
                column(Payment_Journal___TestCaption; Payment_Journal___TestCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Gen__Journal_Batch___Journal_Template_Name_Caption; "Gen. Journal Batch".FieldCaption("Journal Template Name"))
                {
                }
                column(Gen__Journal_Batch__NameCaption; Gen__Journal_Batch__NameCaptionLbl)
                {
                }
                column(Gen__Journal_Line__Posting_Date_Caption; Gen__Journal_Line__Posting_Date_CaptionLbl)
                {
                }
                column(Gen__Journal_Line__Document_Type_Caption; Gen__Journal_Line__Document_Type_CaptionLbl)
                {
                }
                column(Gen__Journal_Line__Document_No__Caption; Gen__Journal_Line__Document_No__CaptionLbl)
                {
                }
                column(Gen__Journal_Line__Account_Type_Caption; Gen__Journal_Line__Account_Type_CaptionLbl)
                {
                }
                column(Gen__Journal_Line__Account_No__Caption; Gen__Journal_Line__Account_No__CaptionLbl)
                {
                }
                column(Gen__Journal_Line_DescriptionCaption; "Gen. Journal Line".FieldCaption(Description))
                {
                }
                column(Gen__Journal_Line_AmountCaption; "Gen. Journal Line".FieldCaption(Amount))
                {
                }
                column(Gen__Journal_Line__Bal__Account_No__Caption; Gen__Journal_Line__Bal__Account_No__CaptionLbl)
                {
                }
                column(Gen__Journal_Line__Bal__Account_Type_Caption; Gen__Journal_Line__Bal__Account_Type_CaptionLbl)
                {
                }
                column(Gen__Journal_Line__Bank_Payment_Type_Caption; "Gen. Journal Line".FieldCaption("Bank Payment Type"))
                {
                }
                column(Gen__Journal_Line__Applies_to_Doc__Type_Caption; Gen__Journal_Line__Applies_to_Doc__Type_CaptionLbl)
                {
                }
                column(Gen__Journal_Line__Applies_to_Doc__No__Caption; Gen__Journal_Line__Applies_to_Doc__No__CaptionLbl)
                {
                }
                column(DocumentCaption; DocumentCaptionLbl)
                {
                }
                column(AccountCaption; AccountCaptionLbl)
                {
                }
                column(Applies_to_Doc_Caption; Applies_to_Doc_CaptionLbl)
                {
                }
                column(Bal__AccountCaption; Bal__AccountCaptionLbl)
                {
                }
                dataitem("Gen. Journal Line"; "Gen. Journal Line")
                {
                    DataItemLink = "Journal Template Name" = FIELD("Journal Template Name"), "Journal Batch Name" = FIELD(Name);
                    DataItemLinkReference = "Gen. Journal Batch";
                    DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");
                    RequestFilterFields = "Posting Date";

                    column(Gen__Journal_Line__Posting_Date_; "Posting Date")
                    {
                    }
                    column(Gen__Journal_Line__Document_Type_; "Document Type")
                    {
                    }
                    column(Gen__Journal_Line__Document_No__; "Document No.")
                    {
                    }
                    column(Gen__Journal_Line__Account_Type_; "Account Type")
                    {
                    }
                    column(Gen__Journal_Line__Account_No__; "Account No.")
                    {
                    }
                    column(Gen__Journal_Line_Description; Description)
                    {
                    }
                    column(Gen__Journal_Line_Amount; Amount)
                    {
                    }
                    column(Gen__Journal_Line__Currency_Code_; "Currency Code")
                    {
                    }
                    column(Gen__Journal_Line__Bal__Account_No__; "Bal. Account No.")
                    {
                    }
                    column(Gen__Journal_Line__Bal__Account_Type_; "Bal. Account Type")
                    {
                    }
                    column(Gen__Journal_Line__Bank_Payment_Type_; "Bank Payment Type")
                    {
                    }
                    column(Gen__Journal_Line__External_Document_No__; "External Document No.")
                    {
                    }
                    column(Gen__Journal_Line__Applies_to_Doc__Type_; "Applies-to Doc. Type")
                    {
                    }
                    column(Gen__Journal_Line__Applies_to_Doc__No__; "Applies-to Doc. No.")
                    {
                    }
                    column(Gen__Journal_Line__Amount__LCY__; "Amount (LCY)")
                    {
                    }
                    column(Gen__Journal_Line__Balance__LCY__; "Balance (LCY)")
                    {
                    }
                    column(ShowDim; ShowDim)
                    {
                    }
                    column(Gen__Journal_Line_Journal_Template_Name; "Journal Template Name")
                    {
                    }
                    column(Gen__Journal_Line_Journal_Batch_Name; "Journal Batch Name")
                    {
                    }
                    column(Gen__Journal_Line_Line_No_; "Line No.")
                    {
                    }
                    column(Gen__Journal_Line__Amount__LCY__Caption; CaptionClassTranslate('101,0,Total (%1)'))
                    {
                    }
                    column(GenJnlLineDescriptionVarGbl; GenJnlLineDescriptionVarGbl)
                    {
                    }
                    dataitem(TempLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        column(Gen__Journal_Line___Amount__LCY__; "Gen. Journal Line"."Amount (LCY)")
                        {
                        }
                        column(Gen__Journal_Line___Balance__LCY__; "Gen. Journal Line"."Balance (LCY)")
                        {
                        }
                        column(TempLoop_Number; Number)
                        {
                        }
                    }
                    dataitem(DimensionLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                        column(DimText; DimText)
                        {
                        }
                        column(DimText_Control55; DimText)
                        {
                        }
                        column(DimensionLoop_DimensionLoop_Number; Number)
                        {
                        }
                        column(DimensionsCaption; DimensionsCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry.Find('-') then CurrReport.Break;
                            end
                            else if not Continue then CurrReport.Break;
                            Clear(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := StrSubstNo('%1 - %2', DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
                                else
                                    DimText := StrSubstNo('%1; %2 - %3', DimText, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until (DimSetEntry.Next = 0);
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not ShowDim then CurrReport.Break;
                            DimSetEntry.SetRange("Dimension Set ID", "Gen. Journal Line"."Dimension Set ID");
                        end;
                    }
                    dataitem(ErrorLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(ErrorText_Number_; ErrorText[Number])
                        {
                        }
                        column(ErrorCounter; ErrorCounter)
                        {
                        }
                        column(ErrorLoop_Number; Number)
                        {
                        }
                        column(ErrorText_Number_Caption; ErrorText_Number_CaptionLbl)
                        {
                        }
                        trigger OnPostDataItem();
                        begin
                            ErrorCounter := 0;
                        end;

                        trigger OnPreDataItem();
                        begin
                            SetRange(Number, 1, ErrorCounter);
                        end;
                    }
                    trigger OnAfterGetRecord();
                    var
                        PaymentTerms: Record "Payment Terms";
                        DimMgt: Codeunit DimensionManagement;
                        TableID: array[10] of Integer;
                        No: array[10] of Code[20];
                    begin
                        if "Currency Code" = '' then "Amount (LCY)" := Amount;
                        UpdateLineBalance;
                        AccName := '';
                        BalAccName := '';
                        if not EmptyLine then begin
                            MakeRecurringTexts("Gen. Journal Line");
                            AmountError := false;
                            if ("Account No." = '') and ("Bal. Account No." = '') then
                                AddError(StrSubstNo(Text001, FieldCaption("Account No."), FieldCaption("Bal. Account No.")))
                            else if ("Account Type" <> "Account Type"::"Fixed Asset") and ("Bal. Account Type" <> "Bal. Account Type"::"Fixed Asset") then TestFixedAssetFields("Gen. Journal Line");
                            CheckICDocument;
                            if "Account No." <> '' then
                                case "Account Type" of
                                    "Account Type"::"G/L Account":
                                        begin
                                            if ("Gen. Bus. Posting Group" <> '') or ("Gen. Prod. Posting Group" <> '') or ("VAT Bus. Posting Group" <> '') or ("VAT Prod. Posting Group" <> '') then begin
                                                if "Gen. Posting Type".AsInteger() = 0 then AddError(StrSubstNo(Text002, FieldCaption("Gen. Posting Type")));
                                            end;
                                            if ("Gen. Posting Type" <> "Gen. Posting Type"::" ") and ("VAT Posting" = "VAT Posting"::"Automatic VAT Entry") then begin
                                                if "VAT Amount" + "VAT Base Amount" <> Amount then AddError(StrSubstNo(Text003, FieldCaption("VAT Amount"), FieldCaption("VAT Base Amount"), FieldCaption(Amount)));
                                                if "Currency Code" <> '' then if "VAT Amount (LCY)" + "VAT Base Amount (LCY)" <> "Amount (LCY)" then AddError(StrSubstNo(Text003, FieldCaption("VAT Amount (LCY)"), FieldCaption("VAT Base Amount (LCY)"), FieldCaption("Amount (LCY)")));
                                            end;
                                        end;
                                    "Account Type"::Customer, "Account Type"::Vendor:
                                        begin
                                            if "Gen. Posting Type".AsInteger() <> 0 then AddError(StrSubstNo(Text004, FieldCaption("Gen. Posting Type"), FieldCaption("Account Type"), "Account Type"));
                                            if ("Gen. Bus. Posting Group" <> '') or ("Gen. Prod. Posting Group" <> '') or ("VAT Bus. Posting Group" <> '') or ("VAT Prod. Posting Group" <> '') then AddError(StrSubstNo(Text005, FieldCaption("Gen. Bus. Posting Group"), FieldCaption("Gen. Prod. Posting Group"), FieldCaption("VAT Bus. Posting Group"), FieldCaption("VAT Prod. Posting Group"), FieldCaption("Account Type"), "Account Type"));
                                            if "Document Type".AsInteger() <> 0 then begin
                                                if "Account Type" = "Account Type"::Customer then
                                                    case "Document Type" of
                                                        "Document Type"::"Credit Memo":
                                                            WarningIfPositiveAmt("Gen. Journal Line");
                                                        "Document Type"::Payment:
                                                            if ("Applies-to Doc. Type" = "Applies-to Doc. Type"::"Credit Memo") and ("Applies-to Doc. No." <> '') then
                                                                WarningIfNegativeAmt("Gen. Journal Line")
                                                            else
                                                                WarningIfPositiveAmt("Gen. Journal Line");
                                                        "Document Type"::Refund:
                                                            WarningIfNegativeAmt("Gen. Journal Line");
                                                        else
                                                            WarningIfNegativeAmt("Gen. Journal Line");
                                                    end
                                                else
                                                    case "Document Type" of
                                                        "Document Type"::"Credit Memo":
                                                            WarningIfNegativeAmt("Gen. Journal Line");
                                                        "Document Type"::Payment:
                                                            if ("Applies-to Doc. Type" = "Applies-to Doc. Type"::"Credit Memo") and ("Applies-to Doc. No." <> '') then
                                                                WarningIfPositiveAmt("Gen. Journal Line")
                                                            else
                                                                WarningIfNegativeAmt("Gen. Journal Line");
                                                        "Document Type"::Refund:
                                                            WarningIfPositiveAmt("Gen. Journal Line");
                                                        else
                                                            WarningIfPositiveAmt("Gen. Journal Line");
                                                    end
                                            end;
                                            if Amount * "Sales/Purch. (LCY)" < 0 then AddError(StrSubstNo(Text008, FieldCaption("Sales/Purch. (LCY)"), FieldCaption(Amount)));
                                            if "Job No." <> '' then AddError(StrSubstNo(Text009, FieldCaption("Job No.")));
                                        end;
                                    "Account Type"::"Bank Account":
                                        begin
                                            if "Gen. Posting Type".AsInteger() <> 0 then AddError(StrSubstNo(Text004, FieldCaption("Gen. Posting Type"), FieldCaption("Account Type"), "Account Type"));
                                            if ("Gen. Bus. Posting Group" <> '') or ("Gen. Prod. Posting Group" <> '') or ("VAT Bus. Posting Group" <> '') or ("VAT Prod. Posting Group" <> '') then AddError(StrSubstNo(Text005, FieldCaption("Gen. Bus. Posting Group"), FieldCaption("Gen. Prod. Posting Group"), FieldCaption("VAT Bus. Posting Group"), FieldCaption("VAT Prod. Posting Group"), FieldCaption("Account Type"), "Account Type"));
                                            if "Job No." <> '' then AddError(StrSubstNo(Text009, FieldCaption("Job No.")));
                                            if (Amount < 0) and ("Bank Payment Type" = "Bank Payment Type"::"Computer Check") then if not "Check Printed" then AddError(StrSubstNo(Text010, FieldCaption("Check Printed"), "Bank Payment Type"::"Electronic Payment"));
                                        end;
                                    "Account Type"::"Fixed Asset":
                                        TestFixedAsset("Gen. Journal Line");
                                end;
                            if "Bal. Account No." <> '' then
                                case "Bal. Account Type" of
                                    "Bal. Account Type"::"G/L Account":
                                        begin
                                            if ("Bal. Gen. Bus. Posting Group" <> '') or ("Bal. Gen. Prod. Posting Group" <> '') or ("Bal. VAT Bus. Posting Group" <> '') or ("Bal. VAT Prod. Posting Group" <> '') then begin
                                                if "Bal. Gen. Posting Type".AsInteger() = 0 then AddError(StrSubstNo(Text002, FieldCaption("Bal. Gen. Posting Type")));
                                            end;
                                            if ("Bal. Gen. Posting Type" <> "Bal. Gen. Posting Type"::" ") and ("VAT Posting" = "VAT Posting"::"Automatic VAT Entry") then begin
                                                if "Bal. VAT Amount" + "Bal. VAT Base Amount" <> -Amount then AddError(StrSubstNo(Text011, FieldCaption("Bal. VAT Amount"), FieldCaption("Bal. VAT Base Amount"), FieldCaption(Amount)));
                                                if "Currency Code" <> '' then if "Bal. VAT Amount (LCY)" + "Bal. VAT Base Amount (LCY)" <> -"Amount (LCY)" then AddError(StrSubstNo(Text011, FieldCaption("Bal. VAT Amount (LCY)"), FieldCaption("Bal. VAT Base Amount (LCY)"), FieldCaption("Amount (LCY)")));
                                            end;
                                        end;
                                    "Bal. Account Type"::Customer, "Bal. Account Type"::Vendor:
                                        begin
                                            if "Bal. Gen. Posting Type" <> 0 then AddError(StrSubstNo(Text004, FieldCaption("Bal. Gen. Posting Type"), FieldCaption("Bal. Account Type"), "Bal. Account Type"));
                                            if ("Bal. Gen. Bus. Posting Group" <> '') or ("Bal. Gen. Prod. Posting Group" <> '') or ("Bal. VAT Bus. Posting Group" <> '') or ("Bal. VAT Prod. Posting Group" <> '') then AddError(StrSubstNo(Text005, FieldCaption("Bal. Gen. Bus. Posting Group"), FieldCaption("Bal. Gen. Prod. Posting Group"), FieldCaption("Bal. VAT Bus. Posting Group"), FieldCaption("Bal. VAT Prod. Posting Group"), FieldCaption("Bal. Account Type"), "Bal. Account Type"));
                                            if "Document Type" <> 0 then begin
                                                if ("Bal. Account Type" = "Bal. Account Type"::Customer) = ("Document Type" in ["Document Type"::Payment, "Document Type"::"Credit Memo"]) then
                                                    WarningIfNegativeAmt("Gen. Journal Line")
                                                else
                                                    WarningIfPositiveAmt("Gen. Journal Line")
                                            end;
                                            if Amount * "Sales/Purch. (LCY)" > 0 then AddError(StrSubstNo(Text012, FieldCaption("Sales/Purch. (LCY)"), FieldCaption(Amount)));
                                            if "Job No." <> '' then AddError(StrSubstNo(Text009, FieldCaption("Job No.")));
                                        end;
                                    "Bal. Account Type"::"Bank Account":
                                        begin
                                            if "Bal. Gen. Posting Type" <> 0 then AddError(StrSubstNo(Text004, FieldCaption("Bal. Gen. Posting Type"), FieldCaption("Bal. Account Type"), "Bal. Account Type"));
                                            if ("Bal. Gen. Bus. Posting Group" <> '') or ("Bal. Gen. Prod. Posting Group" <> '') or ("Bal. VAT Bus. Posting Group" <> '') or ("Bal. VAT Prod. Posting Group" <> '') then AddError(StrSubstNo(Text005, FieldCaption("Bal. Gen. Bus. Posting Group"), FieldCaption("Bal. Gen. Prod. Posting Group"), FieldCaption("Bal. VAT Bus. Posting Group"), FieldCaption("Bal. VAT Prod. Posting Group"), FieldCaption("Bal. Account Type"), "Bal. Account Type"));
                                            if "Job No." <> '' then AddError(StrSubstNo(Text009, FieldCaption("Job No.")));
                                            if (Amount > 0) and ("Bank Payment Type" = "Bank Payment Type"::"Computer Check") then if not "Check Printed" then AddError(StrSubstNo(Text010, FieldCaption("Check Printed"), "Bank Payment Type"::"Electronic Payment"));
                                        end;
                                    "Bal. Account Type"::"Fixed Asset":
                                        TestFixedAsset("Gen. Journal Line");
                                end;
                            if ("Account No." <> '') and not "System-Created Entry" and ("Gen. Posting Type" = "Gen. Posting Type"::" ") and (Amount = 0) and not GenJnlTemplate.Recurring and not "Allow Zero-Amount Posting" and ("Account Type" <> "Account Type"::"Fixed Asset") then WarningIfZeroAmt("Gen. Journal Line");
                            CheckRecurringLine("Gen. Journal Line");
                            CheckAllocations("Gen. Journal Line");
                            if "Posting Date" = 0D then
                                AddError(StrSubstNo(Text002, FieldCaption("Posting Date")))
                            else begin
                                if "Posting Date" <> NormalDate("Posting Date") then if ("Account Type" <> "Account Type"::"G/L Account") or ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account") then AddError(StrSubstNo(Text013, FieldCaption("Posting Date")));
                                if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                                    if UserId <> '' then
                                        if UserSetup.Get(UserId) then begin
                                            AllowPostingFrom := UserSetup."Allow Posting From";
                                            AllowPostingTo := UserSetup."Allow Posting To";
                                        end;
                                    if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                                        AllowPostingFrom := GLSetup."Allow Posting From";
                                        AllowPostingTo := GLSetup."Allow Posting To";
                                    end;
                                    if AllowPostingTo = 0D then AllowPostingTo := 99991231D;
                                end;
                                if ("Posting Date" < AllowPostingFrom) or ("Posting Date" > AllowPostingTo) then AddError(StrSubstNo(Text014, Format("Posting Date")));
                                if "Gen. Journal Batch"."No. Series" <> '' then begin
                                    if NoSeries."Date Order" and ("Posting Date" < LastEntrdDate) then AddError(Text015);
                                    LastEntrdDate := "Posting Date";
                                end;
                            end;
                            if "Document Date" <> 0D then if ("Document Date" <> NormalDate("Document Date")) and (("Account Type" <> "Account Type"::"G/L Account") or ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account")) then AddError(StrSubstNo(Text013, FieldCaption("Document Date")));
                            if "Document No." = '' then
                                AddError(StrSubstNo(Text002, FieldCaption("Document No.")))
                            else if "Gen. Journal Batch"."No. Series" <> '' then begin
                                if (LastEntrdDocNo <> '') and ("Document No." <> LastEntrdDocNo) and ("Document No." <> IncStr(LastEntrdDocNo)) then AddError(Text016);
                                LastEntrdDocNo := "Document No.";
                            end;
                            if ("Account Type" in ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"Fixed Asset"]) and ("Bal. Account Type" in ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor, "Bal. Account Type"::"Fixed Asset"]) then AddError(StrSubstNo(Text017, FieldCaption("Account Type"), FieldCaption("Bal. Account Type")));
                            if Amount * "Amount (LCY)" < 0 then AddError(StrSubstNo(Text008, FieldCaption("Amount (LCY)"), FieldCaption(Amount)));
                            if ("Account Type" = "Account Type"::"G/L Account") and ("Bal. Account Type" = "Bal. Account Type"::"G/L Account") then if "Applies-to Doc. No." <> '' then AddError(StrSubstNo(Text009, FieldCaption("Applies-to Doc. No.")));
                            if (("Account Type" = "Account Type"::"G/L Account") and ("Bal. Account Type" = "Bal. Account Type"::"G/L Account")) or ("Document Type" <> "Document Type"::Invoice) then
                                if PaymentTerms.Get("Payment Terms Code") then begin
                                    if ("Document Type" = "Document Type"::"Credit Memo") and (not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos") then begin
                                        if "Pmt. Discount Date" <> 0D then AddError(StrSubstNo(Text009, FieldCaption("Pmt. Discount Date")));
                                        if "Payment Discount %" <> 0 then AddError(StrSubstNo(Text018, FieldCaption("Payment Discount %")));
                                    end;
                                end
                                else begin
                                    if "Pmt. Discount Date" <> 0D then AddError(StrSubstNo(Text009, FieldCaption("Pmt. Discount Date")));
                                    if "Payment Discount %" <> 0 then AddError(StrSubstNo(Text018, FieldCaption("Payment Discount %")));
                                end;
                            if (("Account Type" = "Account Type"::"G/L Account") and ("Bal. Account Type" = "Bal. Account Type"::"G/L Account")) or ("Applies-to Doc. No." <> '') then if "Applies-to ID" <> '' then AddError(StrSubstNo(Text009, FieldCaption("Applies-to ID")));
                            if ("Account Type" <> "Account Type"::"Bank Account") and ("Bal. Account Type" <> "Bal. Account Type"::"Bank Account") then if GenJnlLine2."Bank Payment Type" > 0 then AddError(StrSubstNo(Text009, FieldCaption("Bank Payment Type")));
                            if ("Account No." <> '') and ("Bal. Account No." <> '') then begin
                                PurchPostingType := false;
                                SalesPostingType := false;
                            end;
                            if "Account No." <> '' then
                                case "Account Type" of
                                    "Account Type"::"G/L Account":
                                        CheckGLAcc("Gen. Journal Line", AccName);
                                    "Account Type"::Customer:
                                        CheckCust("Gen. Journal Line", AccName);
                                    "Account Type"::Vendor:
                                        CheckVend("Gen. Journal Line", AccName);
                                    "Account Type"::"Bank Account":
                                        CheckBankAcc("Gen. Journal Line", AccName);
                                    "Account Type"::"Fixed Asset":
                                        CheckFixedAsset("Gen. Journal Line", AccName);
                                    "Account Type"::"IC Partner":
                                        CheckICPartner("Gen. Journal Line", AccName);
                                end;
                            if "Bal. Account No." <> '' then begin
                                ExchAccGLJnlLine.Run("Gen. Journal Line");
                                case "Account Type" of
                                    "Account Type"::"G/L Account":
                                        CheckGLAcc("Gen. Journal Line", BalAccName);
                                    "Account Type"::Customer:
                                        CheckCust("Gen. Journal Line", BalAccName);
                                    "Account Type"::Vendor:
                                        CheckVend("Gen. Journal Line", BalAccName);
                                    "Account Type"::"Bank Account":
                                        CheckBankAcc("Gen. Journal Line", BalAccName);
                                    "Account Type"::"Fixed Asset":
                                        CheckFixedAsset("Gen. Journal Line", BalAccName);
                                    "Account Type"::"IC Partner":
                                        CheckICPartner("Gen. Journal Line", AccName);
                                end;
                                ExchAccGLJnlLine.Run("Gen. Journal Line");
                            end;
                            if not DimMgt.CheckDimIDComb("Dimension Set ID") then AddError(DimMgt.GetDimCombErr);
                            TableID[1] := DimMgt.TypeToTableID1("Account Type");
                            No[1] := "Account No.";
                            TableID[2] := DimMgt.TypeToTableID1("Bal. Account Type");
                            No[2] := "Bal. Account No.";
                            TableID[3] := DATABASE::Job;
                            No[3] := "Job No.";
                            TableID[4] := DATABASE::"Salesperson/Purchaser";
                            No[4] := "Salespers./Purch. Code";
                            TableID[5] := DATABASE::Campaign;
                            No[5] := "Campaign No.";
                            if not DimMgt.CheckDimValuePosting(TableID, No, "Dimension Set ID") then AddError(DimMgt.GetDimValuePostingErr);
                            if "Bank Payment Type" = "Bank Payment Type"::"Electronic Payment" then begin
                                if not "Check Transmitted" then AddError(StrSubstNo(Text010, FieldCaption("Check Transmitted"), "Bank Payment Type"::"Electronic Payment"));
                                if not "Check Exported" then AddError(StrSubstNo(Text010, FieldCaption("Check Exported"), "Bank Payment Type"::"Electronic Payment"));
                            end;
                        end;
                        CheckBalance;
                        //IMP1.01 Start
                        GenJnlLineDescriptionVarGbl := Description;
                        if "Account Type" = "Account Type"::Vendor then GenJnlLineDescriptionVarGbl := Vend.Name;
                        //IMP1.01 End
                    end;

                    trigger OnPreDataItem();
                    begin
                        GenJnlTemplate.Get("Gen. Journal Batch"."Journal Template Name");
                        if GenJnlTemplate.Recurring then begin
                            if GetFilter("Posting Date") <> '' then AddError(StrSubstNo(Text000, FieldCaption("Posting Date")));
                            SetRange("Posting Date", 0D, WorkDate);
                            if GetFilter("Expiration Date") <> '' then AddError(StrSubstNo(Text000, FieldCaption("Expiration Date")));
                            SetFilter("Expiration Date", '%1 | %2..', 0D, WorkDate);
                        end;
                        if "Gen. Journal Batch"."No. Series" <> '' then begin
                            NoSeries.Get("Gen. Journal Batch"."No. Series");
                            LastEntrdDocNo := '';
                            LastEntrdDate := 0D;
                        end;
                        CurrentCustomerVendors := 0;
                        VATEntryCreated := false;
                        GenJnlLine2.Reset;
                        GenJnlLine2.CopyFilters("Gen. Journal Line");
                        GLAccNetChange.DeleteAll;
                    end;
                }
                dataitem(ReconcileLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number);

                    column(GLAccNetChange__No__; GLAccNetChange."No.")
                    {
                    }
                    column(GLAccNetChange_Name; GLAccNetChange.Name)
                    {
                    }
                    column(GLAccNetChange__Net_Change_in_Jnl__; GLAccNetChange."Net Change in Jnl.")
                    {
                    }
                    column(GLAccNetChange__Balance_after_Posting_; GLAccNetChange."Balance after Posting")
                    {
                    }
                    column(ReconcileLoop_Number; Number)
                    {
                    }
                    column(ReconciliationCaption; ReconciliationCaptionLbl)
                    {
                    }
                    column(GLAccNetChange__No__Caption; GLAccNetChange__No__CaptionLbl)
                    {
                    }
                    column(GLAccNetChange_NameCaption; GLAccNetChange_NameCaptionLbl)
                    {
                    }
                    column(GLAccNetChange__Net_Change_in_Jnl__Caption; GLAccNetChange__Net_Change_in_Jnl__CaptionLbl)
                    {
                    }
                    column(GLAccNetChange__Balance_after_Posting_Caption; GLAccNetChange__Balance_after_Posting_CaptionLbl)
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        if Number = 1 then
                            GLAccNetChange.Find('-')
                        else
                            GLAccNetChange.Next;
                    end;

                    trigger OnPostDataItem();
                    begin
                        GLAccNetChange.DeleteAll;
                    end;

                    trigger OnPreDataItem();
                    begin
                        SetRange(Number, 1, GLAccNetChange.Count);
                    end;
                }
            }
            trigger OnAfterGetRecord();
            begin
                CurrReport.PageNo := 1;
                GenJnlTemplate.Get("Gen. Journal Batch"."Journal Template Name");
            end;

            trigger OnPreDataItem();
            begin
                GLSetup.Get;
                SalesSetup.Get;
                PurchSetup.Get;
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

                    field(ShowDimensions; ShowDim)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Show Dimensions', ESM = 'Mostrar dimensiones', FRC = 'Afficher dimensions', ENC = 'Show Dimensions';
                        ToolTipML = ENU = 'Specifies if you want if you want the report to show dimensions.', ESM = 'Especifica si desea que el informe muestre dimensiones.', FRC = 'Spécifie si vous souhaitez que le rapport affiche les dimensions.', ENC = 'Specifies if you want if you want the report to show dimensions.';
                    }
                }
            }
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
        GenJnlLineFilter := "Gen. Journal Line".GetFilters;
        CompanyInformation.Get;
    end;

    var
        Text000: TextConst ENU = '%1 cannot be filtered when you post recurring journals.', ESM = 'No se puede filtrar %1 cuando registra diarios periódicos.', FRC = '%1 ne peut être filtré lorsque vous reportez des journaux récurrents.', ENC = '%1 cannot be filtered when you post recurring journals.';
        Text001: TextConst ENU = '%1 or %2 must be specified.', ESM = 'Debe especificar %1 o %2.', FRC = '%1 ou %2 doit être spécifié.', ENC = '%1 or %2 must be specified.';
        Text002: TextConst ENU = '%1 must be specified.', ESM = 'Se debe especificar %1.', FRC = '%1 doit être spécifié(e).', ENC = '%1 must be specified.';
        Text003: TextConst ENU = '%1 + %2 must be %3.', ESM = '%1 + %2 debe ser %3.', FRC = '%1 + %2 doit être équivalent à %3.', ENC = '%1 + %2 must be %3.';
        Text004: TextConst ENU = '%1 must be " " when %2 is %3.', ESM = '%1 debe contener un " " cuando %2 es %3.', FRC = '%1 doit être " " lorsque %2 est %3.', ENC = '%1 must be " " when %2 is %3.';
        Text005: TextConst ENU = '%1, %2, %3 or %4 must not be completed when %5 is %6.', ESM = '%1, %2, %3 o %4 no se deben completar cuando %5 es %6.', FRC = '%1, %2, %3 ou %4 doivent être renseignés quand %5 vaut %6.', ENC = '%1, %2, %3 or %4 must not be completed when %5 is %6.';
        Text006: TextConst ENU = '%1 must be negative.', ESM = 'El %1 debe ser negativo.', FRC = '%1 doit être négatif/ve.', ENC = '%1 must be negative.';
        Text007: TextConst ENU = '%1 must be positive.', ESM = 'El %1 debe ser positivo.', FRC = '%1 doit être positif/ve.', ENC = '%1 must be positive.';
        Text008: TextConst ENU = '%1 must have the same sign as %2.', ESM = '%1 y %2 deben tener el mismo signo.', FRC = '%1 doit avoir le même signe que %2.', ENC = '%1 must have the same sign as %2.';
        Text009: TextConst ENU = '%1 cannot be specified.', ESM = 'No se puede especificar %1.', FRC = '%1 ne peut pas être spécifié(e).', ENC = '%1 cannot be specified.';
        Text010: TextConst ENU = '%1 must be Yes for a(n) %2.', ESM = '%1 debe ser Sí para %2.', FRC = '%1 doit être Oui pour un(e) %2.', ENC = '%1 must be Yes for a(n) %2.';
        Text011: TextConst ENU = '%1 + %2 must be -%3.', ESM = '%1 + %2 debe ser -%3.', FRC = '%1 + %2 doit être équivalent à -%3.', ENC = '%1 + %2 must be -%3.';
        Text012: TextConst ENU = '%1 must have a different sign than %2.', ESM = '%1 y %2 deben tener signo diferente.', FRC = '%1 doit avoir un signe différent de %2.', ENC = '%1 must have a different sign than %2.';
        Text013: TextConst ENU = '%1 must only be a closing date for G/L entries.', ESM = '%1 solo puede ser una fecha de cierre en movimientos de contabilidad.', FRC = '%1 doit uniquement être une date de fermeture pour les écritures GL.', ENC = '%1 must only be a closing date for G/L entries.';
        Text014: TextConst ENU = '%1 is not within your allowed range of posting dates.', ESM = '%1 no se encuentra en su rango permitido de fechas de registro.', FRC = '%1 ne se trouve pas dans la plage autorisée de dates de report.', ENC = '%1 is not within your allowed range of posting dates.';
        Text015: TextConst ENU = 'The lines are not listed according to Posting Date because they were not entered in that order.', ESM = 'Las líneas no se listan ordenadas por fecha de registro ya que no fueron introducidas en esa secuencia.', FRC = 'Les lignes ne sont pas répertoriées selon la date de report, car elles n''ont pas été entrées dans cet ordre.', ENC = 'The lines are not listed according to Posting Date because they were not entered in that order.';
        Text016: TextConst ENU = 'There is a gap in the number series.', ESM = 'Hay un salto en la serie numérica.', FRC = 'Il y a un écart dans la série de numéros.', ENC = 'There is a gap in the number series.';
        Text017: TextConst ENU = '%1 or %2 must be G/L Account or Bank Account.', ESM = '%1 o %2 deben ser de tipo Cuenta o Banco.', FRC = '%1 ou %2 doit être un compte GL ou bancaire.', ENC = '%1 or %2 must be G/L Account or Bank Account.';
        Text018: TextConst ENU = '%1 must be 0.', ESM = '%1 debe ser 0.', FRC = '%1 doit être 0.', ENC = '%1 must be 0.';
        Text019: TextConst ENU = '%1 cannot be specified when using recurring journals.', ESM = '%1 no se puede especificar mediante diarios periódicos.', FRC = '%1 ne peut être spécifié lors de l''utilisation de journaux récurrents.', ENC = '%1 cannot be specified when using recurring journals.';
        Text020: TextConst ENU = '%1 must not be %2 when %3 = %4.', ESM = '%1 no debe ser %2 cuando %3 = %4.', FRC = '%1 ne doit pas être %2 quand %3=%4.', ENC = '%1 must not be %2 when %3 = %4.';
        Text021: TextConst ENU = 'Allocations can only be used with recurring journals.', ESM = 'Distribuciones sólo se permiten en diarios periódicos.', FRC = 'Les affectations ne peuvent être utilisées qu''avec des journaux récurrents.', ENC = 'Allocations can only be used with recurring journals.';
        Text022: TextConst ENU = 'Please specify %1 in the %2 allocation lines.', ESM = 'Complete el campo %1 en %2 líneas de distribución.', FRC = 'Veuillez spécifier %1 dans les lignes affectation %2.', ENC = 'Please specify %1 in the %2 allocation lines.';
        Text023: TextConst ENU = '<Month Text>', ESM = '<Month Text>', FRC = '<Month Text>', ENC = '<Month Text>';
        Text024: TextConst ENU = '%1 %2 posted on %3, must be separated by an empty line', ESM = '%1 %2 registrado el %3; debe estar separado por una línea vacía.', FRC = '%1 %2 reporté le %3 doit être séparé par une ligne vide', ENC = '%1 %2 posted on %3, must be separated by an empty line';
        Text025: TextConst ENU = '%1 %2 is out of balance by %3.', ESM = '%1 %2 descuadrado por %3.', FRC = '%1 %2 est hors balance de %3.', ENC = '%1 %2 is out of balance by %3.';
        Text026: TextConst ENU = 'The reversing entries for %1 %2 are out of balance by %3.', ESM = 'Los movs. reversión para %1 %2 están descuadrados por %3.', FRC = 'Les écritures de contrepassation pour %1 %2 sont hors balance de %3.', ENC = 'The reversing entries for %1 %2 are out of balance by %3.';
        Text027: TextConst ENU = 'As of %1, the lines are out of balance by %2.', ESM = 'Para %1, las líneas están descuadradas por %2.', FRC = '‡ dater du %1, les lignes sont hors balance de %2.', ENC = 'As of %1, the lines are out of balance by %2.';
        Text028: TextConst ENU = 'As of %1, the reversing entries are out of balance by %2.', ESM = 'Para %1, los movs. reversión están descuadrados por %2.', FRC = '‡ dater du %1, les écritures de contrepassation sont hors balance de %2.', ENC = 'As of %1, the reversing entries are out of balance by %2.';
        Text029: TextConst ENU = 'The total of the lines is out of balance by %1.', ESM = 'El total de las líneas está descuadrado por %1.', FRC = 'Le total des lignes est hors balance de %1.', ENC = 'The total of the lines is out of balance by %1.';
        Text030: TextConst ENU = 'The total of the reversing entries is out of balance by %1.', ESM = 'El total de los movs. reversión está descuadrado por %1.', FRC = 'Le total des écritures de contrepassation est hors balance de %1.', ENC = 'The total of the reversing entries is out of balance by %1.';
        Text031: TextConst ENU = '%1 %2 does not exist.', ESM = 'No existe %1 %2.', FRC = '%1 %2 n''existe pas.', ENC = '%1 %2 does not exist.';
        Text032: TextConst ENU = '%1 must be %2 for %3 %4.', ESM = '%1 debe ser %2 para %3 %4.', FRC = '%1 doit être %2 pour %3 %4.', ENC = '%1 must be %2 for %3 %4.';
        Text036: TextConst ENU = '%1 %2 %3 does not exist.', ESM = 'No existe %1 %2 %3.', FRC = '%1 %2 %3 n''existe pas.', ENC = '%1 %2 %3 does not exist.';
        Text037: TextConst ENU = '%1 must be %2.', ESM = '%1 debe ser %2.', FRC = '%1 doit être %2.', ENC = '%1 must be %2.';
        Text038: TextConst ENU = 'The currency %1 cannot be found. Please check the currency table.', ESM = 'No se ha encontrado la divisa %1. Compruebe la tabla de divisas.', FRC = 'La devise %1 ne peut être trouvée. Consultez la table des devises.', ENC = 'The currency %1 cannot be found. Please check the currency table.';
        Text039: TextConst ENU = 'Sales %1 %2 already exists.', ESM = 'Ya existe la venta  %1 %2.', FRC = 'Le document %1 vente %2 existe déjà.', ENC = 'Sales %1 %2 already exists.';
        Text040: TextConst ENU = 'Purchase %1 %2 already exists.', ESM = 'Ya existe la compra %1 %2.', FRC = 'Le document %1 achat %2 existe déjà.', ENC = 'Purchase %1 %2 already exists.';
        Text041: TextConst ENU = '%1 must be entered.', ESM = 'Se debe indicar %1.', FRC = '%1 doit être entré(e).', ENC = '%1 must be entered.';
        Text042: TextConst ENU = '%1 must not be filled when %2 is different in %3 and %4.', ESM = 'No se debe completar %1 cuando %2 es diferente en %3 y %4.', FRC = '%1 ne doit pas être renseigné(e) quand %2 est différent dans %3 et %4.', ENC = '%1 must not be filled when %2 is different in %3 and %4.';
        Text043: TextConst ENU = '%1 %2 must not have %3 = %4.', ESM = '%1 %2 no debe ser %3 = %4.', FRC = '%1 %2 ne doit pas avoir %3 = %4.', ENC = '%1 %2 must not have %3 = %4.';
        Text044: TextConst ENU = '%1 must not be specified in fixed asset journal lines.', ESM = 'No se debe especificar %1 en las líneas de diario de activos fijos.', FRC = '%1 ne doit pas être spécifié dans les lignes de journal des immobilisations.', ENC = '%1 must not be specified in fixed asset journal lines.';
        Text045: TextConst ENU = '%1 must be specified in fixed asset journal lines.', ESM = 'Se debe especificar %1 en las líneas de diario de activos fijos.', FRC = '%1 doit être spécifié dans les lignes de journal des immobilisations.', ENC = '%1 must be specified in fixed asset journal lines.';
        Text046: TextConst ENU = '%1 must be different than %2.', ESM = '%1 debe ser diferente de %2.', FRC = '%1 doit être différent de %2.', ENC = '%1 must be different than %2.';
        Text047: TextConst ENU = '%1 and %2 must not both be %3.', ESM = '%1 y %2 no deben ser %3.', FRC = '%1 et %2 ne doivent pas être tous les deux %3.', ENC = '%1 and %2 must not both be %3.';
        Text048: TextConst ENU = '%1  must not be specified when %2 = %3.', ESM = 'No se debe especificar %1 cuando %2 = %3.', FRC = '%1 ne doit pas être spécifié lorsque %2 = %3.', ENC = '%1  must not be specified when %2 = %3.';
        Text049: TextConst ENU = '%1 must not be specified when %2 = %3.', ESM = 'No se debe especificar %1 cuando %2 = %3.', FRC = '%1 ne doit pas être défini(e) quand %2 = %3.', ENC = '%1 must not be specified when %2 = %3.';
        Text050: TextConst ENU = 'must not be specified together with %1 = %2.', ESM = 'no se debe especificar conjuntamente con  %1 = %2.', FRC = 'ne doit pas être défini(e) avec %1 = %2.', ENC = 'must not be specified together with %1 = %2.';
        Text051: TextConst ENU = '%1 must be identical to %2.', ESM = '%1 debe ser idéntico a %2.', FRC = '%1 doit être identique à %2.', ENC = '%1 must be identical to %2.';
        Text052: TextConst ENU = '%1 cannot be a closing date.', ESM = '%1 no puede ser una fecha de cierre.', FRC = '%1 ne peut être une date de fermeture.', ENC = '%1 cannot be a closing date.';
        Text053: TextConst ENU = '%1 is not within your range of allowed posting dates.', ESM = '%1 no está dentro del intervalo de fechas de registro permitidas.', FRC = '%1 ne se trouve pas dans votre plage de dates de report autorisées.', ENC = '%1 is not within your range of allowed posting dates.';
        Text054: TextConst ENU = 'Insurance integration is not activated for %1 %2.', ESM = 'No se ha activado la integración de seguro para %1 %2.', FRC = 'L''intégration des assurances n''est pas activée pour %1 %2.', ENC = 'Insurance integration is not activated for %1 %2.';
        Text055: TextConst ENU = 'must not be specified when %1 is specified.', ESM = 'no se debe especificar cuando se ha seleccionado %1.', FRC = 'ne doit pas être défini(e) quand %1 est défini(e).', ENC = 'must not be specified when %1 is specified.';
        Text056: TextConst ENU = 'When G/L integration is not activated, %1 must not be posted in the general journal.', ESM = 'Si no se ha activado la integración con contabilidad, no se debe registrar %1 en el diario general.', FRC = 'Lorsque l''intégration du GL n''est pas activée, %1 ne doit pas être reporté dans le journal général.', ENC = 'When G/L integration is not activated, %1 must not be posted in the general journal.';
        Text057: TextConst ENU = 'When G/L integration is not activated, %1 must not be specified in the general journal.', ESM = 'Si no se ha activado la integración con contabilidad, no se debe especificar %1 en el diario general.', FRC = 'Lorsque l''intégration du GL n''est pas activée, %1 ne doit pas être spécifié dans le journal général.', ENC = 'When G/L integration is not activated, %1 must not be specified in the general journal.';
        Text058: TextConst ENU = '%1 must not be specified.', ESM = 'No se debe especificar %1.', FRC = '%1 ne doit pas être défini(e).', ENC = '%1 must not be specified.';
        Text059: TextConst ENU = 'The combination of Customer and Gen. Posting Type Purchase is not allowed.', ESM = 'La combinación de cliente y compras de tipo de registro gen. no está permitida.', FRC = 'La combinaison client et type de report général de l''achat n''est pas permise.', ENC = 'The combination of Customer and Gen. Posting Type Purchase is not allowed.';
        Text060: TextConst ENU = 'The combination of Vendor and Gen. Posting Type Sales is not allowed.', ESM = 'La combinación de proveedor y ventas de tipo de registro gen. no está permitida.', FRC = 'La combinaison fournisseur et type de report général de la vente n''est pas permise.', ENC = 'The combination of Vendor and Gen. Posting Type Sales is not allowed.';
        Text061: TextConst ENU = 'The Balance and Reversing Balance recurring methods can be used only with Allocations.', ESM = 'Los métodos recurrentes de saldo y saldo de reversión pueden usarse solo con asignaciones.', FRC = 'Les modes récurrents Solde et Solde inversion ne peuvent être utilisés qu''avec des affectations.', ENC = 'The Balance and Reversing Balance recurring methods can be used only with Allocations.';
        Text062: TextConst ENU = '%1 must not be 0.', ESM = '%1 no debe ser 0.', FRC = '%1 ne doit pas être 0.', ENC = '%1 must not be 0.';
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        AccountingPeriod: Record "Accounting Period";
        GLAcc: Record "G/L Account";
        Currency: Record Currency;
        Cust: Record Customer;
        Vend: Record Vendor;
        BankAccPostingGr: Record "Bank Account Posting Group";
        BankAcc: Record "Bank Account";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlLine2: Record "Gen. Journal Line";
        TempGenJnlLine: Record "Gen. Journal Line" temporary;
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        OldCustLedgEntry: Record "Cust. Ledger Entry";
        OldVendLedgEntry: Record "Vendor Ledger Entry";
        VATPostingSetup: Record "VAT Posting Setup";
        NoSeries: Record "No. Series";
        FA: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        DeprBook: Record "Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        FASetup: Record "FA Setup";
        GLAccNetChange: Record "G/L Account Net Change" temporary;
        CompanyInformation: Record "Company Information";
        DimSetEntry: Record "Dimension Set Entry";
        ExchAccGLJnlLine: Codeunit "Exchange Acc. G/L Journal Line";
        GenJnlLineFilter: Text;
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        AllowFAPostingFrom: Date;
        AllowFAPostingTo: Date;
        LastDate: Date;
        LastDocType: Option Document,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder;
        LastDocNo: Code[20];
        LastEntrdDocNo: Code[20];
        LastEntrdDate: Date;
        DocBalance: Decimal;
        DocBalanceReverse: Decimal;
        DateBalance: Decimal;
        DateBalanceReverse: Decimal;
        TotalBalance: Decimal;
        TotalBalanceReverse: Decimal;
        AccName: Text[100];
        LastLineNo: Integer;
        Day: Integer;
        Week: Integer;
        Month: Integer;
        MonthText: Text[30];
        AmountError: Boolean;
        ErrorCounter: Integer;
        ErrorText: array[50] of Text[250];
        TempErrorText: Text[250];
        BalAccName: Text[100];
        CurrentCustomerVendors: Integer;
        VATEntryCreated: Boolean;
        CustPosting: Boolean;
        VendPosting: Boolean;
        SalesPostingType: Boolean;
        PurchPostingType: Boolean;
        DimText: Text[120];
        OldDimText: Text[120];
        ShowDim: Boolean;
        Continue: Boolean;
        Text063: TextConst ENU = 'Document,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', ESM = 'Documento,Pago,Factura,Nota de crédito,Documento de interés,Recordatorio,Reembolso', FRC = 'Document,Paiement,Facture,Note de crédit,Note de frais financiers,Rappel,Remboursement', ENC = 'Document,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
        Text064: TextConst ENU = '%1 %2 is already used in line %3 (%4 %5).', ESM = '%1 %2 se utiliza ya en la línea %3 (%4 %5).', FRC = '%1 %2 est déjà utilisé(e) à la ligne %3 (%4 %5).', ENC = '%1 %2 is already used in line %3 (%4 %5).';
        Text065: TextConst ENU = '%1 must not be blocked with type %2 when %3 is %4', ESM = '%1 no debe estar bloqueado con el grupo %2 cuando %3 es %4', FRC = '%1 ne doit pas être bloqué avec le type %2 lorsque %3 est %4', ENC = '%1 must not be blocked with type %2 when %3 is %4';
        PrivacyBlockedErr: TextConst Comment = '%1 = account type', ENU = '%1 must not be blocked for privacy.', ESM = '%1 no debe bloquearse por motivos de privacidad.', FRC = '%1 ne doit pas être bloqué à des fins de confidentialité.', ENC = '%1 must not be blocked for privacy.';
        CurrentICPartner: Code[20];
        Text066: TextConst ENU = 'You cannot enter G/L Account or Bank Account in both %1 and %2.', ESM = 'No puede introducir una cuenta o una cuenta bancaria en %1 y en %2.', FRC = 'Vous ne pouvez pas entrer le compte du grand livre ou le compte bancaire à la fois dans %1 et dans %2.', ENC = 'You cannot enter G/L Account or Bank Account in both %1 and %2.';
        Text067: TextConst ENU = '%1 %2 is linked to %3 %4.', ESM = '%1 %2 tiene un vínculo con %3 %4.', FRC = '%1 %2 est lié à %3 %4.', ENC = '%1 %2 is linked to %3 %4.';
        Text069: TextConst ENU = '%1 must not be specified when %2 is %3.', ESM = 'No debe especificarse %1 cuando %2 es %3.', FRC = '%1 ne doit pas être indiqué lorsque %2 est %3.', ENC = '%1 must not be specified when %2 is %3.';
        Text070: TextConst ENU = '%1 must not be specified when the document is not an intercompany transaction.', ESM = 'No debe especificarse %1 si el documento no es una transacción entre empresas vinculadas.', FRC = '%1 ne doit pas être indiqué si le document n''est pas une transaction intersociétés.', ENC = '%1 must not be specified when the document is not an intercompany transaction.';
        USText001: TextConst ENU = 'Warning:  Checks cannot be financially voided when Force Doc. Balance is set to No in the Journal Template.', ESM = 'Aviso: los cheques podrán anularse si Forzar saldo por nº documento está establecido en No en el Libro diario.', FRC = 'Avertissement : impossible d''annuler financièrement un chèque lorsque le paramètre Forcer équilibre doc. est défini à Non dans le modèle de journal.', ENC = 'Warning:  Cheques cannot be financially voided when Force Doc. Balance is set to No in the Journal Template.';
        Payment_Journal___TestCaptionLbl: TextConst ENU = 'Payment Journal - Test', ESM = 'Diario de pagos - Prueba', FRC = 'Journal des paiements - Test', ENC = 'Payment Journal - Test';
        CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page', ESM = 'Pág.', FRC = 'Page', ENC = 'Page';
        Gen__Journal_Batch__NameCaptionLbl: TextConst ENU = 'Journal Batch', ESM = 'Sección diario', FRC = 'Lot journal', ENC = 'Journal Batch';
        Gen__Journal_Line__Posting_Date_CaptionLbl: TextConst ENU = 'Posting Date', ESM = 'Fecha registro', FRC = 'Date de report', ENC = 'Posting Date';
        Gen__Journal_Line__Document_Type_CaptionLbl: TextConst ENU = 'Type', ESM = 'Tipo', FRC = 'Type', ENC = 'Type';
        Gen__Journal_Line__Document_No__CaptionLbl: TextConst ENU = 'Number', ESM = 'Número', FRC = 'Numéro', ENC = 'Number';
        Gen__Journal_Line__Account_Type_CaptionLbl: TextConst ENU = 'Type', ESM = 'Tipo', FRC = 'Type', ENC = 'Type';
        Gen__Journal_Line__Account_No__CaptionLbl: TextConst ENU = 'Number', ESM = 'Número', FRC = 'Numéro', ENC = 'Number';
        Gen__Journal_Line__Bal__Account_No__CaptionLbl: TextConst ENU = 'Number', ESM = 'Número', FRC = 'Numéro', ENC = 'Number';
        Gen__Journal_Line__Bal__Account_Type_CaptionLbl: TextConst ENU = 'Type', ESM = 'Tipo', FRC = 'Type', ENC = 'Type';
        Gen__Journal_Line__Applies_to_Doc__Type_CaptionLbl: TextConst ENU = 'Type', ESM = 'Tipo', FRC = 'Type', ENC = 'Type';
        Gen__Journal_Line__Applies_to_Doc__No__CaptionLbl: TextConst ENU = 'Number', ESM = 'Número', FRC = 'Numéro', ENC = 'Number';
        DocumentCaptionLbl: TextConst ENU = 'Document', ESM = 'Documento', FRC = 'Document', ENC = 'Document';
        AccountCaptionLbl: TextConst ENU = 'Account', ESM = 'Cuenta', FRC = 'Compte', ENC = 'Account';
        Applies_to_Doc_CaptionLbl: TextConst ENU = 'Applies-to Doc.', ESM = 'Liq. por doc.', FRC = 'Doc. affectation', ENC = 'Applies-to Doc.';
        Bal__AccountCaptionLbl: TextConst ENU = 'Bal. Account', ESM = 'Cta. contrapartida', FRC = 'Compte contrepartie', ENC = 'Bal. Account';
        DimensionsCaptionLbl: TextConst ENU = 'Dimensions', ESM = 'Dimensiones', FRC = 'Dimensions', ENC = 'Dimensions';
        ErrorText_Number_CaptionLbl: TextConst ENU = 'Warning!', ESM = 'Advertencia', FRC = 'Attention!', ENC = 'Warning!';
        ReconciliationCaptionLbl: TextConst ENU = 'Reconciliation', ESM = 'Conciliación', FRC = 'Rapprochement', ENC = 'Reconciliation';
        GLAccNetChange__No__CaptionLbl: TextConst ENU = 'No.', ESM = 'Nº', FRC = 'N°', ENC = 'No.';
        GLAccNetChange_NameCaptionLbl: TextConst ENU = 'Name', ESM = 'Nombre', FRC = 'Nom', ENC = 'Name';
        GLAccNetChange__Net_Change_in_Jnl__CaptionLbl: TextConst ENU = 'Net Change in Jnl.', ESM = 'Saldo periodo en diario', FRC = 'Variation nette dans journal', ENC = 'Net Change in Jnl.';
        GLAccNetChange__Balance_after_Posting_CaptionLbl: TextConst ENU = 'Balance after Posting', ESM = 'Saldo después del registro', FRC = 'Solde après report', ENC = 'Balance after Posting';
        "-IMP1.01-": Integer;
        GenJnlLineDescriptionVarGbl: Text;
    //[LineStart(1706)]
    local procedure CheckRecurringLine(GenJnlLine2: Record "Gen. Journal Line");
    begin
        if GenJnlTemplate.Recurring then begin
            if GenJnlLine2."Recurring Method" = 0 then AddError(StrSubstNo(Text002, GenJnlLine2.FieldCaption("Recurring Method")));
            if Format(GenJnlLine2."Recurring Frequency") = '' then AddError(StrSubstNo(Text002, GenJnlLine2.FieldCaption("Recurring Frequency")));
            if GenJnlLine2."Bal. Account No." <> '' then AddError(StrSubstNo(Text019, GenJnlLine2.FieldCaption("Bal. Account No.")));
            case GenJnlLine2."Recurring Method" of
                GenJnlLine2."Recurring Method"::"V  Variable", GenJnlLine2."Recurring Method"::"RV Reversing Variable", GenJnlLine2."Recurring Method"::"F  Fixed", GenJnlLine2."Recurring Method"::"RF Reversing Fixed":
                    WarningIfZeroAmt("Gen. Journal Line");
                GenJnlLine2."Recurring Method"::"B  Balance", GenJnlLine2."Recurring Method"::"RB Reversing Balance":
                    WarningIfNonZeroAmt("Gen. Journal Line");
            end;
            if GenJnlLine2."Recurring Method" > GenJnlLine2."Recurring Method"::"V  Variable" then begin
                if GenJnlLine2."Account Type" = GenJnlLine2."Account Type"::"Fixed Asset" then AddError(StrSubstNo(Text020, GenJnlLine2.FieldCaption("Recurring Method"), GenJnlLine2."Recurring Method", GenJnlLine2.FieldCaption("Account Type"), GenJnlLine2."Account Type"));
                if GenJnlLine2."Bal. Account Type" = GenJnlLine2."Bal. Account Type"::"Fixed Asset" then AddError(StrSubstNo(Text020, GenJnlLine2.FieldCaption("Recurring Method"), GenJnlLine2."Recurring Method", GenJnlLine2.FieldCaption("Bal. Account Type"), GenJnlLine2."Bal. Account Type"));
            end;
        end
        else begin
            if GenJnlLine2."Recurring Method" <> 0 then AddError(StrSubstNo(Text009, GenJnlLine2.FieldCaption("Recurring Method")));
            if Format(GenJnlLine2."Recurring Frequency") <> '' then AddError(StrSubstNo(Text009, GenJnlLine2.FieldCaption("Recurring Frequency")));
        end;
    end;
    //[LineStart(1746)]
    local procedure CheckAllocations(GenJnlLine2: Record "Gen. Journal Line");
    begin
        if GenJnlLine2."Recurring Method" in [GenJnlLine2."Recurring Method"::"B  Balance", GenJnlLine2."Recurring Method"::"RB Reversing Balance"] then begin
            GenJnlAlloc.Reset;
            GenJnlAlloc.SetRange("Journal Template Name", GenJnlLine2."Journal Template Name");
            GenJnlAlloc.SetRange("Journal Batch Name", GenJnlLine2."Journal Batch Name");
            GenJnlAlloc.SetRange("Journal Line No.", GenJnlLine2."Line No.");
            if not GenJnlAlloc.FindFirst then AddError(Text061);
        end;
        GenJnlAlloc.Reset;
        GenJnlAlloc.SetRange("Journal Template Name", GenJnlLine2."Journal Template Name");
        GenJnlAlloc.SetRange("Journal Batch Name", GenJnlLine2."Journal Batch Name");
        GenJnlAlloc.SetRange("Journal Line No.", GenJnlLine2."Line No.");
        GenJnlAlloc.SetFilter(Amount, '<>0');
        if GenJnlAlloc.FindFirst then
            if not GenJnlTemplate.Recurring then
                AddError(Text021)
            else begin
                GenJnlAlloc.SetRange("Account No.", '');
                if GenJnlAlloc.FindFirst then AddError(StrSubstNo(Text022, GenJnlAlloc.FieldCaption("Account No."), GenJnlAlloc.Count));
            end;
    end;
    //[LineStart(1778)]
    local procedure MakeRecurringTexts(var GenJnlLine2: Record "Gen. Journal Line");
    begin
        if (GenJnlLine2."Posting Date" <> 0D) and (GenJnlLine2."Account No." <> '') and (GenJnlLine2."Recurring Method" <> 0) then begin
            Day := Date2DMY(GenJnlLine2."Posting Date", 1);
            Week := Date2DWY(GenJnlLine2."Posting Date", 2);
            Month := Date2DMY(GenJnlLine2."Posting Date", 2);
            MonthText := Format(GenJnlLine2."Posting Date", 0, Text023);
            AccountingPeriod.SetRange("Starting Date", 0D, GenJnlLine2."Posting Date");
            if not AccountingPeriod.FindLast then AccountingPeriod.Name := '';
            GenJnlLine2."Document No." := DelChr(PadStr(StrSubstNo(GenJnlLine2."Document No.", Day, Week, Month, MonthText, AccountingPeriod.Name), MaxStrLen(GenJnlLine2."Document No.")), '>');
            GenJnlLine2.Description := DelChr(PadStr(StrSubstNo(GenJnlLine2.Description, Day, Week, Month, MonthText, AccountingPeriod.Name), MaxStrLen(GenJnlLine2.Description)), '>');
        end;
    end;
    //[LineStart(1802)]
    local procedure CheckBalance();
    var
        GenJnlLine: Record "Gen. Journal Line";
        NextGenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine := "Gen. Journal Line";
        LastLineNo := "Gen. Journal Line"."Line No.";
        if "Gen. Journal Line".Next = 0 then;
        NextGenJnlLine := "Gen. Journal Line";
        MakeRecurringTexts(NextGenJnlLine);
        "Gen. Journal Line" := GenJnlLine;
        if not GenJnlLine.EmptyLine then begin
            DocBalance := DocBalance + GenJnlLine."Balance (LCY)";
            DateBalance := DateBalance + GenJnlLine."Balance (LCY)";
            TotalBalance := TotalBalance + GenJnlLine."Balance (LCY)";
            if GenJnlLine."Recurring Method" >= GenJnlLine."Recurring Method"::"RF Reversing Fixed" then begin
                DocBalanceReverse := DocBalanceReverse + GenJnlLine."Balance (LCY)";
                DateBalanceReverse := DateBalanceReverse + GenJnlLine."Balance (LCY)";
                TotalBalanceReverse := TotalBalanceReverse + GenJnlLine."Balance (LCY)";
            end;
            LastDocType := GenJnlLine."Document Type";
            LastDocNo := GenJnlLine."Document No.";
            LastDate := GenJnlLine."Posting Date";
            if TotalBalance = 0 then begin
                CurrentCustomerVendors := 0;
                VATEntryCreated := false;
            end;
            if GenJnlTemplate."Force Doc. Balance" then begin
                VATEntryCreated := VATEntryCreated or ((GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account") and (GenJnlLine."Account No." <> '') and (GenJnlLine."Gen. Posting Type" in [GenJnlLine."Gen. Posting Type"::Purchase, GenJnlLine."Gen. Posting Type"::Sale])) or ((GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"G/L Account") and (GenJnlLine."Bal. Account No." <> '') and (GenJnlLine."Bal. Gen. Posting Type" in [GenJnlLine."Bal. Gen. Posting Type"::Purchase, GenJnlLine."Bal. Gen. Posting Type"::Sale]));
                if ((GenJnlLine."Account Type" in [GenJnlLine."Account Type"::Customer, GenJnlLine."Account Type"::Vendor]) and (GenJnlLine."Account No." <> '')) or ((GenJnlLine."Bal. Account Type" in [GenJnlLine."Bal. Account Type"::Customer, GenJnlLine."Bal. Account Type"::Vendor]) and (GenJnlLine."Bal. Account No." <> '')) then CurrentCustomerVendors := CurrentCustomerVendors + 1;
                if (CurrentCustomerVendors > 1) and VATEntryCreated then AddError(StrSubstNo(Text024, GenJnlLine."Document Type", GenJnlLine."Document No.", GenJnlLine."Posting Date"));
            end;
        end;
        if (LastDate <> 0D) and (LastDocNo <> '') and ((NextGenJnlLine."Posting Date" <> LastDate) or (NextGenJnlLine."Document Type" <> LastDocType) or (NextGenJnlLine."Document No." <> LastDocNo) or (NextGenJnlLine."Line No." = LastLineNo)) then begin
            if GenJnlTemplate."Force Doc. Balance" then begin
                case true of
                    DocBalance <> 0:
                        AddError(StrSubstNo(Text025, SelectStr(LastDocType + 1, Text063), LastDocNo, DocBalance));
                    DocBalanceReverse <> 0:
                        AddError(StrSubstNo(Text026, SelectStr(LastDocType + 1, Text063), LastDocNo, DocBalanceReverse));
                end;
                DocBalance := 0;
                DocBalanceReverse := 0;
            end;
            if (NextGenJnlLine."Posting Date" <> LastDate) or (NextGenJnlLine."Document Type" <> LastDocType) or (NextGenJnlLine."Document No." <> LastDocNo) then begin
                CurrentCustomerVendors := 0;
                VATEntryCreated := false;
                CustPosting := false;
                VendPosting := false;
                SalesPostingType := false;
                PurchPostingType := false;
            end;
        end;
        if (LastDate <> 0D) and ((NextGenJnlLine."Posting Date" <> LastDate) or (NextGenJnlLine."Line No." = LastLineNo)) then begin
            case true of
                DateBalance <> 0:
                    AddError(StrSubstNo(Text027, LastDate, DateBalance));
                DateBalanceReverse <> 0:
                    AddError(StrSubstNo(Text028, LastDate, DateBalanceReverse));
            end;
            DocBalance := 0;
            DocBalanceReverse := 0;
            DateBalance := 0;
            DateBalanceReverse := 0;
        end;
        if NextGenJnlLine."Line No." = LastLineNo then begin
            case true of
                TotalBalance <> 0:
                    AddError(StrSubstNo(Text029, TotalBalance));
                TotalBalanceReverse <> 0:
                    AddError(StrSubstNo(Text030, TotalBalanceReverse));
            end;
            DocBalance := 0;
            DocBalanceReverse := 0;
            DateBalance := 0;
            DateBalanceReverse := 0;
            TotalBalance := 0;
            TotalBalanceReverse := 0;
            LastDate := 0D;
            LastDocType := 0;
            LastDocNo := '';
        end;
    end;
    //[LineStart(1926)]
    local procedure AddError(Text: Text[250]);
    begin
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
    end;
    //[LineStart(1930)]
    local procedure ReconcileGLAccNo(GLAccNo: Code[20]; ReconcileAmount: Decimal);
    begin
        if not GLAccNetChange.Get(GLAccNo) then begin
            GLAcc.Get(GLAccNo);
            GLAcc.CalcFields("Balance at Date");
            GLAccNetChange.Init;
            GLAccNetChange."No." := GLAcc."No.";
            GLAccNetChange.Name := GLAcc.Name;
            GLAccNetChange."Balance after Posting" := GLAcc."Balance at Date";
            GLAccNetChange.Insert;
        end;
        GLAccNetChange."Net Change in Jnl." := GLAccNetChange."Net Change in Jnl." + ReconcileAmount;
        GLAccNetChange."Balance after Posting" := GLAccNetChange."Balance after Posting" + ReconcileAmount;
        GLAccNetChange.Modify;
    end;
    //[LineStart(1944)]
    local procedure CheckGLAcc(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[100]);
    begin
        if not GLAcc.Get(GenJnlLine."Account No.") then
            AddError(StrSubstNo(Text031, GLAcc.TableCaption, GenJnlLine."Account No."))
        else begin
            AccName := GLAcc.Name;
            if GLAcc.Blocked then AddError(StrSubstNo(Text032, GLAcc.FieldCaption(Blocked), false, GLAcc.TableCaption, GenJnlLine."Account No."));
            if GLAcc."Account Type" <> GLAcc."Account Type"::Posting then begin
                GLAcc."Account Type" := GLAcc."Account Type"::Posting;
                AddError(StrSubstNo(Text032, GLAcc.FieldCaption("Account Type"), GLAcc."Account Type", GLAcc.TableCaption, GenJnlLine."Account No."));
            end;
            if not GenJnlLine."System-Created Entry" then if GenJnlLine."Posting Date" = NormalDate(GenJnlLine."Posting Date") then if not GLAcc."Direct Posting" then AddError(StrSubstNo(Text032, GLAcc.FieldCaption("Direct Posting"), true, GLAcc.TableCaption, GenJnlLine."Account No."));
            if GenJnlLine."Gen. Posting Type" > 0 then begin
                case GenJnlLine."Gen. Posting Type" of
                    GenJnlLine."Gen. Posting Type"::Sale:
                        SalesPostingType := true;
                    GenJnlLine."Gen. Posting Type"::Purchase:
                        PurchPostingType := true;
                end;
                TestPostingType;
                if not VATPostingSetup.Get(GenJnlLine."VAT Bus. Posting Group", GenJnlLine."VAT Prod. Posting Group") then
                    AddError(StrSubstNo(Text036, VATPostingSetup.TableCaption, GenJnlLine."VAT Bus. Posting Group", GenJnlLine."VAT Prod. Posting Group"))
                else if GenJnlLine."VAT Calculation Type" <> VATPostingSetup."VAT Calculation Type" then AddError(StrSubstNo(Text037, GenJnlLine.FieldCaption("VAT Calculation Type"), VATPostingSetup."VAT Calculation Type"))
            end;
            if GLAcc."Reconciliation Account" then ReconcileGLAccNo(GenJnlLine."Account No.", Round(GenJnlLine."Amount (LCY)" / (1 + GenJnlLine."VAT %" / 100)));
        end;
    end;
    //[LineStart(2000)]
    local procedure CheckCust(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[100]);
    begin
        if not Cust.Get(GenJnlLine."Account No.") then
            AddError(StrSubstNo(Text031, Cust.TableCaption, GenJnlLine."Account No."))
        else begin
            AccName := Cust.Name;
            if Cust."Privacy Blocked" then AddError(StrSubstNo(PrivacyBlockedErr, GenJnlLine."Account Type"));
            if ((Cust.Blocked in [Cust.Blocked::All]) or ((Cust.Blocked in [Cust.Blocked::Invoice, Cust.Blocked::Ship]) and (GenJnlLine."Document Type" in [GenJnlLine."Document Type"::Invoice, GenJnlLine."Document Type"::" "]))) then AddError(StrSubstNo(Text065, GenJnlLine."Account Type", Cust.Blocked, GenJnlLine.FieldCaption("Document Type"), GenJnlLine."Document Type"));
            if GenJnlLine."Currency Code" <> '' then if not Currency.Get(GenJnlLine."Currency Code") then AddError(StrSubstNo(Text038, GenJnlLine."Currency Code"));
            if (Cust."IC Partner Code" <> '') and (GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany) then
                if ICPartner.Get(Cust."IC Partner Code") then begin
                    if ICPartner.Blocked then AddError(StrSubstNo('%1 %2', StrSubstNo(Text067, Cust.TableCaption, GenJnlLine."Account No.", ICPartner.TableCaption, GenJnlLine."IC Partner Code"), StrSubstNo(Text032, ICPartner.FieldCaption(Blocked), false, ICPartner.TableCaption, Cust."IC Partner Code")));
                end
                else
                    AddError(StrSubstNo('%1 %2', StrSubstNo(Text067, Cust.TableCaption, GenJnlLine."Account No.", ICPartner.TableCaption, Cust."IC Partner Code"), StrSubstNo(Text031, ICPartner.TableCaption, Cust."IC Partner Code")));
            CustPosting := true;
            TestPostingType;
            if GenJnlLine."Recurring Method" = 0 then
                if GenJnlLine."Document Type" in [GenJnlLine."Document Type"::Invoice, GenJnlLine."Document Type"::"Credit Memo", GenJnlLine."Document Type"::"Finance Charge Memo", GenJnlLine."Document Type"::Reminder] then begin
                    OldCustLedgEntry.Reset;
                    OldCustLedgEntry.SetCurrentKey("Document No.", "Document Type", "Customer No.");
                    OldCustLedgEntry.SetRange("Document Type", GenJnlLine."Document Type");
                    OldCustLedgEntry.SetRange("Document No.", GenJnlLine."Document No.");
                    if OldCustLedgEntry.FindFirst then AddError(StrSubstNo(Text039, GenJnlLine."Document Type", GenJnlLine."Document No."));
                    if SalesSetup."Ext. Doc. No. Mandatory" or (GenJnlLine."External Document No." <> '') then begin
                        if GenJnlLine."External Document No." = '' then AddError(StrSubstNo(Text041, GenJnlLine.FieldCaption("External Document No.")));
                        OldCustLedgEntry.Reset;
                        OldCustLedgEntry.SetCurrentKey("Document Type", "External Document No.", "Customer No.");
                        OldCustLedgEntry.SetRange("Document Type", GenJnlLine."Document Type");
                        OldCustLedgEntry.SetRange("Customer No.", GenJnlLine."Account No.");
                        OldCustLedgEntry.SetRange("External Document No.", GenJnlLine."External Document No.");
                        if OldCustLedgEntry.FindFirst then AddError(StrSubstNo(Text039, GenJnlLine."Document Type", GenJnlLine."External Document No."));
                        CheckAgainstPrevLines("Gen. Journal Line");
                    end;
                end;
        end;
    end;
    //[LineStart(2091)]
    local procedure CheckVend(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[100]);
    begin
        if not Vend.Get(GenJnlLine."Account No.") then
            AddError(StrSubstNo(Text031, Vend.TableCaption, GenJnlLine."Account No."))
        else begin
            AccName := Vend.Name;
            if Vend."Privacy Blocked" then AddError(StrSubstNo(PrivacyBlockedErr, GenJnlLine."Account Type"));
            if ((Vend.Blocked in [Vend.Blocked::All]) or ((Vend.Blocked = Vend.Blocked::Payment) and (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment))) then AddError(StrSubstNo(Text065, GenJnlLine."Account Type", Vend.Blocked, GenJnlLine.FieldCaption("Document Type"), GenJnlLine."Document Type"));
            if GenJnlLine."Currency Code" <> '' then if not Currency.Get(GenJnlLine."Currency Code") then AddError(StrSubstNo(Text038, GenJnlLine."Currency Code"));
            if (Vend."IC Partner Code" <> '') and (GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany) then
                if ICPartner.Get(Cust."IC Partner Code") then begin
                    if ICPartner.Blocked then AddError(StrSubstNo('%1 %2', StrSubstNo(Text067, Vend.TableCaption, GenJnlLine."Account No.", ICPartner.TableCaption, Vend."IC Partner Code"), StrSubstNo(Text032, ICPartner.FieldCaption(Blocked), false, ICPartner.TableCaption, Vend."IC Partner Code")));
                end
                else
                    AddError(StrSubstNo('%1 %2', StrSubstNo(Text067, Vend.TableCaption, GenJnlLine."Account No.", ICPartner.TableCaption, GenJnlLine."IC Partner Code"), StrSubstNo(Text031, ICPartner.TableCaption, Vend."IC Partner Code")));
            VendPosting := true;
            TestPostingType;
            if GenJnlLine."Recurring Method" = 0 then
                if GenJnlLine."Document Type" in [GenJnlLine."Document Type"::Invoice, GenJnlLine."Document Type"::"Credit Memo", GenJnlLine."Document Type"::"Finance Charge Memo", GenJnlLine."Document Type"::Reminder] then begin
                    OldVendLedgEntry.Reset;
                    OldVendLedgEntry.SetCurrentKey("Document No.", "Document Type", "Vendor No.");
                    OldVendLedgEntry.SetRange("Document Type", GenJnlLine."Document Type");
                    OldVendLedgEntry.SetRange("Document No.", GenJnlLine."Document No.");
                    if OldVendLedgEntry.FindFirst then AddError(StrSubstNo(Text040, GenJnlLine."Document Type", GenJnlLine."Document No."));
                    if PurchSetup."Ext. Doc. No. Mandatory" or (GenJnlLine."External Document No." <> '') then begin
                        if GenJnlLine."External Document No." = '' then AddError(StrSubstNo(Text041, GenJnlLine.FieldCaption("External Document No.")));
                        OldVendLedgEntry.Reset;
                        OldVendLedgEntry.SetCurrentKey("External Document No.", "Document Type", "Vendor No.");
                        OldVendLedgEntry.SetRange("Document Type", GenJnlLine."Document Type");
                        OldVendLedgEntry.SetRange("Vendor No.", GenJnlLine."Account No.");
                        OldVendLedgEntry.SetRange("External Document No.", GenJnlLine."External Document No.");
                        if OldVendLedgEntry.FindFirst then AddError(StrSubstNo(Text040, GenJnlLine."Document Type", GenJnlLine."External Document No."));
                        CheckAgainstPrevLines("Gen. Journal Line");
                    end;
                end;
        end;
    end;
    //[LineStart(2185)]
    local procedure CheckBankAcc(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[100]);
    begin
        if not BankAcc.Get(GenJnlLine."Account No.") then
            AddError(StrSubstNo(Text031, BankAcc.TableCaption, GenJnlLine."Account No."))
        else begin
            AccName := BankAcc.Name;
            if BankAcc.Blocked then AddError(StrSubstNo(Text032, BankAcc.FieldCaption(Blocked), false, BankAcc.TableCaption, GenJnlLine."Account No."));
            if (GenJnlLine."Currency Code" <> BankAcc."Currency Code") and (BankAcc."Currency Code" <> '') then AddError(StrSubstNo(Text037, GenJnlLine.FieldCaption("Currency Code"), BankAcc."Currency Code"));
            if GenJnlLine."Currency Code" <> '' then if not Currency.Get(GenJnlLine."Currency Code") then AddError(StrSubstNo(Text038, GenJnlLine."Currency Code"));
            if GenJnlLine."Bank Payment Type" <> 0 then if (GenJnlLine."Bank Payment Type" = GenJnlLine."Bank Payment Type"::"Computer Check") and (GenJnlLine.Amount < 0) then if BankAcc."Currency Code" <> GenJnlLine."Currency Code" then AddError(StrSubstNo(Text042, GenJnlLine.FieldCaption("Bank Payment Type"), GenJnlLine.FieldCaption("Currency Code"), GenJnlLine.TableCaption, BankAcc.TableCaption));
            if BankAccPostingGr.Get(BankAcc."Bank Acc. Posting Group") then if BankAccPostingGr."G/L Account No." <> '' then ReconcileGLAccNo(BankAccPostingGr."G/L Account No.", Round(GenJnlLine."Amount (LCY)" / (1 + GenJnlLine."VAT %" / 100)));
        end;
    end;
    //[LineStart(2229)]
    local procedure CheckFixedAsset(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[100]);
    begin
        if not FA.Get(GenJnlLine."Account No.") then
            AddError(StrSubstNo(Text031, FA.TableCaption, GenJnlLine."Account No."))
        else begin
            AccName := FA.Description;
            if FA.Blocked then AddError(StrSubstNo(Text032, FA.FieldCaption(Blocked), false, FA.TableCaption, GenJnlLine."Account No."));
            if FA.Inactive then AddError(StrSubstNo(Text032, FA.FieldCaption(Inactive), false, FA.TableCaption, GenJnlLine."Account No."));
            if FA."Budgeted Asset" then AddError(StrSubstNo(Text043, FA.TableCaption, GenJnlLine."Account No.", FA.FieldCaption("Budgeted Asset"), true));
            if DeprBook.Get(GenJnlLine."Depreciation Book Code") then
                CheckFAIntegration(GenJnlLine)
            else
                AddError(StrSubstNo(Text031, DeprBook.TableCaption, GenJnlLine."Depreciation Book Code"));
            if not FADeprBook.Get(FA."No.", GenJnlLine."Depreciation Book Code") then AddError(StrSubstNo(Text036, FADeprBook.TableCaption, FA."No.", GenJnlLine."Depreciation Book Code"));
        end;
    end;
    //[LineStart(2267)]
    procedure CheckICPartner(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[100]);
    begin
        if not ICPartner.Get(GenJnlLine."Account No.") then
            AddError(StrSubstNo(Text031, ICPartner.TableCaption, GenJnlLine."Account No."))
        else begin
            AccName := ICPartner.Name;
            if ICPartner.Blocked then AddError(StrSubstNo(Text032, ICPartner.FieldCaption(Blocked), false, ICPartner.TableCaption, GenJnlLine."Account No."));
        end;
    end;
    //[LineStart(2283)]
    local procedure TestFixedAsset(var GenJnlLine: Record "Gen. Journal Line");
    begin
        if GenJnlLine."Job No." <> '' then AddError(StrSubstNo(Text044, GenJnlLine.FieldCaption("Job No.")));
        if GenJnlLine."FA Posting Type" = GenJnlLine."FA Posting Type"::" " then AddError(StrSubstNo(Text045, GenJnlLine.FieldCaption("FA Posting Type")));
        if GenJnlLine."Depreciation Book Code" = '' then AddError(StrSubstNo(Text045, GenJnlLine.FieldCaption("Depreciation Book Code")));
        if GenJnlLine."Depreciation Book Code" = GenJnlLine."Duplicate in Depreciation Book" then AddError(StrSubstNo(Text046, GenJnlLine.FieldCaption("Depreciation Book Code"), GenJnlLine.FieldCaption("Duplicate in Depreciation Book")));
        if GenJnlLine."Account Type" = GenJnlLine."Bal. Account Type" then AddError(StrSubstNo(Text047, GenJnlLine.FieldCaption("Account Type"), GenJnlLine.FieldCaption("Bal. Account Type"), GenJnlLine."Account Type"));
        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Fixed Asset" then
            if GenJnlLine."FA Posting Type" in [GenJnlLine."FA Posting Type"::"Acquisition Cost", GenJnlLine."FA Posting Type"::Disposal, GenJnlLine."FA Posting Type"::Maintenance] then begin
                if (GenJnlLine."Gen. Bus. Posting Group" <> '') or (GenJnlLine."Gen. Prod. Posting Group" <> '') then if GenJnlLine."Gen. Posting Type" = GenJnlLine."Gen. Posting Type"::" " then AddError(StrSubstNo(Text002, GenJnlLine.FieldCaption("Gen. Posting Type")));
            end
            else begin
                if GenJnlLine."Gen. Posting Type" <> GenJnlLine."Gen. Posting Type"::" " then AddError(StrSubstNo(Text048, GenJnlLine.FieldCaption("Gen. Posting Type"), GenJnlLine.FieldCaption("FA Posting Type"), GenJnlLine."FA Posting Type"));
                if GenJnlLine."Gen. Bus. Posting Group" <> '' then AddError(StrSubstNo(Text049, GenJnlLine.FieldCaption("Gen. Bus. Posting Group"), GenJnlLine.FieldCaption("FA Posting Type"), GenJnlLine."FA Posting Type"));
                if GenJnlLine."Gen. Prod. Posting Group" <> '' then AddError(StrSubstNo(Text049, GenJnlLine.FieldCaption("Gen. Prod. Posting Group"), GenJnlLine.FieldCaption("FA Posting Type"), GenJnlLine."FA Posting Type"));
            end;
        if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"Fixed Asset" then
            if GenJnlLine."FA Posting Type" in [GenJnlLine."FA Posting Type"::"Acquisition Cost", GenJnlLine."FA Posting Type"::Disposal, GenJnlLine."FA Posting Type"::Maintenance] then begin
                if (GenJnlLine."Bal. Gen. Bus. Posting Group" <> '') or (GenJnlLine."Bal. Gen. Prod. Posting Group" <> '') then if GenJnlLine."Bal. Gen. Posting Type" = GenJnlLine."Bal. Gen. Posting Type"::" " then AddError(StrSubstNo(Text002, GenJnlLine.FieldCaption("Bal. Gen. Posting Type")));
            end
            else begin
                if GenJnlLine."Bal. Gen. Posting Type" <> GenJnlLine."Bal. Gen. Posting Type"::" " then AddError(StrSubstNo(Text049, GenJnlLine.FieldCaption("Bal. Gen. Posting Type"), GenJnlLine.FieldCaption("FA Posting Type"), GenJnlLine."FA Posting Type"));
                if GenJnlLine."Bal. Gen. Bus. Posting Group" <> '' then AddError(StrSubstNo(Text049, GenJnlLine.FieldCaption("Bal. Gen. Bus. Posting Group"), GenJnlLine.FieldCaption("FA Posting Type"), GenJnlLine."FA Posting Type"));
                if GenJnlLine."Bal. Gen. Prod. Posting Group" <> '' then AddError(StrSubstNo(Text049, GenJnlLine.FieldCaption("Bal. Gen. Prod. Posting Group"), GenJnlLine.FieldCaption("FA Posting Type"), GenJnlLine."FA Posting Type"));
            end;
        TempErrorText := '%1 ' + StrSubstNo(Text050, GenJnlLine.FieldCaption("FA Posting Type"), GenJnlLine."FA Posting Type");
        if GenJnlLine."FA Posting Type" <> GenJnlLine."FA Posting Type"::"Acquisition Cost" then begin
            if GenJnlLine."Depr. Acquisition Cost" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Depr. Acquisition Cost")));
            if GenJnlLine."Salvage Value" <> 0 then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Salvage Value")));
            if GenJnlLine."FA Posting Type" <> GenJnlLine."FA Posting Type"::Maintenance then if GenJnlLine.Quantity <> 0 then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(Quantity)));
            if GenJnlLine."Insurance No." <> '' then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Insurance No.")));
        end;
        if (GenJnlLine."FA Posting Type" = GenJnlLine."FA Posting Type"::Maintenance) and GenJnlLine."Depr. until FA Posting Date" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Depr. until FA Posting Date")));
        if (GenJnlLine."FA Posting Type" <> GenJnlLine."FA Posting Type"::Maintenance) and (GenJnlLine."Maintenance Code" <> '') then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Maintenance Code")));
        if (GenJnlLine."FA Posting Type" <> GenJnlLine."FA Posting Type"::Depreciation) and (GenJnlLine."FA Posting Type" <> GenJnlLine."FA Posting Type"::"Custom 1") and (GenJnlLine."No. of Depreciation Days" <> 0) then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("No. of Depreciation Days")));
        if (GenJnlLine."FA Posting Type" = GenJnlLine."FA Posting Type"::Disposal) and GenJnlLine."FA Reclassification Entry" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("FA Reclassification Entry")));
        if (GenJnlLine."FA Posting Type" = GenJnlLine."FA Posting Type"::Disposal) and (GenJnlLine."Budgeted FA No." <> '') then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Budgeted FA No.")));
        if GenJnlLine."FA Posting Date" = 0D then GenJnlLine."FA Posting Date" := GenJnlLine."Posting Date";
        if DeprBook.Get(GenJnlLine."Depreciation Book Code") then if DeprBook."Use Same FA+G/L Posting Dates" and (GenJnlLine."Posting Date" <> GenJnlLine."FA Posting Date") then AddError(StrSubstNo(Text051, GenJnlLine.FieldCaption("Posting Date"), GenJnlLine.FieldCaption("FA Posting Date")));
        if GenJnlLine."FA Posting Date" <> 0D then begin
            if GenJnlLine."FA Posting Date" <> NormalDate(GenJnlLine."FA Posting Date") then AddError(StrSubstNo(Text052, GenJnlLine.FieldCaption("FA Posting Date")));
            if not (GenJnlLine."FA Posting Date" in [00010101D .. 99981231D]) then AddError(StrSubstNo(Text053, GenJnlLine.FieldCaption("FA Posting Date")));
            if (AllowFAPostingFrom = 0D) and (AllowFAPostingTo = 0D) then begin
                if UserId <> '' then
                    if UserSetup.Get(UserId) then begin
                        AllowFAPostingFrom := UserSetup."Allow FA Posting From";
                        AllowFAPostingTo := UserSetup."Allow FA Posting To";
                    end;
                if (AllowFAPostingFrom = 0D) and (AllowFAPostingTo = 0D) then begin
                    FASetup.Get;
                    AllowFAPostingFrom := FASetup."Allow FA Posting From";
                    AllowFAPostingTo := FASetup."Allow FA Posting To";
                end;
                if AllowFAPostingTo = 0D then AllowFAPostingTo := 99981231D;
            end;
            if (GenJnlLine."FA Posting Date" < AllowFAPostingFrom) or (GenJnlLine."FA Posting Date" > AllowFAPostingTo) then AddError(StrSubstNo(Text053, GenJnlLine.FieldCaption("FA Posting Date")));
        end;
        FASetup.Get;
        if (GenJnlLine."FA Posting Type" = GenJnlLine."FA Posting Type"::"Acquisition Cost") and (GenJnlLine."Insurance No." <> '') and (GenJnlLine."Depreciation Book Code" <> FASetup."Insurance Depr. Book") then AddError(StrSubstNo(Text054, GenJnlLine.FieldCaption("Depreciation Book Code"), GenJnlLine."Depreciation Book Code"));
        if GenJnlLine."FA Error Entry No." > 0 then begin
            TempErrorText := '%1 ' + StrSubstNo(Text055, GenJnlLine.FieldCaption("FA Error Entry No."));
            if GenJnlLine."Depr. until FA Posting Date" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Depr. until FA Posting Date")));
            if GenJnlLine."Depr. Acquisition Cost" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Depr. Acquisition Cost")));
            if GenJnlLine."Duplicate in Depreciation Book" <> '' then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Duplicate in Depreciation Book")));
            if GenJnlLine."Use Duplication List" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Use Duplication List")));
            if GenJnlLine."Salvage Value" <> 0 then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Salvage Value")));
            if GenJnlLine."Insurance No." <> '' then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Insurance No.")));
            if GenJnlLine."Budgeted FA No." <> '' then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Budgeted FA No.")));
            if GenJnlLine."Recurring Method" > 0 then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption("Recurring Method")));
            if GenJnlLine."FA Posting Type" = GenJnlLine."FA Posting Type"::Maintenance then AddError(StrSubstNo(TempErrorText, GenJnlLine."FA Posting Type"));
        end;
    end;
    //[LineStart(2465)]
    local procedure CheckFAIntegration(var GenJnlLine: Record "Gen. Journal Line");
    var
        GLIntegration: Boolean;
    begin
        if GenJnlLine."FA Posting Type" = GenJnlLine."FA Posting Type"::" " then exit;
        case GenJnlLine."FA Posting Type" of
            GenJnlLine."FA Posting Type"::"Acquisition Cost":
                GLIntegration := DeprBook."G/L Integration - Acq. Cost";
            GenJnlLine."FA Posting Type"::Depreciation:
                GLIntegration := DeprBook."G/L Integration - Depreciation";
            GenJnlLine."FA Posting Type"::"Write-Down":
                GLIntegration := DeprBook."G/L Integration - Write-Down";
            GenJnlLine."FA Posting Type"::Appreciation:
                GLIntegration := DeprBook."G/L Integration - Appreciation";
            GenJnlLine."FA Posting Type"::"Custom 1":
                GLIntegration := DeprBook."G/L Integration - Custom 1";
            GenJnlLine."FA Posting Type"::"Custom 2":
                GLIntegration := DeprBook."G/L Integration - Custom 2";
            GenJnlLine."FA Posting Type"::Disposal:
                GLIntegration := DeprBook."G/L Integration - Disposal";
            GenJnlLine."FA Posting Type"::Maintenance:
                GLIntegration := DeprBook."G/L Integration - Maintenance";
        end;
        if not GLIntegration then AddError(StrSubstNo(Text056, GenJnlLine."FA Posting Type"));
        if not DeprBook."G/L Integration - Depreciation" then begin
            if GenJnlLine."Depr. until FA Posting Date" then AddError(StrSubstNo(Text057, GenJnlLine.FieldCaption("Depr. until FA Posting Date")));
            if GenJnlLine."Depr. Acquisition Cost" then AddError(StrSubstNo(Text057, GenJnlLine.FieldCaption("Depr. Acquisition Cost")));
        end;
    end;
    //[LineStart(2507)]
    local procedure TestFixedAssetFields(var GenJnlLine: Record "Gen. Journal Line");
    begin
        if GenJnlLine."FA Posting Type" <> GenJnlLine."FA Posting Type"::" " then AddError(StrSubstNo(Text058, GenJnlLine.FieldCaption("FA Posting Type")));
        if GenJnlLine."Depreciation Book Code" <> '' then AddError(StrSubstNo(Text058, GenJnlLine.FieldCaption("Depreciation Book Code")));
    end;

    procedure TestPostingType();
    begin
        case true of
            CustPosting and PurchPostingType:
                AddError(Text059);
            VendPosting and SalesPostingType:
                AddError(Text060);
        end;
    end;
    //[LineStart(2523)]
    local procedure WarningIfNegativeAmt(GenJnlLine: Record "Gen. Journal Line");
    begin
        if (GenJnlLine.Amount < 0) and not AmountError then begin
            AmountError := true;
            AddError(StrSubstNo(Text007, GenJnlLine.FieldCaption(Amount)));
        end;
    end;
    //[LineStart(2529)]
    local procedure WarningIfPositiveAmt(GenJnlLine: Record "Gen. Journal Line");
    begin
        if (GenJnlLine.Amount > 0) and not AmountError then begin
            AmountError := true;
            AddError(StrSubstNo(Text006, GenJnlLine.FieldCaption(Amount)));
        end;
    end;
    //[LineStart(2535)]
    local procedure WarningIfZeroAmt(GenJnlLine: Record "Gen. Journal Line");
    begin
        if (GenJnlLine.Amount = 0) and not AmountError then begin
            AmountError := true;
            AddError(StrSubstNo(Text002, GenJnlLine.FieldCaption(Amount)));
        end;
    end;
    //[LineStart(2541)]
    local procedure WarningIfNonZeroAmt(GenJnlLine: Record "Gen. Journal Line");
    begin
        if (GenJnlLine.Amount <> 0) and not AmountError then begin
            AmountError := true;
            AddError(StrSubstNo(Text062, GenJnlLine.FieldCaption(Amount)));
        end;
    end;
    //[LineStart(2547)]
    local procedure CheckAgainstPrevLines(GenJnlLine: Record "Gen. Journal Line");
    var
        i: Integer;
        AccType: Integer;
        AccNo: Code[20];
        ErrorFound: Boolean;
    begin
        if (GenJnlLine."External Document No." = '') or not (GenJnlLine."Account Type" in [GenJnlLine."Account Type"::Customer, GenJnlLine."Account Type"::Vendor]) and not (GenJnlLine."Bal. Account Type" in [GenJnlLine."Bal. Account Type"::Customer, GenJnlLine."Bal. Account Type"::Vendor]) then exit;
        if GenJnlLine."Account Type" in [GenJnlLine."Account Type"::Customer, GenJnlLine."Account Type"::Vendor] then begin
            AccType := GenJnlLine."Account Type".AsInteger();
            AccNo := GenJnlLine."Account No.";
        end
        else begin
            AccType := GenJnlLine."Bal. Account Type".AsInteger();
            AccNo := GenJnlLine."Bal. Account No.";
        end;
        TempGenJnlLine.Reset;
        TempGenJnlLine.SetRange("External Document No.", GenJnlLine."External Document No.");
        while (i < 2) and not ErrorFound do begin
            i := i + 1;
            if i = 1 then begin
                TempGenJnlLine.SetRange("Account Type", AccType);
                TempGenJnlLine.SetRange("Account No.", AccNo);
                TempGenJnlLine.SetRange("Bal. Account Type");
                TempGenJnlLine.SetRange("Bal. Account No.");
            end
            else begin
                TempGenJnlLine.SetRange("Account Type");
                TempGenJnlLine.SetRange("Account No.");
                TempGenJnlLine.SetRange("Bal. Account Type", AccType);
                TempGenJnlLine.SetRange("Bal. Account No.", AccNo);
            end;
            if TempGenJnlLine.FindFirst then begin
                ErrorFound := true;
                AddError(StrSubstNo(Text064, GenJnlLine.FieldCaption("External Document No."), GenJnlLine."External Document No.", TempGenJnlLine."Line No.", GenJnlLine.FieldCaption("Document No."), TempGenJnlLine."Document No."));
            end;
        end;
        TempGenJnlLine.Reset;
        TempGenJnlLine := GenJnlLine;
        TempGenJnlLine.Insert;
    end;
    //[Scope('Personalization')]
    //[LineStart(2593)]
    procedure CheckICDocument();
    var
        GenJnlLine4: Record "Gen. Journal Line";
        "IC G/L Account": Record "IC G/L Account";
    begin
        if GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany then begin
            if ("Gen. Journal Line"."Posting Date" <> LastDate) or ("Gen. Journal Line"."Document Type" <> LastDocType) or ("Gen. Journal Line"."Document No." <> LastDocNo) then begin
                GenJnlLine4.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                GenJnlLine4.SetRange("Journal Template Name", "Gen. Journal Line"."Journal Template Name");
                GenJnlLine4.SetRange("Journal Batch Name", "Gen. Journal Line"."Journal Batch Name");
                GenJnlLine4.SetRange("Posting Date", "Gen. Journal Line"."Posting Date");
                GenJnlLine4.SetRange("Document No.", "Gen. Journal Line"."Document No.");
                GenJnlLine4.SetFilter("IC Partner Code", '<>%1', '');
                if GenJnlLine4.FindFirst then
                    CurrentICPartner := GenJnlLine4."IC Partner Code"
                else
                    CurrentICPartner := '';
            end;
            if (CurrentICPartner <> '') and ("Gen. Journal Line"."IC Direction" = "Gen. Journal Line"."IC Direction"::Outgoing) then begin
                if ("Gen. Journal Line"."Account Type" in ["Gen. Journal Line"."Account Type"::"G/L Account", "Gen. Journal Line"."Account Type"::"Bank Account"]) and ("Gen. Journal Line"."Bal. Account Type" in ["Gen. Journal Line"."Bal. Account Type"::"G/L Account", "Gen. Journal Line"."Account Type"::"Bank Account"]) and ("Gen. Journal Line"."Account No." <> '') and ("Gen. Journal Line"."Bal. Account No." <> '') then begin
                    AddError(StrSubstNo(Text066, "Gen. Journal Line".FieldCaption("Account No."), "Gen. Journal Line".FieldCaption("Bal. Account No.")));
                end
                else begin
                    if (("Gen. Journal Line"."Account Type" in ["Gen. Journal Line"."Account Type"::"G/L Account", "Gen. Journal Line"."Account Type"::"Bank Account"]) and ("Gen. Journal Line"."Account No." <> '')) xor (("Gen. Journal Line"."Bal. Account Type" in ["Gen. Journal Line"."Bal. Account Type"::"G/L Account", "Gen. Journal Line"."Account Type"::"Bank Account"]) and ("Gen. Journal Line"."Bal. Account No." <> '')) then begin
                        if "Gen. Journal Line"."IC Account No." = '' then
                            AddError(StrSubstNo(Text002, "Gen. Journal Line".FieldCaption("IC Account No.")))
                        else begin
                            if "IC G/L Account".Get("Gen. Journal Line"."IC Account No.") then if "IC G/L Account".Blocked then AddError(StrSubstNo(Text032, "IC G/L Account".FieldCaption(Blocked), false, "Gen. Journal Line".FieldCaption("IC Account No."), "Gen. Journal Line"."IC Account No."));
                        end;
                    end
                    else if "Gen. Journal Line"."IC Account No." <> '' then AddError(StrSubstNo(Text009, "Gen. Journal Line".FieldCaption("IC Account No.")));
                end;
            end
            else if "Gen. Journal Line"."IC Account No." <> '' then begin
                if "Gen. Journal Line"."IC Direction" = "Gen. Journal Line"."IC Direction"::Incoming then AddError(StrSubstNo(Text069, "Gen. Journal Line".FieldCaption("IC Account No."), "Gen. Journal Line".FieldCaption("IC Direction"), Format("Gen. Journal Line"."IC Direction")));
                if CurrentICPartner = '' then AddError(StrSubstNo(Text070, "Gen. Journal Line".FieldCaption("IC Account No.")));
            end;
        end;
    end;
}
