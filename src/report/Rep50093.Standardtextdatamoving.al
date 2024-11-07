report 50093 "Standard text data moving"
{
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/Standard text data moving.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Standard Text"; "Standard Text")
        {
            trigger OnAfterGetRecord()
            begin
                "Standard Text"."Description 2" := "Standard Text"."Description 2";
                Modify;
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
    trigger OnPostReport()
    begin
        Message('Done');
    end;
}
