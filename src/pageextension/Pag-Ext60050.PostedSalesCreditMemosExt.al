pageextension 60050 "PostedSalesCreditMemosExt" extends "Posted Sales Credit Memos"
{
    layout
    {
        addlast(Control1)
        {
            field("Campaign No."; Rec."Campaign No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = All;
            }
            field("Bill-to County"; Rec."Bill-to County")
            {
                ApplicationArea = All;
            }
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Currency Code")
        {
            field("Return Order No."; Rec."Return Order No.")
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
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
}
