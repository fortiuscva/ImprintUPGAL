codeunit 50012 "Correct Drop Shipment Item Ent"
{
    Permissions = TableData "G/L Entry"=rimd,
        TableData "Item Ledger Entry"=rimd,
        TableData "Sales Shipment Line"=rimd,
        TableData "Sales Invoice Line"=rimd,
        TableData "Purch. Rcpt. Line"=rimd,
        TableData "Value Entry"=rimd;

    trigger OnRun()
    begin
        /*
        //First Document
        //For Purchase
        PurchRcptLineGRec.GET('PR041295',10000);
        PurchRcptLineGRec."Quantity (Base)" := 10000;
        PurchRcptLineGRec.MODIFY;
        
        ItemLedgEntryGRec.GET(65389);
        ItemLedgEntryGRec.Quantity := 10000;
        ItemLedgEntryGRec.MODIFY;
        
        ValueEntryGRec.GET(105360);
        ValueEntryGRec."Cost Amount (Expected)" := 234.5;
        ValueEntryGRec."Expected Cost Posted to G/L" := 234.5;
        ValueEntryGRec."Item Ledger Entry Quantity" := 10000;
        ValueEntryGRec."Valued Quantity" := 10000;
        ValueEntryGRec.MODIFY;
        
        
        GLEntryGRec.GET(488951);
        GLEntryGRec.Amount := 234.5;
        GLEntryGRec."Debit Amount" := 234.5;
        GLEntryGRec.MODIFY;
        
        GLEntryGRec.GET(488952);
        GLEntryGRec.Amount := -234.5;
        GLEntryGRec."Credit Amount" := 234.5;
        GLEntryGRec.MODIFY;
        
        
        //For Sales
        SalesShptLineGRec.GET('PS1026939',10000);
        SalesShptLineGRec."Quantity (Base)" := 10000;
        SalesShptLineGRec."Qty. Invoiced (Base)" := 10000;
        SalesShptLineGRec.MODIFY;
        
        ItemLedgEntryGRec.GET(65390);
        ItemLedgEntryGRec."Invoiced Quantity" := -10000;
        ItemLedgEntryGRec.Quantity := -10000;
        ItemLedgEntryGRec."Shipped Qty. Not Returned" := -10000;
        ItemLedgEntryGRec.MODIFY;
        
        SalesInvLineGRec.GET('PSI126929',10000);
        SalesInvLineGRec."Quantity (Base)" := 10000;
        SalesInvLineGRec.MODIFY;
        
        ValueEntryGRec.GET(105361);
        ValueEntryGRec."Cost Amount (Actual)" := -234.5;
        ValueEntryGRec."Cost Posted to G/L" := -234.5;
        ValueEntryGRec."Invoiced Quantity" := -10000;
        ValueEntryGRec."Item Ledger Entry Quantity" := -10000;
        ValueEntryGRec."Valued Quantity" := -10000;
        ValueEntryGRec.MODIFY;
        
        GLEntryGRec.GET(488953);
        GLEntryGRec.Amount  := -234.5;
        GLEntryGRec."Credit Amount" := 234.5;
        GLEntryGRec.MODIFY;
        
        GLEntryGRec.GET(488954);
        GLEntryGRec.Amount  := 234.5;
        GLEntryGRec."Debit Amount" := 234.5;
        GLEntryGRec.MODIFY;
        */
        /*
        //Second Document
        //For Purchase
        PurchRcptLineGRec.GET('PR041906',10000);
        PurchRcptLineGRec."Quantity (Base)" := 6000;
        PurchRcptLineGRec.MODIFY;
        
        ItemLedgEntryGRec.GET(66543);
        ItemLedgEntryGRec.Quantity := 6000;
        ItemLedgEntryGRec.MODIFY;
        
        ValueEntryGRec.GET(107199);
        ValueEntryGRec."Cost Amount (Expected)" := 140.7;
        ValueEntryGRec."Expected Cost Posted to G/L" := 140.7;
        ValueEntryGRec."Item Ledger Entry Quantity" := 6000;
        ValueEntryGRec."Valued Quantity" := 6000;
        ValueEntryGRec.MODIFY;
        
        
        GLEntryGRec.GET(496353);
        GLEntryGRec.Amount := 140.7;
        GLEntryGRec."Debit Amount" := 140.7;
        GLEntryGRec.MODIFY;
        
        GLEntryGRec.GET(496354);
        GLEntryGRec.Amount := -140.7;
        GLEntryGRec."Credit Amount" := 140.7;
        GLEntryGRec.MODIFY;
        
        
        //For Sales
        SalesShptLineGRec.GET('PS1027339',30000);
        SalesShptLineGRec."Quantity (Base)" := 6000;
        SalesShptLineGRec."Qty. Invoiced (Base)" := 6000;
        SalesShptLineGRec.MODIFY;
        
        ItemLedgEntryGRec.GET(66544);
        ItemLedgEntryGRec."Invoiced Quantity" := -6000;
        ItemLedgEntryGRec.Quantity := -6000;
        ItemLedgEntryGRec."Shipped Qty. Not Returned" := -6000;
        ItemLedgEntryGRec.MODIFY;
        
        SalesInvLineGRec.GET('PSI127302',30000);
        SalesInvLineGRec."Quantity (Base)" := 6000;
        SalesInvLineGRec.MODIFY;
        
        ValueEntryGRec.GET(107200);
        ValueEntryGRec."Cost Amount (Actual)" := -140.7;
        ValueEntryGRec."Cost Posted to G/L" := -140.7;
        ValueEntryGRec."Invoiced Quantity" := -6000;
        ValueEntryGRec."Item Ledger Entry Quantity" := -6000;
        ValueEntryGRec."Valued Quantity" := -6000;
        {
        ValueEntryGRec."Cost per Unit" := 0.02345;
        }
        ValueEntryGRec.MODIFY;
        
        GLEntryGRec.GET(496355);
        GLEntryGRec.Amount  := -140.7;
        GLEntryGRec."Credit Amount" := 140.7;
        GLEntryGRec.MODIFY;
        
        GLEntryGRec.GET(496356);
        GLEntryGRec.Amount  := 140.7;
        GLEntryGRec."Debit Amount" := 140.7;
        GLEntryGRec.MODIFY;
        */
        Message('Completed');
    end;
    var SalesShptLineGRec: Record "Sales Shipment Line";
    PurchRcptLineGRec: Record "Purch. Rcpt. Line";
    ItemLedgEntryGRec: Record "Item Ledger Entry";
    ValueEntryGRec: Record "Value Entry";
    GLEntryGRec: Record "G/L Entry";
    SalesInvLineGRec: Record "Sales Invoice Line";
}
