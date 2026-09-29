report 50085 "Customer Receipt"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Customer Receipt';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'ReceiptReport.rdl';
    WordMergeDataItem = CustLedgerEntry;  // ← changed from GenJournalLine

    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")  // ← changed from GenJournalLine
        {
            RequestFilterHeading = 'Customer Receipt';
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(PostCode; CompanyInfo."Post Code" + ' ' + CompanyInfo.City) { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyVATRegNo; CompanyInfo."VAT Registration No.") { }
            column(Document_No_; "Document No.") { }
            column(CustomerNo; "Customer No.") { }
            column(CustomerName; "Customer Name") { }
            column(PostingDate; "Posting Date") { }
            column(DocumentType; "Document Type") { }
            column(DocumentNo; "Document No.") { }
            column(Description; Description) { }
            column(CurrencyCode; "Currency Code") { }
            column(Amount; Amount) { }
            column(AmountLCY; "Amount (LCY)") { }
            column(DebitAmount; "Debit Amount (LCY)") { }
            column(CreditAmount; "Credit Amount (LCY)") { }
            column(ExternalDocumentNo; "External Document No.") { }
            column(DueDate; "Due Date") { }
            column(DocumentDate; "Document Date") { }
            column(SalesLCY; "Sales (LCY)") { }
            column(ProfitLCY; "Profit (LCY)") { }
            column(InvDiscountLCY; "Inv. Discount (LCY)") { }
            column(PostingGroup; "Customer Posting Group") { }
            column(ShortcutDimension1Code; "Global Dimension 1 Code") { }
            column(ShortcutDimension2Code; "Global Dimension 2 Code") { }
            column(SalespersPurchCode; "Salesperson Code") { }
            column(OnHold; "On Hold") { }
            column(AppliestoDocType; "Applies-to Doc. Type") { }
            column(AppliestoDocNo; "Applies-to Doc. No.") { }
            // column(PaymentDiscount; "Payment Discount %") { }
            column(PmtDiscountDate; "Pmt. Discount Date") { }
            // column(PaymentTermsCode; "Payment Terms Code") { }
            column(ASL_EFRIS_TIN; Customer."ASL.EFRIS.TIN") { }
            column(DimensionSetID; "Dimension Set ID") { }
            column(SourceCode; "Source Code") { }
            column(ReasonCode; "Reason Code") { }
            column(Open; Open) { }
            column(Reversed; Reversed) { }
            column(TransactionNo; "Transaction No.") { }
            column(AmountInWords; NoText[1]) { }
            column(Narration; Narration) { }


            trigger OnAfterGetRecord()
            begin
                CustLedgerEntry.CalcFields(Amount, "Amount (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)");
                WriteAmountInWords.InitTextVariable();
                WriteAmountInWords.FormatNoText(NoText, Abs("Credit Amount (LCY)"), "Currency Code");  // ← Abs() fixes negative
                if Customer.Get("Customer No.") then;
            end;
        }
    }

    requestpage
    {
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
            area(Processing)
            {
            }
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        NoText: array[500] of Text;
        WriteAmountInWords: Codeunit "ASL.WriteAmountInWords";
        Customer: Record Customer;
}