page 50016 "test"
{
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
                /*
                    IF PurchOrderNo = '' THEN
                      EXIT;
                    
                    WITH PurchaseHeader DO BEGIN
                     IF GET(PurchOrderNo) THEN
                       // Purchase Order %1 already exists.
                       ERROR(Text001,PurchOrderNo);
                    END;
                    */
                end;
            }
        }
    }
    actions
    {
    }
    var PurchaseHeader: Record "Purchase Header";
    PurchOrderNo: Code[20];
    Text001: Label 'Purchase Order %1 already exists.';
    procedure GetPONo(): Code[20]begin
        exit(PurchOrderNo);
    end;
}
