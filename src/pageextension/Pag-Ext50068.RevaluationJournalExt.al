pageextension 50068 "Revaluation Journal Ext" extends "Revaluation Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Applies-to Entry")
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
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