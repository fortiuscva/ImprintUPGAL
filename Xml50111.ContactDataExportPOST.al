xmlport 50111 "Contact Data Export POST"
{
    schema
    {
    textelement(Root)
    {
    tableelement("Contact Business Relation";
    "Contact Business Relation")
    {
    XmlName = 'ContactBusinessRelation';

    textelement(contactno1)
    {
    XmlName = 'ContactNo';
    }
    fieldelement(BusinessRelationCode;
    "Contact Business Relation"."Business Relation Code")
    {
    }
    fieldelement(LinkToTable;
    "Contact Business Relation"."Link to Table")
    {
    }
    textelement(linktono)
    {
    XmlName = 'No';
    }
    trigger OnAfterInitRecord()
    begin
        Clear(ContactNo1);
        Clear(LinkToNo);
    end;
    trigger OnBeforeInsertRecord()
    begin
        if not Contact.Get(ContactNo1)then currXMLport.Skip;
        case "Contact Business Relation"."Link to Table" of "Contact Business Relation"."Link to Table"::Customer: begin
            if not Customer.Get(LinkToNo)then currXMLport.Skip;
        end;
        "Contact Business Relation"."Link to Table"::Vendor: begin
            if not Vendor.Get(LinkToNo)then currXMLport.Skip;
        end;
        end;
        "Contact Business Relation"."No.":=LinkToNo;
        "Contact Business Relation"."Contact No.":=ContactNo1;
    end;
    }
    tableelement("Contact Mailing Group";
    "Contact Mailing Group")
    {
    XmlName = 'ContactMailingGroup';

    textelement(contactno2)
    {
    XmlName = 'ContactNo';
    }
    fieldelement(MailingGroupCode;
    "Contact Mailing Group"."Mailing Group Code")
    {
    }
    trigger OnAfterInitRecord()
    begin
        Clear(ContactNo2);
    end;
    trigger OnBeforeInsertRecord()
    begin
        if not Contact.Get(ContactNo2)then currXMLport.Skip;
        "Contact Mailing Group"."Contact No.":=ContactNo2;
    end;
    }
    tableelement("Contact Industry Group";
    "Contact Industry Group")
    {
    XmlName = 'ContactIndustryGroup';

    textelement(contactno3)
    {
    XmlName = 'ContactNo';
    }
    fieldelement(IndustryGroupCode;
    "Contact Industry Group"."Industry Group Code")
    {
    }
    trigger OnAfterInitRecord()
    begin
        Clear(ContactNo3);
    end;
    trigger OnBeforeInsertRecord()
    begin
        if not Contact.Get(ContactNo3)then currXMLport.Skip;
        "Contact Industry Group"."Contact No.":=ContactNo3;
    end;
    }
    tableelement("Rlshp. Mgt. Comment Line";
    "Rlshp. Mgt. Comment Line")
    {
    XmlName = 'RMCommentLine';

    fieldelement(TableName;
    "Rlshp. Mgt. Comment Line"."Table Name")
    {
    }
    textelement(contactno4)
    {
    XmlName = 'No';
    }
    fieldelement(SubNo;
    "Rlshp. Mgt. Comment Line"."Sub No.")
    {
    }
    fieldelement(LineNo;
    "Rlshp. Mgt. Comment Line"."Line No.")
    {
    }
    fieldelement(Date;
    "Rlshp. Mgt. Comment Line".Date)
    {
    }
    fieldelement(Code;
    "Rlshp. Mgt. Comment Line".Code)
    {
    }
    fieldelement(Comment;
    "Rlshp. Mgt. Comment Line".Comment)
    {
    }
    fieldelement(LastDateMod;
    "Rlshp. Mgt. Comment Line"."Last Date Modified")
    {
    }
    trigger OnAfterInitRecord()
    begin
        Clear(ContactNo4);
    end;
    trigger OnBeforeInsertRecord()
    begin
        if not Contact.Get(ContactNo4)then currXMLport.Skip;
        "Rlshp. Mgt. Comment Line"."No.":=ContactNo4;
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
    var Contact: Record Contact;
    Customer: Record Customer;
    Vendor: Record Vendor;
}
