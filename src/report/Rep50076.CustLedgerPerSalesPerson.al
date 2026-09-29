report 50076 "Cust Ledger Per Salesperson"
{
    ApplicationArea = All;
    Caption = 'Customer Ledger Per SalesPeraon';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            DataItemTableView = where("Document Type" = filter('Invoice|Credit Memo'));
            RequestFilterFields = "Posting Date", Open;
            Column(Company_Name; CompanyInfo.Name) { }
            Column(Company_Address; CompanyInfo.Address) { }
            Column(Company_PhoneNo; CompanyInfo."Phone No.") { }
            Column(Company_Picture; CompanyInfo.Picture) { }
            Column(Company_Email; CompanyInfo."E-Mail") { }
            Column(Company_HomePage; CompanyInfo."Home Page") { }
            column(PostingDate; "Posting Date")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(CustomerNo; "Customer No.")
            {
            }
            column(CustomerName; "Customer Name")
            {
            }
            column(SalespersonCode; "Salesperson Code")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AmountLCY; "Amount (LCY)")
            {
            }
            column(SalesLCY; "Sales (LCY)")
            {
            }
            column(RemainingAmount; "Remaining Amount")
            {
            }
            column(RemainingAmtLCY; "Remaining Amt. (LCY)")
            {
            }

            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "No." = field("Document No.");
                RequestFilterFields = "Posting Date";
                column(Sell_to_Contact_No_; "Sell-to Contact No.")
                {

                }
                column(Sell_to_Contact; "Sell-to Contact")
                {

                }
                column(ASL_EFRIS_InvoiceNo; "ASL.EFRIS.InvoiceNo")
                {

                }

            }

        }
    }
    var
        Companyinfo: Record "Company Information";

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);

    end;

}
