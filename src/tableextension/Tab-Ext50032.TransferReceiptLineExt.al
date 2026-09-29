tableextension 50032 "Transfer Receipt Line Ext" extends "Transfer Receipt Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Transfer Reason"; Code[50])
        {
            Editable = false;
        }
    }
}