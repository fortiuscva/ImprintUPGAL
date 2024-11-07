pageextension 60105 "OrderProcessorRoleCenterExt" extends "Order Processor Role Center"
{
    actions
    {
        //Unsupported feature: Change Level on "Items(Action 23)". Please convert manually.
        //Unsupported feature: Change Name on "Items(Action 23)". Please convert manually.
        //Unsupported feature: Change Level on "Customers(Action 26)". Please convert manually.
        //Unsupported feature: Change Name on "Customers(Action 26)". Please convert manually.
        //Unsupported feature: Change Name on ""Credit Management"(Action 1020006)". Please convert manually.
        //Unsupported feature: PropertyDeletion on "Items(Action 23)". Please convert manually.
        //Unsupported feature: PropertyDeletion on "Items(Action 23)". Please convert manually.
        //Unsupported feature: PropertyDeletion on "Customers(Action 26)". Please convert manually.
        //Unsupported feature: PropertyDeletion on "Customers(Action 26)". Please convert manually.
        modify(Action61)
        {
            Visible = false;
        }
        modify(Action93)
        {
            Visible = false;
        }
        addafter(Locations)
        {
            action("Purchase Orders List")
            {
                ApplicationArea = All;
                RunObject = Page "Purchase Order List";
            }
            action("Purchase Orders - Free Samples")
            {
                ApplicationArea = All;
                RunObject = Page "Purchase Order Samples List";
            }
            action("Purchase Orders - All Demos")
            {
                ApplicationArea = All;
                RunObject = Page "Purchase Order Demo List";
            }
            action("Purchase Orders - Projects")
            {
                ApplicationArea = All;
                RunObject = Page "Purchase Order Projects List";
            }
            action("Repair Orders List")
            {
                ApplicationArea = All;
                RunObject = Page "Repair Return Orders List";
            }
        }
        addbefore("Credit Management")
        {
            action("Page Resource List")
            {
                ApplicationArea = All;
                Caption = 'Resources';
                RunObject = Page "Resource List";
            }
        }
        addbefore("Posted Documents")
        {
            group("NAV Relationship Management")
            {
                CaptionML = ENU = 'NAV Relationship Management', ESM = 'Documentos hist’óricos', FRC = 'Documents reportËÇÜs', ENC = 'Posted Documents';
                Image = Sales;

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
        addfirst("Posted Documents")
        {
            action("Sales Order Lines")
            {
                ApplicationArea = All;
                RunObject = Page "Sales Order Lines";
            }
            action("Sales Invoice Lines")
            {
                ApplicationArea = All;
                RunObject = Page "Sales Invoice Lines";
            }
        }
        moveafter(SalesOrdersComplShtNotInv; "Item Journals")
    }
}
