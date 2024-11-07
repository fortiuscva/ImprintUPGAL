pageextension 60030 "ResourceListExt" extends "Resource List"
{
    layout
    {
        addafter(Type)
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
            }
            field("Tax Group Code"; Rec."Tax Group Code")
            {
                ApplicationArea = All;
            }
            field("Vendor Resource No."; Rec."Vendor Resource No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Prices")
        {
            group("S&ales")
            {
                CaptionML = ENU = 'S&ales', ESM = 'Ve&ntas', FRC = 'V&entes', ENC = 'S&ales';
                Image = Sales;

                action(Orders)
                {
                    ApplicationArea = All;
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Orders";
                    RunPageLink = Type=CONST(Resource), "No."=FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
            }
            group("&Purchases")
            {
                CaptionML = ENU = '&Purchases', ESM = '&Compras', FRC = '&Achats', ENC = '&Purchases';
                Image = Purchasing;

                action(Action1000000006)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Orders', ESM = 'Pedidos', FRC = 'Commandes', ENC = 'Orders';
                    Image = Document;
                    RunObject = Page "Purchase Orders";
                    RunPageLink = Type=CONST(Resource), "No."=FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
