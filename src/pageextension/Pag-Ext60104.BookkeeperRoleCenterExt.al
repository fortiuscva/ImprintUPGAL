pageextension 60104 "BookkeeperRoleCenterExt" extends "Bookkeeper Role Center"
{
    actions
    {
        //Unsupported feature: Change Name on ""Posted Documents"(Action 39)". Please convert manually.
        addafter("Sales Orders")
        {
            action("Purchase Orders - Free Samples")
            {
                ApplicationArea = All;
                RunObject = Page "Purchase Order Samples List";
            }
            action("Repair Orders List")
            {
                ApplicationArea = All;
                RunObject = Page "Repair Return Orders List";
            }
        }
        addbefore("Posted Sales Shipments")
        {
            group("NAV Relationship Management")
            {
                CaptionML = ENU = 'NAV Relationship Management', ESM = 'Documentos hist’óricos', FRC = 'Documents reportËÇÜs', ENC = 'Posted Documents';

                action("Contacts - My Contacts")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'My Contacts', ESM = 'Hist’órico remisiones de venta', FRC = 'Livraisons de ventes reportËÇÜes', ENC = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Contacts - My Contact";
                    RunPageMode = View;
                }
                action("Contacts - All Contacts")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'All Contacts', ESM = 'Hist’órico remisiones de venta', FRC = 'Livraisons de ventes reportËÇÜes', ENC = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Contacts - All Contacts";
                    RunPageMode = View;
                }
                action("Contacts - Unassigned Contacts")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Unassigned Contacts', ESM = 'Hist’órico remisiones de venta', FRC = 'Livraisons de ventes reportËÇÜes', ENC = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Contacts - Unassigned";
                }
                action("Contacts - Dormant Contacts")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Dormant Contacts', ESM = 'Hist’órico remisiones de venta', FRC = 'Livraisons de ventes reportËÇÜes', ENC = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Contacts - Dormant Contacts";
                }
                action("All Interactions")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'All Interactions', ESM = 'Hist’órico remisiones de venta', FRC = 'Livraisons de ventes reportËÇÜes', ENC = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "NAV RM Interaction Log Entries";
                }
            }
        }
    }
}
