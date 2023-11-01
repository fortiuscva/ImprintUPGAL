xmlport 50005 "Bartender - Test"
{
    schema
    {
    textelement(Root)
    {
    tableelement("Purch. Rcpt. Line";
    "Purch. Rcpt. Line")
    {
    XmlName = 'PurchReceipt';
    SourceTableView = SORTING("Document No.", "Line No.")ORDER(Ascending)WHERE("Document No."=FILTER('PR094715'));

    fieldelement(PO;
    "Purch. Rcpt. Line"."Order No.")
    {
    }
    fieldelement("Part";
    "Purch. Rcpt. Line"."No.")
    {
    }
    fieldelement(Description;
    "Purch. Rcpt. Line".Description)
    {
    }
    fieldelement(Quantity;
    "Purch. Rcpt. Line".Quantity)
    {
    }
    fieldelement(CustomerNo;
    "Purch. Rcpt. Line"."Customer No.")
    {
    }
    fieldelement(CustomerName;
    "Purch. Rcpt. Line"."Customer Name")
    {
    }
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
}
