report 50032 "Bank Acc - Daily Summary"
{
    ApplicationArea = All;
    Caption = 'Bank Acc - Daily Summary';
    DefaultLayout = RDLC;
    RDLCLayout = 'BankAcc-DailySummary.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(BankAccount; "Bank Account")
        {
            RequestFilterFields = "No.", "Currency Code", "Bank Acc. Posting Group";
            column(Amount; Amount)
            {
            }
            column(Blocked; Blocked)
            {
            }
            column(Balance; Balance)
            {
            }
            column(BalanceLCY; "Balance (LCY)")
            {
            }
            column(BalanceatDate; "Balance at Date")
            {
            }
            column(BalanceatDateLCY; "Balance at Date (LCY)")
            {
            }
            column(BankAccountNo; "Bank Account No.")
            {
            }
            column(BankBranchNo; "Bank Branch No.")
            {
            }
            column(City; City)
            {
            }
            column(Contact; Contact)
            {
            }
            column(CountryRegionCode; "Country/Region Code")
            {
            }
            column(County; County)
            {
            }
            column(CreditAmount; "Credit Amount")
            {
            }
            column(CreditAmountLCY; "Credit Amount (LCY)")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(DateFilter; "Date Filter")
            {
            }
            column(DebitAmount; "Debit Amount")
            {
            }
            column(DebitAmountLCY; "Debit Amount (LCY)")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension1Filter; "Global Dimension 1 Filter")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(GlobalDimension2Filter; "Global Dimension 2 Filter")
            {
            }
            column(Name; Name)
            {
            }
            column(NetChange; "Net Change")
            {
            }
            column(NetChangeLCY; "Net Change (LCY)")
            {
            }
            column(No; "No.")
            {
            }
            column(Actual_Statement_Balance; "Actual Statement Balance")
            {
            }
            column(Statement_Balance_as_of; "Statement Balance as of")
            {
            }
            dataitem(Currency; Currency)
            {
                DataItemLinkReference = BankAccount;
                DataItemLink = Code = field("Currency Code");
                RequestFilterFields = Code;
                column(Code; Code)
                {
                }
                column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                /* IF BankAcc.Blocked then
                    CurrReport.Skip(); */
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        PrintOnlyOnePerPage: Boolean;

    trigger OnPreReport()
    begin
        /* BankAccount."No." := '<>BIA_BK_100';
        BankAccount."Bank Acc. Posting Group" := '<>SHORT TERM LOAN' */
        ;
    end;
}
