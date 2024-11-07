pageextension 60031 "SalesQuoteSubformExt" extends "Sales Quote Subform"
{
    layout
    {
        //Unsupported feature: Change Visible on ""Cross-Reference No."(Control 28)". Please convert manually.
        //Unsupported feature: Change Visible on ""Unit Cost (LCY)"(Control 18)". Please convert manually.
        addafter("Unit Cost (LCY)")
        {
            field("Last Direct Cost"; Rec."Last Direct Cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit Price")
        {
            field("Profit %"; Rec."Profit %")
            {
                ApplicationArea = All;
            }
        }
        addafter("Allow Item Charge Assignment")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Appl.-to Item Entry")
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
    var "-IMP1.01-": Integer;
    SalesLineRecGbl: Record "Sales Line";
    ItemRecGbl: Record Item;
    SaleExplodBOMCU: Codeunit "Sales-Explode BOM";
    UpdateCodeGVar: Codeunit UpdateCode;
//Unsupported feature: CodeModification on "NoOnAfterValidate(PROCEDURE 19066594)". Please convert manually.
//procedure NoOnAfterValidate();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    InsertExtendedText(false);
    if (Type = Type::"Charge (Item)") and ("No." <> xRec."No.") and
       (xRec."No." <> '')
    then
      CurrPage.SaveRecord;

    SaveAndAutoAsmToOrder;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    #1..7

    //IMP1.01 Start
    if ("Document Type" = "Document Type" :: Quote) then begin
      CurrPage.SaveRecord;
      if ItemRecGbl.Get("No.") then;
      ItemRecGbl.CalcFields("Assembly BOM");

      if ItemRecGbl."Assembly BOM" then begin
        //SaleExplodBOMCU.SetAutoConfirm(TRUE);//B2BUPG
        
        SaleExplodBOMCU.Run(Rec);
      end;
    end;
     //IMP1.01 ENd
    */
//end;
//Unsupported feature: CodeModification on "QuantityOnAfterValidate(PROCEDURE 19032465)". Please convert manually.
//procedure QuantityOnAfterValidate();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;
      AutoReserve;
    end;
    DeltaUpdateTotals;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;
      AutoReserve();
    end;
    DeltaUpdateTotals;
    */
//end;
//Unsupported feature: CodeModification on "UnitofMeasureCodeOnAfterValida(PROCEDURE 19057939)". Please convert manually.
//procedure UnitofMeasureCodeOnAfterValida();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;
      AutoReserve;
    end;
    DeltaUpdateTotals;
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    if Reserve = Reserve::Always then begin
      CurrPage.SaveRecord;
      AutoReserve();
    end;
    DeltaUpdateTotals;
    */
//end;
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
