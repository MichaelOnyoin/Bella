pageextension 50072 "Fixed Asset Card Ext" extends "Fixed Asset Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Serial No.")
        {
            field("Tag Number"; Rec."Tag Number")
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