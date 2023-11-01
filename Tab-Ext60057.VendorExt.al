tableextension 60057 "VendorExt" extends Vendor
{
    fields
    {
    }
    var myInt: Integer;
    trigger OnInsert()
    begin
        // ISS2.00 11.01.13 DFP ======================================================\
        SetDefaults;
    // End =======================================================================/
    end;
    PROCEDURE SetDefaults();
    VAR
        DefaultsSetup: Record 50016;
    BEGIN
        // ISS2.00 11.01.13 DFP ======================================================\
        IF NOT DefaultsSetup.GET THEN EXIT;
        VALIDATE("Vendor Posting Group", DefaultsSetup."Vendor Posting Group");
        VALIDATE("Gen. Bus. Posting Group", DefaultsSetup."V. Gen. Bus. Posting Group");
        VALIDATE("VAT Bus. Posting Group", DefaultsSetup."V. VAT Bus. Posting Group");
    // End =======================================================================/
    END;
}
