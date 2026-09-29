pageextension 50097 "Posted Purch Rcpt Ext" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Vendor Order No.")
        {
            field("Manufacturer Invoice No"; Rec."Manufacturer Invoice No")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}