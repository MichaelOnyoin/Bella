pageextension 50007 "Sales Invoice Subform Ext" extends "Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("Employee No."; Rec."Resource No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Working Description"; Rec."Working Description")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the Working Description for this line.';
            }
        }
    }
}
