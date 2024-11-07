pageextension 60056 "SalesJournalExt" extends "Sales Journal"
{
    layout
    {
        addafter("Salespers./Purch. Code")
        {
            field("Lead Source Code"; Rec."Lead Source Code")
            {
                ApplicationArea = All;
            }
        }
    }
//Unsupported feature: CodeModification on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
