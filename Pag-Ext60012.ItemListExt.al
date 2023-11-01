pageextension 60012 "ItemListExt" extends "Item List"
{
    layout
    {
        /*modify(Control113)
        {
            Visible = false;
        }*/
        addfirst(Control1)
        {
            field("Mfg. Item No."; Rec."Mfg. Item No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
            }
            field("Salesperson Name"; Rec."Salesperson Name")
            {
                ApplicationArea = All;
            }
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
            }
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
            }
            field(Control1000000005; Rec.Inventory)
            {
                ApplicationArea = All;
            }
        }
        addafter("Substitutes Exist")
        {
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;
            }
            field("Inventory at Date"; Rec."Inventory at Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Action24)
        {
            separator(Action1000000004)
            {
            }
            action("Recent Posted Invoice Lines")
            {
                ApplicationArea = All;
                Caption = 'Recent Posted Invoice Lines';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Recent Sales Invoice Lines";
                RunPageLink = "No." = FIELD("No.");
                RunPageView = WHERE(Type = CONST(Item));
            }
            action("Recent Posted Cr. Memo Lines")
            {
                ApplicationArea = All;
                Caption = 'Recent Posted Cr. Memo Lines';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Recent Sales Cr. Memo Lines";
                RunPageLink = "No." = FIELD("No.");
                RunPageView = WHERE(Type = CONST(Item));
            }
        }
    }
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
}
