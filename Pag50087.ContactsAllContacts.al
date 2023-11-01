page 50087 "Contacts - All Contacts"
{
    // ISS2.00 11.08.13 DFP - Added call to FilterSalesperson in OnOpenPage
    // ISS2.00 07.25.13 DFP - Added field:
    //                          50100 "Lead Source Code" after "Salesperson Code"
    // IMP1.01,SP5333,12/15/16,ST: Added code to OnOpenPage()/.
    //                             Declared Goal Variable.
    Caption = 'Contact List';
    CardPageID = "Contact Card";
    DataCaptionFields = "Company No.";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = false;
    PageType = List;
    SaveValues = false;
    ShowFilter = true;
    SourceTable = Contact;
    SourceTableView = SORTING("Company Name", "Company No.", Type, Name);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'NAV Customer ID#';
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Caption = 'Last edit date';
                    ApplicationArea = All;
                }
                field(ID_Status; Rec.ID_Status)
                {
                    Caption = 'ID Status';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Lead Source Code"; Rec."Lead Source Code")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    Caption = 'State';
                    ApplicationArea = All;
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        EnableFields;
        StyleIsStrong:=Rec.Type = Rec.Type::Company;
        NameIndent:=0;
        if Rec.Type <> Rec.Type::Company then begin
            Cont.SetCurrentKey("Company Name", "Company No.", Type, Name);
            if(Rec."Company No." <> '') and (not Rec.HasFilter) and (not Rec.MarkedOnly) and (Rec.CurrentKey = Cont.CurrentKey)then NameIndent:=1 end;
    end;
    trigger OnOpenPage()
    begin
        /*
        // ISS2.00 DFP =========================================================\
        FilterSalesperson;
        // End =================================================================/
        */
        //IMP1.01 Start
        UserNameVarGbl:=CopyStr(UserId, 7);
    //SETRANGE("Salesperson Code",UserNameVarGbl);
    //IMP1.01 Emd
    end;
    var Cont: Record Contact;
    [InDataSet]
    StyleIsStrong: Boolean;
    [InDataSet]
    NameIndent: Integer;
    CompanyGroupEnabled: Boolean;
    PersonGroupEnabled: Boolean;
    "-IMP1.01-": Integer;
    UserNameVarGbl: Text;
    local procedure EnableFields()
    begin
        CompanyGroupEnabled:=Rec.Type = Rec.Type::Company;
        PersonGroupEnabled:=Rec.Type = Rec.Type::Person;
    end;
}
