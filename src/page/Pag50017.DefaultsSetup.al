page 50017 "Defaults Setup"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Defaults Setup";

    layout
    {
        area(content)
        {
            group(Customer)
            {
                Caption = 'Customer';

                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                }
                field("C. Gen. Bus. Posting Group"; Rec."C. Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("C. VAT Bus. Posting Group"; Rec."C. VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
            }
            group(Vendor)
            {
                Caption = 'Vendor';

                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = All;
                }
                field("V. Gen. Bus. Posting Group"; Rec."V. Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("V. VAT Bus. Posting Group"; Rec."V. VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
            }
            group(Item)
            {
                Caption = 'Item';

                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Gr. (Price)"; Rec."VAT Bus. Posting Gr. (Price)")
                {
                    ApplicationArea = All;
                }
                field("Item Tax Group Code"; Rec."Item Tax Group Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Resource)
            {
                Caption = 'Resource';

                field("R. VAT Prod. Posting Group"; Rec."R. VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("R. Gen. Prod. Posting Group"; Rec."R. Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Resource Tax Group Code"; Rec."Resource Tax Group Code")
                {
                    ApplicationArea = All;
                }
            }
            group("Item Import")
            {
                Caption = 'Item Import';

                field("SN Item Tracking Code"; Rec."SN Item Tracking Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}
