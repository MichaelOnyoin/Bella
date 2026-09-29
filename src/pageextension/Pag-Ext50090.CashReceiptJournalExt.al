pageextension 50090 "Cash Receipt Journal Ext" extends "Cash Receipt Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bal. Account No.")
        {
            field("Paid To/Received From"; Rec."Paid To/Received From")
            {
                ApplicationArea = All;
                Caption = 'Working Description';
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
            field("Invoice No."; Rec."Invoice No.")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
            begin
                If Rec."Paid To/Received From" = '' then begin
                    Error('Working Description must have a value in journal line');
                end;
            end;

        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
            begin
                If Rec."Paid To/Received From" = '' then begin
                    Error('Working Description must have a value in journal line');
                end;
            end;

        }
        // Add changes to page actions here
        addfirst("P&osting")
        {
            /* action("Post Receipt")
             {
                 ApplicationArea = All;
                 Promoted = true;
                 PromotedCategory = Process;
                 PromotedIsBig = true;
                 Image = PostedOrder;
                 trigger OnAction()
                 var
                     DocumentNoMinMax: Code[40];
                     Filter: Code[255];
                 begin
                     Filter := GETFILTER("Document No.");
                     InsertReceipt();
                     CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                     CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                     CurrPage.UPDATE(FALSE);
                     ChangeReceiptStatus(FALSE, Filter);
                 end;
             }*/

            action("Print Receipt")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Image = PostPrint;

                trigger OnAction()
                var
                    DocNo: Code[20];
                    InternalReceipt: Report "Internal Receipt";
                    CurrentJnlBatchName: Code[10];
                    GenJournalLine: Record "Gen. Journal Line";
                    VoucherReceipt: Record "Voucher And Receipt"; // table variable for procedure
                begin
                    Rec.TestField("Invoice No.");
                    // Initialize
                    GenJournalLine.COPY(Rec);

                    DocNo := GenJournalLine."Document No.";
                    CurrentJnlBatchName := GenJournalLine.GETRANGEMAX("Journal Batch Name");

                    // Transfer all journal lines to Voucher And Receipt
                    Rec.TransferJournalToReceipt(GenJournalLine);


                    // // Commit after transfer to release write lock
                     COMMIT;

                    // // Copy transferred lines to Internal Receipt via the table procedure
                    // VoucherReceipt.CopyJournalToInternalReceipt(GenJournalLine);
                    // MESSAGE('Copied transferred lines to Internal Receipt for Document %1', DocNo);

                    // // Commit again after copy to release write lock
                    // COMMIT;

                    // Run the Internal Receipt report safely
                    GenJournalLine.Reset();
                    GenJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    GenJournalLine.SetRange("Document No.", Rec."Document No.");
                    if GenJournalLine.FindFirst() then
                        Report.Run(Report::"Payment Receipt", true, false, GenJournalLine);

                    // Mark the Gen. Journal Lines as Printed
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Document No.", DocNo);
                    IF GenJournalLine.FINDSET THEN
                        REPEAT
                            GenJournalLine.Printed := TRUE;
                            GenJournalLine.MODIFY;
                        UNTIL GenJournalLine.NEXT = 0;

                    // Reset filters for the page
                    Rec.SETRANGE("Document No.");
                    Rec.SETRANGE("Posting Date");
                    Rec.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    Rec.SETRANGE("Journal Batch Name", CurrentJnlBatchName);
                end;
            }


        }

    }

    var
        CurrentJnlBatchName: Code[10];
        GenJournalLine: Record "Gen. Journal Line";
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