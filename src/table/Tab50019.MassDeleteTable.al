table 50019 "Mass Delete Table"
{
    fields
    {
        field(1; "Table No."; Integer)
        {
        }
        field(5; "Table Name"; Text[30])
        {
        }
        field(80; "No. of Records"; Integer)
        {
        }
        field(100; "Delete Table"; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Table No.")
        {
        }
    }
    fieldgroups
    {
    }
    procedure PopulateTables()
    var
        //TableInfo: Record "Table Information"; //UPGCloud
        MassDeleteTable: Record "Mass Delete Table";
    begin
    //UPGCloud >>
    /*
        TableInfo.Reset;
        TableInfo.SetRange("Company Name", CompanyName);
        if TableInfo.FindSet(false) then
            repeat
                if not MassDeleteTable.Get(TableInfo."Table No.") then begin
                    MassDeleteTable.Init;
                    MassDeleteTable."Table No." := TableInfo."Table No.";
                    MassDeleteTable."Table Name" := TableInfo."Table Name";
                    MassDeleteTable.Insert;
                end;
                if MassDeleteTable."No. of Records" <> TableInfo."No. of Records" then begin
                    MassDeleteTable."No. of Records" := TableInfo."No. of Records";
                    MassDeleteTable.Modify;
                end;
            until TableInfo.Next = 0;
            */
    //UPGCloud <<
    end;
}
