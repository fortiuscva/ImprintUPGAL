pageextension 60107 "SalesLineFactBoxExt" extends "Sales Line FactBox"
{
    layout
    {
        addafter(Item)
        {
            field(InvoiceHistory; StrSubstNo('%1', NoOfHistoryLines))
            {
                ApplicationArea = All;
                Caption = 'Invoice History';

                trigger OnDrillDown();
                begin
                    // ISS2.00 01.08.14 DFP =================================================================\
                    ShowLineHistory;
                    CurrPage.Update;
                // End ==================================================================================/
                end;
            }
        }
    }
    procedure ShowLineHistory();
    var
        InvLine: Record "Sales Invoice Line";
    begin
        // ISS2.00 01.08.14 DFP =================================================================\
        if Rec.Type = Rec.Type::" " then exit;
        InvLine.Reset;
        InvLine.SetCurrentKey("Sell-to Customer No.", Type);
        InvLine.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
        InvLine.SetRange(Type, Rec.Type);
        InvLine.SetFilter("No.", '%1', Rec."No.");
        PAGE.Run(PAGE::"Recent Sales Invoice Lines", InvLine);
    // End ==================================================================================/
    end;
    procedure NoOfHistoryLines(): Integer;
    var
        InvLine: Record "Sales Invoice Line";
    begin
        // ISS2.00 01.08.14 DFP =================================================================\
        if Rec.Type = Rec.Type::" " then exit(0);
        InvLine.Reset;
        InvLine.SetCurrentKey("Sell-to Customer No.", Type);
        InvLine.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
        InvLine.SetRange(Type, Rec.Type);
        InvLine.SetFilter("No.", '%1', Rec."No.");
        exit(InvLine.Count);
    // End ==================================================================================/
    end;
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
