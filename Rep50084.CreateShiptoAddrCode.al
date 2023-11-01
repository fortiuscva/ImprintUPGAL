report 50084 "Create Ship-to Addr. Code"
{
    // IMP1.01,07/13/18,SK: Created new report to Insert Ship-to Address for empty customer.
    // IMP1.02,07/31/18,SK: Added code "Customer - OnAfterGetRecord()" to update new fields.
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                ShipToAddrRecGbl2.Reset;
                ShipToAddrRecGbl2.SetRange("Customer No.", "No.");
                if not ShipToAddrRecGbl2.FindFirst then begin
                    ShipToAddrRecGbl.Init;
                    ShipToAddrRecGbl."Customer No.":=Customer."No.";
                    ShipToAddrRecGbl.Code:=Customer."No." + '-00';
                    ShipToAddrRecGbl.Name:=Customer.Name;
                    ShipToAddrRecGbl."Name 2":=Customer."Name 2";
                    ShipToAddrRecGbl.Address:=Customer.Address;
                    ShipToAddrRecGbl."Address 2":=Customer."Address 2";
                    ShipToAddrRecGbl.City:=Customer.City;
                    ShipToAddrRecGbl.County:=Customer.County;
                    ShipToAddrRecGbl."Country/Region Code":=Customer."Country/Region Code";
                    ShipToAddrRecGbl."Post Code":=Customer."Post Code";
                    ShipToAddrRecGbl.Contact:=Customer.Contact;
                    ShipToAddrRecGbl."Phone No.":=Customer."Phone No.";
                    //IMP1.02 Start
                    ShipToAddrRecGbl."Shipment Method Code":=Customer."Shipment Method Code";
                    ShipToAddrRecGbl."Shipping Agent Code":=Customer."Shipping Agent Code";
                    ShipToAddrRecGbl."Shipping Agent Service Code":=Customer."Shipping Agent Service Code";
                    ShipToAddrRecGbl."Service Zone Code":=Customer."Service Zone Code";
                    ShipToAddrRecGbl."Tax Area Code":=Customer."Tax Area Code";
                    ShipToAddrRecGbl."Tax Liable":=Customer."Tax Liable";
                    ShipToAddrRecGbl."Tax Liable Entry Date":=Customer."Tax Liable Entry Date";
                    ShipToAddrRecGbl."Verbally Confirmed":=Customer."Verbally Confirmed";
                    ShipToAddrRecGbl."No Response":=Customer."No Response";
                    ShipToAddrRecGbl."Refuse to Provide Info":=Customer."Refuse to Provide Info";
                    ShipToAddrRecGbl."Self Assessed":=Customer."Self Assessed";
                    ShipToAddrRecGbl."Self Assessed - Notes":=Customer."Self Assessed - Notes";
                    ShipToAddrRecGbl."Tax Exempt Muti-State":=Customer."Tax Exempt Muti-State";
                    ShipToAddrRecGbl."Tax Exemption No.":=Customer."Tax Exemption No.";
                    ShipToAddrRecGbl."Tax Exempt Categories":=Customer."Tax Exempt Categories";
                    ShipToAddrRecGbl."First Tax Exempt Date on File":=Customer."First Tax Exempt Date on File";
                    ShipToAddrRecGbl."Tax Exempt Entry Date":=Customer."Tax Exempt Entry Date";
                    ShipToAddrRecGbl."Tax Exempt Expiration Date":=Customer."Tax Exempt Expiration Date";
                    //IMP1.02 ENd
                    ShipToAddrRecGbl.Insert;
                    CounterVar+=1;
                end;
            end;
        }
    }
    requestpage
    {
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
    trigger OnPostReport()
    begin
        if CounterVar > 0 then Message('Created Successfully')
        else
            Message('Nothing to Create');
    end;
    var CustShipCodeVarGbl: Code[10];
    CounterVar: Integer;
    ShipToAddrRecGbl: Record "Ship-to Address";
    ShipToAddrRecGbl2: Record "Ship-to Address";
}
