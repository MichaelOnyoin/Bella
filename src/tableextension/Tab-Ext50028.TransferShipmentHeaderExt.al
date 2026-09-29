tableextension 50028 "Transfer Shipment Header Ext" extends "Transfer Shipment Header"
{
    fields
    {
        // Add changes to table fields here
        /* field(50000; "Transfer Reason"; Code[20])
        {
            TableRelation = Confidential.Code where(Type = const("Transfer Reason"));
        } */
        field(50000; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = ToBeClassified;
        }

        // added by Jed
        field(50001; "Transfer Reason"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
}