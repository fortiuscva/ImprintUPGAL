codeunit 50102 "Vendor XMLPort"
{
    trigger OnRun()
    begin
        // Delete neccessary tables
        PBMgt.OpenWindow('Deleting Tables...');
        OrderAddress.DeleteAll(true);
        Vendor.DeleteAll(true);
        PBMgt.CloseWindow;
        Commit;
        PBMgt.OpenWindow('Processing Import...');
        LocalFilename:='Vendors.xml';
        UploadIntoStream('Select xml File', 'C:\XMLImport\', 'XML File *.xml|*.xml', LocalFilename, ThisInStream);
        //InFile.OPEN(ImportFolder + 'Vendors.xml');
        //InFile.CREATEINSTREAM(ThisInStream);
        RunXMLPort.SetSource(ThisInStream);
        RunXMLPort.Import;
        //RUN;
        //InFile.CLOSE;
        PBMgt.CloseWindow;
        Message('Import complete.');
    end;
    var Vendor: Record Vendor;
    OrderAddress: Record "Order Address";
    RunXMLPort: XMLport "Vendor Import";
    ImportFolder: Label '\\Navision2013\c$\XMLImport\';
    PBMgt: Codeunit "Progress Bar Management";
    ThisInStream: InStream;
    LocalFilename: Text[1024];
}
