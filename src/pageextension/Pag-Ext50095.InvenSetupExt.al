pageextension 50095 "Inven Setup Ext" extends "Inventory Setup"
{
    layout
    {
        addafter("Posted Phys. Invt. Order Nos.")
        {
            field("COA Number"; Rec."COA Number")
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