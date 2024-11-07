codeunit 50103 "Order Address XMLPort"
{
    trigger OnRun()
    begin
        // Delete neccessary tables
        PBMgt.OpenWindow('Deleting Tables...');
        OrderAddress.DeleteAll(true);
        PBMgt.CloseWindow;
        Commit;
        PBMgt.OpenWindow('Processing Import...');
        LocalFilename:='OrderAddresses.xml';
        UploadIntoStream('Select xml File', 'C:\XMLImport\', 'XML File *.xml|*.xml', LocalFilename, ThisInStream);
        RunXMLPort.SetSource(ThisInStream);
        RunXMLPort.Import;
        PBMgt.CloseWindow;
        Message('Import complete.');
    end;
    var OrderAddress: Record "Order Address";
    RunXMLPort: XMLport "Order Address Import";
    ImportFolder: Label '\\Navision2013\c$\XMLImport\';
    PBMgt: Codeunit "Progress Bar Management";
    ThisInStream: InStream;
    LocalFilename: Text[1024];
}
