pageextension 60072 "ContactListExt" extends "Contact List"
{
    layout
    {
        addafter(Name)
        {
            field("Company No."; Rec."Company No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("Lead Source Code"; Rec."Lead Source Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Documents)
        {
            group(Action1100796001)
            {
                action("New Contact")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'New Contact', ESM = 'Pedido venta', FRC = 'Document de vente', ENC = 'Sales Order';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = New;
                    RunObject = Page "Contact Card";
                    RunPageLink = "Company No."=FIELD("No.");
                    RunPageMode = Create;
                }
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
