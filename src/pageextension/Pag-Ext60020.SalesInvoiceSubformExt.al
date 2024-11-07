pageextension 60020 "SalesInvoiceSubformExt" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Inv. Discount Amount")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Custom Transit Number")
        {
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean var
                    PurchHeader: Record 38;
                    PurchOrder: Page 50;
                begin
                    // ISS2.00 09.06.13 DFP ===========================================================================\
                    Rec.TESTFIELD("Purchase Order No.");
                    PurchHeader.SETRANGE("No.", Rec."Purchase Order No.");
                    PurchOrder.SETTABLEVIEW(PurchHeader);
                    //PurchOrder.EDITABLE := FALSE;
                    PurchOrder.RUN;
                // End ============================================================================================/
                end;
            }
        }
    }
//Unsupported feature: CodeModification on "ValidateAutoReserve(PROCEDURE 19032465)". Please convert manually.
//procedure ValidateAutoReserve();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;
      AutoReserve;
    end;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;
      AutoReserve();   // NA0001
    end;
    */
//end;
}
