report 50074 "Send Cust Item Stats  SP"
{
    // IMP1.01,03/07/17,SK: Created new report.
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = SORTING(Code)ORDER(Ascending);
            RequestFilterFields = "Code";

            column(Name; Name)
            {
            }
            trigger OnAfterGetRecord()
            begin
                clear(EmailAdd);
                clear(EmailCC);
                Name:=StrSubstNo('CustomerSales%1.pdf', Code); //Default Subject is PDF FIlename
                //UPGCloud >>
                TempBlob_lRec.CreateOutStream(Out, TEXTENCODING::UTF8); // Create Outstream
                //UPGCloud <<
                ToFile:=Name;
                // FileName := TemporaryPath + ToFile;//UPGCloud
                BodyText:=': Imprint-Weekly Customer Sales Activity'; //SendAsPDFSubstitutions(BodyText,FALSE); //"merge" arguments into Email Body
                Name:='Imprint Sales Department'; //SendAsPDFSubstitutions(EmailSubj,TRUE); //"merge" arguments into Subject, too...
                ReportID:=50073;
                if "E-Mail" <> '' then EmailAdd.add("E-Mail");
                if "Salesperson/Purchaser"."E-Mail 2" <> '' then begin
                    EmailAdd.add("E-Mail 2");
                end;
                if("E-Mail" = '') and ("E-Mail 2" = '')then EmailAdd.add('ssystems3@imprint-e.com');
                EmailCC.Add('ssystems3@imprint-e.com');
                // EmailAdd := 'ssystems3@imprint-e.com';  //Remove after testing.
                SP2.Reset;
                SP2.SetRange(Code, Code);
                SP2.FindFirst;
                //UPGCloud >>
                RecRef.GetTable(SP2);
                //REPORT.SaveAsPdf(ReportID, FileName, SP2);//UPGCloud
                //UPGcloud >>
                REPORT.SAVEAS(ReportID, '', REPORTFORMAT::Pdf, Out, RecRef);
                FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('Proforma_%1.Pdf', FileName), TRUE); // export report in PDF format
                //UPGcloud <<
                //   if Exists(FileName) then begin // initials//UPGCloud
                /*
                Clear(SMTP);
                //SMTP.CreateMessage(Name,'info@imprint.com',EmailAdd,'Imprint-Weekly Customer Sales Activity',BodyText,TRUE);
                SMTP.CreateMessage(Name, 'administrator@imprint-e.com', EmailAdd, 'Imprint-Weekly Customer Sales Activity', BodyText, true);
                // IF EmailAdd2 <> '' THEN
                // SMTP.AddCC(EmailAdd2);
                SMTP.AddCC(EmailCC);
                //SMTP.AddBCC('obaid@solsyst.com');  //To add as bcc
                SMTP.AddAttachment(FileName, ''); // initials
                if not (SMTP.Send) then;
                */
                Clear(Email);
                Clear(Emailmessage);
                Emailmessage.Create('administrator@imprint-e.com', 'Imprint-Weekly Customer Sales Activity', BodyText);
                Emailmessage.AddAttachment(FileName, '', '');
                EmailCC.Add('ssystems3@imprint-e.com');
                if not Email.Send(Emailmessage)then;
            //end;//UPGcloud
            //FILE.Erase(FileName);//UPGCloud
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
    var NewRunDate: Date;
    PrintRunDate: Text;
    Mail: Codeunit Mail;
    Name: Text;
    FileName: Text;
    ToFile: Text;
    BodyTemp: Text;
    BodyTemp2: Text;
    "--FP7.0.09---": Integer;
    DialogOption: Option Always, Never, Ask;
    ShowDialog: Boolean;
    ReportID: Integer;
    BodyText: Text;
    SalesHeader: Record "Sales Header";
    EmailSubj: Text;
    [InDataSet]
    EnableSendAsPDF: Boolean;
    FakeEmail: Text;
    Email: Codeunit Email;
    Emailmessage: Codeunit "Email Message";
    EmailAdd: list of[Text];
    EmailCC: list of[text];
    EmailAdd2: Text;
    SP2: Record "Salesperson/Purchaser";
    //UPGCloud
    RecRef: RecordRef;
    Out: OutStream;
    TempBlob_lRec: Codeunit "Temp Blob";
    FileManagement_lCdu: Codeunit "File Management";
}
