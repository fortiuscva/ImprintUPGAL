page 50030 "Warehouse Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
            }
            group(Control1900724708)
            {
                ShowCaption = false;

                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(reporting)
        {
            action("<Report Sales History>")
            {
                ApplicationArea = All;
                Caption = 'Sales History';
                Image = "Report";
                RunObject = Report "Sales History";
            }
            action("<Report Top_Inv. Items>")
            {
                ApplicationArea = All;
                Caption = 'Top Inventory Items';
                Image = "Report";
                RunObject = Report "Top __ Inventory Items";
            }
        }
        area(embedding)
        {
            action("Page Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Orders";
            }
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action("Purchase Orders - Free Samples")
            {
                ApplicationArea = All;
                RunObject = Page "Purchase Order Samples List";
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
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
            }
            action("<Page Bin Content>")
            {
                ApplicationArea = All;
                Caption = 'Bin Contents';
                RunObject = Page "Bin Content";
            }
            action("Item Reclass. Journals")
            {
                ApplicationArea = All;
                Caption = 'Item Reclass. Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type"=CONST(Transfer), Recurring=CONST(false));
            }
            action("Item Journals")
            {
                ApplicationArea = All;
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type"=CONST(Item), Recurring=CONST(false));
            }
        }
        area(sections)
        {
            group("NAV Relationship Management")
            {
                Caption = 'NAV Relationship Management';
                Image = Sales;

                action("Contacts - My Contacts")
                {
                    ApplicationArea = All;
                    Caption = 'My Contacts';
                    Image = PostedShipment;
                    RunObject = Page "Contacts - My Contact";
                    RunPageMode = View;
                }
                action("Contacts - All Contacts")
                {
                    ApplicationArea = All;
                    Caption = 'All Contacts';
                    Image = PostedShipment;
                    RunObject = Page "Contacts - All Contacts";
                    RunPageMode = View;
                }
                action("Contacts - Unassigned Contacts")
                {
                    ApplicationArea = All;
                    Caption = 'Unassigned Contacts';
                    Image = PostedShipment;
                    RunObject = Page "Contacts - Unassigned";
                }
                action("Contacts - Dormant Contacts")
                {
                    ApplicationArea = All;
                    Caption = 'Dormant Contacts';
                    Image = PostedShipment;
                    RunObject = Page "Contacts - Dormant Contacts";
                }
                action("All Interactions")
                {
                    ApplicationArea = All;
                    Caption = 'All Interactions';
                    Image = PostedShipment;
                    RunObject = Page "NAV RM Interaction Log Entries";
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;

                action("Posted Sales Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                }
                action("Posted Return Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
            }
        }
        area(creation)
        {
            action("Sales &Quote")
            {
                ApplicationArea = All;
                Caption = 'Sales &Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
            }
            action("Sales &Invoice")
            {
                ApplicationArea = All;
                Caption = 'Sales &Invoice';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
            }
            action("Sales &Order")
            {
                ApplicationArea = All;
                Caption = 'Sales &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
            }
            action("Sales &Return Order")
            {
                ApplicationArea = All;
                Caption = 'Sales &Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Return Order";
                RunPageMode = Create;
            }
            action("Sales &Credit Memo")
            {
                ApplicationArea = All;
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
            Caption = 'Tasks';
            IsHeader = true;
            }
            action("Sales &Journal")
            {
                ApplicationArea = All;
                Caption = 'Sales &Journal';
                Image = Journals;
                RunObject = Page "Sales Journal";
            }
            action("Sales Price &Worksheet")
            {
                ApplicationArea = All;
                Caption = 'Sales Price &Worksheet';
                Image = PriceWorksheet;
                RunObject = Page "Sales Price Worksheet";
            }
            action("Sales &Prices")
            {
                ApplicationArea = All;
                Caption = 'Sales &Prices';
                Image = SalesPrices;
                RunObject = Page "Sales Prices";
            }
            action("Sales &Line Discounts")
            {
                ApplicationArea = All;
                Caption = 'Sales &Line Discounts';
                Image = SalesLineDisc;
                RunObject = Page "Sales Line Discounts";
            }
            separator(History)
            {
            Caption = 'History';
            IsHeader = true;
            }
            action("Navi&gate")
            {
                ApplicationArea = All;
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
            }
            separator(Customer)
            {
            Caption = 'Customer';
            IsHeader = true;
            }
            action("Credit Management")
            {
                ApplicationArea = All;
                Caption = 'Credit Management';
                RunObject = Page "Customer List - Credit Mgmt.";
            }
            action("Order Status")
            {
                ApplicationArea = All;
                Caption = 'Order Status';
                RunObject = Page "Customer List - Order Status";
            }
        }
    }
}
