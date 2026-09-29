pageextension 50075 "Item Analy ViewBudgEntries Ext" extends "Item Analy. View Budg. Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;
            }
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}