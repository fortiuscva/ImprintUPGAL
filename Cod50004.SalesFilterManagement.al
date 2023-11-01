codeunit 50004 "Sales Filter Management"
{
    trigger OnRun()
    begin
    end;
    var UserSetup: Record "User Setup";
    UserSetupFound: Boolean;
    DummyFilter: Label 'XYZ123ABC$';
    procedure GetUserSetup()
    begin
        if UserSetupFound then exit;
        if not UserSetup.Get(UserId)then Clear(UserSetup);
        if(UserSetup."Salesperson Filter" = '') and (not UserSetup."Sales Supervisor")then UserSetup."Salesperson Filter":=DummyFilter;
        UserSetupFound:=true;
    end;
    procedure CheckSupervisor()SupervisorOut: Boolean begin
        GetUserSetup;
        exit(UserSetup."Sales Supervisor");
    end;
    procedure SPFilterSalesperson(var Salesperson: Record "Salesperson/Purchaser")
    begin
        // Salesperson/Purchaser
        // Filters recordset to the User's Salesperson Filter
        GetUserSetup;
        if CheckSupervisor then exit;
        Salesperson.FilterGroup(2);
        Salesperson.SetFilter(Code, UserSetup."Salesperson Filter");
        Salesperson.FilterGroup(0);
    end;
    procedure SHFilterSalesperson(var SalesHeader: Record "Sales Header")
    begin
        // Sales Header
        // Filters recordset to the User's Salesperson Filter
        GetUserSetup;
        if CheckSupervisor then exit;
        SalesHeader.FilterGroup(2);
        SalesHeader.SetFilter("Salesperson Code", UserSetup."Salesperson Filter");
        SalesHeader.FilterGroup(0);
    end;
    procedure SHDefaultSalesperson(var SalesHeader: Record "Sales Header"; ValidateField: Boolean)
    begin
        GetUserSetup;
        if ValidateField then SalesHeader.Validate("Salesperson Code", UserSetup."Salespers./Purch. Code")
        else
            SalesHeader."Salesperson Code":=UserSetup."Salespers./Purch. Code";
    end;
    procedure PHFilterSalesperson(var PurchHeader: Record "Purchase Header")
    begin
        // Purchase Header
        // Filters recordset to the User's Salesperson Filter
        GetUserSetup;
        if CheckSupervisor then exit;
        PurchHeader.FilterGroup(2);
        PurchHeader.SetFilter("Purchaser Code", UserSetup."Salesperson Filter");
        PurchHeader.FilterGroup(0);
    end;
    procedure PHDefaultSalesperson(var PurchHeader: Record "Purchase Header"; ValidateField: Boolean)
    begin
        GetUserSetup;
        if ValidateField then PurchHeader.Validate("Purchaser Code", UserSetup."Salespers./Purch. Code")
        else
            PurchHeader."Purchaser Code":=UserSetup."Salespers./Purch. Code";
    end;
}
