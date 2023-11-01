pageextension 60093 "PostedServiceInvoiceSubformExt" extends "Posted Service Invoice Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("Service Item Line Description"; Rec."Service Item Line Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("Resource 1"; Rec."Resource 1")
            {
                ApplicationArea = All;
            }
            field("Resource 2"; Rec."Resource 2")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(ItemShipmentLines)
        {
            action(GetShipmentLines)
            {
                ApplicationArea = All;
                Caption = 'Get Shipment & Lines';
                Image = ShipmentLines;

                trigger OnAction();
                begin
                    //IMP1.02 Start
                    Clear(ServInvHeadRecGbl);
                    Clear(ServShptHeadReGbl);
                    if ServInvHeadRecGbl.Get(Rec."Document No.")then;
                    ServShptHeadReGbl.Reset;
                    ServShptHeadReGbl.SetRange("Order No.", ServInvHeadRecGbl."Order No.");
                    if ServShptHeadReGbl.FindFirst then begin
                        PAGE.RunModal(5974, ServShptHeadReGbl);
                    end;
                //IMP1.02 End
                end;
            }
        }
    }
    var "-IMP1.02-": Integer;
    ServShptHeadReGbl: Record "Service Shipment Header";
    ServInvHeadRecGbl: Record "Service Invoice Header";
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
