Report 50061 "Sale Register1"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Sale Register';
    RDLCLayout = './Report Layout/SaleRegister.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "Posting Date", "No.", "Sell-to Customer No.";
            column(Remaining_Amount; "Remaining Amount") { }
            column(Due_Date; "Due Date") { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Document_Date; "Document Date") { }
            column(Amount; Amount) { }
            column(Amount_Including_VAT; "Amount Including VAT") { }
            column(AmountLCY; AmountLCY) { }
            //column(CurrencyExchangeRate; CurrencyExchangeRate."Relational Exch. Rate Amount") { }
        }
    }
    var
        AmountLCY: Decimal;
}