pageextension 50083 "Sales Cr. Memo Subform Ext" extends "Sales Cr. Memo Subform" //96
{
    layout
    {
        // Add changes to page layout here
        addafter("Qty. Assigned")
        {
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }

            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }

        addafter("Location Code")
        {
            field("Employee No."; Rec."Resource No.")
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