report 50046 "Sales History Excel"
{
    // IMP1.01,12/01/17,SK: Created new excel report
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = SORTING(Type, "No.")WHERE(Quantity=FILTER(<>0));
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin
                RowNo+=1;
                EnterCell(RowNo, 1, Format("Sales Invoice Line"."Posting Date"), false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                EnterCell(RowNo, 2, Format("Sales Invoice Line"."Shipment Date"), false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                EnterCell(RowNo, 3, Format("Sales Invoice Line"."Sell-to Customer No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 4, Format("Sales Invoice Line"."Document No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 5, Format("Sales Invoice Line".Type), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 6, Format("Sales Invoice Line"."No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 7, Format("Sales Invoice Line".Description), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 8, Format("Sales Invoice Line".Quantity), false, false, false, '', TempExcelBuffer."Cell Type"::Number); //CLEM1.05
                EnterCell(RowNo, 9, Format("Sales Invoice Line"."Unit Price"), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 10, Format("Sales Invoice Line".Amount), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 11, Format("Sales Invoice Line"."Location Code"), false, false, false, '', TempExcelBuffer."Cell Type"::Text); //CLEM1.02
                EnterCell(RowNo, 12, Format("Sales Invoice Line"."Unit of Measure Code"), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 13, Format("Sales Invoice Line"."Posting Group"), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 14, Format("Sales Invoice Line"."Job No."), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                SalesInvHeadRecGbl.Get("Sales Invoice Line"."Document No.");
                EnterCell(RowNo, 15, Format(SalesInvHeadRecGbl."Ship-to County"), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 16, Format(SalesInvHeadRecGbl."Bill-to County"), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            end;
            trigger OnPreDataItem()
            begin
                TempExcelBuffer.DeleteAll;
                Clear(TempExcelBuffer);
                RowNo:=2;
                EnterCell(RowNo, 1, 'Posting Date', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 2, 'Shipment Date', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 3, 'Sell-To Customer No.', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 4, 'Document No.', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 5, 'Type', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 6, 'No.', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 7, 'Description', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 8, 'Quantity', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 9, 'Unit Price', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 10, 'Amount', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 11, 'Location Code', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 12, 'Unit oof Measure Code', true, false, true, '', TempExcelBuffer."Cell Type"::Text); //CLEM1.05
                EnterCell(RowNo, 13, 'Posting Goup', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 14, 'Job No.', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                EnterCell(RowNo, 15, 'Ship-To State', true, false, true, '', TempExcelBuffer."Cell Type"::Text); //CLEM1.02
                EnterCell(RowNo, 16, 'Bll-To State', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
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
        //TempExcelBuffer.CreateBook('Sales History', '');//UPGCloud
        TempExcelBuffer.CreateNewBook('Sales History'); //UPGCloud>>
        TempExcelBuffer.WriteSheet('Sales History', CompanyName, UserId);
        TempExcelBuffer.CloseBook;
        TempExcelBuffer.OpenExcel;
    //TempExcelBuffer.GiveUserControl;//UPG    Function Removed in BC14
    end;
    var RowNo: Integer;
    TempExcelBuffer: Record "Excel Buffer" temporary;
    SalesInvHeadRecGbl: Record "Sales Invoice Header";
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
