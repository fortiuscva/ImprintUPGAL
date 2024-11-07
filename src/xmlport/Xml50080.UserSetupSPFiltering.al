xmlport 50080 "User Setup SP Filtering"
{
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
    textelement(Root)
    {
    tableelement(usersetup;
    "User Setup")
    {
    AutoReplace = false;
    AutoSave = false;
    AutoUpdate = false;
    XmlName = 'UserSetup';

    textelement(xUserID)
    {
    }
    textelement(xSupervisor)
    {
    }
    textelement(xSPCode)
    {
    }
    textelement(xSPFilter)
    {
    }
    trigger OnAfterInitRecord()
    begin
        ClearVars;
    end;
    trigger OnBeforeInsertRecord()
    begin
        xUserID:='IEINC\' + xUserID;
        if not UserSetup.Get(xUserID)then begin
            UserSetup.Init;
            UserSetup.Validate("User ID", xUserID);
            UserSetup.Insert;
        end;
        UserSetup."Sales Supervisor":=(xSupervisor = 'Yes');
        if SPerson.Get(xSPCode)then UserSetup."Salespers./Purch. Code":=xSPCode;
        UserSetup."Salesperson Filter":=xSPFilter;
        UserSetup.Modify;
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
    var SPerson: Record "Salesperson/Purchaser";
    procedure ClearVars()
    begin
        Clear(xUserID);
        Clear(xSupervisor);
        Clear(xSPCode);
        Clear(xSPFilter);
    end;
}
