pageextension 60011 "ItemCardExt" extends "Item Card"
{
    layout
    {
        addafter(Type)
        {
            field("Mfg. Item No."; Rec."Mfg. Item No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(GTIN)
        {
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;
            }
        }
        addafter(Warehouse)
        {
            group("Import Fields")
            {
                Caption = 'Import Fields';

                field("Item Import Code"; Rec."Item Import Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Import Date"; Rec."Item Import Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Import Time"; Rec."Item Import Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mfg. Item No. (Match)"; Rec."Mfg. Item No. (Match)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lock Description"; Rec."Lock Description")
                {
                    ApplicationArea = All;
                }
                field("Lock Item Category"; Rec."Lock Item Category")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Last Date Modified")
        {
            field("Created Date"; Rec."Created Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Search Description")
        {
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
            }
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
            }
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
            }
            field("Salesperson Name"; Rec."Salesperson Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Created Date")
        {
            field("Skip Bluestar Description"; Rec."Skip Bluestar Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. on Sales Order")
        {
            field("Qty. On Sales Quotes"; Rec."Qty. On Sales Quotes")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("BOM Level")
        {
            separator(Action1000000009)
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
