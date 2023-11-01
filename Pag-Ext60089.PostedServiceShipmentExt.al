pageextension 60089 "PostedServiceShipmentExt" extends "Posted Service Shipment"
{
    layout
    {
        addafter("No. Printed")
        {
            field("Resource 1"; Rec."Resource 1")
            {
                ApplicationArea = All;
            }
            field("Resource 2"; Rec."Resource 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Your Reference")
        {
            field("Posting Description"; Rec."Posting Description")
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
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
