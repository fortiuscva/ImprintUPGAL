xmlport 50110 "Contact Data Export PRE"
{
    schema
    {
    textelement(Root)
    {
    tableelement("Business Relation";
    "Business Relation")
    {
    AutoUpdate = true;
    XmlName = 'BusinessRelation';

    fieldelement(Code;
    "Business Relation".Code)
    {
    }
    fieldelement(Description;
    "Business Relation".Description)
    {
    }
    }
    tableelement("Mailing Group";
    "Mailing Group")
    {
    AutoUpdate = true;
    XmlName = 'MailingGroup';

    fieldelement(Code;
    "Mailing Group".Code)
    {
    }
    fieldelement(Description;
    "Mailing Group".Description)
    {
    }
    }
    tableelement("Industry Group";
    "Industry Group")
    {
    AutoUpdate = true;
    XmlName = 'IndustryGroup';

    fieldelement(Code;
    "Industry Group".Code)
    {
    }
    fieldelement(Description;
    "Industry Group".Description)
    {
    }
    }
    tableelement("Interaction Group";
    "Interaction Group")
    {
    AutoUpdate = true;
    XmlName = 'InteractionGroup';

    fieldelement(Code;
    "Interaction Group".Code)
    {
    }
    fieldelement(Description;
    "Interaction Group".Description)
    {
    }
    }
    tableelement(Salutation;
    Salutation)
    {
    AutoUpdate = true;
    XmlName = 'Salutation';

    fieldelement(Code;
    Salutation.Code)
    {
    }
    fieldelement(Description;
    Salutation.Description)
    {
    }
    }
    tableelement("Organizational Level";
    "Organizational Level")
    {
    XmlName = 'OrgLevel';

    fieldelement(Code;
    "Organizational Level".Code)
    {
    }
    fieldelement(Description;
    "Organizational Level".Description)
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
