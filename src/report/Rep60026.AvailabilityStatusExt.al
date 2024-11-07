report 60026 "Availability Status Ext"
{
    // version NAVNA13.00
    // ISS2.00 12.18.13 DFP - Widened fields
    //                      - Added first Bin Code with Inventory
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Availability Status.rdlc';
    CaptionML = ENU = 'Availability Status', ESM = 'Estado disponib.', FRC = 'État des disponibilités', ENC = 'Availability Status';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Search Description", "Inventory Posting Group", "Vendor No.", "Location Filter";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Item_TABLECAPTION__________ItemFilter; Item.TableCaption + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(GroupKey; GroupKey)
            {
            }
            column(Item__Inventory_Posting_Group_; "Inventory Posting Group")
            {
            }
            column(Item_Item_Description; Item.Description)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item__Base_Unit_of_Measure_; "Base Unit of Measure")
            {
            }
            column(Item_Inventory; Inventory)
            {
                DecimalPlaces = 0 : 5;
            }
            column(Qty__on_Sales_Order_; -"Qty. on Sales Order")
            {
                DecimalPlaces = 0 : 5;
            }
            column(Item__Qty__on_Purch__Order_; "Qty. on Purch. Order")
            {
                DecimalPlaces = 0 : 5;
            }
            column(QtyAvailable; QtyAvailable)
            {
                DecimalPlaces = 0 : 5;
            }
            column(Item__Reorder_Point_; "Reorder Point")
            {
                DecimalPlaces = 0 : 5;
            }
            column(QuantityOnRelProdOrd; QuantityOnRelProdOrd)
            {
                DecimalPlaces = 0 : 5;
            }
            column(QuantityOnPlanProdOrd; QuantityOnPlanProdOrd)
            {
                DecimalPlaces = 0 : 5;
            }
            column(Qty__on_Service_Order_; -"Qty. on Service Order")
            {
                DecimalPlaces = 0 : 5;
            }
            column(Availability_StatusCaption; Availability_StatusCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; FieldCaption("Base Unit of Measure"))
            {
            }
            column(Item_InventoryCaption; FieldCaption(Inventory))
            {
            }
            column(Qty__on_Sales_Order_Caption; Qty__on_Sales_Order_CaptionLbl)
            {
            }
            column(Item__Qty__on_Purch__Order_Caption; FieldCaption("Qty. on Purch. Order"))
            {
            }
            column(QtyAvailableCaption; QtyAvailableCaptionLbl)
            {
            }
            column(Item__Reorder_Point_Caption; FieldCaption("Reorder Point"))
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(QuantityOnRelProdOrdCaption; QuantityOnRelProdOrdCaptionLbl)
            {
            }
            column(QuantityOnPlanProdOrdCaption; QuantityOnPlanProdOrdCaptionLbl)
            {
            }
            column(Qty__on_Prod__Ord_Caption; Qty__on_Prod__Ord_CaptionLbl)
            {
            }
            column(Qty__on_Service_Order_Caption; Qty__on_Service_Order_CaptionLbl)
            {
            }
            column(Item__Inventory_Posting_Group_Caption; FieldCaption("Inventory Posting Group"))
            {
            }
            column(BinCode; BinCode)
            {
            }
            trigger OnAfterGetRecord();
            begin
                CalcFields(Inventory, "Qty. on Sales Order", "Qty. on Purch. Order", "Qty. on Service Order", "Scheduled Receipt (Qty.)", "Scheduled Need (Qty.)", "Rel. Scheduled Receipt (Qty.)", "Rel. Scheduled Need (Qty.)");
                QuantityOnRelProdOrd := "Rel. Scheduled Receipt (Qty.)" - "Rel. Scheduled Need (Qty.)";
                QuantityOnPlanProdOrd := "Scheduled Receipt (Qty.)" - "Scheduled Need (Qty.)" - QuantityOnRelProdOrd;
                QtyAvailable := Inventory - "Qty. on Sales Order" + "Qty. on Purch. Order" - "Qty. on Service Order" + QuantityOnRelProdOrd + QuantityOnPlanProdOrd;
                // NA0001.end
                // ISS DFP 12.18.13 ====================================\
                // Find the first Bin with Inventory
                BinContent.Reset;
                BinContent.SetCurrentKey("Item No.");
                BinContent.SetRange("Item No.", Item."No.");
                BinContent.SetFilter(Quantity, '>0');
                if BinContent.FindFirst then
                    BinCode := BinContent."Bin Code"
                else
                    Clear(BinCode);
                // End =================================================/
            end;

            trigger OnPreDataItem();
            begin
                if StrPos(Item.CurrentKey, FieldCaption("Inventory Posting Group")) = 0 then
                    GroupKey := false
                else
                    GroupKey := true;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport();
    begin
        ItemFilter := Item.GetFilters;
        CompanyInformation.Get;
    end;

    var
        CompanyInformation: Record "Company Information";
        ItemFilter: Text;
        QuantityOnRelProdOrd: Decimal;
        QuantityOnPlanProdOrd: Decimal;
        QtyAvailable: Decimal;
        GroupKey: Boolean;
        Availability_StatusCaptionLbl: TextConst ENU = 'Availability Status', ESM = 'Estado disponib.', FRC = 'État des disponibilités', ENC = 'Availability Status';
        CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page', ESM = 'Pág.', FRC = 'Page', ENC = 'Page';
        Qty__on_Sales_Order_CaptionLbl: TextConst ENU = 'Qty. on Sales Order', ESM = 'Cant. en pedidos venta', FRC = 'Qté sur document de vente', ENC = 'Qty. on Sales Order';
        QtyAvailableCaptionLbl: TextConst ENU = 'Quantity Available', ESM = 'Cantidad disponible', FRC = 'Quantité disponible', ENC = 'Quantity Available';
        QuantityOnRelProdOrdCaptionLbl: TextConst ENU = 'Released', ESM = 'Lanzados', FRC = 'Relâché', ENC = 'Released';
        QuantityOnPlanProdOrdCaptionLbl: TextConst ENU = 'Planned', ESM = 'Planificada', FRC = 'Planifié', ENC = 'Planned';
        Qty__on_Prod__Ord_CaptionLbl: TextConst ENU = 'Qty. on Prod. Ord.', ESM = 'Cdad. en orden producc.', FRC = 'Quantité sur bon de production', ENC = 'Qty. on Prod. Ord.';
        Qty__on_Service_Order_CaptionLbl: TextConst ENU = 'Qty. on Service Order', ESM = 'Cant. en ped. servicio', FRC = 'Qté sur commande service', ENC = 'Qty. on Service Order';
        BinContent: Record "Bin Content";
        BinCode: Code[20];
}
