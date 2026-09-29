pageextension 50001 "ASL.GenLedgerSetup" extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("ASL.Print only Released Docs"; Rec."ASL.Print only Released Docs")
            {
                Caption = 'Print Only Released Documents';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ASL.Print only Released Docs field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}
