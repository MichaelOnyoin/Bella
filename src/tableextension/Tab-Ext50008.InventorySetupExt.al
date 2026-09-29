tableextension 50008 "InventorySetupExt" extends "Inventory Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Journal Template Name"; Code[10]) { }
        field(50010; "Journal Batch Name"; Code[10]) { }
        field(50001; "COA Number"; Code[50])
        {
            TableRelation = "No. Series".Code;
        }
    }
}