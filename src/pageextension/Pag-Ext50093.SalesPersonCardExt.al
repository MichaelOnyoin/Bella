pageextension 50093 "Sales Person Card Ext" extends "Salesperson/Purchaser Card"
{
    layout
    {
        addafter("Phone No.")
        {
            field("MoMo Code"; Rec."MoMo Code")
            {
                ApplicationArea = All;
            }
            field(UserID; Rec.UserID)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the UserID field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}