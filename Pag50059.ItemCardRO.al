page 50059 "Item Card-RO"
{
    // ISS2.00 03.27.14 DFP - Added "Source Type" above Item Category
    // ISS2.00 01.21.14 DFP - Added Recent Posted Invoice and Credit Memo Lines under History
    // ISS2.00 10.08.13 DFP - Added "Description 2" to page
    // IMP1.01,10/20/16,ST:Added field Customer No.,Customer Name,Salesperson Code,Salesperson Name.,Qty. on Purch. Return Order,Qty. on Sales Return Order.
    // IMP1.02,08/10/18,SK: Pullout "Created Date" under Genreal Tab.
    // IMP1.03,10/02/19,ST: Modifications handled to skip updating item description when update happening through xmlport 50011/"Item Import (BlueStar)".
    //                       - Added field "Skip Bluestar Description".
    Caption = 'Item Card';
    Editable = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Item;
    SourceTableView = SORTING("Mfg. Item No.");

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit then CurrPage.Update;
                    end;
                }
                field("Mfg. Item No."; Rec."Mfg. Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ApplicationArea = All;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ApplicationArea = All;
                }
                field("Automatic Ext. Texts"; Rec."Automatic Ext. Texts")
                {
                    ApplicationArea = All;
                }
                field("Created From Nonstock Item"; Rec."Created From Nonstock Item")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        EnableCostingControls;
                    end;
                }
                field("Service Item Group"; Rec."Service Item Group")
                {
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
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
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Name"; Rec."Salesperson Name")
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Purch. Return Order"; Rec."Qty. on Purch. Return Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Sales Return Order"; Rec."Qty. on Sales Return Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Service Order"; Rec."Qty. on Service Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Job Order"; Rec."Qty. on Job Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Assembly Order"; Rec."Qty. on Assembly Order")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Qty. on Asm. Component"; Rec."Qty. on Asm. Component")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Skip Bluestar Description"; Rec."Skip Bluestar Description")
                {
                    ApplicationArea = All;
                    Caption = 'Skip Bluestar & ScanSource Description';
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';

                field("Costing Method"; Rec."Costing Method")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        EnableCostingControls;
                    end;
                }
                field("Cost is Adjusted"; Rec."Cost is Adjusted")
                {
                    ApplicationArea = All;
                }
                field("Cost is Posted to G/L"; Rec."Cost is Posted to G/L")
                {
                    ApplicationArea = All;
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    ApplicationArea = All;
                    Enabled = StandardCostEnable;

                    trigger OnDrillDown()
                    var
                        ShowAvgCalcItem: Codeunit "Show Avg. Calc. - Item";
                    begin
                        ShowAvgCalcItem.DrillDownAvgCostAdjmtPoint(Rec)
                    end;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Enabled = UnitCostEnable;

                    trigger OnDrillDown()
                    var
                        ShowAvgCalcItem: Codeunit "Show Avg. Calc. - Item";
                    begin
                        ShowAvgCalcItem.DrillDownAvgCostAdjmtPoint(Rec)
                    end;
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    ApplicationArea = All;
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."Profit %")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Net Invoiced Qty."; rec."Net Invoiced Qty.")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Item Disc. Group"; Rec."Item Disc. Group")
                {
                    ApplicationArea = All;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Application Wksh. User ID"; Rec."Application Wksh. User ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            group(Replenishment)
            {
                Caption = 'Replenishment';

                field("Replenishment System"; Rec."Replenishment System")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                }
                group(Purchase)
                {
                    Caption = 'Purchase';

                    field("Vendor No."; Rec."Vendor No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor Item No."; Rec."Vendor Item No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control230)
                {
                    Caption = 'Production';

                    field("Manufacturing Policy"; Rec."Manufacturing Policy")
                    {
                        ApplicationArea = All;
                    }
                    field("Routing No."; Rec."Routing No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Production BOM No."; Rec."Production BOM No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Rounding Precision"; Rec."Rounding Precision")
                    {
                        ApplicationArea = All;
                    }
                    field("Flushing Method"; Rec."Flushing Method")
                    {
                        ApplicationArea = All;
                    }
                    field("Scrap %"; Rec."Scrap %")
                    {
                        ApplicationArea = All;
                    }
                    field("Lot Size"; Rec."Lot Size")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Assembly)
                {
                    Caption = 'Assembly';

                    field("Assembly Policy"; Rec."Assembly Policy")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Planning)
            {
                Caption = 'Planning';

                field("Reordering Policy"; Rec."Reordering Policy")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        EnablePlanningControls
                    end;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Order Tracking Policy"; Rec."Order Tracking Policy")
                {
                    ApplicationArea = All;
                }
                field("Stockkeeping Unit Exists"; Rec."Stockkeeping Unit Exists")
                {
                    ApplicationArea = All;
                }
                field("Dampener Period"; Rec."Dampener Period")
                {
                    ApplicationArea = All;
                    Enabled = DampenerPeriodEnable;
                }
                field("Dampener Quantity"; Rec."Dampener Quantity")
                {
                    ApplicationArea = All;
                    Enabled = DampenerQtyEnable;
                }
                field(Critical; Rec.Critical)
                {
                    ApplicationArea = All;
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    ApplicationArea = All;
                    Enabled = SafetyLeadTimeEnable;
                }
                field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
                {
                    ApplicationArea = All;
                    Enabled = SafetyStockQtyEnable;
                }
                group("Lot-for-Lot Parameters")
                {
                    Caption = 'Lot-for-Lot Parameters';

                    field("Include Inventory"; Rec."Include Inventory")
                    {
                        ApplicationArea = All;
                        Enabled = IncludeInventoryEnable;

                        trigger OnValidate()
                        begin
                            EnablePlanningControls
                        end;
                    }
                    field("Lot Accumulation Period"; Rec."Lot Accumulation Period")
                    {
                        ApplicationArea = All;
                        Enabled = LotAccumulationPeriodEnable;
                    }
                    field("Rescheduling Period"; Rec."Rescheduling Period")
                    {
                        ApplicationArea = All;
                        Enabled = ReschedulingPeriodEnable;
                    }
                }
                group("Reorder-Point Parameters")
                {
                    Caption = 'Reorder-Point Parameters';

                    grid(Control65)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;

                        group(Control64)
                        {
                            ShowCaption = false;

                            field("Reorder Point"; Rec."Reorder Point")
                            {
                                ApplicationArea = All;
                                Enabled = ReorderPointEnable;
                            }
                            field("Reorder Quantity"; Rec."Reorder Quantity")
                            {
                                ApplicationArea = All;
                                Enabled = ReorderQtyEnable;
                            }
                            field("Maximum Inventory"; Rec."Maximum Inventory")
                            {
                                ApplicationArea = All;
                                Enabled = MaximumInventoryEnable;
                            }
                        }
                    }
                    field("Overflow Level"; Rec."Overflow Level")
                    {
                        ApplicationArea = All;
                        Enabled = OverflowLevelEnable;
                        Importance = Additional;
                    }
                    field("Time Bucket"; Rec."Time Bucket")
                    {
                        ApplicationArea = All;
                        Enabled = TimeBucketEnable;
                        Importance = Additional;
                    }
                }
                group("Order Modifiers")
                {
                    Caption = 'Order Modifiers';

                    grid(Control60)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;

                        group(Control61)
                        {
                            ShowCaption = false;

                            field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
                            {
                                ApplicationArea = All;
                                Enabled = MinimumOrderQtyEnable;
                            }
                            field("Maximum Order Quantity"; Rec."Maximum Order Quantity")
                            {
                                ApplicationArea = All;
                                Enabled = MaximumOrderQtyEnable;
                            }
                            field("Order Multiple"; Rec."Order Multiple")
                            {
                                ApplicationArea = All;
                                Enabled = OrderMultipleEnable;
                            }
                        }
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';

                field("Tariff No."; Rec."Tariff No.")
                {
                    ApplicationArea = All;
                }
                field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
            }
            group("Item Tracking")
            {
                Caption = 'Item Tracking';

                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Serial Nos."; Rec."Serial Nos.")
                {
                    ApplicationArea = All;
                }
                field("Lot Nos."; Rec."Lot Nos.")
                {
                    ApplicationArea = All;
                }
                field("Expiration Calculation"; Rec."Expiration Calculation")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1907509201)
            {
                Caption = 'Warehouse';

                field("Special Equipment Code"; Rec."Special Equipment Code")
                {
                    ApplicationArea = All;
                }
                field("Put-away Template Code"; Rec."Put-away Template Code")
                {
                    ApplicationArea = All;
                }
                field("Put-away Unit of Measure Code"; Rec."Put-away Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Phys Invt Counting Period Code"; Rec."Phys Invt Counting Period Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Last Phys. Invt. Date"; Rec."Last Phys. Invt. Date")
                {
                    ApplicationArea = All;
                }
                field("Last Counting Period Update"; Rec."Last Counting Period Update")
                {
                    ApplicationArea = All;
                }
                field("Identifier Code"; Rec."Identifier Code")
                {
                    ApplicationArea = All;
                }
                field("Use Cross-Docking"; Rec."Use Cross-Docking")
                {
                    ApplicationArea = All;
                }
            }
            group("E-Ship")
            {
                Caption = 'E-Ship';

                field("<Net Weight2>"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("<Gross Weight2>"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ApplicationArea = All;
                }
            }
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
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = true;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Master Data")
            {
                Caption = 'Master Data';
                Image = DataEntry;

                action("&Units of Measure")
                {
                    ApplicationArea = All;
                    Caption = '&Units of Measure';
                    Image = UnitOfMeasure;
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action("Va&riants")
                {
                    ApplicationArea = All;
                    Caption = 'Va&riants';
                    Image = ItemVariant;
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                }
                action(Action184)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(27), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("Substituti&ons")
                {
                    ApplicationArea = All;
                    Caption = 'Substituti&ons';
                    Image = ItemSubstitution;
                    RunObject = Page "Item Substitution Entry";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                }
                action("Cross Re&ferences")
                {
                    ApplicationArea = All;
                    Caption = 'Cross Re&ferences';
                    Image = Change;
                    //RunObject = Page "Item Cross Reference Entries";
                    // RunPageLink = "Item No." = FIELD("No.");
                }
                action("E&xtended Text")
                {
                    ApplicationArea = All;
                    Caption = 'E&xtended Text';
                    Image = Text;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                }
                action(Translations)
                {
                    ApplicationArea = All;
                    Caption = 'Translations';
                    Image = Translations;
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                action("&Picture")
                {
                    ApplicationArea = All;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Item Picture";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                }
                action(Identifiers)
                {
                    ApplicationArea = All;
                    Caption = 'Identifiers';
                    Image = BarCode;
                    RunObject = Page "Item Identifiers";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
                }
            }
            group(Availability)
            {
                Caption = 'Availability';
                Image = ItemAvailability;

                action(ItemsByLocation)
                {
                    ApplicationArea = All;
                    Caption = 'Items b&y Location';
                    Image = ItemAvailbyLoc;

                    trigger OnAction()
                    var
                        ItemsByLocation: Page "Items by Location";
                    begin
                        ItemsByLocation.SetRecord(Rec);
                        ItemsByLocation.Run;
                    end;
                }
                group("&Item Availability by")
                {
                    Caption = '&Item Availability by';
                    Image = ItemAvailability;

                    action("<Action110>")
                    {
                        ApplicationArea = All;
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Rec, ItemAvailFormsMgt.ByEvent);
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        Image = Period;
                        RunObject = Page "Item Availability by Periods";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        RunObject = Page "Item Availability by Variant";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';
                        Image = Warehouse;
                        RunObject = Page "Item Availability by Location";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                    }
                    action("BOM Level")
                    {
                        ApplicationArea = All;
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Rec, ItemAvailFormsMgt.ByBOM);
                        end;
                    }
                    action(Timeline)
                    {
                        ApplicationArea = All;
                        Caption = 'Timeline';
                        Image = Timeline;
                        Visible = false;

                    }
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;

                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;

                    action("Ledger E&ntries")
                    {
                        ApplicationArea = All;
                        Caption = 'Ledger E&ntries';
                        Image = ItemLedger;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("&Reservation Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        RunObject = Page "Reservation Entries";
                        RunPageLink = "Reservation Status" = CONST(Reservation), "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.", "Variant Code", "Location Code", "Reservation Status");
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        RunObject = Page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                    action("&Value Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                    action("Item &Tracking Entries")
                    {
                        ApplicationArea = All;
                        Caption = 'Item &Tracking Entries';
                        Image = ItemTrackingLedger;

                        trigger OnAction()
                        var
                            ItemTrackingMgt: Codeunit 6500;
                        begin
                            //ItemTrackingMgt.CallItemTrackingEntryForm(3,'',"No.",'','','','');
                        end;
                    }
                    action("&Warehouse Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type", Dedicated);
                    }
                    action("Application Worksheet")
                    {
                        ApplicationArea = All;
                        Caption = 'Application Worksheet';
                        Image = ApplicationWorksheet;
                        RunObject = Page "Application Worksheet";
                        RunPageLink = "Item No." = FIELD("No.");
                    }
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
                        Caption = 'Recent Posted Cr. Memo Lines';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Recent Sales Cr. Memo Lines";
                        RunPageLink = "No." = FIELD("No.");
                        RunPageView = WHERE(Type = CONST(Item));
                        ApplicationArea = All;
                    }
                }
                group(Action102)
                {
                    Caption = 'Statistics';
                    Image = Statistics;

                    action(Statistics)
                    {
                        Caption = 'Statistics';
                        Image = Statistics;
                        Promoted = true;
                        PromotedCategory = Process;
                        ShortCutKey = 'F7';
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ItemStatistics: Page "Item Statistics";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RunModal;
                        end;
                    }
                    action("Entry Statistics")
                    {
                        Caption = 'Entry Statistics';
                        Image = EntryStatistics;
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action("T&urnover")
                    {
                        Caption = 'T&urnover';
                        Image = Turnover;
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                Image = Purchasing;

                action("Ven&dors")
                {
                    Caption = 'Ven&dors';
                    Image = Vendor;
                    RunObject = Page "Item Vendor Catalog";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page "Purchase Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page "Purchase Line Discounts";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Prepa&yment Percentages")
                {
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Purchase Prepmt. Percentages";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(Action47)
                {
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Purchase Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Purchase Return Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action("Nonstoc&k Items")
                {
                    Caption = 'Nonstoc&k Items';
                    Image = NonStockItem;
                    RunObject = Page "Catalog Item List";
                    ApplicationArea = All;
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                Image = Sales;

                action(Action82)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page "Sales Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Action80)
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page "Sales Line Discounts";
                    RunPageLink = Type = CONST(Item), Code = FIELD("No.");
                    RunPageView = SORTING(Type, Code);
                    ApplicationArea = All;
                }
                action(Action300)
                {
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Sales Prepayment Percentages";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Action83)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action(Action163)
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
            }
            group("Assembly/Production")
            {
                Caption = 'Assembly/Production';
                Image = Production;

                action(Structure)
                {
                    Caption = 'Structure';
                    Image = Hierarchy;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BOMStructure: Page "BOM Structure";
                    begin
                        BOMStructure.InitItem(Rec);
                        BOMStructure.Run;
                    end;
                }
                action("Cost Shares")
                {
                    Caption = 'Cost Shares';
                    Image = CostBudget;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BOMCostShares: Page "BOM Cost Shares";
                    begin
                        BOMCostShares.InitItem(Rec);
                        BOMCostShares.Run;
                    end;
                }
                group("Assemb&ly")
                {
                    Caption = 'Assemb&ly';
                    Image = AssemblyBOM;

                    action(AssemblyBOM)
                    {
                        Caption = 'Assembly BOM';
                        Image = BOM;
                        RunObject = Page "Assembly BOM";
                        RunPageLink = "Parent Item No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Where-Used")
                    {
                        Caption = 'Where-Used';
                        Image = Track;
                        RunObject = Page "Where-Used List";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        RunPageView = SORTING(Type, "No.");
                        ApplicationArea = All;
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Clear(CalculateStdCost);
                            CalculateStdCost.CalcItem(Rec."No.", true);
                        end;
                    }
                    action("Calc. Unit Price")
                    {
                        Caption = 'Calc. Unit Price';
                        Image = SuggestItemPrice;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Clear(CalculateStdCost);
                            CalculateStdCost.CalcAssemblyItemPrice(Rec."No.")
                        end;
                    }
                }
                group(Production)
                {
                    Caption = 'Production';
                    Image = Production;

                    action("Production BOM")
                    {
                        Caption = 'Production BOM';
                        Image = BOM;
                        RunObject = Page "Production BOM";
                        RunPageLink = "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action(Action78)
                    {
                        Caption = 'Where-Used';
                        Image = "Where-Used";
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
                        begin
                            ProdBOMWhereUsed.SetItem(Rec, WorkDate);
                            ProdBOMWhereUsed.RunModal;
                        end;
                    }
                    action(Action5)
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Clear(CalculateStdCost);
                            CalculateStdCost.CalcItem(Rec."No.", false);
                        end;
                    }
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;

                action("&Bin Contents")
                {
                    Caption = '&Bin Contents';
                    Image = BinContent;
                    RunObject = Page "Bin Content";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("Stockkeepin&g Units")
                {
                    Caption = 'Stockkeepin&g Units';
                    Image = SKU;
                    RunObject = Page "Stockkeeping Unit List";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
            }
            group(Service)
            {
                Caption = 'Service';
                Image = ServiceItem;

                action("Ser&vice Items")
                {
                    Caption = 'Ser&vice Items';
                    Image = ServiceItem;
                    RunObject = Page "Service Items";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Troubleshooting)
                {
                    Caption = 'Troubleshooting';
                    Image = Troubleshoot;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TroubleshootingHeader: Record "Troubleshooting Header";
                    begin
                        TroubleshootingHeader.ShowForItem(Rec);
                    end;
                }
                action("Troubleshooting Setup")
                {
                    Caption = 'Troubleshooting Setup';
                    Image = Troubleshoot;
                    RunObject = Page "Troubleshooting Setup";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group(Resources)
            {
                Caption = 'Resources';
                Image = Resource;

                group("R&esource")
                {
                    Caption = 'R&esource';
                    Image = Resource;

                    action("Resource Skills")
                    {
                        Caption = 'Resource Skills';
                        Image = ResourceSkills;
                        RunObject = Page "Resource Skills";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Skilled Resources")
                    {
                        Caption = 'Skilled Resources';
                        Image = ResourceSkills;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ResourceSkill: Record "Resource Skill";
                        begin
                            Clear(SkilledResourceList);
                            SkilledResourceList.Initialize(ResourceSkill.Type::Item, Rec."No.", Rec.Description);
                            SkilledResourceList.RunModal;
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("&Create Stockkeeping Unit")
                {
                    Caption = '&Create Stockkeeping Unit';
                    Image = CreateSKU;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Item: Record Item;
                    begin
                        Item.SetRange("No.", Rec."No.");
                        REPORT.RunModal(REPORT::"Create Stockkeeping Unit", true, false, Item);
                    end;
                }
                action("C&alculate Counting Period")
                {
                    Caption = 'C&alculate Counting Period';
                    Image = CalculateCalendar;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PhysInvtCountMgt: Codeunit "Phys. Invt. Count.-Management";
                    begin
                        PhysInvtCountMgt.UpdateItemPhysInvtCount(Rec);
                    end;
                }
                separator(Action241)
                {
                }
                action("Apply Template")
                {
                    Caption = 'Apply Template';
                    Ellipsis = true;
                    Image = ApplyTemplate;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ConfigTemplateMgt: Codeunit "Config. Template Management";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        ConfigTemplateMgt.UpdateFromTemplateSelection(RecRef);
                    end;
                }
            }
            action("Requisition Worksheet")
            {
                Caption = 'Requisition Worksheet';
                Image = Worksheet;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Req. Worksheet";
                ApplicationArea = All;
            }
            action("Item Journal")
            {
                Caption = 'Item Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Journal";
                ApplicationArea = All;
            }
            action("Item Reclassification Journal")
            {
                Caption = 'Item Reclassification Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Reclass. Journal";
                ApplicationArea = All;
            }
            action("Item Tracing")
            {
                Caption = 'Item Tracing';
                Image = ItemTracing;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Tracing";
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            action("Item Turnover")
            {
                Caption = 'Item Turnover';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item Turnover";
                ApplicationArea = All;
            }
            action("Item Transaction Detail")
            {
                Caption = 'Item Transaction Detail';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Item Transaction Detail";
                ApplicationArea = All;
            }
            action("Serial Number Status/Aging")
            {
                Caption = 'Serial Number Status/Aging';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Top __ Inventory Items";
                ApplicationArea = All;
            }
            action("Issue History")
            {
                Caption = 'Issue History';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Issue History";
                ApplicationArea = All;
            }
            action("Costed Bill of Materials")
            {
                Caption = 'Costed Bill of Materials';
                Image = "Report";
                Promoted = false;
                ApplicationArea = All;
                // RunObject = report 10171;//Commented UPG issue 
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
            }
            action("Item Sales by Customer")
            {
                Caption = 'Item Sales by Customer';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item Sales by Customer";
                ApplicationArea = All;
            }
            action("Picking List by Item")
            {
                Caption = 'Picking List by Item';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Picking List by Item";
                ApplicationArea = All;
            }
            action("Sales Order Status")
            {
                Caption = 'Sales Order Status';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Order Status";
                ApplicationArea = All;
            }
            action("Serial Number Sold History")
            {
                Caption = 'Serial Number Sold History';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Serial Number Sold History";
                ApplicationArea = All;
            }
            action("Vendor Purchases by Item")
            {
                Caption = 'Vendor Purchases by Item';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Vendor Purchases by Item";
                ApplicationArea = All;
            }
            action("Item/Vendor Catalog")
            {
                Caption = 'Item/Vendor Catalog';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item/Vendor Catalog";
                ApplicationArea = All;
            }
            action("Purchase Order Status")
            {
                Caption = 'Purchase Order Status';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Purchase Order Status";
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        EnablePlanningControls;
        EnableCostingControls;
        //ZD7.0
        /*         IF GUIALLOWED THEN BEGIN ZdRecRef.GETTABLE(Rec); IF ZdRecRef.GET(ZdRecRef.RECORDID)  AND (ZdRecRef.RECORDID <> ZdPrevRecID) THEN BEGIN ZdPrevRecID := ZdRecRef.RECORDID; CurrPage.Zetadocs.PAGE.SetRecordID(ZdRecRef.RECORDID); CurrPage.
            Zetadocs.PAGE.ACTIVATE(TRUE); END; END;
                     //ZD7.0
                     */
    end;

    trigger OnInit()
    begin
        UnitCostEnable := true;
        StandardCostEnable := true;
        OverflowLevelEnable := true;
        DampenerQtyEnable := true;
        DampenerPeriodEnable := true;
        LotAccumulationPeriodEnable := true;
        ReschedulingPeriodEnable := true;
        IncludeInventoryEnable := true;
        OrderMultipleEnable := true;
        MaximumOrderQtyEnable := true;
        MinimumOrderQtyEnable := true;
        MaximumInventoryEnable := true;
        ReorderQtyEnable := true;
        ReorderPointEnable := true;
        SafetyStockQtyEnable := true;
        SafetyLeadTimeEnable := true;
        TimeBucketEnable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        EnablePlanningControls;
        EnableCostingControls;
    end;

    var
        ZdPrevRecID: RecordID;
        ZdRecRef: RecordRef;
        SkilledResourceList: Page "Skilled Resource List";
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        [InDataSet]
        TimeBucketEnable: Boolean;
        [InDataSet]
        SafetyLeadTimeEnable: Boolean;
        [InDataSet]
        SafetyStockQtyEnable: Boolean;
        [InDataSet]
        ReorderPointEnable: Boolean;
        [InDataSet]
        ReorderQtyEnable: Boolean;
        [InDataSet]
        MaximumInventoryEnable: Boolean;
        [InDataSet]
        MinimumOrderQtyEnable: Boolean;
        [InDataSet]
        MaximumOrderQtyEnable: Boolean;
        [InDataSet]
        OrderMultipleEnable: Boolean;
        [InDataSet]
        IncludeInventoryEnable: Boolean;
        [InDataSet]
        ReschedulingPeriodEnable: Boolean;
        [InDataSet]
        LotAccumulationPeriodEnable: Boolean;
        [InDataSet]
        DampenerPeriodEnable: Boolean;
        [InDataSet]
        DampenerQtyEnable: Boolean;
        [InDataSet]
        OverflowLevelEnable: Boolean;
        [InDataSet]
        StandardCostEnable: Boolean;
        [InDataSet]
        UnitCostEnable: Boolean;

    procedure EnablePlanningControls()
    var
        PlanningGetParam: Codeunit "Planning-Get Parameters";
        TimeBucketEnabled: Boolean;
        SafetyLeadTimeEnabled: Boolean;
        SafetyStockQtyEnabled: Boolean;
        ReorderPointEnabled: Boolean;
        ReorderQtyEnabled: Boolean;
        MaximumInventoryEnabled: Boolean;
        MinimumOrderQtyEnabled: Boolean;
        MaximumOrderQtyEnabled: Boolean;
        OrderMultipleEnabled: Boolean;
        IncludeInventoryEnabled: Boolean;
        ReschedulingPeriodEnabled: Boolean;
        LotAccumulationPeriodEnabled: Boolean;
        DampenerPeriodEnabled: Boolean;
        DampenerQtyEnabled: Boolean;
        OverflowLevelEnabled: Boolean;
        PlanningParameters: Record "Planning Parameters";
    begin
        //PlanningGetParam.SetUpPlanningControls(Rec."Reordering Policy", Rec."Include Inventory", TimeBucketEnabled, SafetyLeadTimeEnabled, SafetyStockQtyEnabled, ReorderPointEnabled, ReorderQtyEnabled, MaximumInventoryEnabled, MinimumOrderQtyEnabled, MaximumOrderQtyEnabled, OrderMultipleEnabled, IncludeInventoryEnabled, ReschedulingPeriodEnabled, LotAccumulationPeriodEnabled, DampenerPeriodEnabled, DampenerQtyEnabled, OverflowLevelEnabled);
        PlanningGetParam.SetPlanningParameters(PlanningParameters);
        TimeBucketEnable := PlanningParameters."Time Bucket Enabled";
        SafetyLeadTimeEnable := PlanningParameters."Safety Lead Time Enabled";
        SafetyStockQtyEnable := PlanningParameters."Safety Stock Qty Enabled";
        ReorderPointEnable := PlanningParameters."Reorder Point Enabled";
        ReorderQtyEnable := PlanningParameters."Reorder Quantity Enabled";
        MaximumInventoryEnable := PlanningParameters."Maximum Inventory Enabled";
        MinimumOrderQtyEnable := PlanningParameters."Minimum Order Qty Enabled";
        MaximumOrderQtyEnable := PlanningParameters."Maximum Order Qty Enabled";
        OrderMultipleEnable := PlanningParameters."Order Multiple Enabled";
        IncludeInventoryEnable := PlanningParameters."Include Inventory Enabled";
        ReschedulingPeriodEnable := PlanningParameters."Rescheduling Period Enabled";
        LotAccumulationPeriodEnable := PlanningParameters."Lot Accum. Period Enabled";
        DampenerPeriodEnable := PlanningParameters."Dampener Period Enabled";
        DampenerQtyEnable := PlanningParameters."Dampener Quantity Enabled";
        OverflowLevelEnable := PlanningParameters."Overflow Level Enabled";
    end;

    procedure EnableCostingControls()
    begin
        StandardCostEnable := Rec."Costing Method" = Rec."Costing Method"::Standard;
        UnitCostEnable := Rec."Costing Method" <> Rec."Costing Method"::Standard;
    end;
}
