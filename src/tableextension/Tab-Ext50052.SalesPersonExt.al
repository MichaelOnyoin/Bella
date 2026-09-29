tableextension 50052 "Sales Person Ext" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; "MoMo Code"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "UserID"; Code[50])
        {
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
    }
    keys
    {
        key(Kay1; "MoMo Code")
        {
        }
        key(Key2; UserID)
        {
        }
    }
}