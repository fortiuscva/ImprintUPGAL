pageextension 60002 "SalespersonsPurchasersExt" extends "Salespersons/Purchasers"
{
    actions
    {
        addafter(ShowLog)
        {
            separator(Action1000000000)
            {
            }
            action(SPCompInfo)
            {
                Caption = 'Salesperson Company Info';
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = Page "Salesperson Company Info";
                RunPageLink = "Salesperson Code"=FIELD(Code);
            }
        }
    }
}
