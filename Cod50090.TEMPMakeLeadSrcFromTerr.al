codeunit 50090 "TEMP Make Lead Src From Terr"
{
    trigger OnRun()
    begin
        if Terr.FindSet(false)then repeat LeadSource.Init;
                LeadSource.Code:=Terr.Code;
                LeadSource.Description:=Terr.Name;
                LeadSource.Insert;
            until Terr.Next = 0;
        Terr.DeleteAll;
    end;
    var Terr: Record Territory;
    LeadSource: Record "Lead Source";
}
