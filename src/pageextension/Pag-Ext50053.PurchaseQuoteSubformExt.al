pageextension 50053 "Purchase Quote Subform Ext" extends "Purchase Quote Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Qty. Assigned")
        {
            field("Document No."; Rec."Document No.")
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