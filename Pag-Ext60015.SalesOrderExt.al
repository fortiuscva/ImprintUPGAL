pageextension 60015 "SalesOrderExt" extends "Sales Order"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Profit (LCY)"; Rec."Profit (LCY)")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Shipping and Billing")
        {
            group(Shipping)
            {
                CaptionML = ENU = 'Shipping', ESM = 'Envío', FRC = 'Livraison', ENC = 'Shipping';
                Visible = false;
            }
        }
        // addafter("Ship-to City")
        // {
        //     field("Ship-to County "; Rec."Ship-to County")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'State';
        //     }
        // }
        modify(Control297)
        {
            Visible = true;
        }
        //IMP1.15 >>
        modify("Sell-to Customer Name")
        {
            Editable = false;
        }
        modify("Sell-to Address")
        {
            Editable = false;
        }
        modify("Sell-to Address 2")
        {
            Editable = false;
        }
        modify("Sell-to County")
        {
            Editable = false;
        }
        modify("Sell-to City")
        {
            Editable = false;
        }
        modify("Sell-to Post Code")
        {
            Editable = false;
        }
        modify("Bill-to Name")
        {
            Editable = false;
        }
        modify("Bill-to Address")
        {
            Editable = false;
        }
        modify("Bill-to Address 2")
        {
            Editable = false;
        }
        modify("Bill-to County")
        {
            Editable = false;
        }
        modify("Bill-to City")
        {
            Editable = false;
        }
        modify("Bill-to Post Code")
        {
            Editable = false;
        }
        //IMP1.15 <<
        addafter("Shipping Agent Code")
        {
            field("Third Party Shipping Acc. No."; Rec."Third Party Shipping Acc. No.")
            {
                ApplicationArea = all;
            }
        }
        addlast("Invoice Details")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Shipping Advice")
        {
            field("Tax Exemption No."; Rec."Tax Exemption No.")
            {
                ApplicationArea = All;
            }
            field("Tax Exempt Categories"; Rec."Tax Exempt Categories")
            {
                ApplicationArea = All;
            }
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("CertCapture Exemption No."; Rec."CertCapture Exemption No.")
            {
                ApplicationArea = All;
            }
        }
        addbefore(Status)
        {
            field("On Hold"; Rec."On Hold")
            {
                ApplicationArea = All;
                Editable = false; //IMP1.15
            }
            field("Override Credit"; Rec."Override Credit")
            {
                ApplicationArea = All;
                Editable = false; //IMP1.15
            }
        }
        modify("External Document No.")
        {
            Caption = 'Customer PO No.';
        }
        moveafter(General; "Shipping and Billing")
        modify(Control90)
        {
            Visible = false;
        }
        addbefore("Shipment Method")
        {
            group(Control90Cust)
            {
                //Visible = false;
                ShowCaption = false;

                field(ShippingOptionsCust; ShipToOptionsCust)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ship-to';
                    OptionCaption = 'Alternate Shipping Address';
                    ToolTip = 'Specifies the address that the products on the sales document are shipped to. Default (Sell-to Address): The same as the customer''s sell-to address. Alternate Ship-to Address: One of the customer''s alternate ship-to addresses. Custom Address: Any ship-to address that you specify in the fields below.';

                    trigger OnValidate()
                    var
                        ShipToAddress: Record "Ship-to Address";
                        ShipToAddressList: Page "Ship-to Address List";
                        IsHandled: Boolean;
                    begin
                        /*                         IsHandled := false;
                                                OnBeforeValidateShipToOptionsCust(Rec, ShipToOptionsCust, IsHandled);
                                                if IsHandled then
                                                    exit; */
                        case ShipToOptionsCust of ShipToOptionsCust::"Default (Sell-to Address)": begin
                            Rec.Validate("Ship-to Code", '');
                            Rec.CopySellToAddressToShipToAddress;
                        end;
                        ShipToOptionsCust::"Alternate Shipping Address": begin
                            ShipToAddress.SetRange("Customer No.", rec."Sell-to Customer No.");
                            ShipToAddressList.LookupMode:=true;
                            ShipToAddressList.SetTableView(ShipToAddress);
                            if ShipToAddressList.RunModal = ACTION::LookupOK then begin
                                ShipToAddressList.GetRecord(ShipToAddress);
                                // OnValidateShipToOptionsCustOnAfterShipToAddressListGetRecord(ShipToAddress, Rec);
                                Rec.Validate("Ship-to Code", ShipToAddress.Code);
                                IsShipToCountyVisible:=FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                            end
                            else
                                ShipToOptionsCust:=ShipToOptionsCust::"Custom Address";
                        end;
                        ShipToOptionsCust::"Custom Address": begin
                            Rec.Validate("Ship-to Code", '');
                            IsShipToCountyVisible:=FormatAddress.UseCounty(rec."Ship-to Country/Region Code");
                        end;
                        end;
                    //OnAfterValidateShippingOptions(Rec, ShipToOptionsCust);
                    end;
                }
                group(Control4Cust)
                {
                    ShowCaption = false;
                    Visible = NOT(ShipToOptionsCust = ShipToOptionsCust::"Default (Sell-to Address)");

                    field("ShiptoCode"; Rec."Ship-to Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Code';
                        Editable = ShipToOptionsCust = ShipToOptionsCust::"Alternate Shipping Address";
                        Importance = Promoted;
                        ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';

                        trigger OnValidate()
                        var
                            ShipToAddress: Record "Ship-to Address";
                        begin
                            if(xRec."Ship-to Code" <> '') and (Rec."Ship-to Code" = '')then Error(EmptyShipToCodeErr);
                            if Rec."Ship-to Code" <> '' then begin
                                ShipToAddress.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code");
                                IsShipToCountyVisible:=FormatAddress.UseCounty(ShipToAddress."Country/Region Code");
                            end
                            else
                                IsShipToCountyVisible:=false;
                        end;
                    }
                    field("ShiptoName"; Rec."Ship-to Name")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Name';
                        Editable = ShipToOptionsCust = ShipToOptionsCust::"Custom Address";
                        ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                    }
                    field("ShiptoAddress"; Rec."Ship-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Editable = ShipToOptionsCust = ShipToOptionsCust::"Custom Address";
                        QuickEntry = false;
                        ToolTip = 'Specifies the address that products on the sales document will be shipped to.';
                    }
                    field("ShiptoAddress2"; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Editable = ShipToOptionsCust = ShipToOptionsCust::"Custom Address";
                        QuickEntry = false;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("ShiptoCity"; Rec."Ship-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Editable = ShipToOptionsCust = ShipToOptionsCust::"Custom Address";
                        QuickEntry = false;
                        ToolTip = 'Specifies the city of the customer on the sales document.';
                    }
                    group(Control297Cust)
                    {
                        ShowCaption = false;

                        //Visible = IsShipToCountyVisible;
                        field("ShiptoCounty"; Rec."Ship-to County")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'County';
                            Editable = ShipToOptionsCust = ShipToOptionsCust::"Custom Address";
                            QuickEntry = false;
                            ToolTip = 'Specifies the state, province or county of the address.';
                        }
                    }
                    field("ShiptoPostCode"; Rec."Ship-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Editable = ShipToOptionsCust = ShipToOptionsCust::"Custom Address";
                        QuickEntry = false;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("ShiptoCountry/RegionCode"; Rec."Ship-to Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Country/Region';
                        Editable = ShipToOptionsCust = ShipToOptionsCust::"Custom Address";
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the customer''s country/region.';

                        trigger OnValidate()
                        begin
                            IsShipToCountyVisible:=FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
                        end;
                    }
                    field("ShiptoUPSZone"; Rec."Ship-to UPS Zone")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'UPS Zone';
                        Editable = ShipToOptionsCust = ShipToOptionsCust::"Custom Address";
                        ToolTip = 'Specifies a UPS Zone code for this document if UPS is used for shipments.';
                    }
                }
                field("ShiptoContact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contact';
                    ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                }
            }
        }
    }
    actions
    {
        addafter(Action3)
        {
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

                    trigger OnAction();
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
                            //salesLine1."No.":=salesset."G/L Freight Account No.";//B2BUPG
                            //  salesLine1."Allow Qty Change":=TRUE;
                            salesLine1.Validate(salesLine1."No.");
                            salesLine1.Validate(Quantity, 1);
                            salesLine1."Unit Cost (LCY)":=shipcost;
                            salesLine1.Validate("Unit Cost (LCY)");
                            salesLine1."Unit Price":=shipprice;
                            salesLine1.Validate("Unit Price");
                            //GLAcc.GET(salesset."G/L Freight Account No.");//B2BUPG
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
        }
        addlast("F&unctions")
        {
            action("Create Purchase Orders")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                begin
                    //IMP1.04 STart
                    ReleaseSalesDoc.PerformManualRelease(Rec);
                    COMMIT;
                    //IMP1.04 End
                    // ISS2.00 09.06.13 DFP ===========================================================================\
                    CreatePurchOrders(FALSE);
                // End ============================================================================================/
                end;
            }
            action("Create Purchase Orders (Specify No.)")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // ISS2.00 09.06.13 DFP ===========================================================================\
                    CreatePurchOrders(TRUE);
                // End ============================================================================================/
                end;
            }
            action("Check Purchase Order Links")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // ISS2.00 12.05.13 DFP ===================================================\
                    Rec.RepairPurchLink(FALSE);
                // End ====================================================================/
                end;
            }
        }
    }
    procedure CreatePurchOrders(OverridePONo: Boolean)
    var
        POCreationMgt: Codeunit 50008;
    begin
        // ISS2.00 09.06.13 DFP ===========================================================================\
        CLEAR(POCreationMgt);
        POCreationMgt.CreatePurchOrders(Rec."No.", OverridePONo, FALSE);
    //DP
    //PurchResoCU.CreateDirectandSpecialPO(Rec);
    // End ============================================================================================/
    end;
    var tempshiprec: Record SHIPMENTS_ALL temporary;
    shipcost: Decimal;
    shipprice: Decimal;
    shipweight: Decimal;
    shipmentrec: Record SHIPMENTS_ALL;
    numberofcartoons: Integer;
    ptrack: Text[50];
    salesset: Record "Sales & Receivables Setup";
    salesLine1: Record "Sales Line";
    lineno: Integer;
    IsShipToCountyVisible: Boolean;
    FormatAddress: Codeunit "Format Address";
    EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';
    ShipToOptionsCust: Option "Alternate Shipping Address", "Default (Sell-to Address)", "Custom Address";
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
