report 50049 "***Find Mismatch Drop Ship"
{
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/Find Mismatch Drop Ship.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            column(SalesNo; "Sales Line"."Document No.")
            {
            }
            column(PoNo; "Sales Line"."Purchase Order No.")
            {
            }
            column(PoLine; "Sales Line"."Purch. Order Line No.")
            {
            }
            column(Message; PrintMessage)
            {
            }
            trigger OnAfterGetRecord()
            begin
                PrintMessage := '';
                if ("Purchase Order No." <> '') and ("Purch. Order Line No." <> 0) then begin
                    PL.Reset;
                    PL.SetRange("Document No.", "Purchase Order No.");
                    PL.SetRange("Line No.", "Purch. Order Line No.");
                    if PL.FindFirst then begin
                        if "No." <> PL."No." then begin
                            PL2.Reset;
                            PL2.SetRange("Document No.", "Purchase Order No.");
                            PL2.SetRange("No.", "No.");
                            if PL2.FindFirst then begin
                                "Purch. Order Line No." := PL2."Line No.";
                                Modify;
                                PrintMessage := 'FIXED';
                            end
                            else
                                CurrReport.Skip;
                        end
                        else
                            CurrReport.Skip;
                    end
                    else
                        CurrReport.Skip;
                end
                else
                    CurrReport.Skip;
            end;
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
    labels
    {
    }
    var
        PrintMessage: Text[50];
        PL: Record "Purchase Line";
        PL2: Record "Purchase Line";
}
