pageextension 50039 "Customer Ledger Entries Ext" extends "Customer Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter(Open)
        {
            /* field("Branch Code"; "Branch Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Return Branch Code"; "Return Branch Code")
            {
                ApplicationArea = All;
                Editable = false;
            } */
        }
        addafter("Salesperson Code")
        {
            field(Contact; Rec.Contact)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contact field.';
            }
            field("Customer Posting Group"; "Customer Posting Group")
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