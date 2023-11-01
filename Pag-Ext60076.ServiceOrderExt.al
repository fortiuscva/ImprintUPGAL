pageextension 60076 "ServiceOrderExt" extends "Service Order"
{
    layout
    {
        //Unsupported feature: Change Level on "Control49(Control 49)". Please convert manually.
        //Unsupported feature: Change Level on ""Ship-to Country/Region Code"(Control 43)". Please convert manually.
        addafter("Release Status")
        {
            field("Customer PO No."; Rec."Customer PO No.")
            {
                ApplicationArea = All;
            }
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;
            }
            field("Customer Payment Terms Code"; Rec."Customer Payment Terms Code")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Resource 1"; Rec."Resource 1")
            {
                ApplicationArea = All;
            }
            field("Resource 2"; Rec."Resource 2")
            {
                ApplicationArea = All;
            }
        }
        addlast(Shipping)
        {
            field("Tax Exemption No."; Rec."Tax Exemption No.")
            {
                ApplicationArea = All;
            }
            field("Tax Exempt Categories"; Rec."Tax Exempt Categories")
            {
                ApplicationArea = All;
            }
            field("Expiration Date"; Rec."Expiration Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("CertCapture Exemption No."; Rec."CertCapture Exemption No.")
            {
                ApplicationArea = All;
            }
        }
        moveafter(General; Shipping)
        modify("Response Date")
        {
            Editable = true;
        }
        modify("Response Time")
        {
            Editable = true;
        }
        modify(Priority)
        {
            Editable = true;
        }
    }
    actions
    {
        addafter("&Print")
        {
            action(PrintTicket)
            {
                ApplicationArea = All;
                CaptionML = ENU = '&Print Ticket', ESM = '&Imprimir', FRC = '&Imprimer', ENC = '&Print';
                Image = Print;

                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                trigger OnAction();
                var
                    DocPrint: Codeunit "Document-Print";
                begin
                    //IMP1.02 Start
                    ServiceHeader.Reset;
                    ServiceHeader.SetRange("No.", Rec."No.");
                    REPORT.RunModal(REPORT::"Service Ticket", true, false, ServiceHeader);
                //IMP1.02 End
                end;
            }
        }
    }
    var "-IMP1.02-": Integer;
    ServiceHeader: Record "Service Header";
}
