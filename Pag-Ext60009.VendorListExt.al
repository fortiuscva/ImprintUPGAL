pageextension 60009 "VendorListExt" extends "Vendor List"
{
    layout
    {
        addafter(Name)
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
            field(County; Rec.County)
            {
                ApplicationArea = All;
            }
            field("Federal ID No."; Rec."Federal ID No.")
            {
                ApplicationArea = All;
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
        }
    }
}
