pageextension 50087 "Accountant Activity Ext" extends "Accountant Activities"
{
    layout
    {
        addafter("Product Videos")
        {
            cuegroup("Expiring Items")
            {
                field("Item Expiry"; Rec."Item Expiry")
                {
                    ApplicationArea = All;
                    Caption = 'Items Expiring in 4 Months';
                    ToolTip = 'Specifies the value of the Item Expiry field.';
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}