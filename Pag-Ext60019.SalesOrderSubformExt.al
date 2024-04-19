pageextension 60019 "SalesOrderSubformExt" extends "Sales Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Profit (LCY)"; Rec."Profit (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Profit ($) field.';
                Editable = false;
            }
        }
        //Unsupported feature: Change Visible on ""Bin Code"(Control 114)". Please convert manually.
        addafter("Unit Price")
        {
            field("Last Direct Cost"; Rec."Last Direct Cost")
            {
                ApplicationArea = All;
            }
        }
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

                trigger OnDrillDown()
                var
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
                /*
                    trigger OnLookup(var Text: Text): Boolean

                    var
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
                    */
            }
        }
        addafter("Last Direct Cost")
        {
            field("Profit %"; Rec."Profit %")
            {
                ApplicationArea = All;
            }
        }
        modify("Return Reason Code")
        {
            Visible = true;
        }
        modify("Unit Cost (LCY)")
        {
            Visible = true;
        }
    }
    //Unsupported feature: CodeModification on "NoOnAfterValidate(PROCEDURE 409)". Please convert manually.
    //procedure NoOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
        InsertExtendedText(false);
        if (Type = Type::"Charge (Item)") and ("No." <> xRec."No.") and
           (xRec."No." <> '')
        #4..8
        if Reserve = Reserve::Always then begin
          CurrPage.SaveRecord;
          if ("Outstanding Qty. (Base)" <> 0) and ("No." <> xRec."No.") then begin
            AutoReserve;
            CurrPage.Update(false);
          end;
        end;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        #1..11
            AutoReserve();
        #13..15
        */
    //end;
    //Unsupported feature: CodeModification on "LocationCodeOnAfterValidate(PROCEDURE 8594)". Please convert manually.
    //procedure LocationCodeOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
        SaveAndAutoAsmToOrder;

        if (Reserve = Reserve::Always) and
           ("Outstanding Qty. (Base)" <> 0) and
           ("Location Code" <> xRec."Location Code")
        then begin
          CurrPage.SaveRecord;
          AutoReserve;
          CurrPage.Update(false);
        end;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        #1..7
          AutoReserve();
          CurrPage.Update(false);
        end;
        */
    //end;
    //Unsupported feature: CodeModification on "ReserveOnAfterValidate(PROCEDURE 8303)". Please convert manually.
    //procedure ReserveOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
        if (Reserve = Reserve::Always) and ("Outstanding Qty. (Base)" <> 0) then begin
          CurrPage.SaveRecord;
          AutoReserve;
        end;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        if (Reserve = Reserve::Always) and ("Outstanding Qty. (Base)" <> 0) then begin
          CurrPage.SaveRecord;
          AutoReserve();
        end;
        */
    //end;
    //Unsupported feature: CodeModification on "QuantityOnAfterValidate(PROCEDURE 6272)". Please convert manually.
    //procedure QuantityOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
        if Type = Type::Item then
          case Reserve of
            Reserve::Always:
              begin
                CurrPage.SaveRecord;
                AutoReserve;
              end;
          end;

        OnAfterQuantityOnAfterValidate(Rec,xRec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        #1..5
                AutoReserve();
        #7..10
        */
    //end;
    //Unsupported feature: CodeModification on "QtyToAsmToOrderOnAfterValidate(PROCEDURE 19)". Please convert manually.
    //procedure QtyToAsmToOrderOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
        CurrPage.SaveRecord;
        if Reserve = Reserve::Always then
          AutoReserve;
        CurrPage.Update(true);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        CurrPage.SaveRecord;
        if Reserve = Reserve::Always then
          AutoReserve();
        CurrPage.Update(true);
        */
    //end;
    //Unsupported feature: CodeModification on "UnitofMeasureCodeOnAfterValida(PROCEDURE 1752)". Please convert manually.
    //procedure UnitofMeasureCodeOnAfterValida();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
        DeltaUpdateTotals;
        if Reserve = Reserve::Always then begin
          CurrPage.SaveRecord;
          AutoReserve;
          CurrPage.Update(false);
        end;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        #1..3
          AutoReserve();
          CurrPage.Update(false);
        end;
        */
    //end;
    //Unsupported feature: CodeModification on "ShipmentDateOnAfterValidate(PROCEDURE 2525)". Please convert manually.
    //procedure ShipmentDateOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
        if (Reserve = Reserve::Always) and
           ("Outstanding Qty. (Base)" <> 0) and
           ("Shipment Date" <> xRec."Shipment Date")
        then begin
          CurrPage.SaveRecord;
          AutoReserve;
          CurrPage.Update(false);
        end else
          CurrPage.Update(true);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        #1..5
          AutoReserve();
        #7..9
        */
    //end;
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
}
