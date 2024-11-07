codeunit 50105 "Misc Codes XMLPort"
{
    trigger OnRun()
    begin
        // Delete neccessary tables
        PBMgt.OpenWindow('Deleting Tables...');
        PaymentTerms.DeleteAll(true);
        Salesperson.DeleteAll(true);
        PaymentMethod.DeleteAll(true);
        Location.DeleteAll(true);
        ShippingAgent.DeleteAll(true);
        ShippingAgentService.DeleteAll(true);
        ShipmentMethod.DeleteAll(true);
        Territory.DeleteAll(true);
        PBMgt.CloseWindow;
        Commit;
        PBMgt.OpenWindow('Processing Import...');
        LocalFilename:='MiscCodes.xml';
        UploadIntoStream('Select xml File', 'C:\XMLImport\', 'XML File *.xml|*.xml', LocalFilename, ThisInStream);
        RunXMLPort.SetSource(ThisInStream);
        RunXMLPort.Import;
        Commit;
        PBMgt.CloseWindow;
        Message('Import complete.');
    end;
    var PaymentTerms: Record "Payment Terms";
    Salesperson: Record "Salesperson/Purchaser";
    PaymentMethod: Record "Payment Method";
    Location: Record Location;
    ShippingAgent: Record "Shipping Agent";
    ShippingAgentService: Record "Shipping Agent Services";
    Country: Record "Country/Region";
    ShipmentMethod: Record "Shipment Method";
    Territory: Record Territory;
    RunXMLPort: XMLport "Misc Codes Import";
    ImportFolder: Label 'C:\XMLImport\';
    PBMgt: Codeunit "Progress Bar Management";
    ThisInStream: InStream;
    InFile: File;
    LocalFilename: Text[1024];
}
