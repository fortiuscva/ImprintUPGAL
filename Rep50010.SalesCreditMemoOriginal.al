report 50010 "Sales Credit Memo - Original"
{
    // <changelog>
    //   <add id="NA0001" dev="ELYNCH" date="2004-04-07" area="REPORTS SR" feature="622"
    //     releaseversion="NAVUS3.70">NA Sales Document</add>
    //   <change id="NA0002" dev="JNOZZI" date="2006-05-10" area="BUG FIX"  request="16629"
    //     baseversion="NAVUS3.70" releaseversion="NAVNA4.00.03">Allow the printing of a blank &quot;voided&quot;
    //     invoice.</change>
    //   <change id="NA0003" dev="JNOZZI" date="2006-06-05" area="REPORTS SR" feature="337"
    //     baseversion="NAVNA4.00.03" releaseversion="NAVNA5.00">Implement the W1 Logo Position functionality.</change>
    //   <change id="NA0004" dev="JNOZZI" date="2007-12-20" area="NASALESTAX" feature="31197"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.01">Implement hooks to External Sales Tax Engine.</change>
    //   <change id="NA0005" dev="MBAHADUR" date="2007-12-10" area="REPORTS SR" feature="0003"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA5.00.01">modified sales comment line tableview property to
    //     support comment line feature.</change>
    //   <change id="NA0006" dev="V-JELI" date="2008-05-16" area="NASALESTAX" feature="37492"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA6.00">Change in handling Blank Tax Area on lines.</change>
    //   <change id="NA0007" dev="V-LOLU" date="2008-06-10" area="REPORTS SR" feature="NC14261"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00">Report Transformation - Local Report Layout.</change>
    //   <change id="NA0008" dev="V-JOOSTL" date="2009-04-23" area="REPORTS SR"  request="PS37379"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00.01">If header comments exist, an extra blank page is printed
    //     before the document.</change>
    //   <add id="NA0009" dev="ALL-E" date="2010-11-15" area="MX" feature="VSTF202674"
    //     releaseversion="NA7.00">RFC and CURP data fields</add>
    // </changelog>
    DefaultLayout = RDLC;
    RDLCLayout = './Sales Credit Memo - Original.rdl';
    Caption = 'Sales Credit Memo';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Credit Memo';

            column(No_SalesCrMemoHeader; "No.")
            {
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                dataitem(SalesLineComments; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Credit Memo"), "Print On Credit Memo" = CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        //NA0005.begin
                        TempSalesCrMemoLine.Init;
                        TempSalesCrMemoLine."Document No." := "Sales Cr.Memo Header"."No.";
                        TempSalesCrMemoLine."Line No." := HighestLineNo + 10;
                        HighestLineNo := TempSalesCrMemoLine."Line No.";
                        if StrLen(Comment) <= MaxStrLen(TempSalesCrMemoLine.Description) then begin
                            TempSalesCrMemoLine.Description := Comment;
                            TempSalesCrMemoLine."Description 2" := '';
                        end
                        else begin
                            SpacePointer := MaxStrLen(TempSalesCrMemoLine.Description) + 1;
                            while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do SpacePointer := SpacePointer - 1;
                            if SpacePointer = 1 then SpacePointer := MaxStrLen(TempSalesCrMemoLine.Description) + 1;
                            TempSalesCrMemoLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                            TempSalesCrMemoLine."Description 2" := CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesCrMemoLine."Description 2"));
                        end;
                        TempSalesCrMemoLine.Insert;
                        //NA0005.end
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    TempSalesCrMemoLine := "Sales Cr.Memo Line";
                    TempSalesCrMemoLine.Insert;
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesCrMemoLine.Reset;
                    TempSalesCrMemoLine.DeleteAll;
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Credit Memo"), "Print On Credit Memo" = CONST(true), "Document Line No." = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    TempSalesCrMemoLine.Init;
                    TempSalesCrMemoLine."Document No." := "Sales Cr.Memo Header"."No.";
                    TempSalesCrMemoLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesCrMemoLine."Line No.";
                    if StrLen(Comment) <= MaxStrLen(TempSalesCrMemoLine.Description) then begin
                        TempSalesCrMemoLine.Description := Comment;
                        TempSalesCrMemoLine."Description 2" := '';
                    end
                    else begin
                        SpacePointer := MaxStrLen(TempSalesCrMemoLine.Description) + 1;
                        while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do SpacePointer := SpacePointer - 1;
                        if SpacePointer = 1 then SpacePointer := MaxStrLen(TempSalesCrMemoLine.Description) + 1;
                        TempSalesCrMemoLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                        TempSalesCrMemoLine."Description 2" := CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesCrMemoLine."Description 2"));
                    end;
                    TempSalesCrMemoLine.Insert;
                end;

                trigger OnPreDataItem()
                begin
                    // NA0005- Begin
                    TempSalesCrMemoLine.Init;
                    TempSalesCrMemoLine."Document No." := "Sales Cr.Memo Header"."No.";
                    TempSalesCrMemoLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesCrMemoLine."Line No.";
                    TempSalesCrMemoLine.Insert;
                    // NA0005- End
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyAddress1; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress2; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress3; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress4; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress5; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress6; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress1; BillToAddress[1])
                    {
                    }
                    column(BillToAddress2; BillToAddress[2])
                    {
                    }
                    column(BillToAddress3; BillToAddress[3])
                    {
                    }
                    column(BillToAddress4; BillToAddress[4])
                    {
                    }
                    column(BillToAddress5; BillToAddress[5])
                    {
                    }
                    column(BillToAddress6; BillToAddress[6])
                    {
                    }
                    column(BillToAddress7; BillToAddress[7])
                    {
                    }
                    column(ShptDate_SalesCrMemoHeader; "Sales Cr.Memo Header"."Shipment Date")
                    {
                    }
                    column(ApplDocType_SalesCrMemoHeader; "Sales Cr.Memo Header"."Applies-to Doc. Type")
                    {
                    }
                    column(ApplDocNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Applies-to Doc. No.")
                    {
                    }
                    column(ShipToAddress1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress7; ShipToAddress[7])
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(YourRef_SalesCrMemoHeader; "Sales Cr.Memo Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(DocDate_SalesCrMemoHeader; "Sales Cr.Memo Header"."Document Date")
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BillToAddress8; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(PrintFooter; PrintFooter)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(TaxIdentType_Cust; Format(Cust."Tax Identification Type"))
                    {
                    }
                    column(CreditCaption; CreditCaptionLbl)
                    {
                    }
                    column(ShipDateCaption; ShipDateCaptionLbl)
                    {
                    }
                    column(ApplytoTypeCaption; ApplytoTypeCaptionLbl)
                    {
                    }
                    column(ApplytoNumberCaption; ApplytoNumberCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(PONumberCaption; PONumberCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(CreditMemoCaption; CreditMemoCaptionLbl)
                    {
                    }
                    column(CreditMemoNumberCaption; CreditMemoNumberCaptionLbl)
                    {
                    }
                    column(CreditMemoDateCaption; CreditMemoDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    dataitem(SalesCrMemoLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLineNo; TempSalesCrMemoLine."No.")
                        {
                        }
                        column(TempSalesCrMemoLineUOM; TempSalesCrMemoLine."Unit of Measure")
                        {
                        }
                        column(TempSalesCrMemoLineQty; TempSalesCrMemoLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(TempSalesCrMemoLineDesc; TempSalesCrMemoLine.Description + ' ' + TempSalesCrMemoLine."Description 2")
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesCrMemoLineAmtTaxLiable; TempSalesCrMemoLine.Amount - TaxLiable)
                        {
                        }
                        column(TempSalesCrMemoLineAmtAmtExclInvDisc; TempSalesCrMemoLine.Amount - AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLineAmtInclVATAmt; TempSalesCrMemoLine."Amount Including VAT" - TempSalesCrMemoLine.Amount)
                        {
                        }
                        column(TempSalesCrMemoLineAmtInclVAT; TempSalesCrMemoLine."Amount Including VAT")
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownAmt3; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(ItemNoCaption; ItemNoCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(TotalPriceCaption; TotalPriceCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(InvoiceDiscountCaption; InvoiceDiscountCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(AmountSubjecttoSalesTaxCaption; AmountSubjecttoSalesTaxCaptionLbl)
                        {
                        }
                        column(AmountExemptfromSalesTaxCaption; AmountExemptfromSalesTaxCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            if OnLineNumber = 1 then
                                TempSalesCrMemoLine.Find('-')
                            else
                                TempSalesCrMemoLine.Next;
                            if TempSalesCrMemoLine.Type.AsInteger() = 0 then begin
                                TempSalesCrMemoLine."No." := '';
                                TempSalesCrMemoLine."Unit of Measure" := '';
                                TempSalesCrMemoLine.Amount := 0;
                                TempSalesCrMemoLine."Amount Including VAT" := 0;
                                TempSalesCrMemoLine."Inv. Discount Amount" := 0;
                                TempSalesCrMemoLine.Quantity := 0;
                            end
                            else if TempSalesCrMemoLine.Type = TempSalesCrMemoLine.Type::"G/L Account" then TempSalesCrMemoLine."No." := '';
                            if TempSalesCrMemoLine.Amount <> TempSalesCrMemoLine."Amount Including VAT" then begin
                                TaxFlag := true;
                                TaxLiable := TempSalesCrMemoLine.Amount;
                            end
                            else begin
                                TaxFlag := false;
                                TaxLiable := 0;
                            end;
                            AmountExclInvDisc := TempSalesCrMemoLine.Amount + TempSalesCrMemoLine."Inv. Discount Amount";
                            if TempSalesCrMemoLine.Quantity = 0 then
                                UnitPriceToPrint := 0 // so it won't print
                            else
                                UnitPriceToPrint := Round(AmountExclInvDisc / TempSalesCrMemoLine.Quantity, 0.00001);
                            //NA0007.begin
                            if OnLineNumber = NumberOfLines then PrintFooter := true;
                            //NA0007.end
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CreateTotals(TaxLiable, AmountExclInvDisc, TempSalesCrMemoLine.Amount, TempSalesCrMemoLine."Amount Including VAT");
                            NumberOfLines := TempSalesCrMemoLine.Count;
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PageNo := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then SalesCrMemoPrinted.Run("Sales Cr.Memo Header");
                        CurrReport.Break;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := Text000;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + Abs(NoCopies);
                    if NoLoops <= 0 then NoLoops := 1;
                    CopyNo := 0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if PrintCompany then begin
                    if RespCenter.Get("Responsibility Center") then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    end;
                end;
                //CurrReport.Language := Language.GetLanguageID("Language Code");
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                if "Salesperson Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");
                // NA0002.begin
                if "Bill-to Customer No." = '' then begin
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                end;
                // NA0002.end
                FormatAddress.SalesCrMemoBillTo(BillToAddress, "Sales Cr.Memo Header");
                FormatAddress.SalesCrMemoShipTo(ShipToAddress, ShipToAddress, "Sales Cr.Memo Header");
                if LogInteraction then if not CurrReport.Preview then SegManagement.LogDocument(6, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
                Clear(BreakdownTitle);
                Clear(BreakdownLabel);
                Clear(BreakdownAmt);
                TotalTaxLabel := Text008;
                TaxRegNo := '';
                TaxRegLabel := '';
                if "Tax Area Code" <> '' then begin
                    TaxArea.Get("Tax Area Code");
                    case TaxArea."Country/Region" of
                        TaxArea."Country/Region"::US:
                            TotalTaxLabel := Text005;
                        TaxArea."Country/Region"::CA:
                            begin
                                TotalTaxLabel := Text007;
                                TaxRegNo := CompanyInformation."VAT Registration No.";
                                TaxRegLabel := CompanyInformation.FieldCaption("VAT Registration No.");
                            end;
                    end;
                    SalesTaxCalc.StartSalesTaxCalculation;
                    // NA0004.begin
                    if TaxArea."Use External Tax Engine" then
                        SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Sales Cr.Memo Header", 0, "No.")
                    else begin
                        // NA0004.end
                        SalesTaxCalc.AddSalesCrMemoLines("No.");
                        SalesTaxCalc.EndSalesTaxCalculation("Posting Date");
                    end; // NA0004
                    SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                    BrkIdx := 0;
                    PrevPrintOrder := 0;
                    PrevTaxPercent := 0;
                    TempSalesTaxAmtLine.Reset;
                    TempSalesTaxAmtLine.SetCurrentKey("Print Order", "Tax Area Code for Key", "Tax Jurisdiction Code");
                    if TempSalesTaxAmtLine.Find('-') then
                        repeat
                            if (TempSalesTaxAmtLine."Print Order" = 0) or (TempSalesTaxAmtLine."Print Order" <> PrevPrintOrder) or (TempSalesTaxAmtLine."Tax %" <> PrevTaxPercent) then begin
                                BrkIdx := BrkIdx + 1;
                                if BrkIdx > 1 then begin
                                    if TaxArea."Country/Region" = TaxArea."Country/Region"::CA then
                                        BreakdownTitle := Text006
                                    else
                                        BreakdownTitle := Text003;
                                end;
                                if BrkIdx > ArrayLen(BreakdownAmt) then begin
                                    BrkIdx := BrkIdx - 1;
                                    BreakdownLabel[BrkIdx] := Text004;
                                end
                                else
                                    BreakdownLabel[BrkIdx] := StrSubstNo(TempSalesTaxAmtLine."Print Description", TempSalesTaxAmtLine."Tax %");
                            end;
                            BreakdownAmt[BrkIdx] := BreakdownAmt[BrkIdx] + TempSalesTaxAmtLine."Tax Amount";
                        until TempSalesTaxAmtLine.Next = 0;
                    if BrkIdx = 1 then begin
                        Clear(BreakdownLabel);
                        Clear(BreakdownAmt);
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                // NA0003.begin
                // CompanyInformation.GET('');
                // IF PrintCompany THEN
                // FormatAddress.Company(CompanyAddress,CompanyInformation)
                // ELSE
                // CLEAR(CompanyAddress);
                // NA0003.end
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

                    field(NoCopies; NoCopies)
                    {
                        Caption = 'Number of Copies';
                        ApplicationArea = All;
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        Caption = 'Print Company Address';
                        ApplicationArea = All;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            //LogInteraction:=SegManagement.FindInteractTmplCode(6) <> '';
            LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Cr. Memo") <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        // NA0003.begin
        CompanyInformation.Get;
        SalesSetup.Get;
        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo3.Get;
                    CompanyInfo3.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.Get;
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.Get;
                    CompanyInfo2.CalcFields(Picture);
                end;
        end;
        if PrintCompany then
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            Clear(CompanyAddress);
        // NA0003.end
    end;

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesCrMemoLine: Record "Sales Cr.Memo Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        SalesCrMemoPrinted: Codeunit "Sales Cr. Memo-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit 398;
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        Text009: Label 'VOID CREDIT MEMO';
        [InDataSet]
        LogInteractionEnable: Boolean;
        CreditCaptionLbl: Label 'Credit';
        ShipDateCaptionLbl: Label 'Ship Date';
        ApplytoTypeCaptionLbl: Label 'Apply to Type';
        ApplytoNumberCaptionLbl: Label 'Apply to Number';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'P.O. Number';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        CreditMemoCaptionLbl: Label 'CREDIT MEMO';
        CreditMemoNumberCaptionLbl: Label 'Credit Memo Number:';
        CreditMemoDateCaptionLbl: Label 'Credit Memo Date:';
        PageCaptionLbl: Label 'Page:';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ToCaptionLbl: Label 'To:';
        ItemNoCaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Unit Price';
        TotalPriceCaptionLbl: Label 'Total Price';
        SubtotalCaptionLbl: Label 'Subtotal:';
        InvoiceDiscountCaptionLbl: Label 'Invoice Discount:';
        TotalCaptionLbl: Label 'Total:';
        AmountSubjecttoSalesTaxCaptionLbl: Label 'Amount Subject to Sales Tax';
        AmountExemptfromSalesTaxCaptionLbl: Label 'Amount Exempt from Sales Tax';
}
