codeunit 50009 "Unblock/Reblock Customer"
{
    trigger OnRun()
    begin
        // TRUE to Unblock; FALSE to Reblock
        UnblockCust:=false;
        Customer.Reset;
        PBMgt.OpenProgressBar('Customers', Customer.Count, false, true);
        if Customer.FindSet(false)then repeat PBMgt.UpdateProgressBar;
                if UnblockCust then begin
                    // Unblock Customers
                    if Customer.Blocked <> Customer.Blocked::" " then begin
                        Customer.TestField("Responsibility Center", '');
                        Customer."Responsibility Center":=Format(Customer.Blocked);
                        Customer.Blocked:=Customer.Blocked::" ";
                        Customer.Modify;
                    end;
                end
                else
                begin
                    // Reblock Customers
                    if Customer."Responsibility Center" <> '' then begin
                        Evaluate(Customer.Blocked, Customer."Responsibility Center");
                        Customer."Responsibility Center":='';
                        Customer.Modify;
                    end;
                end;
            until Customer.Next = 0;
        PBMgt.CloseProgressBar;
        Message('Process complete.');
    end;
    var Customer: Record Customer;
    PBMgt: Codeunit "Progress Bar Management";
    UnblockCust: Boolean;
}
