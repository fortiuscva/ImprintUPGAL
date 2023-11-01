page 50050 "Purch. Line UOM Fact Box"
{
    // IMP1.01,09/26/16,ST: Created new fact box.
    Caption = 'UOM Details';
    PageType = ListPart;
    SourceTable = "Item Unit of Measure";
    SourceTableView = SORTING("Item No.", Code)ORDER(Ascending)WHERE("Item No."=FILTER(<>''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
