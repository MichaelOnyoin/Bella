pageextension 50092 "Sales Person Ext" extends "Salespersons/Purchasers"
{
    layout
    {
        addafter("Phone No.")
        {
            field("MoMo Code"; Rec."MoMo Code")
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