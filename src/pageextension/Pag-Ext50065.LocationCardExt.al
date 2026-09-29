pageextension 50065 "Location Card Ext" extends "Location Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Use As In-Transit")
        {
            field("Include in report"; Rec."Include in report")
            {
                ApplicationArea = All;
            }
            field(Restricted; Rec.Restricted)
            {
            }
        }
            }

    actions
    {
        // Add changes to page actions here
    }
}