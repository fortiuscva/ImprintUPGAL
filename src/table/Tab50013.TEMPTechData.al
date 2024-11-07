table 50013 "TEMP Tech Data"
{
    fields
    {
        field(13; "Mfg. Part No. (Match)"; Code[50])
        {
        }
        field(500; Instances; Integer)
        {
            CalcFormula = Count("TEMP Tech Data Detail" WHERE("Mfg. Part No. (Match)"=FIELD("Mfg. Part No. (Match)")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Mfg. Part No. (Match)")
        {
        }
    }
    fieldgroups
    {
    }
}
