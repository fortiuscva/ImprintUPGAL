pageextension 60065 "ResourcesSetupExt" extends "Resources Setup"
{
    layout
    {
        addbefore(Numbering)
        {
            group(General)
            {
                CaptionML = ENU = 'General', ESM = 'General', FRC = 'Général', ENC = 'General';

                field("Require Sales Purch. Doc. Link"; Rec."Require Sales Purch. Doc. Link")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
