page 50018 "Enter Purchase Order No."
{
    PageType = Card;

    layout
    {
        area(content)
        {
            field(PurchOrderNo; PurchOrderNo)
            {
                ApplicationArea = All;
                Caption = 'Purchase Order No.';

                trigger OnValidate()
                begin
                    if PurchOrderNo = '' then exit;
                    if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchOrderNo) then // Purchase Order %1 already exists.
                        Error(Text001, PurchOrderNo);
                end;
            }
        }
    }
    actions
    {
    }
    var
        PurchaseHeader: Record "Purchase Header";
        PurchOrderNo: Code[20];
        Text001: Label 'Purchase Order %1 already exists.';

    procedure GetPONo(): Code[20]
    begin
        exit(PurchOrderNo);
    end;
}
