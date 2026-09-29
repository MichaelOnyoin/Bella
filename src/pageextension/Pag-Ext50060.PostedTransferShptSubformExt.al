pageextension 50060 "Posted TransferShptSubform Ext" extends "Posted Transfer Shpt. Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("Transfer Reason"; Rec."Transfer Reason")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}