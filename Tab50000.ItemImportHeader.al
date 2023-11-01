table 50000 "Item Import Header"
{
    DrillDownPageID = "Item Import List";
    LookupPageID = "Item Import List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; "Import Date"; Date)
        {
        }
        field(6; "Import Time"; Time)
        {
        }
        field(7; "Import User ID"; Code[20])
        {
            TableRelation = User;
        }
        field(15; "Item Import Source Code"; Code[10])
        {
        }
        field(17; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
        }
        field(20; "Pricing Update Date"; Date)
        {
        }
        field(25; "Description Lock"; Boolean)
        {
        }
        field(30; "Log Type"; Option)
        {
            OptionMembers = Full, "Errors & Updates", "Errors Only";
        }
        field(50; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        ImportLine.Reset;
        ImportLine.SetRange("Document No.", Rec."No.");
        ImportLine.DeleteAll;
    end;
    var ImportLine: Record "Item Import Line";
}
