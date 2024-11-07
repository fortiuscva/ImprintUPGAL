xmlport 50079 "ScanSource Item Categories"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement(importcatconv;
    "Item Import Cat. Conversion")
    {
    XmlName = 'ImportCatConv';

    fieldelement(ItemCat1;
    ImportCatConv."Import Category 1")
    {
    }
    fieldelement(ItemCat2;
    ImportCatConv."Import Category 2")
    {
    }
    fieldelement(ItemCat3;
    ImportCatConv."Import Category 3")
    {
    }
    fieldelement(ItemCatCode;
    ImportCatConv."Item Category Code")
    {
    trigger OnAfterAssignField()
    begin
        CreateItemCat(ImportCatConv."Item Category Code");
    end;
    }
    trigger OnAfterInitRecord()
    begin
        ImportCatConv.Init;
    end;
    trigger OnBeforeInsertRecord()
    begin
        ImportCatConv."Item Import Source Code":=ImportSourceCode;
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
    trigger OnPreXmlPort()
    begin
        ImportSourceCode:='SCANSOURCE';
    end;
    var ImportSourceCode: Code[10];
    procedure ResetVars()
    begin
    /*
        clear(itemcat1);
        clear(itemcat2);
        clear(itemcat3);
        clear(itemcatcode);
        */
    end;
    procedure CreateItemCat(ItemCatIn: Code[10])
    var
        ItemCat: Record "Item Category";
    begin
        if ItemCat.Get(ItemCatIn)then exit;
        ItemCat.Init;
        ItemCat.Code:=ItemCatIn;
        ItemCat.Description:='Imported';
        ItemCat.Insert;
    end;
}
