report 50043 "UnclearedCheques-List"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'UnclearedCheques-List.rdlc';
    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = WHERE("Journal Batch Name" = CONST('CHECQUES'));
            RequestFilterFields = "Account No.", "Account Type";
            RequestFilterHeading = 'Uncleared Cheques-List';
            column(Posting_Date; "Posting Date")
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Account_No_; "Account No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Cheque_No_; "Cheque No.")
            {
            }
            column(Invoice_No_; "Invoice No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Amount__LCY_; "Amount (LCY)")
            {
            }

            trigger OnPreDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            begin
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
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
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}