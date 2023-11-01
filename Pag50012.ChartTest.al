page 50012 "Chart Test"
{
    layout
    {
    }
    actions
    {
        area(processing)
        {
            action(ShowChart)
            {
                ApplicationArea = All;
                Caption = 'Show Chart';
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PAGE.RunModal(PAGE::"Sales Statistics Chart");
                end;
            }
        }
    }
}
