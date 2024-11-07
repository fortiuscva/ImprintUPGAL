pageextension 60036 "PostedSalesShipmentExt" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Ship-to Contact")
        {
            field("E-Mail Address"; Rec."E-Mail Address")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Code")
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
            }
            field("CertCapture Exemption No."; Rec."CertCapture Exemption No.")
            {
                ApplicationArea = All;
            }
        }
        addlast(Shipping)
        {
            group("E-ship")
            {
                field("Third Party Shipping Acc. No."; rec."Third Party Shipping Acc. No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
