page 50032 "Imprint SO Processor Actv."
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Sales Cue";

    layout
    {
        area(content)
        {
            cuegroup("For Release")
            {
                Caption = 'For Release';

                field("Sales Quotes - Open"; Rec."Sales Quotes - Open")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Quotes";
                }
                field("Sales Orders - Open"; Rec."Sales Orders - Open")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Order List";
                }
                actions
                {
                    action("New Sales Quote")
                    {
                        ApplicationArea = All;
                        Caption = 'New Sales Quote';
                        RunObject = Page "Sales Quote";
                        RunPageMode = Create;
                    }
                    action("New Sales Order")
                    {
                        ApplicationArea = All;
                        Caption = 'New Sales Order';
                        RunObject = Page "Sales Order";
                        RunPageMode = Create;
                    }
                }
            }
            cuegroup("Sales Orders Released Not Shipped")
            {
                Caption = 'Sales Orders Released Not Shipped';

                field("Ready to Ship"; Rec."Ready to Ship")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Order List";
                }
                field("Partially Shipped"; Rec."Partially Shipped")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Order List";
                }
                field(Delayed; Rec.Delayed)
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Order List";
                }
                actions
                {
                    action(Navigate)
                    {
                        ApplicationArea = All;
                        Caption = 'Navigate';
                        RunObject = Page Navigate;
                    }
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
        Rec.SetRange("Date Filter", 0D, WorkDate - 1);
        Rec.SetFilter("Date Filter2", '>=%1', WorkDate);
    end;
}
