tableextension 50029 "Transfer Receipt Header Ext" extends "Transfer Receipt Header"
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
    }
}