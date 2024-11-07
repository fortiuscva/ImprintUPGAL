page 50056 "Sales Order- Credit Mgmt"
{
    // ISS2.00 03.02.14 DFP - Added field "Third Party Shipping Acc. No."
    // ISS2.00 01.24.14 DFP - Added Flowfield "Profit (LCY)"
    // ISS2.00 12.10.13 DFP - Made "Document Date" and "Order Date" invisible
    // ISS2.00 10.31.13 DFP - Added call to FilterSalesperson in OnOpenPage
    //                      - Added call to DefaultSalesperon in OnNewRecord
    // ISS2.00 09.06.13 DFP - Added Function button for Create Purchase Orders
    //                      - Added function CreatePurchOrders
    // 
    // //DP  Edit Menu on Functions Button
    //       Add global variable
    // 
    // IMP1.01,16-Nov-15,ST: Added new action button "Proforma Invoice".
    // IMP1.02,21-Jan-16,ST: Added new control Email Address to Shippping Tab.
    // IMP1.03,SP591,06/20/17,ST: Added fields "On Hold","Override Credit".
    Caption = 'Sales Order';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type"=FILTER(Order));

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
                        if Rec.AssistEdit(xRec)then CurrPage.Update;
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        if Rec.GetFilter("Sell-to Contact No.") = xRec."Sell-to Contact No." then if Rec."Sell-to Contact No." <> xRec."Sell-to Contact No." then Rec.SetRange("Sell-to Contact No.");
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    QuickEntry = false;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                    QuickEntry = false;
                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                    ApplicationArea = All;
                    Caption = 'Sell-to State / ZIP Code';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    QuickEntry = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    QuickEntry = false;
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    QuickEntry = false;
                    Visible = true;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    QuickEntry = false;

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Profit (LCY)"; Rec."Profit (LCY)")
                {
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;
                }
                field("Override Credit"; Rec."Override Credit")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    QuickEntry = false;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';

                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    Editable = false; //IMP1.10
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Editable = false; //IMP1.10
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Editable = false; //IMP1.10
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                    Editable = false; //IMP1.10
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to State / ZIP Code';
                    Editable = false; //IMP1.10
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Editable = false; //IMP1.10
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Ship-to UPS Zone"; Rec."Ship-to UPS Zone")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Third Party Shipping Acc. No."; Rec."Third Party Shipping Acc. No.")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        if Rec."Shipping Advice" <> xRec."Shipping Advice" then if not Confirm(Text001, false, Rec.FieldCaption("Shipping Advice"))then Error(Text002);
                    end;
                }
            }
            part(SalesLines; "Sales Order Subform")
            {
                SubPageLink = "Document No."=FIELD("No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';

                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to County"; Rec."Bill-to County")
                {
                    ApplicationArea = All;
                    Caption = 'State / ZIP Code';
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        Clear(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WorkDate);
                        if ChangeExchangeRate.RunModal = ACTION::OK then begin
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.Update;
                        end;
                        Clear(ChangeExchangeRate);
                    end;
                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900201301)
            {
                Caption = 'Prepayment';

                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Include Tax"; Rec."Prepmt. Include Tax")
                {
                    ApplicationArea = All;
                }
            }
            group("E-Ship")
            {
                Caption = 'E-Ship';

                field("<Shipping Agent Code2>"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
        }
        area(factboxes)
        {
            part(Control1903720907; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No."=FIELD("Sell-to Customer No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1902018507; "Customer Statistics FactBox")
            {
                SubPageLink = "No."=FIELD("Bill-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                SubPageLink = "No."=FIELD("Sell-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1906127307; "Sales Line FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "Document Type"=FIELD("Document Type"), "Document No."=FIELD("Document No."), "Line No."=FIELD("Line No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1901314507; "Item Invoicing FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No."=FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1906354007; "Approval FactBox")
            {
                SubPageLink = "Table ID"=CONST(36), "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1907012907; "Resource Details FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No."=FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1901796907; "Item Warehouse FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No."=FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1907234507; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No."=FIELD("Bill-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
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
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";

                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        Commit;
                        if Rec."Tax Area Code" = '' then PAGE.RunModal(PAGE::"Sales Order Statistics", Rec)
                        else
                            PAGE.RunModal(PAGE::"Sales Order Stats.", Rec)end;
                }
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No."=FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("A&pprovals")
                {
                    ApplicationArea = All;
                    Caption = 'A&pprovals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", Rec."Document Type", rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type"=FIELD("Document Type"), "No."=FIELD("No."), "Document Line No."=CONST(0);
                }
                action("Assembly Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Assembly Orders';
                    Image = AssemblyOrder;

                    trigger OnAction()
                    var
                        AssembleToOrderLink: Record "Assemble-to-Order Link";
                    begin
                        AssembleToOrderLink.ShowAsmOrders(Rec);
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;

                action("S&hipments")
                {
                    ApplicationArea = All;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No."=FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = All;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No."=FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;

                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document"=CONST("Sales Order"), "Source No."=FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                action("Whse. Shipment Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Whse. Shipment Lines';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type"=CONST(37), "Source Subtype"=FIELD("Document Type"), "Source No."=FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Image = Prepayment;

                action("Prepa&yment Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No."=FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No."=FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
            }
        }
        area(processing)
        {
            action("Save and Send")
            {
                ApplicationArea = All;
                Caption = 'Save and Send';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Save document to the archive and/or Send it via Outlook';

                trigger OnAction()
                begin
                // CurrPage.Zetadocs.PAGE.SaveAndSend(10075);
                end;
            }
            group(Action21)
            {
                Caption = 'Release';
                Image = ReleaseDoc;

                action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Create Purchase Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Create Purchase Orders';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // ISS2.00 09.06.13 DFP ===========================================================================\
                        CreatePurchOrders(false);
                    // End ============================================================================================/
                    end;
                }
                action("Create Purchase Orders (Specify No.)")
                {
                    ApplicationArea = All;
                    Caption = 'Create Purchase Orders (Specify No.)';
                    Visible = true;

                    trigger OnAction()
                    begin
                        // ISS2.00 09.06.13 DFP ===========================================================================\
                        CreatePurchOrders(true);
                    // End ============================================================================================/
                    end;
                }
                action("Check Purchase Order Links")
                {
                    ApplicationArea = All;
                    Caption = 'Check Purchase Order Links';

                    trigger OnAction()
                    begin
                    // ISS2.00 12.05.13 DFP ===================================================\
                    //RepairPurchLink(FALSE);
                    // End ====================================================================/
                    end;
                }
                action("Calculate &Invoice Discount")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Image = CustomerCode;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                action("Update Profit ($)")
                {
                    ApplicationArea = All;
                    Caption = 'Update Profit ($)';
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        // ISS2.00 01.24.14 DFP ====================================================\
                        Rec.CalcFields("Profit (LCY)");
                    // End =====================================================================/
                    end;
                }
                group("<Action1100768008>")
                {
                    Caption = 'Purchasing';
                    Visible = false;

                    action("Create this Sales Order's POs")
                    {
                        ApplicationArea = All;
                        Caption = 'Create this Sales Order''s POs';
                        Visible = false;

                        trigger OnAction()
                        begin
                        //DP
                        //PurchResoCU.CreateDirectandSpecialPO(Rec);
                        end;
                    }
                }
                separator(Action1100768001)
                {
                }
                action(CopyDocument)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RunModal;
                        Clear(CopySalesDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        Clear(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RunModal;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = All;
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.Update(false);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    ApplicationArea = All;
                    Caption = 'Send IC Sales Order Cnfmn.';
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        PurchaseHeader: Record "Purchase Header";
                    begin
                    /*IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                          ICInOutboxMgt.SendSalesDoc(Rec,FALSE);
                          */
                    end;
                }
            }
            group(Plan)
            {
                Caption = 'Plan';
                Image = Planning;

                action("Order &Promising")
                {
                    ApplicationArea = All;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SetRange("Source Type", Rec."Document Type");
                        OrderPromisingLine.SetRange("Source ID", Rec."No.");
                        PAGE.RunModal(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Demand Overview")
                {
                    ApplicationArea = All;
                    Caption = 'Demand Overview';
                    Image = Forecast;

                    trigger OnAction()
                    var
                        DemandOverview: Page "Demand Overview";
                    begin
                        DemandOverview.SetCalculationParameter(true);
                        DemandOverview.Initialize(0D, 1, Rec."No.", '', '');
                        DemandOverview.RunModal;
                    end;
                }
                action("Pla&nning")
                {
                    ApplicationArea = All;
                    Caption = 'Pla&nning';
                    Image = Planning;

                    trigger OnAction()
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder(Rec."No.");
                        SalesPlanForm.RunModal;
                    end;
                }
            }
            group(Request)
            {
                Caption = 'Request';
                Image = SendApprovalRequest;

                action("Send A&pproval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    begin
                    //IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;

                    trigger OnAction()
                    begin
                    //IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                group(Authorize)
                {
                    Caption = 'Authorize';
                    Image = AuthorizeCreditCard;

                    action(Action256)
                    {
                        ApplicationArea = All;
                        Caption = 'Authorize';
                        Image = AuthorizeCreditCard;

                        trigger OnAction()
                        begin
                        //Authorize;
                        end;
                    }
                    action("Void A&uthorize")
                    {
                        ApplicationArea = All;
                        Caption = 'Void A&uthorize';
                        Image = VoidCreditCard;

                        trigger OnAction()
                        begin
                        //Void;
                        end;
                    }
                }
            }
            group(Action3)
            {
                Caption = 'Warehouse';
                Image = Warehouse;

                action("Create Inventor&y Put-away / Pick")
                {
                    ApplicationArea = All;
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;
                        if not Rec.Find('=><')then Rec.Init;
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    ApplicationArea = All;
                    Caption = 'Create &Whse. Shipment';
                    Image = NewShipment;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);
                        if not Rec.Find('=><')then Rec.Init;
                    end;
                }
            }
            group(Shipments)
            {
                action("View Shipments")
                {
                    ApplicationArea = All;
                    RunObject = Page "Tracking Shipments";
                    RunPageLink = "Sales Order Number"=FIELD("No.");
                }
                action("Calculate Shipping Cost")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        CostInt: Decimal;
                        PriceInt: Decimal;
                        GLAcc: Record "G/L Account";
                    begin
                        tempshiprec.DeleteAll;
                        shipcost:=0;
                        shipprice:=0;
                        CostInt:=0;
                        PriceInt:=0;
                        shipweight:=0;
                        shipmentrec.Reset;
                        shipmentrec.SetRange(shipmentrec."Sales Order Number", Rec."No.");
                        shipmentrec.SetRange(Processed, false);
                        if shipmentrec.Find('-')then repeat if(shipmentrec.Void = '') or (shipmentrec.Void = 'N')then begin
                                    //   shipcost+=shipmentrec."Shipping Cost";
                                    //   shipprice+=shipmentrec."Shipping Price";
                                    Evaluate(CostInt, shipmentrec.UPS_ShipCost);
                                    Evaluate(PriceInt, shipmentrec.UPS_ShipPrice);
                                    shipcost+=CostInt;
                                    shipprice+=PriceInt;
                                    // shipcost += shipmentrec.UPS_ShipCost;      //Update to use more specific costs.
                                    // shipprice += shipmentrec.UPS_ShipPrice;
                                    numberofcartoons+=1;
                                    shipweight+=shipmentrec.Weight;
                                    ptrack:=shipmentrec."Tracking Number";
                                end;
                                tempshiprec.TransferFields(shipmentrec);
                                tempshiprec.Insert;
                            until shipmentrec.Next = 0;
                        if shipprice > 0 then begin
                            salesset.Get;
                            salesLine1.Reset;
                            salesLine1.SetRange("Document Type", Rec."Document Type");
                            salesLine1.SetRange("Document No.", Rec."No.");
                            if salesLine1.Find('+')then lineno:=salesLine1."Line No.";
                            salesLine1.Reset;
                            Clear(salesLine1);
                            salesLine1."Document Type":=salesLine1."Document Type"::Order;
                            salesLine1."Document No.":=Rec."No.";
                            salesLine1."Line No.":=lineno + 10000;
                            salesLine1.Insert(true);
                            salesLine1.Type:=salesLine1.Type::"G/L Account";
                            //salesLine1."No.":=salesset."G/L Freight Account No.";
                            //  salesLine1."Allow Qty Change":=TRUE;
                            salesLine1.Validate(salesLine1."No.");
                            salesLine1.Validate(Quantity, 1);
                            salesLine1."Unit Cost (LCY)":=shipcost;
                            salesLine1.Validate("Unit Cost (LCY)");
                            salesLine1."Unit Price":=shipprice;
                            salesLine1.Validate("Unit Price");
                            //GLAcc.GET(salesset."G/L Freight Account No.");
                            salesLine1.Validate("Tax Group Code", GLAcc."Tax Group Code");
                            salesLine1.Modify;
                            tempshiprec.Reset;
                            if tempshiprec.Find('-')then repeat shipmentrec.Get(tempshiprec."Sales Order Number", tempshiprec."Tracking Number", tempshiprec.Void);
                                    shipmentrec.Processed:=true;
                                    shipmentrec.Modify;
                                until tempshiprec.Next = 0;
                        end;
                        Rec."Package Tracking No.":=ptrack;
                        Rec.Modify;
                        CurrPage.Update(false);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;

                action(Post_)
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = All;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RunModal(REPORT::"Batch Post Sales Orders", true, true, Rec);
                        CurrPage.Update(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;

                    action("Prepayment &Test Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Prepayment &Test Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        ApplicationArea = All;
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                        /*IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                              SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec,FALSE);
                              */
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        ApplicationArea = All;
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                        /*IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                              SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec,TRUE);
                              */
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        ApplicationArea = All;
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        ApplicationArea = All;
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record "Purchase Header";
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                        end;
                    }
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;

                action("Order Confirmation")
                {
                    ApplicationArea = All;
                    Caption = 'Order Confirmation';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
                action("Work Order")
                {
                    ApplicationArea = All;
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                action("Pick Instruction")
                {
                    ApplicationArea = All;
                    Caption = 'Pick Instruction';
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Pick Instruction");
                    end;
                }
                action("Proforma Invoice")
                {
                    ApplicationArea = All;
                    Caption = 'Proforma Invoice';
                    Image = Print;
                    Promoted = false;

                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    trigger OnAction()
                    begin
                        SalesHeadGRec.Reset;
                        SalesHeadGRec.SetRange("Document Type", Rec."Document Type");
                        SalesHeadGRec.SetRange("No.", Rec."No.");
                        if SalesHeadGRec.FindFirst then;
                    //REPORT.RUNMODAL(REPORT::"Sales Order - Proforma Invoice",TRUE,FALSE,SalesHeadGRec);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Drop Shipment Status")
            {
                ApplicationArea = All;
                Caption = 'Drop Shipment Status';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Drop Shipment Status";
            }
            action("Picking List by Order")
            {
                ApplicationArea = All;
                Caption = 'Picking List by Order';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Picking List by Order";
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        JobQueueVisible:=Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
    //BEGIN ZdRecRef.GETTABLE(Rec); IF ZdRecRef.GET(ZdRecRef.RECORDID) THEN BEGIN CurrPage.Zetadocs.PAGE.SetRecordID(ZdRecRef.RECORDID); CurrPage.Zetadocs.PAGE.ACTIVATE(TRUE); END; END;
    end;
    trigger OnDeleteRecord(): Boolean begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.CheckCreditMaxBeforeInsert;
        Rec."On Hold":='.'; //IMP1.15
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center":=UserMgt.GetSalesFilter;
    // ISS2.00 DFP =========================================================\
    //DefaultSalesperson(FALSE);
    // End =================================================================/
    end;
    trigger OnOpenPage()
    begin
        if UserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;
        Rec.SetRange("Date Filter", 0D, WorkDate - 1);
    // ISS2.00 DFP =========================================================\
    //FilterSalesperson;
    // End =================================================================/
    end;
    var ZdRecRef: RecordRef;
    Text000: Label 'Unable to execute this function while in view only mode.';
    CopySalesDoc: Report "Copy Sales Document";
    MoveNegSalesLines: Report "Move Negative Sales Lines";
    ReportPrint: Codeunit "Test Report-Print";
    DocPrint: Codeunit "Document-Print";
    ArchiveManagement: Codeunit ArchiveManagement;
    ChangeExchangeRate: Page "Change Exchange Rate";
    UserMgt: Codeunit "User Setup Management";
    Usage: Option "Order Confirmation", "Work Order", "Pick Instruction";
    [InDataSet]
    JobQueueVisible: Boolean;
    Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
    Text002: Label 'The update has been interrupted to respect the warning.';
    SalesLine: Record "Sales Line";
    Text14000701: Label 'Sales Order %1 added to Bill of Lading %2.';
    Text14000702: Label 'Information is OK';
    "--DP--": Integer;
    "-IMP1.01-": Integer;
    SalesHeadGRec: Record "Sales Header";
    shipmentrec: Record SHIPMENTS_ALL;
    tempshiprec: Record SHIPMENTS_ALL temporary;
    shipcost: Decimal;
    shipprice: Decimal;
    shipweight: Decimal;
    numberofcartoons: Integer;
    ptrack: Text[50];
    salesset: Record "Sales & Receivables Setup";
    salesLine1: Record "Sales Line";
    lineno: Integer;
    local procedure Post(PostingCodeunitID: Integer)
    begin
        Rec.SendToPosting(PostingCodeunitID);
        if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then CurrPage.Close;
        CurrPage.Update(false);
    end;
    procedure UpdateAllowed(): Boolean begin
        if CurrPage.Editable = false then Error(Text000);
        exit(true);
    end;
    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;
    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        if Rec.GetFilter("Sell-to Customer No.") = xRec."Sell-to Customer No." then if Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." then Rec.SetRange("Sell-to Customer No.");
        CurrPage.Update;
    end;
    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
    end;
    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.Update;
    end;
    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
    end;
    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
    end;
    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
    end;
    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.Update;
    end;
    procedure CreatePurchOrders(OverridePONo: Boolean)
    var
        POCreationMgt: Codeunit "Purch. Order Creation Mgt.";
    begin
        // ISS2.00 09.06.13 DFP ===========================================================================\
        Clear(POCreationMgt);
        POCreationMgt.CreatePurchOrders(Rec."No.", OverridePONo, false);
    //DP
    //PurchResoCU.CreateDirectandSpecialPO(Rec);
    // End ============================================================================================/
    end;
}
