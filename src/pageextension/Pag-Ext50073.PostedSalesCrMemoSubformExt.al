pageextension 50073 "PostedSales CrMemoSubform Ext" extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Return Reason Code")
        {
            field("Resource No."; Rec."Resource No.")
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