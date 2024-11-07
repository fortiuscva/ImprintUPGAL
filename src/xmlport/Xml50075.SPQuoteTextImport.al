xmlport 50075 "SP Quote Text Import"
{
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
    textelement(Root)
    {
    tableelement(spcompinfo;
    "Salesperson Company Info")
    {
    AutoSave = true;
    AutoUpdate = true;
    XmlName = 'SPCompInfo';
    SourceTableView = SORTING("Salesperson Code");

    fieldelement(Code;
    SPCompInfo."Salesperson Code")
    {
    }
    fieldelement(Quote1;
    SPCompInfo."Quote Text 1")
    {
    }
    fieldelement(Quote2;
    SPCompInfo."Quote Text 2")
    {
    }
    fieldelement(Quote3;
    SPCompInfo."Quote Text 3")
    {
    }
    fieldelement(Quote4;
    SPCompInfo."Quote Text 4")
    {
    }
    fieldelement(DocTagLine;
    SPCompInfo."Document Tag Line")
    {
    }
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
