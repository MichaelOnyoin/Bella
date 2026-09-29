pageextension 50023 "Rel. Prod OrderLines Ext" extends "Released Prod. Order Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Cost Amount")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("LocationCode"; Rec."Location Code")
            {
                ApplicationArea = All;
                Caption = 'Location Code';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}