page 50034 "Management  Role Center"
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

                part(Control1901851508; "SO Processor Activities")
                {
                    ApplicationArea = All;
                }
                systempart(Control1901420308; Outlook)
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
                {
                    AccessByPermission = TableData "Power BI User Configuration" = I;
                    ApplicationArea = Basic, Suite;
                }
                part(Control1; "Trailing Sales Orders Chart")
                {
                    ApplicationArea = All;
                }
                part(Control4; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part(Control1907692008; "My Customers")
                {
                    ApplicationArea = All;
                }
                part(Control1905989608; "My Items")
                {
                    ApplicationArea = All;
                }
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
            action("Item Sales History")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Sales History Excel";
            }
            action("Returns Analysis")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Return Analysis";
            }
            action("Customer - &Order Summary")
            {
                ApplicationArea = All;
                Caption = 'Customer - &Order Summary';
                Image = "Report";
                RunObject = Report "Customer - Order Summary";
            }
            action("Customer/Item Statistics")
            {
                ApplicationArea = All;
                Caption = 'Customer/Item Statistics';
                Image = "Report";
                RunObject = Report "Customer/Item Statistics";
            }
            action("Item Ledger vs Bin mismatch")
            {
                ApplicationArea = All;
                RunObject = Report "Check item qty  whse mismatch";
            }
            separator(Action17)
            {
            }
            action("Inventory to GL Reconcile V2")
            {
                ApplicationArea = All;
                RunObject = Report "Inventory to G/L Reconcile v2";
            }
            action("Cust./Item Stat. by Salespers.")
            {
                ApplicationArea = All;
                Caption = 'Cust./Item Stat. by Salespers.';
                Image = "Report";
                RunObject = Report "Cust./Item Stat. by Salespers.";
            }
            action("List Price Sheet")
            {
                ApplicationArea = All;
                Caption = 'List Price Sheet';
                Image = "Report";
                RunObject = Report "List Price Sheet";
            }
            separator(Action22)
            {
            }
            action("Inventory - Sales &Back Orders")
            {
                ApplicationArea = All;
                Caption = 'Inventory - Sales &Back Orders';
                Image = "Report";
                RunObject = Report "Inventory - Sales Back Orders";
            }
            action("Sales Order Status")
            {
                ApplicationArea = All;
                Caption = 'Sales Order Status';
                Image = "Report";
                RunObject = Report "Sales Order Status";
            }
            action("Customer Contact Mailing List")
            {
                ApplicationArea = All;
                Caption = 'Customer Contact Mailing List';
                Image = "Report";
                RunObject = Report "Contact Top  List";
            }
        }
        area(embedding)
        {
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List - Order Stats";
            }
            action("Shipped Not Invoiced")
            {
                ApplicationArea = All;
                Caption = 'Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Shipped Not Invoiced" = CONST(true));
            }
            action("Completely Shipped Not Invoiced")
            {
                ApplicationArea = All;
                Caption = 'Completely Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE("Completely Shipped" = CONST(true), Invoice = CONST(false));
            }
            action("Sales Quotes")
            {
                ApplicationArea = All;
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page "Sales Quotes";
            }
            action("Blanket Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Blanket Sales Orders';
                RunObject = Page "Blanket Sales Orders";
            }
            action("Sales Invoices")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
            }
            action("Sales Return Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Return Orders';
                Image = ReturnOrder;
                RunObject = Page "Sales Return Order List";
            }
            action("Sales Credit Memos")
            {
                ApplicationArea = All;
                Caption = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
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
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
            }
            action("New Items to Update")
            {
                ApplicationArea = All;
                RunObject = Page "New Items to Update";
            }
            action("Sales Orders - Credit Hold")
            {
                ApplicationArea = All;
                RunObject = Page "Sales Order List - Credit Mgmt";
            }
            action("Credit Management")
            {
                ApplicationArea = All;
                RunObject = Page "Customer List - Credit Mgmt.";
            }
            action("Change Log - Customers")
            {
                ApplicationArea = All;
                RunObject = Page "Change Log - Customers";
            }
            action("<Page Resource List>")
            {
                ApplicationArea = All;
                Caption = 'Resources';
                RunObject = Page "Resource List";
            }
            action(Customers)
            {
                ApplicationArea = All;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action("Services by Resources")
            {
                ApplicationArea = All;
                RunObject = Page "Service by Resources";
            }
            action("Item Journals")
            {
                ApplicationArea = All;
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item), Recurring = CONST(false));
            }
            action("Sales Journals")
            {
                ApplicationArea = All;
                Caption = 'Sales Journals';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Sales), Recurring = CONST(false));
            }
            action("Cash Receipt Journals")
            {
                ApplicationArea = All;
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST("Cash Receipts"), Recurring = CONST(false));
            }
            action("<Page Item Reclass. Journal>")
            {
                ApplicationArea = All;
                Caption = 'Item Reclass. Journal';
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
                action("All Contacts - Update List")
                {
                    ApplicationArea = All;
                    RunObject = Page "All Contacts - To Update";
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
            group("Item Imports")
            {
                Caption = 'Item Imports';

                action("Item Import (Standard)")
                {
                    ApplicationArea = All;
                    Caption = 'Item Import (Standard)';
                    RunObject = xmlport "Item Import (Standard)";
                }
                action("Item Import ScanSource- Simple")
                {
                    ApplicationArea = All;
                    Caption = 'Item Import ScanSource- Simple';
                    RunObject = xmlport "Item Import ScanSource- Simple";
                }
                action("Item Import (ScanSource)")
                {
                    ApplicationArea = All;
                    Caption = 'Item Import (ScanSource)';
                    RunObject = xmlport "Item Import (ScanSource)";
                }
                action("Item Import (BlueStar)")
                {
                    ApplicationArea = All;
                    Caption = 'Item Import (BlueStar)';
                    RunObject = xmlport "Item Import (BlueStar)";
                }
                action("Item Import (Ingram)")
                {
                    ApplicationArea = All;
                    Caption = 'Item Import (Ingram)';
                    RunObject = xmlport "Item Import (Ingram)";
                }
                action("Item Import (Accutech)")
                {
                    ApplicationArea = All;
                    Caption = 'Item Import (Accutech)';
                    RunObject = xmlport "Item Import (Accutech)";
                }
                action("Item Import (Tech Data Mat.)")
                {
                    ApplicationArea = All;
                    Caption = 'Item Import (Tech Data Mat.)';
                    RunObject = xmlport "Item Import (Tech Data Mat.)";
                }
                action("Item Import (Tech Data Price)")
                {
                    ApplicationArea = All;
                    Caption = 'Item Import (Tech Data Price)';
                    RunObject = xmlport "Item Import (Tech Data Price)";
                }
                action("TEMP Tech Data")
                {
                    ApplicationArea = All;
                    Caption = 'TEMP Tech Data';
                    RunObject = page "TEMP Tech Data";
                }
                action("Item Import Sources")
                {
                    ApplicationArea = All;
                    Caption = 'Item Import Sources';
                    RunObject = page "Item Import Sources";
                }
                action("Item Import No. Overrides")
                {
                    ApplicationArea = All;
                    Caption = 'Item Import No. Overrides';
                    RunObject = page "Item Import No. Overrides";
                }
                action("TEMP Item Category Check")
                {
                    ApplicationArea = All;
                    Caption = 'TEMP Item Category Check';
                    RunObject = page "TEMP Item Category Check";
                }
                action("Item Import List")
                {
                    ApplicationArea = All;
                    Caption = 'Item Import Results And Log';
                    RunObject = page "Item Import List";
                }
                action("Delete IPT Items")
                {
                    ApplicationArea = All;
                    Caption = 'Delete IPT Items';
                    RunObject = report "Delete IPT Items";
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
            action("Create -00 Ship To")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Create Ship-to Addr. With 00";
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
            separator(Action42)
            {
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
            action(Action1020001)
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
