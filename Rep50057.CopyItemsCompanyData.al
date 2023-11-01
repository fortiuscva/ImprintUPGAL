report 50057 "Copy Items Company Data"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending);
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Clear(ISXItem);
                ISXItemString:=CopyStr(Item."Mfg. Item No.", 1, 3);
                if((ISXItemString = 'ISX') and (Item."Vendor No." = '6V'))then CurrReport.Skip;
                ItemGRec.Reset;
                ItemGRec.ChangeCompany(ToCompanyName);
                TempItemGRec.ChangeCompany(ToCompanyName);
                ItemGRec.SetRange("Mfg. Item No.", Item."Mfg. Item No.");
                if not ItemGRec.FindFirst then begin
                    ItemGRec.Init;
                    ItemGRec.TransferFields(Item);
                    ItemGRec.Insert;
                    TempItemGRec.Init;
                    TempItemGRec.TransferFields(Item);
                    TempItemGRec.Insert;
                end;
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
    CustGRec: Record Customer;
    ItemGRec: Record Item;
    Company: Record Company;
    TempCustGRec: Record "Temp - Customer";
    TempItemGRec: Record "Temp - Item";
    ISXItem: Boolean;
    ISXItemString: Text[3];
}
