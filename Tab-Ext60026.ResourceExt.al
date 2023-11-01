tableextension 60026 "ResourceExt" extends Resource
{
    DataCaptionFields = "No.", Name;

    fields
    {
        field(50000; "Vendor Resource No."; Code[30])
        {
            Description = 'ISS2.00';
        }
    }
    var
        ResLedger: Record 203;
        ISSText000: label 'ENU=You cannot delete %1 %2 because there are one or more Ledger Entries.';

    trigger OnInsert()
    begin
        // ISS2.00 11.01.13 DFP ======================================================\
        SetDefaults;
        // End 
    end;

    trigger OnAfterDelete()
    begin
        // ISS2.00 11.02.13 DFP =======================================================\
        ResLedger.RESET;
        ResLedger.SETCURRENTKEY("Resource No.");
        ResLedger.SETRANGE("Resource No.", Rec."No.");
        IF NOT ResLedger.ISEMPTY THEN // You cannot delete %1 %2 because there are one or more Ledger Entries.
            ERROR(ISSText000, Rec.TABLECAPTION, Rec."No.");
        // End ========================================================================/
    end;

    PROCEDURE SetDefaults();
    VAR
        DefaultsSetup: Record 50016;
    BEGIN
        // ISS2.00 11.01.13 DFP ======================================================\
        IF NOT DefaultsSetup.GET THEN EXIT;
        VALIDATE("Gen. Prod. Posting Group", DefaultsSetup."R. Gen. Prod. Posting Group");
        VALIDATE("Tax Group Code", DefaultsSetup."Resource Tax Group Code");
        VALIDATE("VAT Prod. Posting Group", DefaultsSetup."R. VAT Prod. Posting Group");
        // End =======================================================================/
    END;
}
