page 50053 "Serial Numbers by Bin FactBox"
{
    // IMP1.01,08/17/20,ST: Enhancements to display Serial No's by bin code.
    //                        Created new page.
    Caption = 'Serial Numbers by Bin FactBox';
    PageType = ListPart;
    SourceTable = "Serial Numbers by Bin Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Control7)
            {
                ShowCaption = false;

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Qty. (Base)"; Rec."Qty. (Base)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnFindRecord(Which: Text): Boolean begin
        FillTempTable;
        exit(Rec.Find(Which));
    end;
    local procedure FillTempTable()
    var
        SerialNosByBinCode: Query "Serial Numbers by Bin";
    begin
        SerialNosByBinCode.SetRange(Item_No, Rec.GetRangeMin("Item No."));
        SerialNosByBinCode.SetRange(Variant_Code, Rec.GetRangeMin("Variant Code"));
        SerialNosByBinCode.SetRange(Location_Code, Rec.GetRangeMin("Location Code"));
        SerialNosByBinCode.Open;
        Rec.DeleteAll;
        while SerialNosByBinCode.Read do begin
            Rec.Init;
            Rec."Item No.":=SerialNosByBinCode.Item_No;
            Rec."Variant Code":=SerialNosByBinCode.Variant_Code;
            Rec."Zone Code":=SerialNosByBinCode.Zone_Code;
            Rec."Bin Code":=SerialNosByBinCode.Bin_Code;
            Rec."Location Code":=SerialNosByBinCode.Location_Code;
            Rec."Lot No.":=SerialNosByBinCode.Lot_No;
            Rec."Serial No.":=SerialNosByBinCode.Serial_No;
            Rec."Qty. (Base)":=SerialNosByBinCode.Sum_Qty_Base;
            Rec.Insert;
        end;
    end;
}
