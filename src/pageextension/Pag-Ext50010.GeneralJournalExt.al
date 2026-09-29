pageextension 50010 "General Journal Ext" extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bal. Account No.")
        {
            field("FA Posting Type"; Rec."FA Posting Type")
            {
                ApplicationArea = All;
            }
            field("Paid To/Received From"; Rec."Paid To/Received From")
            {
                ApplicationArea = All;
            }
            field("Requested by"; Rec."Requested by")
            {
                ApplicationArea = All;
            }
            field("Authorised by"; Rec."Authorised by")
            {
                ApplicationArea = All;
            }
            field("Approved by"; Rec."Approved by")
            {
                ApplicationArea = All;
            }
            field("Reviewed by"; Rec."Reviewed by")
            {
                ApplicationArea = All;
            }
            field("GL Name"; Rec."GL Name")
            {
                ApplicationArea = All;
            }
            field("Cheque No."; Rec."Cheque No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Invoice No."; Rec."Invoice No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
    var
        JournalBatch: Record "Gen. Journal Batch";
        ASL001: Label 'Your not Allow to Access %1 Journal. Please Contact Your Administrator.';

    trigger OnOpenPage()
    begin
        JournalBatch.Reset();
        JournalBatch.SetRange(JournalBatch.Name, Rec."Journal Batch Name");
        if JournalBatch.FindFirst() then begin
            if JournalBatch."Batch User" <> '' then begin
                if JournalBatch."Batch User" <> UserId then begin
                    Error(ASL001, JournalBatch.Name);
                end;
            end;
        end;
    end;
}
