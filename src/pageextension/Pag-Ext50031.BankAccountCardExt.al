pageextension 50031 "Bank Account Card Ext" extends "Bank Account Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Actual Statement Balance"; Rec."Actual Statement Balance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Actual Bank Balance as per the date specified in the Statement Balance as of field';
            }
            field("Statement Balance as of"; Rec."Statement Balance as of")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date the current statement balance field was updated';
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter("Detail Trial Balance")
        {
            action("Petty Cash book")
            {
                ApplicationArea = All;
                Caption = 'Petty Cash Book';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;

                trigger OnAction()
                var
                    BankAccount: Record "Bank Account";
                    BankPettyCash: Report "Bank Acc. - Detail Petty Cash";
                begin
                    BankAccount.RESET;
                    BankAccount.SETRANGE(BankAccount."No.", Rec."No.");
                    BankPettyCash.SETTABLEVIEW(BankAccount);
                    BankPettyCash.RUN;
                end;
            }
        }
    }
}
