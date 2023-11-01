codeunit 50101 "Ship-to XMLPort"
{
    trigger OnRun()
    begin
        // Delete neccessary tables
        PBMgt.OpenWindow('Deleting Tables...');
        ShipTo.DeleteAll(true);
        PBMgt.CloseWindow;
        Commit;
        PBMgt.OpenWindow('Processing Import...');
        LocalFilename:='ShipTos.xml';
        UploadIntoStream('Select xml File', 'C:\XMLImport\', 'XML File *.xml|*.xml', LocalFilename, ThisInStream);
        RunXMLPort.SetSource(ThisInStream);
        RunXMLPort.Import;
        Commit;
        PBMgt.CloseWindow;
        Message('Import complete.');
    end;
    var ShipTo: Record "Ship-to Address";
    RunXMLPort: XMLport "Ship-to Import";
    ImportFolder: Label 'C:\XMLImport\';
    PBMgt: Codeunit "Progress Bar Management";
    ThisInStream: InStream;
    InFile: File;
    LocalFilename: Text[1024];
}
