pageextension 60092 "PostedServiceInvoiceExt" extends "Posted Service Invoice"
{
    layout
    {
        addafter("Document Date")
        {
            field("Service Date"; Rec."Service Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("No. Printed")
        {
            field("Customer PO No."; Rec."Customer PO No.")
            {
                ApplicationArea = All;
            }
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;
            }
            field("Customer Payment Terms Code"; Rec."Customer Payment Terms Code")
            {
                ApplicationArea = All;
            }
            field("Resource 1"; Rec."Resource 1")
            {
                ApplicationArea = All;
            }
            field("Resource 2"; Rec."Resource 2")
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
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
