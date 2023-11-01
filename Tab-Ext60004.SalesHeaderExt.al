tableextension 60004 "SalesHeaderExt" extends "Sales Header"
{
    DataCaptionFields = "No.", "Sell-to Customer Name";

    fields
    {
        field(50010; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Sum("Sales Line"."Profit (LCY)" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            Caption = 'Profit ($)';
            DecimalPlaces = 2 : 2;
            Description = 'ISS2.00';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "Third Party Shipping Acc. No."; Code[20])
        {
            trigger OnValidate()
            begin
                //TestShippingAccountNo("Account No.");
            end;

            trigger OnLookup()
            begin
                // ISS2.00 03.02.14 DFP ==================================================================\
                LookupTPShipAccount;
                // End ===================================================================================/
            end;
        }
        field(50018; "Tax Exempt Categories"; Text[50])
        {
            Description = 'IMP1.12';
        }
        field(50019; "CertCapture Exemption No."; Text[30])
        {
            Description = 'IMP1.13';
        }
        field(50021; "E-Mail Address"; Text[80])
        {
            Caption = 'E-Mail';
            Description = 'IMP1.01';
            ExtendedDatatype = EMail;
        }
        field(50026; "Purchaser Code"; Code[10])
        {
            Description = 'IMP1.09';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50030; "Repair Order"; Boolean)
        {
            Description = 'IMP1.02';
            Editable = false;
        }
        field(50036; "Expiration Date"; Date)
        {
            Description = 'IMP1.14';
        }
        field(50040; "Override Credit"; Boolean)
        {
            Description = 'IMP1.07';
        }
        field(50100; "Lead Source Code"; Code[10])
        {
            Description = 'ISS2.00';
            TableRelation = "Lead Source".Code;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                // ISS2.00 03.02.14 DFP ==================================================================\
                IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN DefaultTPShipAccount;
                // End ===================================================================================/
            end;
        }
        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            var
                ShipToAddr: Record "Ship-to Address";
                cust: Record Customer;
            begin
                // ISS2.00 03.02.14 DFP ==================================================================\
                IF "Ship-to Code" <> xRec."Ship-to Code" THEN DefaultTPShipAccount;
                // End ===================================================================================/
                IF "Ship-to Code" <> '' then if ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code") then; //IMP1.10
                                                                                                             //IMP1.19 >> 
                if Rec."Document Type" in [Rec."Document Type"::"Credit Memo", Rec."Document Type"::"Return Order"] then Rec.UpdateShipToAdd(ShipToAddr);
                //IMP1.19 <<
                if cust.get("Sell-to Customer No.") then; //IMP1.15
                                                          //IMP1.12 Start
                "Tax Exemption No." := ShipToAddr."Tax Exemption No.";
                "Tax Exempt Categories" := ShipToAddr."Tax Exempt Categories";
                //IMP1.12 End
                //IMP1.13 STart
                IF ShipToAddr."CertCapture Exemption No." <> '' THEN
                    "CertCapture Exemption No." := ShipToAddr."CertCapture Exemption No."
                ELSE
                    "CertCapture Exemption No." := Cust."CertCapture Exemption No.";
                //IMP1.13 End
            end;
        }
        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            begin
                // IM1.04 - original/new
                //UpdateSalesLines(FIELDCAPTION("Shipment Date"),CurrFieldNo <> 0);
                UpdateSalesLines(FIELDCAPTION("Shipment Date"), FALSE); // IM1.04
            end;
        }
        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            begin
                // ISS2.00 11.13.13 DFP =========================================================\
                // Update Salesperson on Lines
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", Rec."Document Type");
                SalesLine.SETRANGE("Document No.", Rec."No.");
                IF NOT SalesLine.ISEMPTY THEN SalesLine.MODIFYALL("Salesperson Code", Rec."Salesperson Code");
                // End ==========================================================================/
            end;
        }
        modify("Sell-to Contact No.")
        {
            trigger OnAfterValidate()
            begin
                UpdateContactLastMod("Document Type", "Sell-to Contact No."); //IMP1.06
            end;
        }
        modify("External Document No.")
        {
            trigger OnAfterValidate()
            var
                SalesLineRecLcl: Record "Sales Line";
                PurchHeadRecLcl: Record "Purchase Header";
            begin
                if (xRec."External Document No." <> "External Document No.") and ("Document Type" in ["Document Type"::Order]) then begin
                    SalesLineRecLcl.Reset();
                    SalesLineRecLcl.SetRange("Document Type", Rec."Document Type");
                    SalesLineRecLcl.SetRange("Document No.", Rec."No.");
                    SalesLineRecLcl.SetFilter("Purchase Order No.", '<>%1', '');
                    if SalesLineRecLcl.FindFirst() then begin
                        PurchHeadRecLcl.reset;
                        if PurchHeadRecLcl.get(PurchHeadRecLcl."Document Type"::Order, SalesLineRecLcl."Purchase Order No.") then begin
                            PurchHeadRecLcl."Customer PO No." := Rec."External Document No.";
                            PurchHeadRecLcl.Modify();
                        end;
                    end;
                end;
            end;
        }
    }
    trigger ondelete()
    var
        myInt: Integer;
    begin
        // ISS2.00 06.22.13 DFP ============================================================\
        // Remove Sales Statistic Entries
        SalesStatMgt.UpdateStatSalesDoc(Rec, TRUE);
        // End =============================================================================/
    end;

    var
        SalesFilterMgt: Codeunit 50004;
        SalesLine: Record "Sales Line";
        SalesStatMgt: Codeunit 50001;

    procedure CheckForReasonCode()
    var
        SalesLineRecLcl: Record "Sales Line";
        Text0001: label 'Please enter Return Reason Code before posting this order.';
    begin
        SalesLineRecLcl.RESET;
        SalesLineRecLcl.SETRANGE("Document Type", "Document Type");
        SalesLineRecLcl.SETRANGE("Document No.", "No.");
        SalesLineRecLcl.SETRANGE(Type, SalesLineRecLcl.Type::Item);
        SalesLineRecLcl.SETFILTER("No.", '<>%1', '');
        IF SalesLineRecLcl.FINDSET THEN
            REPEAT
                IF SalesLineRecLcl."Return Reason Code" = '' THEN ERROR(Text0001);
            UNTIL SalesLineRecLcl.NEXT = 0;
    end;

    procedure UpdateContactLastMod(DocType: Enum "Sales Document Type"; ContNo: Code[20])
    var
        ContactRecLcl: Record Contact;
    begin
        //IMP1.06 Start
        IF (DocType IN [DocType::Quote, DocType::Order]) AND (ContNo <> '') THEN BEGIN
            IF ContactRecLcl.GET(ContNo) THEN BEGIN
                ContactRecLcl.VALIDATE("Last Date Modified", TODAY);
                ContactRecLcl.MODIFY;
            END;
        END;
        //IMP1.06 End
    end;

    procedure CheckForCrLimitWarning()
    var
        Text001: label 'The customer credit limit has been exceeded.';
        Text002: Label 'This customer has an overdue balance.';
        Text003: Label 'This customer has an overdue balance and the customer credit limit has been exceeded.';
        SalesStatMgt: Codeunit 50001;
    begin
        IF (("On Hold" = 'CLE') OR ("On Hold" = 'OVD') OR ("On Hold" = 'CLD')) AND NOT "Override Credit" THEN BEGIN
            IF "On Hold" = 'CLE' THEN
                ERROR(Text001)
            ELSE
                IF "On Hold" = 'OVD' THEN
                    ERROR(Text002)
                ELSE
                    IF "On Hold" = 'CLD' THEN ERROR(Text003);
        END;
    end;

    PROCEDURE FilterSalesperson();
    BEGIN
        // ISS2.00 DFP =================================================\
        // Filters recordset to the User's Salesperson Filter
        SalesFilterMgt.SHFilterSalesperson(Rec);
        // End =========================================================/
    END;

    PROCEDURE DefaultSalesperson(ValidateField: Boolean);
    BEGIN
        // ISS2.00 DFP =================================================\
        SalesFilterMgt.SHDefaultSalesperson(Rec, ValidateField);
        // End =========================================================/
    END;

    PROCEDURE RepairPurchLink(QuietMode: Boolean);
    VAR
        PurchLine: Record 39;
        LocalText001: label 'Non-existing Purchase Order Links have been removed.';
        LinkRemoved: Boolean;
        LocalText002: label 'Purchase Order Links have been verified.\\No changes were made.';
    BEGIN
        // ISS2.00 DFP =================================================\
        CLEAR(LinkRemoved);
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", Rec."Document Type");
        SalesLine.SETRANGE("Document No.", Rec."No.");
        IF SalesLine.FINDSET(FALSE) THEN
            REPEAT
                IF (SalesLine."Purch. Order Line No." <> 0) AND (SalesLine."Outstanding Quantity" <> 0) THEN BEGIN
                    // Verify the Purchase Docuemnt Line exists
                    IF NOT PurchLine.GET(PurchLine."Document Type"::Order, SalesLine."Purchase Order No.", SalesLine."Purch. Order Line No.") THEN BEGIN
                        // Remove Link; it's dead
                        SalesLine."Purchase Order No." := '';
                        SalesLine."Purch. Order Line No." := 0;
                        SalesLine.MODIFY;
                        LinkRemoved := TRUE;
                    END;
                END;
            UNTIL SalesLine.NEXT = 0;
        IF NOT QuietMode THEN BEGIN
            IF LinkRemoved THEN // Non-existing Purchase Order Links have been removed.
                MESSAGE(LocalText001)
            ELSE
                // Purchase Order Links have been verified.\\No changes were made.
                MESSAGE(LocalText002);
        END;
        // End =========================================================/
    END;

    PROCEDURE LookupTPShipAccount();
    VAR
        ShippingAccount: Record 50011;
        ShippingAccountPage: Page 50015;
    BEGIN
        // ISS2.00 03.02.14 DFP ==================================================================\
        ShippingAccount.RESET;
        // Ship-to Type,Ship-to No.,Ship-to Code,Shipping Agent Code,Account No.
        ShippingAccount.SETRANGE("Ship-to Type", ShippingAccount."Ship-to Type"::Customer);
        ShippingAccount.SETRANGE("Ship-to No.", Rec."Sell-to Customer No.");
        IF Rec."Ship-to Code" <> '' THEN
            ShippingAccount.SETFILTER("Ship-to Code", '''''|' + Rec."Ship-to Code")
        ELSE
            ShippingAccount.SETFILTER("Ship-to Code", '''''');
        //SETFILTER("Shipping Agent Code",'%1',Rec."Shipping Agent Code");
        CLEAR(ShippingAccountPage);
        ShippingAccountPage.LOOKUPMODE(TRUE);
        ShippingAccountPage.SETTABLEVIEW(ShippingAccount);
        IF ShippingAccountPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ShippingAccountPage.GETRECORD(ShippingAccount);
            Rec.VALIDATE("Shipping Agent Code", ShippingAccount."Shipping Agent Code");
            Rec.VALIDATE("Third Party Shipping Acc. No.", ShippingAccount."Account No.");
        END;
        // End ===================================================================================/
    END;

    PROCEDURE DefaultTPShipAccount();
    VAR
        ShippingAccount: Record 50011;
    BEGIN
        /*
        // ISS2.00 03.02.14 DFP ==================================================================\

        WITH ShippingAccount DO BEGIN
          RESET;
          // Ship-to Type,Ship-to No.,Ship-to Code,Shipping Agent Code,Account No.
          SETRANGE("Ship-to Type","Ship-to Type"::Customer);
          SETRANGE("Ship-to No.",Rec."Sell-to Customer No.");
          // First look for Ship-to match
          SETFILTER("Ship-to Code",'%1',Rec."Ship-to Code");
          //SETFILTER("Shipping Agent Code",'%1',Rec."Shipping Agent Code");
          SETRANGE("Default Account",TRUE);
          IF FINDFIRST THEN BEGIN
            Rec.VALIDATE("Shipping Agent Code","Shipping Agent Code");
            Rec.VALIDATE("Third Party Shipping Acc. No.","Account No.");
            EXIT;
          END;

          IF Rec."Ship-to Code" <> '' THEN BEGIN
            // Next look for blank Ship-to
            SETFILTER("Ship-to Code",'''''');
            IF FINDFIRST THEN BEGIN
              Rec.VALIDATE("Shipping Agent Code","Shipping Agent Code");
              Rec.VALIDATE("Third Party Shipping Acc. No.","Account No.");
              EXIT;
            END;
          END;
        END;
        // End ===================================================================================/
        */
        IF Rec."Ship-to Code" <> '' THEN BEGIN
            ShippingAccount.RESET;
            // Ship-to Type,Ship-to No.,Ship-to Code,Shipping Agent Code,Account No.
            ShippingAccount.SETRANGE("Ship-to Type", ShippingAccount."Ship-to Type"::Customer);
            ShippingAccount.SETRANGE("Ship-to No.", Rec."Sell-to Customer No.");
            // First look for Ship-to match
            ShippingAccount.SETFILTER("Ship-to Code", '%1', Rec."Ship-to Code");
            //SETFILTER("Shipping Agent Code",'%1',Rec."Shipping Agent Code");
            IF ShippingAccount.FINDFIRST THEN BEGIN
                Rec.VALIDATE("Shipping Agent Code", ShippingAccount."Shipping Agent Code");
                Rec.VALIDATE("Third Party Shipping Acc. No.", ShippingAccount."Account No.");
                EXIT;
            END
            ELSE BEGIN
                ShippingAccount.RESET;
                ShippingAccount.SETRANGE("Ship-to Type", ShippingAccount."Ship-to Type"::Customer);
                ShippingAccount.SETRANGE("Ship-to No.", Rec."Sell-to Customer No.");
                ShippingAccount.SETRANGE("Default Account", TRUE);
                IF ShippingAccount.FINDFIRST THEN BEGIN
                    Rec.VALIDATE("Shipping Agent Code", ShippingAccount."Shipping Agent Code");
                    Rec.VALIDATE("Third Party Shipping Acc. No.", ShippingAccount."Account No.");
                    EXIT;
                END;
            END;
        END
        ELSE BEGIN
            ShippingAccount.RESET;
            ShippingAccount.SETRANGE("Ship-to Type", ShippingAccount."Ship-to Type"::Customer);
            ShippingAccount.SETRANGE("Ship-to No.", Rec."Sell-to Customer No.");
            ShippingAccount.SETFILTER("Ship-to Code", '%1', Rec."Ship-to Code");
            ShippingAccount.SETRANGE("Default Account", TRUE);
            IF ShippingAccount.FINDFIRST THEN BEGIN
                Rec.VALIDATE("Shipping Agent Code", ShippingAccount."Shipping Agent Code");
                Rec.VALIDATE("Third Party Shipping Acc. No.", ShippingAccount."Account No.");
                EXIT;
            END;
        END;
    END;

    procedure UpdateShipToAdd(ShipToAddr: Record "Ship-to Address")
    var
        IsHandled: Boolean;
    begin
        "Ship-to Name" := ShipToAddr.Name;
        "Ship-to Name 2" := ShipToAddr."Name 2";
        "Ship-to Address" := ShipToAddr.Address;
        "Ship-to Address 2" := ShipToAddr."Address 2";
        "Ship-to City" := ShipToAddr.City;
        "Ship-to Post Code" := ShipToAddr."Post Code";
        "Ship-to County" := ShipToAddr.County;
        Validate("Ship-to Country/Region Code", ShipToAddr."Country/Region Code");
        "Ship-to Contact" := ShipToAddr.Contact;
        "Shipping Agent Code" := ShipToAddr."Shipping Agent Code";
        "Shipping Agent Service Code" := ShipToAddr."Shipping Agent Service Code";
        if ShipToAddr."Tax Area Code" <> '' then "Tax Area Code" := ShipToAddr."Tax Area Code";
        "Tax Liable" := ShipToAddr."Tax Liable";
    end;
}
