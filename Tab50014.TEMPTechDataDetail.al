table 50014 "TEMP Tech Data Detail"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(10; "Dist. Part No."; Code[20])
        {
        }
        field(11; "Mfg. Part No."; Code[50])
        {
        }
        field(13; "Mfg. Part No. (Match)"; Code[50])
        {
        }
        field(20; Description; Text[250])
        {
        }
        field(25; "Mfg. Name"; Text[200])
        {
        }
        field(26; "Mfg. Code"; Text[30])
        {
        }
        field(40; "Cat 1"; Text[100])
        {
        }
        field(41; "Cat 2"; Text[100])
        {
        }
        field(42; "Cat 3"; Text[100])
        {
        }
        field(43; "Cat 4"; Text[100])
        {
        }
        field(44; "Cat 5"; Text[100])
        {
        }
        field(45; "Cat 6"; Text[100])
        {
        }
        field(60; "Added Date"; Text[30])
        {
        }
        field(65; "List Price"; Code[20])
        {
        }
        field(70; "UPC No."; Code[30])
        {
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Mfg. Part No. (Match)")
        {
        }
    }
    fieldgroups
    {
    }
}
