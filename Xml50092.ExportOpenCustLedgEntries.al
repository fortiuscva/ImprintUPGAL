xmlport 50092 "Export Open Cust Ledg Entries"
{
    Direction = Export;
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
    textelement(Root)
    {
    tableelement("Cust. Ledger Entry";
    "Cust. Ledger Entry")
    {
    AutoUpdate = true;
    XmlName = 'CustLedgerEntry';
    SourceTableView = SORTING("Entry No.")ORDER(Ascending)WHERE(Open=CONST(true), "Salesperson Code"=FILTER('MFREEMAN'|'JMCGURRAN'));

    fieldelement(CustomerNo;
    "Cust. Ledger Entry"."Customer No.")
    {
    }
    fieldelement(PostingDate;
    "Cust. Ledger Entry"."Posting Date")
    {
    }
    fieldelement(DocumentType;
    "Cust. Ledger Entry"."Document Type")
    {
    }
    fieldelement(DocumentNo;
    "Cust. Ledger Entry"."Document No.")
    {
    }
    fieldelement(ExternalDocNo;
    "Cust. Ledger Entry"."External Document No.")
    {
    }
    fieldelement(Description;
    "Cust. Ledger Entry".Description)
    {
    }
    fieldelement(RemainingAmount;
    "Cust. Ledger Entry"."Remaining Amount")
    {
    }
    fieldelement(SellToCustomerNo;
    "Cust. Ledger Entry"."Sell-to Customer No.")
    {
    }
    fieldelement(DueDate;
    "Cust. Ledger Entry"."Due Date")
    {
    }
    fieldelement(SalesPersonCode;
    "Cust. Ledger Entry"."Salesperson Code")
    {
    }
    textelement(paymentterms)
    {
    XmlName = 'PaymentTerms';
    }
    trigger OnAfterGetRecord()
    begin
        PaymentTerms:='';
        if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Invoice then begin
            if SalesInvoiceHead.Get("Cust. Ledger Entry"."Document No.")then begin
                if SalesInvoiceHead."Payment Terms Code" <> '' then PaymentTerms:=SalesInvoiceHead."Payment Terms Code";
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
    var SalesInvoiceHead: Record "Sales Invoice Header";
}
