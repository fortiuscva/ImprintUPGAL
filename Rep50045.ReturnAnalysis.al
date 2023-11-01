report 50045 "Return Analysis"
{
    // IMP1.01,02/19/18,SK: Created New report.
    // IMP1.02,03/01/18,SK: Added nw column as "Salesperson" & "Purchaser" and getting the details.
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")WHERE(Type=FILTER(Item|"G/L Account"));
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord()
            begin
                SalesCrMemHeadRecGbl.Get("Document No.");
                RowNo+=1;
                EnterCell(RowNo, 1, 'Sales Credit Memo', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 2, Format(SalesCrMemHeadRecGbl."Posting Date"), false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                EnterCell(RowNo, 3, Format(SalesCrMemHeadRecGbl."Sell-to Customer No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 4, Format(SalesCrMemHeadRecGbl."Sell-to Customer Name"), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 5, Format("Document No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 6, Format(SalesCrMemHeadRecGbl."External Document No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 7, Format(Type), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 8, Format("No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 9, Format(Description), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 10, Format(Quantity), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 11, Format("Unit of Measure Code"), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 12, Format("Unit Price"), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 13, Format("Line Amount"), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 14, Format("Amount Including VAT"), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 15, Format("Unit Cost (LCY)"), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 16, Format("Return Reason Code"), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                //IMP1.02 STart
                if SalesPurchaserRecGbl.Get(SalesCrMemHeadRecGbl."Salesperson Code")then;
                EnterCell(RowNo, 17, Format(SalesPurchaserRecGbl.Name), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                if PurchaserRecGbl.Get(SalesCrMemHeadRecGbl."Purchaser Code")then;
                EnterCell(RowNo, 18, Format(PurchaserRecGbl.Name), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            //IMP1.02 End
            end;
        }
        dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")WHERE(Type=FILTER(Item|"G/L Account"));
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord()
            begin
                PurchCrMemHeadRecGbl.Get("Document No.");
                RowNo+=1;
                EnterCell(RowNo, 1, 'Purchase Credit Memo', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 2, Format(PurchCrMemHeadRecGbl."Posting Date"), false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                EnterCell(RowNo, 3, Format(PurchCrMemHeadRecGbl."Buy-from Vendor No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 4, Format(PurchCrMemHeadRecGbl."Buy-from Vendor Name"), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 5, Format("Document No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 6, Format(PurchCrMemHeadRecGbl."Vendor Cr. Memo No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 7, Format(Type), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 8, Format("No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 9, Format(Description), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 10, Format(Quantity), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 11, Format("Unit of Measure Code"), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 12, Format("Direct Unit Cost"), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 13, Format("Line Amount"), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 14, Format("Amount Including VAT"), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 15, Format(''), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 16, Format("Return Reason Code"), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                //IMP1.02 STart
                if SalesPurchaserRecGbl.Get(PurchCrMemHeadRecGbl."Salesperson Code")then;
                EnterCell(RowNo, 17, Format(SalesPurchaserRecGbl.Name), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                if PurchaserRecGbl.Get(PurchCrMemHeadRecGbl."Purchaser Code")then;
                EnterCell(RowNo, 18, Format(PurchaserRecGbl.Name), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            //IMP1.02 End
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
    }
    trigger OnPostReport()
    begin
        //TempExcelBuffer.CreateBook('Return Analysis', '');//UPGCloud
        TempExcelBuffer.CreateNewBook('Return Analysis'); //UPGCloud>>
        TempExcelBuffer.WriteSheet('Return Analysis', CompanyName, UserId);
        TempExcelBuffer.CloseBook;
        TempExcelBuffer.OpenExcel;
    //TempExcelBuffer.GiveUserControl;//UPG   Function Removed in BC14
    end;
    trigger OnPreReport()
    begin
        SalesFilterText:="Sales Cr.Memo Line".GetFilters;
        PurchFilterText:="Purch. Cr. Memo Line".GetFilters;
        if SalesFilterText = '' then Error('You must specify atleast Posting Date.');
        if PurchFilterText = '' then Error('You must specify atleast Posting Date.');
        TempExcelBuffer.DeleteAll;
        Clear(TempExcelBuffer);
        RowNo:=2;
        EnterCell(RowNo, 1, 'Document Type', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 2, 'Posting Date', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 3, 'Customer/Vendor No', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 4, 'Customer/Vendor Nme', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 5, 'Document No.', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 6, 'External Doc. No', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 7, 'Type', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 8, 'Item No.', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 9, 'Description', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 10, 'Quantity', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 11, 'UOM', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 12, 'Unit Pric/Cost', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 13, 'Line Amount Excl. Tax', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 14, 'Line Amount Incl. Tax', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 15, 'Unit Cost', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 16, 'Return Reason Code', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 17, 'Salesperson', true, false, true, '', TempExcelBuffer."Cell Type"::Text); //IMP1.02
        EnterCell(RowNo, 18, 'Purchaser', true, false, true, '', TempExcelBuffer."Cell Type"::Text); //IMP1.02
    end;
    var RowNo: Integer;
    TempExcelBuffer: Record "Excel Buffer" temporary;
    SalesCrMemHeadRecGbl: Record "Sales Cr.Memo Header";
    PurchCrMemHeadRecGbl: Record "Purch. Cr. Memo Hdr.";
    SalesFilterText: Text;
    PurchFilterText: Text;
    SalesPurchaserRecGbl: Record "Salesperson/Purchaser";
    PurchaserRecGbl: Record "Salesperson/Purchaser";
    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; Format: Text[30]; CellType: Option)
    begin
        TempExcelBuffer.Init;
        TempExcelBuffer.Validate("Row No.", RowNo);
        TempExcelBuffer.Validate("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text":=CellValue;
        TempExcelBuffer.Formula:='';
        TempExcelBuffer.Bold:=Bold;
        TempExcelBuffer.Italic:=Italic;
        TempExcelBuffer.Underline:=UnderLine;
        TempExcelBuffer.NumberFormat:=Format;
        TempExcelBuffer."Cell Type":=CellType;
        TempExcelBuffer.Insert;
    end;
}
