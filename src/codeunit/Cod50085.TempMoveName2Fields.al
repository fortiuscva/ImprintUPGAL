codeunit 50085 "Temp Move Name 2 Fields"
{
    trigger OnRun()
    begin
        Customer.Reset;
        if Customer.FindSet(false)then repeat Customer."AP Contact":=Customer."Name 2";
                Customer."Name 2":='';
                Customer."AP Phone No.":=Customer."Telex No.";
                Customer."Telex No.":='';
                Customer.Modify;
            until Customer.Next = 0;
        ShipTo.Reset;
        ShipTo.ModifyAll("Name 2", '');
        SalesHeader.Reset;
        SalesHeader.ModifyAll("Sell-to Customer Name 2", '');
        SalesHeader.ModifyAll("Ship-to Name 2", '');
        SalesHeader.ModifyAll("Bill-to Name 2", '');
        Message('Process complete.');
    end;
    var Customer: Record Customer;
    ShipTo: Record "Ship-to Address";
    SalesHeader: Record "Sales Header";
}
