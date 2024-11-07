pageextension 60032 "SalesCrMemoSubformExt" extends "Sales Cr. Memo Subform"
{
    layout
    {
        modify("Return Reason Code")
        {
            Visible = true;
        }
        modify("Bin Code")
        {
            Visible = true;
        }
    }
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
      AutoReserve();   // NA0001
    end;
    */
//end;
//Unsupported feature: CodeModification on "QuantityOnAfterValidate(PROCEDURE 6272)". Please convert manually.
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
      AutoReserve();   // NA0001
    end;
    DeltaUpdateTotals;
    */
//end;
//Unsupported feature: CodeModification on "UnitofMeasureCodeOnAfterValida(PROCEDURE 1752)". Please convert manually.
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
      AutoReserve();   // NA0001
    end;
    DeltaUpdateTotals;
    */
//end;
//Unsupported feature: InsertAfter on "Documentation". Please convert manually.
//Unsupported feature: PropertyChange. Please convert manually.
}
