report 50060 "Copy Customer Ship To Adress"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Temp - Customer"; "Temp - Customer")
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending);
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                ShipToAddrRec.Reset;
                ShipToAddrRec.SetRange("Customer No.", "Temp - Customer"."No.");
                if ShipToAddrRec.FindSet then repeat ToCompanyShipToAddrRec.Reset;
                        ToCompanyShipToAddrRec.ChangeCompany(ToCompanyName);
                        ToCompanyShipToAddrRec.SetRange("Customer No.", ShipToAddrRec."Customer No.");
                        ToCompanyShipToAddrRec.SetRange(Code, ShipToAddrRec.Code);
                        if not ToCompanyShipToAddrRec.FindFirst then begin
                            ToCompanyShipToAddrRec.Init;
                            ToCompanyShipToAddrRec.TransferFields(ShipToAddrRec);
                            ToCompanyShipToAddrRec.Insert;
                            TempShipToAddr.Init;
                            TempShipToAddr.TransferFields(ShipToAddrRec);
                            TempShipToAddr.Insert;
                        end;
                    until ShipToAddrRec.Next = 0;
            end;
            trigger OnPreDataItem()
            begin
                TempShipToAddr.Reset;
                TempShipToAddr.ChangeCompany(ToCompanyName);
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
    TempCustGRec: Record "Temp - Customer";
    ShipToAddrRec: Record "Ship-to Address";
    TempShipToAddr: Record "Serial Numbers by Bin Buffer";
    ToCompanyShipToAddrRec: Record "Ship-to Address";
    Company: Record Company;
}
