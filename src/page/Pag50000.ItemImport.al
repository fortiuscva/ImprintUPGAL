page 50000 "Item Import"
{
    Editable = false;
    PageType = Document;
    SourceTable = "Item Import Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Item Import Source Code"; Rec."Item Import Source Code")
                {
                    ApplicationArea = All;
                }
                field("Pricing Update Date"; Rec."Pricing Update Date")
                {
                    ApplicationArea = All;
                }
                field("Description Lock"; Rec."Description Lock")
                {
                    ApplicationArea = All;
                }
                field("Log Type"; Rec."Log Type")
                {
                    ApplicationArea = All;
                }
                field("Import Date"; Rec."Import Date")
                {
                    ApplicationArea = All;
                }
                field("Import Time"; Rec."Import Time")
                {
                    ApplicationArea = All;
                }
                field("Import User ID"; Rec."Import User ID")
                {
                    ApplicationArea = All;
                }
            }
            part(ItemImportLines; "Item Import Subform")
            {
                SubPageLink = "Document No."=FIELD("No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
