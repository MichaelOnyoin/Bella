tableextension 50027 "Transfer Header Ext" extends "Transfer Header"
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
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Inventory Posting Group"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50002; "Prod Order No."; Code[20])
        {
            TableRelation = "Production Order"."No.";
        }
        field(50003; "Transfer Reason"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
}