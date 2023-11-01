pageextension 60038 "PostedSalesInvoiceExt" extends "Posted Sales Invoice"
{
    layout
    {
        //Unsupported feature: Change Level on ""Shipping Agent Code"(Control 79)". Please convert manually.
        addafter("Salesperson Code")
        {
            field("User ID"; rec."User ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("No. Printed")
        {
            field("Posting Description"; rec."Posting Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipping Details")
        {
            field("Tax Exemption No."; Rec."Tax Exemption No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Tax Exempt Categories"; rec."Tax Exempt Categories")
            {
                ApplicationArea = All;
            }
            field("CertCapture Exemption No."; rec."CertCapture Exemption No.")
            {
                ApplicationArea = All;
            }
            field("Expiration Date"; rec."Expiration Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(ShowLog)
        {
            group(Shipments)
            {
                action("View Shipments")
                {
                    ApplicationArea = All;
                    RunObject = Page "Posted Tracking Shipments";
                    RunPageLink = "Sales Order Number"=FIELD("Order No.");
                }
                action("Update Ship to Code")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = UpdateUnitCost;

                    trigger OnAction()
                    var
                        Upgrade: Codeunit UpdateCode;
                    begin
                        Upgrade.UpdateSalesInvLineShipToCode();
                    end;
                }
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
