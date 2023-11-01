pageextension 60061 "NavigateExt" extends Navigate
{
    // version NAVW114.04,NAVNA14.04,ISS2.00
    var SalesStatEntry: Record "Sales Statistic Entry";
//Unsupported feature: CodeModification on "ShowRecords(PROCEDURE 6)". Please convert manually.
//procedure ShowRecords();
//Parameters and return type have not been exported.
//>>>> ORIGINAL CODE:
//begin
/*
    IsHandled := false;
    OnBeforeNavigateShowRecords(
      "Table ID",DocNoFilter,PostingDateFilter,ItemTrackingSearch,Rec,IsHandled,
    #4..158
          PAGE.Run(0,PostedDepositHeader);
        DATABASE::"Posted Deposit Line":
          PAGE.Run(0,PostedDepositLine);
      end;

    OnAfterNavigateShowRecords(
      "Table ID",DocNoFilter,PostingDateFilter,ItemTrackingSearch,Rec,
      SalesInvHeader,SalesCrMemoHeader,PurchInvHeader,PurchCrMemoHeader,ServInvHeader,ServCrMemoHeader);
    */
//end;
//>>>> MODIFIED CODE:
//begin
/*
    #1..161

        // ISS2.00 04.14.14 =================================================================================\
        DATABASE::"Sales Statistic Entry":
          PAGE.Run(0,SalesStatEntry);
        // End ==============================================================================================/
    #162..166
    */
//end;
//Unsupported feature: PropertyChange. Please convert manually.
}
