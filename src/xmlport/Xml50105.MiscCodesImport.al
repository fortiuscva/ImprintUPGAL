xmlport 50105 "Misc Codes Import"
{
    schema
    {
    textelement(Root)
    {
    tableelement("Payment Terms";
    "Payment Terms")
    {
    XmlName = 'PaymentTerms';

    fieldelement(Code;
    "Payment Terms".Code)
    {
    }
    fieldelement(DueDateCalc;
    "Payment Terms"."Due Date Calculation")
    {
    }
    fieldelement(DiscDateCalc;
    "Payment Terms"."Discount Date Calculation")
    {
    }
    fieldelement(DiscountPercent;
    "Payment Terms"."Discount %")
    {
    }
    fieldelement(Description;
    "Payment Terms".Description)
    {
    }
    fieldelement(CalcPmtDiscOnCM;
    "Payment Terms"."Calc. Pmt. Disc. on Cr. Memos")
    {
    }
    }
    tableelement("Salesperson/Purchaser";
    "Salesperson/Purchaser")
    {
    XmlName = 'Salesperson';

    fieldelement(Code;
    "Salesperson/Purchaser".Code)
    {
    }
    fieldelement(Name;
    "Salesperson/Purchaser".Name)
    {
    }
    fieldelement(CommPercent;
    "Salesperson/Purchaser"."Commission %")
    {
    }
    fieldelement(Dim1;
    "Salesperson/Purchaser"."Global Dimension 1 Code")
    {
    }
    fieldelement(Dim2;
    "Salesperson/Purchaser"."Global Dimension 2 Code")
    {
    }
    fieldelement(EMail;
    "Salesperson/Purchaser"."E-Mail")
    {
    }
    fieldelement(PhoneNo;
    "Salesperson/Purchaser"."Phone No.")
    {
    }
    }
    tableelement("Payment Method";
    "Payment Method")
    {
    XmlName = 'PaymentMethod';

    fieldelement(Code;
    "Payment Method".Code)
    {
    }
    fieldelement(Description;
    "Payment Method".Description)
    {
    }
    fieldelement(BalAccountType;
    "Payment Method"."Bal. Account Type")
    {
    }
    fieldelement(BalAccountNo;
    "Payment Method"."Bal. Account No.")
    {
    }
    }
    tableelement(Location;
    Location)
    {
    XmlName = 'Location';

    fieldelement(Code;
    Location.Code)
    {
    }
    fieldelement(Name;
    Location.Name)
    {
    }
    fieldelement(Name2;
    Location."Name 2")
    {
    }
    fieldelement(Address;
    Location.Address)
    {
    }
    fieldelement(Address2;
    Location."Address 2")
    {
    }
    fieldelement(City;
    Location.City)
    {
    }
    fieldelement(PhoneNo;
    Location."Phone No.")
    {
    }
    fieldelement(PhoneNo2;
    Location."Phone No. 2")
    {
    }
    fieldelement(TelexNo;
    Location."Telex No.")
    {
    }
    fieldelement(FaxNo;
    Location."Fax No.")
    {
    }
    fieldelement(Contact;
    Location.Contact)
    {
    }
    fieldelement(PostCode;
    Location."Post Code")
    {
    }
    fieldelement(County;
    Location.County)
    {
    }
    fieldelement(EMail;
    Location."E-Mail")
    {
    }
    fieldelement(HomePage;
    Location."Home Page")
    {
    }
    fieldelement(CountryCode;
    Location."Country/Region Code")
    {
    }
    fieldelement(UseAsInTransit;
    Location."Use As In-Transit")
    {
    }
    fieldelement(RequirePutAway;
    Location."Require Put-away")
    {
    }
    fieldelement(RequirePick;
    Location."Require Pick")
    {
    }
    fieldelement(CrossDocDueDateCalc;
    Location."Cross-Dock Due Date Calc.")
    {
    }
    fieldelement(UseCrossDocking;
    Location."Use Cross-Docking")
    {
    }
    fieldelement(ReqReceive;
    Location."Require Receive")
    {
    }
    fieldelement(ReqShipment;
    Location."Require Shipment")
    {
    }
    fieldelement(BinMandatory;
    Location."Bin Mandatory")
    {
    }
    fieldelement(DirectedPutAwayPick;
    Location."Directed Put-away and Pick")
    {
    }
    fieldelement(DefaultBinSel;
    Location."Default Bin Selection")
    {
    }
    fieldelement(OutboundWhseHandlingTime;
    Location."Outbound Whse. Handling Time")
    {
    }
    fieldelement(InboundWhseHandlingTime;
    Location."Inbound Whse. Handling Time")
    {
    }
    fieldelement(PutAwayTemplateCode;
    Location."Put-away Template Code")
    {
    }
    fieldelement(UsePutAwayWorksheet;
    Location."Use Put-away Worksheet")
    {
    }
    fieldelement(AllowBreakBulk;
    Location."Allow Breakbulk")
    {
    }
    fieldelement(BinCapacityPolicy;
    Location."Bin Capacity Policy")
    {
    }
    fieldelement(OpenShopFloorBinCode;
    Location."Open Shop Floor Bin Code")
    {
    }
    fieldelement(InboundProdBinCode;
    Location."To-Production Bin Code")
    {
    }
    fieldelement(OutboundProdBinCode;
    Location."From-Production Bin Code")
    {
    }
    fieldelement(AdjBinCode;
    Location."Adjustment Bin Code")
    {
    }
    fieldelement(AlwaysCreatePutAwayLine;
    Location."Always Create Put-away Line")
    {
    }
    fieldelement(AlwaysCreatePickLine;
    Location."Always Create Pick Line")
    {
    }
    fieldelement(SpecialEquipment;
    Location."Special Equipment")
    {
    }
    fieldelement(ReceiptBinCode;
    Location."Receipt Bin Code")
    {
    }
    fieldelement(ShipmentBinCode;
    Location."Shipment Bin Code")
    {
    }
    fieldelement(CrossDockBinCode;
    Location."Cross-Dock Bin Code")
    {
    }
    fieldelement(BaseCalendarCode;
    Location."Base Calendar Code")
    {
    }
    fieldelement(UseADCS;
    Location."Use ADCS")
    {
    }
    fieldelement(TaxAreaCode;
    Location."Tax Area Code")
    {
    }
    fieldelement(TaxExemptionNo;
    Location."Tax Exemption No.")
    {
    }
    }
    tableelement("Shipping Agent";
    "Shipping Agent")
    {
    XmlName = 'ShippingAgent';

    fieldelement(Code;
    "Shipping Agent".Code)
    {
    }
    fieldelement(Name;
    "Shipping Agent".Name)
    {
    }
    fieldelement(InternetAddress;
    "Shipping Agent"."Internet Address")
    {
    }
    fieldelement(AccoiuntNo;
    "Shipping Agent"."Account No.")
    {
    }
    }
    tableelement("Shipping Agent Services";
    "Shipping Agent Services")
    {
    XmlName = 'ShippingAgentService';

    fieldelement(ShippingAgentCode;
    "Shipping Agent Services"."Shipping Agent Code")
    {
    }
    fieldelement(Code;
    "Shipping Agent Services".Code)
    {
    }
    fieldelement(Description;
    "Shipping Agent Services".Description)
    {
    }
    fieldelement(ShippingTime;
    "Shipping Agent Services"."Shipping Time")
    {
    }
    fieldelement(BaseCalendarCode;
    "Shipping Agent Services"."Base Calendar Code")
    {
    }
    }
    tableelement("Shipment Method";
    "Shipment Method")
    {
    XmlName = 'ShipmentMethod';

    fieldelement(Code;
    "Shipment Method".Code)
    {
    }
    fieldelement(Description;
    "Shipment Method".Description)
    {
    }
    }
    tableelement("Lead Source";
    "Lead Source")
    {
    XmlName = 'Territory';

    fieldelement(Code;
    "Lead Source".Code)
    {
    }
    fieldelement(Name;
    "Lead Source".Description)
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
