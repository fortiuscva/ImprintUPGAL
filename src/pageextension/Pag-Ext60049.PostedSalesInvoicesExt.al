pageextension 60049 "PostedSalesInvoicesExt" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Due Date")
        {
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = All;
            }
            field("Tax Area Code"; Rec."Tax Area Code")
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
    }
}
