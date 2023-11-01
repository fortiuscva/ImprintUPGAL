pageextension 60096 "SalesReturnOrderExt" extends "Sales Return Order"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("Purchaser Code"; Rec."Purchaser Code")
            {
                ApplicationArea = All;
            }
        }
        addlast("Shipping and Billing")
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
        //IMP1.17 >>
        addfirst("Ship-to")
        {
            field("Ship-to Code"; Rec."Ship-to Code")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Ship-to Contact"; "Location Code")
        moveafter(General; "Shipping and Billing")
        moveafter("Shipping and Billing"; SalesLines)
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
