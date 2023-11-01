xmlport 50081 "Bin Import"
{
    schema
    {
    textelement(Root)
    {
    tableelement(Bin;
    Bin)
    {
    XmlName = 'Bin';

    fieldelement(Code;
    Bin.Code)
    {
    }
    fieldelement(Description;
    Bin.Description)
    {
    }
    trigger OnAfterInitRecord()
    begin
        Clear(Bin);
    end;
    trigger OnBeforeInsertRecord()
    begin
        Bin."Location Code":='NAPERVILLE';
    end;
    }
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
}
