pageextension 50061 "Transfer Order Subform Ext" extends "Transfer Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Quantity Received")
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