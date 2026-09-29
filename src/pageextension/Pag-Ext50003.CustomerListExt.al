pageextension 50003 "Customer List Ext" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
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
                    CustomerChecques.SetRange(CustomerChecques."Account Type", CustomerChecques."Account Type"::Customer);
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
                ToolTip = 'Shows the Customer total amount on Posted Checques';
                trigger OnDrillDown()
                var
                    CustomerChecques: Record "Gen. Journal Line";
                    ViewChecques: Page "Uncleared Cheques";
                begin
                    CustomerChecques.SETRANGE(CustomerChecques."Account No.", Rec."No.");
                    CustomerChecques.SetRange(CustomerChecques."Account Type", CustomerChecques."Account Type"::Customer);
                    CustomerChecques.SETRANGE(CustomerChecques."Journal Batch Name", 'CUST_CHECQ');
                    Rec.CopyFilter("Currency Filter", CustomerChecques."Currency Code");
                    ViewChecques.SetTableView(CustomerChecques);
                    ViewChecques.Run();
                end;
            }
        }
        addbefore("Balance (LCY)")
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    Rec.OpenCustomerLedgerEntries(true);
                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Customer - Sales List")
        {
            action("Customer - Payment Receipt")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report;
                RunObject = report "Customer - Payment Receipt";
                trigger OnAction()
                begin
                end;
            }
            action("Customer Statement")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report;
                trigger OnAction()
                var
                    Customer: Record Customer;
                    CustStatement: Report "Statement MOD";
                begin
                    Customer.SETRANGE(Customer."No.", REc."No.");
                    CustStatement.SetTableView(Customer);
                    CustStatement.RUN;
                end;
            }
        }
        addafter(ReportCustomerDetailTrial)
        {
            action(ActionName)
            {
                ApplicationArea = Suite;
                Caption = 'Customer - Detail Trial Bal. Mod';
                Image = "Report";
                ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';

                trigger OnAction()
                var
                    Customer: Record customer;
                    DetailedTrialBalance: Report "Customer Detail Trial Bal";
                begin
                    Customer.Reset();
                    Customer.SetRange(Customer."No.", Rec."No.");
                    DetailedTrialBalance.SetTableView(Customer);
                    DetailedTrialBalance.Run();
                end;
            }
        }
        addafter(ReportCustomerTrialBalance)
        {
            action(ReportCustomerDetailTrials)
            {
                ApplicationArea = Suite;
                Caption = 'Customer - Detail Trial Bal.';
                Image = "Report";
                ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';

                trigger OnAction()
                var
                    CustDetailedBalance: Report "Customer - Detail Trial Bal.";
                    Customer: Record Customer;
                begin
                    Customer.Reset();
                    Customer.SetRange(Customer."No.", Rec."No.");
                    CustDetailedBalance.SetTableView(Customer);
                    CustDetailedBalance.Run();
                end;
            }
        }
        modify(ReportCustomerDetailTrial)
        {
            Visible = false;
            Enabled = false;
        }
        Modify(Statement)
        {
            Visible = false;
            Enabled = false;
        }
    }
}