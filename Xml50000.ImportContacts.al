xmlport 50000 "Import Contacts"
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
    textelement(xType)
    {
    MinOccurs = Zero;
    }
    textelement(xCompanyNo)
    {
    MinOccurs = Zero;
    }
    textelement(xCompanyName)
    {
    MinOccurs = Zero;
    }
    textelement(xName)
    {
    MinOccurs = Zero;
    }
    textelement(xJobTitle)
    {
    MinOccurs = Zero;
    }
    textelement(xDepartment)
    {
    MinOccurs = Zero;
    }
    textelement(xAddress)
    {
    MinOccurs = Zero;
    }
    textelement(xAddress2)
    {
    MinOccurs = Zero;
    }
    textelement(xCity)
    {
    MinOccurs = Zero;
    }
    textelement(xState)
    {
    MinOccurs = Zero;
    }
    textelement(xPostCode)
    {
    MinOccurs = Zero;
    }
    textelement(xCounty)
    {
    MinOccurs = Zero;
    }
    textelement(xPhoneNo)
    {
    MinOccurs = Zero;
    }
    textelement(xExtensionNo)
    {
    MinOccurs = Zero;
    }
    textelement(xSalesperson)
    {
    MinOccurs = Zero;
    }
    textelement(xIDStatus)
    {
    MinOccurs = Zero;
    }
    textelement(xLeadSourceCode)
    {
    MinOccurs = Zero;
    }
    textelement(xSalutaionCode)
    {
    MinOccurs = Zero;
    }
    textelement(xCountryRegCode)
    {
    MinOccurs = Zero;
    }
    textelement(xMobilePhone)
    {
    MinOccurs = Zero;
    }
    textelement(xFaxNo)
    {
    }
    textelement(xEmail)
    {
    MinOccurs = Zero;
    }
    textelement(xHomePage)
    {
    MinOccurs = Zero;
    }
    textelement(xLastModDate)
    {
    MinOccurs = Zero;
    }
    textelement(xUser1)
    {
    MinOccurs = Zero;
    }
    textelement(xUser2)
    {
    MinOccurs = Zero;
    }
    textelement(xUser3)
    {
    MinOccurs = Zero;
    }
    textelement(xUser4)
    {
    MinOccurs = Zero;
    }
    textelement(xUser5)
    {
    MinOccurs = Zero;
    }
    textelement(xUser6)
    {
    MinOccurs = Zero;
    }
    textelement(xUser7)
    {
    MinOccurs = Zero;
    }
    textelement(xUser8)
    {
    MinOccurs = Zero;
    }
    textelement(xUser9)
    {
    MinOccurs = Zero;
    }
    textelement(xUser10)
    {
    MinOccurs = Zero;
    }
    textelement(xPrinters)
    {
    MinOccurs = Zero;
    }
    textelement(xCooling)
    {
    MinOccurs = Zero;
    }
    textelement(xScanners)
    {
    MinOccurs = Zero;
    }
    textelement(xPower)
    {
    MinOccurs = Zero;
    }
    textelement(xServiceContract)
    {
    MinOccurs = Zero;
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
            Clear(CreateContact);
            Clear(ModifyContact);
            Clear(SalesPerCodeVarGbl);
            Clear(CountryCodeVarGbl);
            if xUser8 <> '' then Evaluate(RevenueVarGbl, xUser8);
            if xLastModDate <> '' then Evaluate(LastModDateVarGbl, xLastModDate);
            /*
                        IF xSalesperson <> '' THEN BEGIN
                          SalesperRecGbl.RESET;
                          SalesperRecGbl.SETRANGE(Name,xSalesperson);
                          SalesperRecGbl.FINDFIRST;
                          SalesPerCodeVarGbl := SalesperRecGbl.Code;
                        END;
                        */
            SalesPerCodeVarGbl:=xSalesperson;
            if xCountryRegCode <> '' then begin
                CountryRecGbl.Reset;
                //CountryRecGbl.SETRANGE(Name,xCountryRegCode);
                CountryRecGbl.SetRange(Code, xCountryRegCode);
                CountryRecGbl.FindFirst;
                CountryCodeVarGbl:=CountryRecGbl.Code;
            end;
            if(xType = 'Company')then begin
                CompContactRecGbl.Reset;
                CompContactRecGbl.SetRange(Type, CompContactRecGbl.Type::Company);
                CompContactRecGbl.SetRange("Company Name", xCompanyName);
                if CompContactRecGbl.FindFirst then begin
                    if(CompContactRecGbl."Last Date Modified" < LastModDateVarGbl)then if not CompContactRecGbl."Accounts Payable Contact" then ModifyContact:=true end
                else
                    CreateContact:=true;
            end
            else if(xType = 'Person')then begin
                    CompContactRecGbl.Reset;
                    CompContactRecGbl.SetRange(Type, CompContactRecGbl.Type::Company);
                    CompContactRecGbl.SetRange("Company Name", xCompanyName);
                    if CompContactRecGbl.FindFirst then begin
                        PersContactRecGbl.Reset;
                        PersContactRecGbl.SetRange(Type, PersContactRecGbl.Type::Person);
                        PersContactRecGbl.SetRange("Company Name", xCompanyName);
                        PersContactRecGbl.SetRange(Name, xName);
                        if PersContactRecGbl.FindFirst then begin
                            if(PersContactRecGbl."Last Date Modified" < LastModDateVarGbl)then if not CompContactRecGbl."Accounts Payable Contact" then ModifyContact:=true end
                        else
                            CreateContact:=true;
                    end;
                end;
            if CreateContact then begin
                ContactRecGbl.Init;
                ContactRecGbl."No.":='';
                if(xType = 'Company')then ContactRecGbl.Type:=ContactRecGbl.Type::Company
                else if(xType = 'Person')then ContactRecGbl.Type:=ContactRecGbl.Type::Person;
                ContactRecGbl.Insert(true);
                if(xType = 'Company')then begin
                    ContactRecGbl.Validate(Name, xCompanyName);
                end
                else if(xType = 'Person')then begin
                        ContactRecGbl.Validate("Company No.", CompContactRecGbl."No.");
                        ContactRecGbl.Validate("Company Name", xCompanyName);
                        ContactRecGbl.Validate(Name, xName);
                    end;
                TransferFields(ContactRecGbl);
                ContactRecGbl.Modify(true);
            end
            else if ModifyContact then begin
                    if(xType = 'Company')then begin
                        TransferFields(CompContactRecGbl);
                        CompContactRecGbl.Modify(true);
                    end
                    else if(xType = 'Person')then begin
                            TransferFields(PersContactRecGbl);
                            PersContactRecGbl.Modify(true);
                        end;
                end;
        end
        else
            LabelRecordVarGbl:=false;
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
        xType:='';
        xCompanyNo:='';
        xCompanyName:='';
        xName:='';
        xJobTitle:='';
        xDepartment:='';
        xAddress:='';
        xAddress2:='';
        xCity:='';
        xState:='';
        xPostCode:='';
        xCounty:='';
        xPhoneNo:='';
        xExtensionNo:='';
        xSalesperson:='';
        xIDStatus:='';
        xLeadSourceCode:='';
        xSalutaionCode:='';
        xCountryRegCode:='';
        xMobilePhone:='';
        xFaxNo:='';
        xEmail:='';
        xHomePage:='';
        xLastModDate:='';
        xUser1:='';
        xUser2:='';
        xUser3:='';
        xUser4:='';
        xUser5:='';
        xUser6:='';
        xUser7:='';
        xUser8:='';
        xUser9:='';
        xUser10:='';
        xPrinters:='';
        xCooling:='';
        xScanners:='';
        xPower:='';
        xServiceContract:='';
    end;
    procedure TransferFields(var ContactRecPar: Record Contact)
    begin
        ContactRecPar.Validate("Job Title", xJobTitle);
        ContactRecPar.Validate(Department, DepartmentVarGbl);
        ContactRecPar.Validate(Address, xAddress);
        ContactRecPar.Validate("Address 2", xAddress2);
        ContactRecPar.Validate(City, xCity);
        ContactRecPar.Validate(County, xState);
        ContactRecPar.Validate("Post Code", xPostCode);
        ContactRecPar.Validate("County Name", xCounty);
        ContactRecPar.Validate("Phone No.", xPhoneNo);
        ContactRecPar.Validate("Extension No.", xExtensionNo);
        ContactRecPar.Validate("Salesperson Code", SalesPerCodeVarGbl);
        ContactRecPar.Validate(ID_Status, IDStatusVarGbl);
        ContactRecPar.Validate("Lead Source Code", xLeadSourceCode);
        ContactRecPar.Validate("Salutation Code", xSalutaionCode);
        ContactRecPar.Validate("Country/Region Code", CountryCodeVarGbl);
        ContactRecPar.Validate("Mobile Phone No.", xMobilePhone);
        ContactRecPar.Validate("Fax No.", xFaxNo);
        ContactRecPar.Validate("E-Mail", xEmail);
        ContactRecPar.Validate("Home Page", xHomePage);
        ContactRecPar.Validate("Last Date Modified", LastModDateVarGbl);
        ContactRecPar.Validate("SIC Code", xUser1);
        ContactRecPar.Validate("Automated Pkg", xUser2);
        ContactRecPar.Validate("User 3", xUser3);
        ContactRecPar.Validate("User 4", xUser4);
        ContactRecPar.Validate("Mailing Data", xUser5);
        ContactRecPar.Validate("Lead Group ID", xUser6);
        ContactRecPar.Validate("User 7", xUser7);
        ContactRecPar.Validate(Revenue, RevenueVarGbl);
        ContactRecPar.Validate("Product Type", xUser9);
        ContactRecPar.Validate(Employees, xUser10);
        UpdatePrinters(ContactRecPar, xPrinters);
        UpdateBagging(ContactRecPar, xCooling);
        UpdateScanners(ContactRecPar, xScanners);
        UpdateSoftware(ContactRecPar, xPower);
        UpdateServieContract(ContactRecPar, xServiceContract);
    end;
    procedure UpdatePrinters(var ContactRecPar: Record Contact; SplitTxtVarPar: Text)
    var
        SplitTxtVarLcl: Text;
        SrchStr: Text;
        StopLoop: Boolean;
        NewStr: Text;
        Pos: Integer;
        CommaPos: Integer;
        ColonPos: Integer;
    begin
        SplitTxtVarLcl:=SplitTxtVarPar;
        repeat Clear(StopLoop);
            Clear(NewStr);
            CommaPos:=StrPos(SplitTxtVarLcl, ',');
            ColonPos:=StrPos(SplitTxtVarLcl, ';');
            if(CommaPos = 0) and (ColonPos = 0)then Pos:=0
            else
            begin
                if(CommaPos < ColonPos)then begin
                    if CommaPos <> 0 then Pos:=CommaPos
                    else
                        Pos:=ColonPos end
                else
                begin
                    if ColonPos <> 0 then Pos:=ColonPos
                    else
                        Pos:=CommaPos;
                end;
            end;
            if Pos = 0 then begin
                NewStr:=CopyStr(SplitTxtVarLcl, 1, StrLen(SplitTxtVarLcl));
                StopLoop:=true;
            end
            else
            begin
                NewStr:=CopyStr(SplitTxtVarLcl, 1, Pos - 1);
                SplitTxtVarLcl:=DelStr(SplitTxtVarLcl, 1, Pos);
            end;
            if UpperCase(NewStr) = 'BRADY' then ContactRecPar."Printers - Brady":=true
            else if UpperCase(NewStr) = 'DATAMAX' then ContactRecPar."Printers - Datamax":=true
                else if UpperCase(NewStr) = 'EPSON' then ContactRecPar."Printers - Epson":=true
                    else if UpperCase(NewStr) = 'GHS PRINTING' then ContactRecPar."Printers - GHS Printing":=true
                        else if UpperCase(NewStr) = 'GODEX' then ContactRecPar."Printers - Godex":=true
                            else if UpperCase(NewStr) = 'HP' then ContactRecPar."Printers - HP":=true
                                else if UpperCase(NewStr) = 'INTERMEC' then ContactRecPar."Printers - Intermec":=true
                                    else if UpperCase(NewStr) = 'PRINTRONIX' then ContactRecPar."Printers - Printronix":=true
                                        else if UpperCase(NewStr) = 'SATO' then ContactRecPar."Printers - Sato":=true
                                            else if UpperCase(NewStr) = 'VOID FILL' then ContactRecPar."Printers - Void Fill":=true
                                                else if UpperCase(NewStr) = 'ZEBRA' then ContactRecPar."Printers - Zebra":=true
                                                    else if UpperCase(NewStr) = 'CAB' then ContactRecPar."Printers - CAB":=true
                                                        else if UpperCase(NewStr) = 'MARKEM' then ContactRecPar."Printers - MARKEM":=true
                                                            else if UpperCase(NewStr) = 'PRIMERA' then ContactRecPar."Printers - Primera":=true
                                                                else if UpperCase(NewStr) = 'TSC' then ContactRecPar."Printers - TSC":=true
                                                                    else if UpperCase(NewStr) = 'VIDEOJET' then ContactRecPar."Printers - VIDEOJET":=true
                                                                        else if UpperCase(NewStr) = 'NONE' then ContactRecPar."Printers - None":=true
                                                                            else
                                                                            begin
                                                                                if ContactRecPar."Printers - Model / Details" <> '' then ContactRecPar."Printers - Model / Details"+=',' + NewStr
                                                                                else
                                                                                    ContactRecPar."Printers - Model / Details":=NewStr;
                                                                            end;
        until StopLoop;
    end;
    procedure UpdateBagging(var ContactRecPar: Record Contact; SplitTxtVarPar: Text)
    var
        SplitTxtVarLcl: Text;
        SrchStr: Text;
        StopLoop: Boolean;
        NewStr: Text;
        Pos: Integer;
        CommaPos: Integer;
        ColonPos: Integer;
    begin
        SplitTxtVarLcl:=SplitTxtVarPar;
        repeat Clear(StopLoop);
            Clear(NewStr);
            CommaPos:=StrPos(SplitTxtVarLcl, ',');
            ColonPos:=StrPos(SplitTxtVarLcl, ';');
            if(CommaPos = 0) and (ColonPos = 0)then Pos:=0
            else
            begin
                if(CommaPos < ColonPos)then begin
                    if CommaPos <> 0 then Pos:=CommaPos
                    else
                        Pos:=ColonPos end
                else
                begin
                    if ColonPos <> 0 then Pos:=ColonPos
                    else
                        Pos:=CommaPos;
                end;
            end;
            if Pos = 0 then begin
                NewStr:=CopyStr(SplitTxtVarLcl, 1, StrLen(SplitTxtVarLcl));
                StopLoop:=true;
            end
            else
            begin
                NewStr:=CopyStr(SplitTxtVarLcl, 1, Pos - 1);
                SplitTxtVarLcl:=DelStr(SplitTxtVarLcl, 1, Pos);
            end;
            if UpperCase(NewStr) = 'AUTOMATED PACKAGING' then ContactRecPar."Bagging - Automated Packaging":=true
            else
            begin
                if ContactRecPar."Bagging - Model / Details" <> '' then ContactRecPar."Bagging - Model / Details"+=',' + NewStr
                else
                    ContactRecPar."Bagging - Model / Details":=NewStr;
            end;
        until StopLoop;
    end;
    procedure UpdateScanners(var ContactRecPar: Record Contact; SplitTxtVarPar: Text)
    var
        SplitTxtVarLcl: Text;
        SrchStr: Text;
        StopLoop: Boolean;
        NewStr: Text;
        Pos: Integer;
        CommaPos: Integer;
        ColonPos: Integer;
    begin
        SplitTxtVarLcl:=SplitTxtVarPar;
        repeat Clear(StopLoop);
            Clear(NewStr);
            CommaPos:=StrPos(SplitTxtVarLcl, ',');
            ColonPos:=StrPos(SplitTxtVarLcl, ';');
            if(CommaPos = 0) and (ColonPos = 0)then Pos:=0
            else
            begin
                if(CommaPos < ColonPos)then begin
                    if CommaPos <> 0 then Pos:=CommaPos
                    else
                        Pos:=ColonPos end
                else
                begin
                    if ColonPos <> 0 then Pos:=ColonPos
                    else
                        Pos:=CommaPos;
                end;
            end;
            if Pos = 0 then begin
                NewStr:=CopyStr(SplitTxtVarLcl, 1, StrLen(SplitTxtVarLcl));
                StopLoop:=true;
            end
            else
            begin
                NewStr:=CopyStr(SplitTxtVarLcl, 1, Pos - 1);
                SplitTxtVarLcl:=DelStr(SplitTxtVarLcl, 1, Pos);
            end;
            if UpperCase(NewStr) = 'DATALOGIC' then ContactRecPar."Scanners - Datalogic":=true
            else if UpperCase(NewStr) = 'HONEYWELL' then ContactRecPar."Scanners - Honeywell":=true
                else if UpperCase(NewStr) = 'INTERMEC' then ContactRecPar."Scanners - Intermec":=true
                    else if UpperCase(NewStr) = 'MANY VARIOUS' then ContactRecPar."Scanners - Many Various":=true
                        else if UpperCase(NewStr) = 'ZEBRA/MOTOROLA/SYMB' then ContactRecPar."Scanners - Zebra/Motorola/Symb":=true
                            else if UpperCase(NewStr) = 'NONE' then ContactRecPar."Scanners - None":=true
                                else
                                begin
                                    if ContactRecPar."Scanners - Model / Details" <> '' then ContactRecPar."Scanners - Model / Details"+=',' + NewStr
                                    else
                                        ContactRecPar."Scanners - Model / Details":=NewStr;
                                end;
        until StopLoop;
    end;
    procedure UpdateSoftware(var ContactRecPar: Record Contact; SplitTxtVarPar: Text)
    var
        SplitTxtVarLcl: Text;
        SrchStr: Text;
        StopLoop: Boolean;
        NewStr: Text;
        Pos: Integer;
        CommaPos: Integer;
        ColonPos: Integer;
    begin
        SplitTxtVarLcl:=SplitTxtVarPar;
        repeat Clear(StopLoop);
            Clear(NewStr);
            CommaPos:=StrPos(SplitTxtVarLcl, ',');
            ColonPos:=StrPos(SplitTxtVarLcl, ';');
            if(CommaPos = 0) and (ColonPos = 0)then Pos:=0
            else
            begin
                if(CommaPos < ColonPos)then begin
                    if CommaPos <> 0 then Pos:=CommaPos
                    else
                        Pos:=ColonPos end
                else
                begin
                    if ColonPos <> 0 then Pos:=ColonPos
                    else
                        Pos:=CommaPos;
                end;
            end;
            if Pos = 0 then begin
                NewStr:=CopyStr(SplitTxtVarLcl, 1, StrLen(SplitTxtVarLcl));
                StopLoop:=true;
            end
            else
            begin
                NewStr:=CopyStr(SplitTxtVarLcl, 1, Pos - 1);
                SplitTxtVarLcl:=DelStr(SplitTxtVarLcl, 1, Pos);
            end;
            if UpperCase(NewStr) = 'BARTENDER' then ContactRecPar."Software - Bartender":=true
            else if UpperCase(NewStr) = 'LOFTWARE' then ContactRecPar."Software - Loftware":=true
                else if UpperCase(NewStr) = 'NICELABEL' then ContactRecPar."Software - Nicelabel":=true
                    else if UpperCase(NewStr) = 'OTHER' then ContactRecPar."Software - Other":=true
                        else if UpperCase(NewStr) = 'TEKLYNX' then ContactRecPar."Software - Teklynx":=true
                            else
                            begin
                                if ContactRecPar."Software - Details" <> '' then ContactRecPar."Software - Details"+=',' + NewStr
                                else
                                    ContactRecPar."Software - Details":=NewStr;
                            end;
        until StopLoop;
    end;
    procedure UpdateServieContract(var ContactRecPar: Record Contact; SplitTxtVarPar: Text)
    var
        SplitTxtVarLcl: Text;
        SrchStr: Text;
        StopLoop: Boolean;
        NewStr: Text;
        Pos: Integer;
        CommaPos: Integer;
        ColonPos: Integer;
    begin
        SplitTxtVarLcl:=SplitTxtVarPar;
        repeat Clear(StopLoop);
            Clear(NewStr);
            CommaPos:=StrPos(SplitTxtVarLcl, ',');
            ColonPos:=StrPos(SplitTxtVarLcl, ';');
            if(CommaPos = 0) and (ColonPos = 0)then Pos:=0
            else
            begin
                if(CommaPos < ColonPos)then begin
                    if CommaPos <> 0 then Pos:=CommaPos
                    else
                        Pos:=ColonPos end
                else
                begin
                    if ColonPos <> 0 then Pos:=ColonPos
                    else
                        Pos:=CommaPos;
                end;
            end;
            if Pos = 0 then begin
                NewStr:=CopyStr(SplitTxtVarLcl, 1, StrLen(SplitTxtVarLcl));
                StopLoop:=true;
            end
            else
            begin
                NewStr:=CopyStr(SplitTxtVarLcl, 1, Pos - 1);
                SplitTxtVarLcl:=DelStr(SplitTxtVarLcl, 1, Pos);
            end;
            if UpperCase(NewStr) = 'APC' then ContactRecPar."Service Contracts - APC":=true
            else if UpperCase(NewStr) = 'BARTENDER' then ContactRecPar."Service Contracts - Bartender":=true
                else if UpperCase(NewStr) = 'HONEYWELL' then ContactRecPar."Service Contracts - Honeywell":=true
                    else if UpperCase(NewStr) = 'IMPRINT' then ContactRecPar."Service Contracts - Imprint":=true
                        else if UpperCase(NewStr) = 'NSC' then ContactRecPar."Service Contracts - NSC":=true
                            else if UpperCase(NewStr) = 'ZEBRA/MOTO' then ContactRecPar."Service Contracts - Zebra/Moto":=true
                                else
                                begin
                                    if ContactRecPar."Service Contracts - Details" <> '' then ContactRecPar."Service Contracts - Details"+=',' + NewStr
                                    else
                                        ContactRecPar."Service Contracts - Details":=NewStr;
                                end;
        until StopLoop;
    end;
}
