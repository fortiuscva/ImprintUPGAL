xmlport 50001 "Import Last Mod. Dat"
{
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement(Contact;
    Contact)
    {
    AutoReplace = false;
    AutoSave = false;
    AutoUpdate = false;
    XmlName = 'ContactTable';
    SourceTableView = SORTING("No.")ORDER(Ascending);

    textelement(xNo)
    {
    MinOccurs = Zero;
    }
    textelement(xLastDateModified)
    {
    }
    trigger OnAfterInitRecord()
    begin
        if LabelRecordVarGbl then begin
            LabelRecordVarGbl:=false;
            currXMLport.Skip;
        end
        else
            InitColumns;
    end;
    trigger OnAfterInsertRecord()
    begin
        if not LabelRecordVarGbl then begin
            /*
                        IF (xType = 'Company') THEN BEGIN
                          CompContactRecGbl.RESET;
                          CompContactRecGbl.SETRANGE(Type,CompContactRecGbl.Type :: Company);
                          CompContactRecGbl.SETRANGE("Company Name",xCompanyName);
                          IF CompContactRecGbl.FINDFIRST THEN BEGIN
                            IF (CompContactRecGbl."Last Date Modified" < LastModDateVarGbl) THEN
                              IF NOT CompContactRecGbl."Accounts Payable Contact" THEN
                                ModifyContact := TRUE
                          END ELSE
                            CreatroeContact := TRUE;
                        */
            if xLastDateModified <> '' then begin
                Evaluate(LastModDateVarGbl, xLastDateModified);
                CompContactRecGbl.Reset;
                CompContactRecGbl.SetRange(Type, CompContactRecGbl.Type::Company);
                CompContactRecGbl.SetRange("No.", xNo);
                if CompContactRecGbl.FindFirst then begin
                    CompContactRecGbl."Last Date Modified":=LastModDateVarGbl;
                    CompContactRecGbl.Modify;
                end;
            end;
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
    trigger OnPreXmlPort()
    begin
        LabelRecordVarGbl:=true;
    end;
    var CompContactRecGbl: Record Contact;
    PersContactRecGbl: Record Contact;
    CreateContact: Boolean;
    ModifyContact: Boolean;
    LastModDateVarGbl: Date;
    ContactRecGbl: Record Contact;
    IDStatusVarGbl: Option, " ", "Cold Qualified Lead", " Customer", " Dead", " Do Not Call", " Prospect", " Secondary Contact", " Unqualified Lead", " Vendor";
    RevenueVarGbl: Decimal;
    DepartmentVarGbl: Text;
    LabelRecordVarGbl: Boolean;
    SalesperRecGbl: Record "Salesperson/Purchaser";
    SalesPerCodeVarGbl: Code[20];
    CountryCodeVarGbl: Code[10];
    CountryRecGbl: Record "Country/Region";
    procedure InitColumns()
    begin
        xNo:='';
        xLastDateModified:='';
    end;
}
