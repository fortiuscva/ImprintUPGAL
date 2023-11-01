report 50061 "Copy Item UOM"
{
    Permissions = TableData "Item Unit of Measure"=rimd;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Temp - Item"; "Temp - Item")
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending);
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                ItemUOMGRec.Reset;
                ItemUOMGRec.SetRange("Item No.", "Temp - Item"."No.");
                if ItemUOMGRec.FindSet then repeat ToCompanyItemUOM.Reset;
                        ToCompanyItemUOM.ChangeCompany(ToCompanyName);
                        ToCompanyItemUOM.SetRange("Item No.", ItemUOMGRec."Item No.");
                        ToCompanyItemUOM.SetRange(Code, ItemUOMGRec.Code);
                        if not ToCompanyItemUOM.FindFirst then begin
                            ToCompanyItemUOM.Init;
                            ToCompanyItemUOM.TransferFields(ItemUOMGRec);
                            ToCompanyItemUOM.Insert;
                            TempItemUOM.Init;
                            TempItemUOM.TransferFields(ItemUOMGRec);
                            TempItemUOM.Insert;
                        end;
                    until ItemUOMGRec.Next = 0;
            end;
            trigger OnPreDataItem()
            begin
                TempItemUOM.Reset;
                TempItemUOM.ChangeCompany(ToCompanyName);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Copy to Company"; ToCompanyName)
                    {
                        Editable = false;
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean begin
                            Company.Reset;
                            if PAGE.RunModal(PAGE::Companies, Company) = ACTION::LookupOK then ToCompanyName:=Company.Name;
                        end;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        if ToCompanyName = '' then Error('To Company Name cannot be empty.');
    end;
    var ToCompanyName: Text[1024];
    ShipToAddrRec: Record "Ship-to Address";
    TempItemUOM: Record "Temp - Item Unit of Measure";
    ToCompanyItemUOM: Record "Item Unit of Measure";
    Company: Record Company;
    ItemUOMGRec: Record "Item Unit of Measure";
}
