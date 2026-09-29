pageextension 50019 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Territory Code"; Rec."Territory Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Territory Code")
        {
            field("Allow Sale Beyond Credit limit"; Rec."Allow Sale Beyond Credit limit")
            {
                ApplicationArea = All;
            }
            field("TIN Mandatory"; Rec."TIN Mandatory")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Balance Due (LCY)")
        {
            field("Post Dated Cheque Amount"; Rec."Post Dated Cheque Amount")
            {
                ApplicationArea = All;
                Caption = 'Uncleared Cheques - Amount';
                ToolTip = 'Shows the Customer total amount on Posted Checques';

                trigger OnDrillDown()
                var
                    CustomerChecques: Record "Gen. Journal Line";
                    ViewChecques: Page "Uncleared Cheques";
                begin
                    CustomerChecques.SETRANGE(CustomerChecques."Account No.", Rec."No.");
                    CustomerChecques.SETRANGE(CustomerChecques."Journal Batch Name", 'CUST_CHECQ');
                    Rec.CopyFilter("Currency Filter", CustomerChecques."Currency Code");
                    ViewChecques.SetTableView(CustomerChecques);
                    ViewChecques.Run();
                end;
            }
            field("Post Dated Checque Amount(LCY)"; Rec."Post Dated Checque Amount(LCY)")
            {
                ApplicationArea = All;
                Caption = 'Uncleared Cheques - Amount(LCY)';
                ToolTip = 'Shows the Customer total amount on Posted Checques in LCY';

                trigger OnDrillDown()
                var
                    CustomerChecques: Record "Gen. Journal Line";
                    ViewChecques: Page "Uncleared Cheques";
                begin
                    CustomerChecques.SETRANGE(CustomerChecques."Account No.", Rec."No.");
                    CustomerChecques.SETRANGE(CustomerChecques."Journal Batch Name", 'CUST_CHECQ');
                    Rec.CopyFilter("Currency Filter", CustomerChecques."Currency Code");
                    ViewChecques.SetTableView(CustomerChecques);
                    ViewChecques.Run();
                end;
            }
        }
        addbefore("Balance (LCY)")
        {
            field("Balance Cust"; Rec.Balance)
            {
                ApplicationArea = All;
                Caption = 'Balance';
                trigger OnDrillDown()
                begin
                    Rec.OpenCustomerLedgerEntries(true);
                end;
            }
        }
        // addafter("Registration Number")
        // {
        //     field(TIN; Rec.TIN)
        //     {
        //         ApplicationArea = Basic, Suite;
        //         ShowMandatory = true;
        //     }
        //     field("Room No.";Rec."Room No.")
        //     {
        //         ApplicationArea=Basic, Suite;
        //     }
        //     field("Square Meters";Rec."Square Meters")
        //     {
        //         ApplicationArea=Basic, Suite;
        //     }
        // }
    }
    actions
    {
        // Add changes to page actions here
        Modify("Report Statement")
        {
            Visible = false;
        }
        addafter("Report Customer Detailed Aging")
        {
            action("Customer Statement")
            {
                ApplicationArea = All;
                Caption = 'Customer statement';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;

                trigger OnAction()
                begin
                    RunReport(REPORT::"statement MOD", Rec."No.");
                end;
            }
        }

        addafter("S&ales")
        {
            action("Print Receipt")
            {
                Image=Receipt;
                Promoted=true;
                PromotedCategory=Report;
                ApplicationArea=Basic, Suite;
                trigger OnAction()
                var
                    CustomerLedgerEntry: Record "Cust. Ledger Entry";
                begin
                    CustomerLedgerEntry.Reset();
                    CustomerLedgerEntry.SetRange("Customer No.", Rec."No.");
                    if CustomerLedgerEntry.FindFirst() then
                        Report.Run(Report::"Customer Receipt", true, false, CustomerLedgerEntry);
                end;
            }
        }
    }

    var
        Usersetup: Record "User Setup";

    trigger OnNewRecord(BelowxRec: Boolean)
    var

    begin
        Usersetup.Reset();
        Usersetup.SetRange(Usersetup."User ID",UserId);
        if Usersetup.FindFirst() then begin
        if Usersetup."Create Customer" = false then begin 
            Error('You are not allowed to Create a Customer');
        end;
        end;
    end;
}
