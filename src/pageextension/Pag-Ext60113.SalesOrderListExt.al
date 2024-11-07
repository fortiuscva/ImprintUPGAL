pageextension 60113 "SalesOrderListExt" extends "Sales Order List"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Sell-to County"; Rec."Sell-to County")
            {
                ApplicationArea = All;
            }
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Name")
        {
            field("Ship-to Address"; Rec."Ship-to Address")
            {
                ApplicationArea = All;
            }
            field("Ship-to City"; Rec."Ship-to City")
            {
                ApplicationArea = All;
            }
        }
        addafter("Requested Delivery Date")
        {
            field("Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst("&Print")
        {
            action("Proforma Invoice")
            {
                ApplicationArea = All;
                Caption = 'Proforma Invoice';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction();
                begin
                    SalesHeadGRec.Reset;
                    SalesHeadGRec.SetRange("Document Type", Rec."Document Type");
                    SalesHeadGRec.SetRange("No.", Rec."No.");
                    if SalesHeadGRec.FindFirst then;
                    REPORT.RunModal(REPORT::"Sales Order - Proforma Invoice", true, false, SalesHeadGRec);
                end;
            }
        }
    }
    var "-IMP1.01-": Integer;
    SalesHeadGRec: Record "Sales Header";
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
