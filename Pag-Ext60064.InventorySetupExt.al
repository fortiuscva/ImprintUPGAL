pageextension 60064 "InventorySetupExt" extends "Inventory Setup"
{
    layout
    {
        addfirst(Location)
        {
            field("Default Location Code"; Rec."Default Location Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Numbering)
        {
            group("Item Imports")
            {
                Caption = 'Item Imports';

                field("Item Import Nos."; Rec."Item Import Nos.")
                {
                    ApplicationArea = All;
                }
                field("Item Import Log Type"; Rec."Item Import Log Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
