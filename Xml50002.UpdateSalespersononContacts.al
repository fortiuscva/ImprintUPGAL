xmlport 50002 "Update Salesperson on Contacts"
{
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
    textelement(Root)
    {
    tableelement(Contact;
    Contact)
    {
    AutoSave = false;
    XmlName = 'Contacts';

    textelement(ContactNo)
    {
    }
    textelement(Salesperson)
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        if ContactRecGbl.Get(ContactNo)then begin
            ContactRecGbl.Validate("Salesperson Code", Salesperson);
            ContactRecGbl.Modify;
        end;
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
    var ContactRecGbl: Record Contact;
}
