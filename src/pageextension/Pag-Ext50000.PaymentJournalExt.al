pageextension 50000 "Payment Journal Ext" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bal. Account No.")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Depreciation Book Code"; Rec."Depreciation Book Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.';
            }

            field("FA Posting Type"; Rec."FA Posting Type")
            {
                ApplicationArea = All;
            }
            field("FA Posting Date"; Rec."FA Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the posting date of the related fixed asset transaction, such as a depreciation.';
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
            field("Prepared by"; Rec."Prepared by")
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
        }
        addafter("Account No.")
        {
            field("GL Name"; Rec."GL Name")
            {
                ApplicationArea = All;
                Caption = 'Account Name';
                Editable = false;
                Visible = true;
            }
        }
        modify(AccName)
        {
            Caption = 'Acccount Name';
            Editable = false;
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
            //Print Voucher
            action("Print Voucher")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                Image = PrintCheck;
                trigger OnAction()
                var
                    DocNo: Code[20];
                    PaymentVoucher: Report "Payment Voucher";
                    JournalBatch: Code[10];
                    PostingDate: Date;
                    CurrentJnlBatchName: Code[10];
                    GenJournalLine: Record "Gen. Journal Line";
                    TotalAmount: Decimal;
                    countNumber: Integer;
                begin
                    countNumber := 0;
                    TotalAmount := 0;
                    CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                    GenJournalLine.COPY(Rec);
                    DocNo := GenJournalLine."Document No.";
                    JournalBatch := GenJournalLine."Journal Batch Name";
                    PostingDate := GenJournalLine."Posting Date";
                    //SalesCommentLine.CopyJournalToVoucher(GenJournalLine);

                    Rec.TransferJournalToVoucher(GenJournalLine);
                    COMMIT;
                    PaymentVoucher.SetPrintDocumentNo(DocNo);
                    PaymentVoucher.RUN;

                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Document No.", DocNo);
                    IF GenJournalLine.FINDSET THEN
                        REPEAT
                        BEGIN
                            GenJournalLine.Printed := TRUE;
                            GenJournalLine.MODIFY;
                        END;
                        UNTIL GenJournalLine.NEXT = 0;

                    Rec.SETRANGE("Document No.");
                    Rec.SETRANGE("Posting Date");
                    Rec.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    Rec.SETRANGE("Journal Batch Name", CurrentJnlBatchName);
                end;
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