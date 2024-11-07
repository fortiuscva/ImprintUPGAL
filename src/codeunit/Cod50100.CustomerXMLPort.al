codeunit 50100 "Customer XMLPort"
{
    trigger OnRun()
    begin
        // Delete neccessary tables
        PBMgt.OpenWindow('Deleting Ship-tos...');
        ShipTo.DeleteAll(true);
        PBMgt.CloseWindow;
        PBMgt.OpenWindow('Customerss...');
        Customer.DeleteAll(true);
        PBMgt.CloseWindow;
        Commit;
        PBMgt.OpenWindow('Processing Import...');
        LocalFilename:='Customers.xml';
        UploadIntoStream('Select xml File', 'C:\XMLImport\', 'XML File *.xml|*.xml', LocalFilename, ThisInStream);
        //InFile.OPEN(ImportFolder + 'Customers.xml');
        //InFile.CREATEINSTREAM(ThisInStream);
        /*WITH RunXMLPort DO BEGIN
          SETSOURCE(ThisInStream);
          IMPORT;
          COMMIT;
          //RUN;
        END;
        */
        //IMPUPG
        Clear(ThisInStream);
        Commit;
        LocalFilename:='Customers.xml';
        UploadIntoStream('Select xml File', 'C:\XMLImport\', 'XML File *.xml|*.xml', LocalFilename, ThisInStream);
        //InFile.OPEN(ImportFolder + 'Customers.xml');
        //InFile.CREATEINSTREAM(ThisInStream);
        /*WITH RunXMLPort DO BEGIN
          SETSOURCE(ThisInStream);
          IMPORT;
          COMMIT;
          //RUN;
        END;
        */
        //IMPUPG
        //InFile.CLOSE;
        PBMgt.CloseWindow;
        Message('Import complete.');
    end;
    var Customer: Record Customer;
    ShipTo: Record "Ship-to Address";
    ImportFolder: Label 'C:\XMLImport\';
    PBMgt: Codeunit "Progress Bar Management";
    ThisInStream: InStream;
    InFile: File;
    LocalFilename: Text[1024];
}
