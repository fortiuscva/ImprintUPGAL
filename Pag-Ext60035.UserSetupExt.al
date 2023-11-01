pageextension 60035 "UserSetupExt" extends "User Setup"
{
    layout
    {
        addafter("User ID")
        {
            field("Stat. Chart Salesperson Change"; Rec."Stat. Chart Salesperson Change")
            {
                ApplicationArea = All;
            }
            field("Sales Supervisor"; Rec."Sales Supervisor")
            {
                ApplicationArea = All;
            }
            field("Salesperson Filter"; Rec."Salesperson Filter")
            {
                ApplicationArea = All;
            }
        }
        addafter(Email)
        {
            field("Edit Accounts Payable Contacts"; Rec."Edit Accounts Payable Contacts")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
