pageextension 60074 "SalespersonPurchaserCardExt" extends "Salesperson/Purchaser Card"
{
    actions
    {
        addafter(ShowLog)
        {
            group("&Print")
            {
                CaptionML = ENU = '&Print', ESM = '&Imprimir', FRC = '&Imprimer', ENC = '&Print';
                Image = Print;

                action("Monthly Sales")
                {
                    ApplicationArea = All;
                    Caption = 'Monthly Sales';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction();
                    begin
                        // ISS2.00 02.21.14 DFP ===========================================================\
                        Salesperson:=Rec;
                        Salesperson.SetRecFilter;
                        REPORT.Run(REPORT::"TEST Monthly Sales by SP", true, true, Salesperson);
                    // End ============================================================================/
                    end;
                }
            }
        }
    }
    var Salesperson: Record "Salesperson/Purchaser";
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
