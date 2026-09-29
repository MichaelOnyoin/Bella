pageextension 50011 "Bank Acc. Ledger Entries Ext" extends "Bank Account Ledger Entries"
{
    Editable = true;
    layout
    {
        // Add changes to page layout here
        addafter("Amount (LCY)")
        {
            field("Authorised by"; Rec."Authorised by")
            {
                ApplicationArea = All;
            }
            field("Paid To/Received From"; Rec."Paid To/Received From")
            {
                ApplicationArea = All;
                Caption = 'Working Description';
            }
            field("Requested by"; Rec."Requested by")
            {
                ApplicationArea = All;
            }
            field("Reviewed by"; Rec."Reviewed by")
            {
                ApplicationArea = All;
            }
            field("Approved by"; Rec."Approved by")
            {
                ApplicationArea = All;
            }
            field("Prepared by"; Rec."Prepared by")
            {
                ApplicationArea = All;
            }
            field("Statement No."; Rec."Statement No.")
            {
                ApplicationArea = All;
                Editable = true;
            }

            field("Statement Line No."; Rec."Statement Line No.")
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