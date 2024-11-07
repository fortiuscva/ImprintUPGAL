report 60005 "Vendor - Payment Receipt Ext"
{
    // version NAVW114.04,NAVNA14.04
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/Vendor - Payment Receipt.rdl';
    CaptionML = ENU = 'Vendor - Payment Receipt', ESM = 'Proveedor - Recepción pago', FRC = 'Fournisseur - Reçu de paiement', ENC = 'Vendor - Payment Receipt';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = SORTING("Document Type", "Vendor No.", "Posting Date", "Currency Code") WHERE("Document Type" = FILTER(Payment | Refund));
            RequestFilterFields = "Vendor No.", "Posting Date", "Document No.";

            dataitem(PageLoop; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                column(VendAddr6; VendAddr[6])
                {
                }
                column(VendAddr7; VendAddr[7])
                {
                }
                column(VendAddr8; VendAddr[8])
                {
                }
                column(VendAddr4; VendAddr[4])
                {
                }
                column(VendAddr5; VendAddr[5])
                {
                }
                column(VendAddr3; VendAddr[3])
                {
                }
                column(VendAddr1; VendAddr[1])
                {
                }
                column(VendAddr2; VendAddr[2])
                {
                }
                column(VendNo_VendLedgEntry; "Vendor Ledger Entry"."Vendor No.")
                {
                    IncludeCaption = true;
                }
                column(DocDate_VendLedgEntry; Format("Vendor Ledger Entry"."Document Date", 0, 4))
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
                column(PhoneNo; CompanyInfo."Phone No.")
                {
                }
                column(HomePage; CompanyInfo."Home Page")
                {
                }
                column(Email; CompanyInfo."E-Mail")
                {
                }
                column(VATRegistrationNo; CompanyInfo."VAT Registration No.")
                {
                }
                column(GiroNo; CompanyInfo."Giro No.")
                {
                }
                column(BankName; CompanyInfo."Bank Name")
                {
                }
                column(BankAccountNo; CompanyInfo."Bank Account No.")
                {
                }
                column(ReportTitle; ReportTitle)
                {
                }
                column(DocNo_VendLedgEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(PymtDiscTitle; PaymentDiscountTitle)
                {
                }
                column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                {
                }
                column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                {
                }
                column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                {
                }
                column(CompanyInfoBankAccNoCaption; CompanyInfoBankAccNoCaptionLbl)
                {
                }
                column(RcptNoCaption; RcptNoCaptionLbl)
                {
                }
                column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                {
                }
                column(PostingDateCaption; PostingDateCaptionLbl)
                {
                }
                column(AmtCaption; AmtCaptionLbl)
                {
                }
                column(PymtAmtSpecCaption; PymtAmtSpecCaptionLbl)
                {
                }
                column(PymtTolInvCurrCaption; PymtTolInvCurrCaptionLbl)
                {
                }
                dataitem(DetailedVendorLedgEntry1; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Applied Vend. Ledger Entry No." = FIELD("Entry No.");
                    DataItemLinkReference = "Vendor Ledger Entry";
                    DataItemTableView = SORTING("Applied Vend. Ledger Entry No.", "Entry Type") WHERE(Unapplied = CONST(false));

                    column(AppliedVLENo_DtldVendLedgEntry; "Applied Vend. Ledger Entry No.")
                    {
                    }
                    dataitem(VendLedgEntry1; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Vendor Ledger Entry No.");
                        DataItemLinkReference = DetailedVendorLedgEntry1;
                        DataItemTableView = SORTING("Entry No.");

                        column(PostingDate_VendLedgEntry1; Format("Posting Date"))
                        {
                        }
                        column(DocType_VendLedgEntry1; "Document Type")
                        {
                            IncludeCaption = true;
                        }
                        column(DocNo_VendLedgEntry1; "Document No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Description_VendLedgEntry1; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(NegShowAmountVendLedgEntry1; -NegShowAmountVendLedgEntry1)
                        {
                        }
                        column(CurrCode_VendLedgEntry1; CurrencyCode("Currency Code"))
                        {
                        }
                        column(NegPmtDiscInvCurrVendLedgEntry1; -NegPmtDiscInvCurrVendLedgEntry1)
                        {
                        }
                        column(NegPmtTolInvCurrVendLedgEntry1; -NegPmtTolInvCurrVendLedgEntry1)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            if "Entry No." = "Vendor Ledger Entry"."Entry No." then CurrReport.Skip;
                            NegPmtDiscInvCurrVendLedgEntry1 := 0;
                            NegPmtTolInvCurrVendLedgEntry1 := 0;
                            PmtDiscPmtCurr := 0;
                            PmtTolPmtCurr := 0;
                            NegShowAmountVendLedgEntry1 := -DetailedVendorLedgEntry1.Amount;
                            if "Vendor Ledger Entry"."Currency Code" <> "Currency Code" then begin
                                NegPmtDiscInvCurrVendLedgEntry1 := Round("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := Round("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                AppliedAmount := Round(-DetailedVendorLedgEntry1.Amount / "Original Currency Factor" * "Vendor Ledger Entry"."Original Currency Factor", Currency."Amount Rounding Precision");
                            end
                            else begin
                                NegPmtDiscInvCurrVendLedgEntry1 := Round("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := Round("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                AppliedAmount := -DetailedVendorLedgEntry1.Amount;
                            end;
                            PmtDiscPmtCurr := Round("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            PmtTolPmtCurr := Round("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                        end;
                    }
                }
                dataitem(DetailedVendorLedgEntry2; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemLinkReference = "Vendor Ledger Entry";
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Entry Type", "Posting Date") WHERE(Unapplied = CONST(false));

                    column(VLENo_DtldVendLedgEntry; "Vendor Ledger Entry No.")
                    {
                    }
                    dataitem(VendLedgEntry2; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD("Applied Vend. Ledger Entry No.");
                        DataItemLinkReference = DetailedVendorLedgEntry2;
                        DataItemTableView = SORTING("Entry No.");

                        column(NegAppliedAmt; -AppliedAmount)
                        {
                        }
                        column(Description_VendLedgEntry2; Description)
                        {
                        }
                        column(DocNo_VendLedgEntry2; "Document No.")
                        {
                        }
                        column(DocType_VendLedgEntry2; "Document Type")
                        {
                        }
                        column(PostingDate_VendLedgEntry2; Format("Posting Date"))
                        {
                        }
                        column(CurrCode_VendLedgEntry2; CurrencyCode("Currency Code"))
                        {
                        }
                        column(NegPmtDiscInvCurrVendLedgEntry2; -NegPmtDiscInvCurrVendLedgEntry1)
                        {
                        }
                        column(NegPmtTolInvCurr1VendLedgEntry2; -NegPmtTolInvCurrVendLedgEntry1)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            if "Entry No." = "Vendor Ledger Entry"."Entry No." then CurrReport.Skip;
                            NegPmtDiscInvCurrVendLedgEntry1 := 0;
                            NegPmtTolInvCurrVendLedgEntry1 := 0;
                            PmtDiscPmtCurr := 0;
                            PmtTolPmtCurr := 0;
                            NegShowAmountVendLedgEntry1 := DetailedVendorLedgEntry2.Amount;
                            if "Vendor Ledger Entry"."Currency Code" <> "Currency Code" then begin
                                NegPmtDiscInvCurrVendLedgEntry1 := Round("Pmt. Disc. Rcd.(LCY)" * "Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := Round("Pmt. Tolerance (LCY)" * "Original Currency Factor");
                            end
                            else begin
                                NegPmtDiscInvCurrVendLedgEntry1 := Round("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1 := Round("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            end;
                            PmtDiscPmtCurr := Round("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            PmtTolPmtCurr := Round("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            AppliedAmount := DetailedVendorLedgEntry2.Amount;
                            RemainingAmount := (RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                        end;
                    }
                }
                dataitem(Total; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(NegRemainingAmt; -RemainingAmount)
                    {
                    }
                    column(CurrCode_VendLedgEntry; CurrencyCode("Vendor Ledger Entry"."Currency Code"))
                    {
                    }
                    column(NegOriginalAmt_VendLedgEntry; -"Vendor Ledger Entry"."Original Amount")
                    {
                    }
                    column(ExtDocNo_VendLedgEntry; "Vendor Ledger Entry"."External Document No.")
                    {
                    }
                    column(PymtAmtNotAllocatedCaption; PymtAmtNotAllocatedCaptionLbl)
                    {
                    }
                    column(PymtAmtCaption; PymtAmtCaptionLbl)
                    {
                    }
                    column(ExternalDocNoCaption; ExternalDocNoCaptionLbl)
                    {
                    }
                }
            }
            trigger OnAfterGetRecord();
            begin
                Vend.Get("Vendor No.");
                FormatAddr.Vendor(VendAddr, Vend);
                if not Currency.Get("Currency Code") then Currency.InitRoundingPrecision;
                if "Document Type" = "Document Type"::Payment then begin
                    ReportTitle := Text004;
                    PaymentDiscountTitle := Text007;
                end
                else begin
                    ReportTitle := Text003;
                    PaymentDiscountTitle := Text006;
                end;
                CalcFields("Original Amount");
                RemainingAmount := -"Original Amount";
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.Get;
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                GLSetup.Get;
            end;
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
    labels
    {
        label(CurrencyCodeCaption;
        ENU = 'Currency Code', ESM = 'Cód. divisa', FRC = 'Code devise', ENC = 'Currency Code')
        label(PageCaption;
        ENU = 'Page', ESM = 'Pág.', FRC = 'Page', ENC = 'Page')
        label(DocDateCaption;
        ENU = 'Document Date', ESM = 'Fecha emisión documento', FRC = 'Date document', ENC = 'Document Date')
        label(EmailCaption;
        ENU = 'Email', ESM = 'Correo electrónico', FRC = 'Courriel', ENC = 'Email')
        label(HomePageCaption;
        ENU = 'Home Page', ESM = 'Página principal', FRC = 'Page d''accueil', ENC = 'Home Page')
    }
    var
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        Vend: Record Vendor;
        Currency: Record Currency;
        FormatAddr: Codeunit "Format Address";
        ReportTitle: Text[30];
        PaymentDiscountTitle: Text[30];
        CompanyAddr: array[8] of Text[100];
        VendAddr: array[8] of Text[100];
        RemainingAmount: Decimal;
        AppliedAmount: Decimal;
        NegPmtDiscInvCurrVendLedgEntry1: Decimal;
        NegPmtTolInvCurrVendLedgEntry1: Decimal;
        PmtDiscPmtCurr: Decimal;
        Text003: TextConst ENU = 'Payment Receipt', ESM = 'Recepción pago', FRC = 'Reçu de paiement', ENC = 'Payment Receipt';
        Text004: TextConst ENU = 'Payment Voucher', ESM = 'Justific. pago', FRC = 'Just. paiement', ENC = 'Payment Voucher';
        Text006: TextConst ENU = 'Payment Discount Given', ESM = 'Descuento P.P. concedido', FRC = 'Escompte de paiement accordé', ENC = 'Payment Discount Given';
        Text007: TextConst ENU = 'Payment Discount Received', ESM = 'Descuento P.P. recibido', FRC = 'Escompte de paiement obtenu', ENC = 'Payment Discount Received';
        PmtTolPmtCurr: Decimal;
        NegShowAmountVendLedgEntry1: Decimal;
        CompanyInfoPhoneNoCaptionLbl: TextConst ENU = 'Phone No.', ESM = 'Nº teléfono', FRC = 'N° téléphone', ENC = 'Phone No.';
        CompanyInfoGiroNoCaptionLbl: TextConst ENU = 'Giro No.', ESM = 'Nº giro postal', FRC = 'N° CCP', ENC = 'Giro No.';
        CompanyInfoBankNameCaptionLbl: TextConst ENU = 'Bank', ESM = 'Banco', FRC = 'Banque', ENC = 'Bank';
        CompanyInfoBankAccNoCaptionLbl: TextConst ENU = 'Account No.', ESM = 'Nº cuenta', FRC = 'N° de compte', ENC = 'Account No.';
        RcptNoCaptionLbl: TextConst ENU = 'Receipt No.', ESM = 'Nº recepción', FRC = 'N° bon de réception', ENC = 'Receipt No.';
        CompanyInfoVATRegNoCaptionLbl: TextConst ENU = 'GST Registration No.', ESM = 'Nº registro impuesto sobre bienes y servicios (IBS)', FRC = 'N° enregistrement GST', ENC = 'GST Registration No.';
        PostingDateCaptionLbl: TextConst ENU = 'Posting Date', ESM = 'Fecha registro', FRC = 'Date de report', ENC = 'Posting Date';
        AmtCaptionLbl: TextConst ENU = 'Amount', ESM = 'Importe', FRC = 'Montant', ENC = 'Amount';
        PymtAmtSpecCaptionLbl: TextConst ENU = 'Payment Amount Specification', ESM = 'Especificación importe pago', FRC = 'Détail montant règlement', ENC = 'Payment Amount Specification';
        PymtTolInvCurrCaptionLbl: TextConst ENU = 'Payment Tolerance', ESM = 'Tolerancia pago', FRC = 'Tolérance de règlement', ENC = 'Payment Tolerance';
        PymtAmtNotAllocatedCaptionLbl: TextConst ENU = 'Payment Amount Not Allocated', ESM = 'Importe pago sin asignar', FRC = 'Montant règlement non affecté', ENC = 'Payment Amount Not Allocated';
        PymtAmtCaptionLbl: TextConst ENU = 'Payment Amount', ESM = 'Importe pago', FRC = 'Montant règlement', ENC = 'Payment Amount';
        ExternalDocNoCaptionLbl: TextConst ENU = 'External Document No.', ESM = 'Nº documento externo', FRC = 'N° doc. externe', ENC = 'External Document No.';

    local procedure CurrencyCode(SrcCurrCode: Code[10]): Code[10];
    begin
        if SrcCurrCode = '' then exit(GLSetup."LCY Code");
        exit(SrcCurrCode);
    end;
}
