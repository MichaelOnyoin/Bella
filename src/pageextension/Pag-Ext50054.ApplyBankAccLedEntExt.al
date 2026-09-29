pageextension 50054 "Apply Bank Acc. Led Ent Ext" extends "Apply Bank Acc. Ledger Entries"
{
    Editable = true;
    layout
    {
        // Add changes to page layout here
        addafter(Open)
        {
            field("Difference Statement No."; Rec."Difference Statement No.")
            {
                ApplicationArea = All;
                Editable = true;
            }

            field("Diff Statement Line No."; Rec."Diff Statement Line No.")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}