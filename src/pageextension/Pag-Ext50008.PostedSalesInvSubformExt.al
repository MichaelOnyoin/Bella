pageextension 50008 "Posted Sales Inv. Subform Ext" extends "Posted Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Line Amount")
        {
            /* field("Location Code"; Rec."Location Code")
            {
              ApplicationArea = All;
            } */
            field("Employee No."; Rec."Resource No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("SALESPERSON CODE"; Rec."SALESPERSON CODE")
            {
                ApplicationArea = All;
            }
        }
        modify("ShortcutDimCode[3]")
        {
            Visible = false;
        }
    }
}
