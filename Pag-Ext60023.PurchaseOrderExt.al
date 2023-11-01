pageextension 60023 "PurchaseOrderExt" extends "Purchase Order"
{
    layout
    {
        addafter("Ship-to Code")
        {
            field("Third Party Shipping Acc. No."; Rec."Third Party Shipping Acc. No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Quote No.")
        {
            field("Customer PO No."; Rec."Customer PO No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer PO No. field.';
            }
        }
        moveafter(General; "Shipping and Payment")
    }
    actions
    {
        addafter("&Print")
        {
            action("Print Drop / Non Drop Order")
            {
                ApplicationArea = All;
                Caption = 'Print Drop / Non Drop Order';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;

                trigger OnAction()
                var
                    DocumentSendingProfile: Record "Document Sending Profile";
                    DummyReportSelections: Record "Report Selections";
                    PurchOrder: Record "Purchase Header";
                begin
                    DummyReportSelections.Reset();
                    DummyReportSelections.SetRange(Usage, DummyReportSelections.Usage::"P.Order");
                    if DummyReportSelections.FindFirst()then;
                    PurchOrder.Reset();
                    PurchOrder.SetRange("Document Type", Rec."Document Type");
                    PurchOrder.SetRange("No.", Rec."No.");
                    if PurchOrder.FindFirst()then;
                    DocumentSendingProfile.TrySendToPrinterVendor(DummyReportSelections.Usage::"P.Order".AsInteger(), PurchOrder, Rec.FieldNo("Buy-from Vendor No."), true);
                end;
            }
        }
    }
}
