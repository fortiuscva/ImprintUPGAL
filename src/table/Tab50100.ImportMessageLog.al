table 50100 "Import Message Log"
{
    fields
    {
        field(1; "Import Code"; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(11; "Import Date"; Date)
        {
        }
        field(12; "Import Time"; Time)
        {
        }
        field(40; "Msg. Code"; Code[3])
        {
        }
        field(55; "Msg. Description"; Text[100])
        {
        }
        field(60; "Msg. Result"; Text[100])
        {
        }
        field(65; "Msg. Type"; Option)
        {
            OptionMembers = " ",Info,Error;
        }
        field(100; "Ref. 1 Name"; Text[30])
        {
        }
        field(101; "Ref. 1 Value"; Code[20])
        {
        }
        field(105; "Ref. 2 Name"; Text[30])
        {
        }
        field(106; "Ref. 2 Value"; Code[20])
        {
        }
        field(110; "Ref. 3 Name"; Text[30])
        {
        }
        field(111; "Ref. 3 Value"; Code[20])
        {
        }
    }
    keys
    {
        key(Key1; "Import Code", "Line No.")
        {
        }
    }
    fieldgroups
    {
    }
    var
        ImportCode: Code[20];
        ImportDate: Date;
        ImportTime: Time;
        NextLineNo: Integer;
        Text001: Label 'Please use the StartImport function to use the %1.';
        Text002: Label 'No Import Messages were generated.';

    local procedure TestStarted()
    begin
        // This function tests to make sure StartImport was called and parameters are set
        // Local access only
        if ImportCode = '' then // Please use the StartImport function to use the %1.
            Error(Text001, TableCaption);
    end;

    procedure StartImport(ImportCodeIn: Code[20])
    begin
        // This function will delete existing Message Log for this Import Code and set the parameters
        // Call on start of the Import
        Reset;
        SetRange("Import Code", ImportCodeIn);
        DeleteAll;
        NextLineNo := 10;
        ImportCode := ImportCodeIn;
        ImportDate := Today;
        ImportTime := Time;
    end;

    procedure LogMsg(MsgCode: Code[3]; MsgDesc: Text[100]; MsgResult: Text[100]; MsgType: Integer; Ref1Name: Text[30]; Ref1Value: Text[200]; Ref2Name: Text[30]; Ref2Value: Text[200]; Ref3Name: Text[30]; Ref3Value: Text[200])
    begin
        // This function will create a Message Log
        TestStarted;
        Init;
        "Import Code" := ImportCode;
        "Line No." := NextLineNo;
        NextLineNo += 10;
        "Import Date" := ImportDate;
        "Import Time" := ImportTime;
        "Msg. Code" := MsgCode;
        "Msg. Description" := MsgDesc;
        "Msg. Result" := MsgResult;
        "Msg. Type" := MsgType;
        "Ref. 1 Name" := Ref1Name;
        "Ref. 1 Value" := Ref1Value;
        "Ref. 2 Name" := Ref2Name;
        "Ref. 2 Value" := Ref2Value;
        "Ref. 3 Name" := Ref3Name;
        "Ref. 3 Value" := Ref3Value;
        Insert;
    end;

    procedure ShowMsg()
    begin
        // This function will run the Import Message Form
        // Call on completion of the Import
        TestStarted;
        if Count = 0 then // No Import Messages were generated.
            Message(Text002);
        //FORM.RUN(0,Rec);
    end;
}
