tableextension 50054 "Purch. Rcpt Header Ext" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50979; "Manufacturer Invoice No"; Text[100])
        {
            Caption = 'Manufacturer Invoice No';
            DataClassification = ToBeClassified;
        }
    }
}
