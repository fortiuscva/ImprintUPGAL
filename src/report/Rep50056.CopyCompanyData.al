report 50056 "Copy Company Data"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")ORDER(Ascending)WHERE("Salesperson Code"=FILTER('MFREEMAN'|'JMCGURRAN'));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                if not CustGRec.Get("No.")then begin
                    CustGRec.Init;
                    CustGRec.TransferFields(Customer);
                    CustGRec.Insert;
                    TempCustGRec.Init;
                    TempCustGRec.TransferFields(Customer);
                    TempCustGRec.Insert;
                end;
            end;
            trigger OnPreDataItem()
            begin
                CustGRec.Reset;
                CustGRec.ChangeCompany(ToCompanyName);
                TempCustGRec.ChangeCompany(ToCompanyName);
            end;
        }
        dataitem("Tax Jurisdiction"; "Tax Jurisdiction")
        {
            trigger OnAfterGetRecord()
            begin
                if not TaxJurisdictionGRec.Get("Tax Jurisdiction".Code)then begin
                    TaxJurisdictionGRec.Init;
                    TaxJurisdictionGRec.TransferFields("Tax Jurisdiction");
                    TaxJurisdictionGRec.Insert;
                    TempTaxJurisdictionGRec.Init;
                    TempTaxJurisdictionGRec.TransferFields("Tax Jurisdiction");
                    TempTaxJurisdictionGRec.Insert;
                end;
            end;
            trigger OnPreDataItem()
            begin
                TaxJurisdictionGRec.Reset;
                TaxJurisdictionGRec.ChangeCompany(ToCompanyName);
                TempTaxJurisdictionGRec.ChangeCompany(ToCompanyName);
            end;
        }
        dataitem("Tax Group"; "Tax Group")
        {
            trigger OnAfterGetRecord()
            begin
                if not TaxGroupGRec.Get("Tax Group".Code)then begin
                    TaxGroupGRec.Init;
                    TaxGroupGRec.TransferFields("Tax Group");
                    TaxGroupGRec.Insert;
                    TempTaxGroupGRec.Init;
                    TempTaxGroupGRec.TransferFields("Tax Group");
                    TempTaxGroupGRec.Insert;
                end;
            end;
            trigger OnPreDataItem()
            begin
                TaxGroupGRec.Reset;
                TaxGroupGRec.ChangeCompany(ToCompanyName);
                TempTaxGroupGRec.ChangeCompany(ToCompanyName);
            end;
        }
        dataitem("Tax Area"; "Tax Area")
        {
            trigger OnAfterGetRecord()
            begin
                if not TaxAreaGRec.Get("Tax Area".Code)then begin
                    TaxAreaGRec.Init;
                    TaxAreaGRec.TransferFields("Tax Area");
                    TaxAreaGRec.Insert;
                /*
                    TempTaxAreaGRec.Init;
                    TempTaxAreaGRec.TransferFields("Tax Area");
                    TempTaxAreaGRec.Insert;
                    */
                end;
            end;
            trigger OnPreDataItem()
            begin
            /*
                TaxAreaGRec.Reset;
                TaxAreaGRec.ChangeCompany(ToCompanyName);
                TempTaxAreaGRec.ChangeCompany(ToCompanyName);
                */
            end;
        }
        dataitem("Tax Area Line"; "Tax Area Line")
        {
            trigger OnAfterGetRecord()
            begin
                if not TaxAreaLineGRec.Get("Tax Area Line"."Tax Area", "Tax Area Line"."Tax Jurisdiction Code")then begin
                    TaxAreaLineGRec.Init;
                    TaxAreaLineGRec.TransferFields("Tax Area Line");
                    TaxAreaLineGRec.Insert;
                    TempTaxAreaLineGRec.Init;
                    TempTaxAreaLineGRec.TransferFields("Tax Area Line");
                    TempTaxAreaLineGRec.Insert;
                end;
            end;
            trigger OnPreDataItem()
            begin
                TaxAreaLineGRec.Reset;
                TaxAreaLineGRec.ChangeCompany(ToCompanyName);
                TempTaxAreaLineGRec.ChangeCompany(ToCompanyName);
            end;
        }
        dataitem("Tax Detail"; "Tax Detail")
        {
            trigger OnAfterGetRecord()
            begin
                if not TaxDetailGRec.Get("Tax Detail"."Tax Jurisdiction Code", "Tax Detail"."Tax Group Code", "Tax Detail"."Tax Type", "Tax Detail"."Effective Date")then begin
                    TaxDetailGRec.Init;
                    TaxDetailGRec.TransferFields("Tax Detail");
                    TaxDetailGRec.Insert;
                    TempTaxDetailGRec.Init;
                    TempTaxDetailGRec.TransferFields("Tax Detail");
                    TempTaxDetailGRec.Insert;
                end;
            end;
            trigger OnPreDataItem()
            begin
                TaxDetailGRec.Reset;
                TaxDetailGRec.ChangeCompany(ToCompanyName);
                TempTaxDetailGRec.ChangeCompany(ToCompanyName);
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
    Company: Record Company;
    TaxJurisdictionGRec: Record "Tax Jurisdiction";
    TaxGroupGRec: Record "Tax Group";
    TaxAreaGRec: Record "Tax Area";
    TaxAreaLineGRec: Record "Tax Area Line";
    TaxDetailGRec: Record "Tax Detail";
    "---": Integer;
    TempCustGRec: Record "Temp - Customer";
    TempTaxJurisdictionGRec: Record "Temp - Tax Jurisdiction";
    TempTaxGroupGRec: Record "Temp - Item Unit of Measure";
    //TempTaxAreaGRec: Record "Temp - Tax Area";
    TempTaxAreaLineGRec: Record "Temp - Contact";
    TempTaxDetailGRec: Record "Temp - Contact Business Rel.";
}
