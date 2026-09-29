codeunit 50087 "Weekly Report Mgt"
{
    procedure GetWeekDateRange(WeekStartDate: Date; var StartDate: Date; var EndDate: Date)
    begin
        // Week runs MON–SUN; derive from any date within the week
        StartDate := CalcDate('<-CW>', WeekStartDate);  // Monday
        EndDate := CalcDate('<CW>', WeekStartDate);     // Sunday
    end;

    procedure CalcDomesticInvoicesNet(
    StartDate: Date;
    EndDate: Date;
    CustomerFilter: Code[20]): Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        TotalInvoices: Decimal;
        TotalCreditNotes: Decimal;
    begin
        TotalInvoices := 0;
        TotalCreditNotes := 0;

        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
        CustLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        SetDomesticCustomerFilter(CustLedgEntry, CustomerFilter);
        if CustLedgEntry.FindSet() then
            repeat
                CustLedgEntry.CalcFields("Original Amt. (LCY)");
                TotalInvoices += CustLedgEntry."Original Amt. (LCY)";
            until CustLedgEntry.Next() = 0;

        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::"Credit Memo");
        CustLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        SetDomesticCustomerFilter(CustLedgEntry, CustomerFilter);
        if CustLedgEntry.FindSet() then
            repeat
                CustLedgEntry.CalcFields("Original Amt. (LCY)");
                TotalCreditNotes += Abs(CustLedgEntry."Original Amt. (LCY)");
            until CustLedgEntry.Next() = 0;

        exit(TotalInvoices - TotalCreditNotes);
    end;
    // ---------------------------------------------------------------
    // CASH RECEIVED – DOMESTIC
    // Payments applied to domestic customer invoices within period
    // ---------------------------------------------------------------
    procedure CalcCashReceivedDomestic(
        StartDate: Date;
        EndDate: Date;
        CustomerFilter: Code[20]): Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        TotalCash: Decimal;
    begin
        TotalCash := 0;

        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Payment);
        CustLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        // CustLedgEntry.SetFilter("Document No.", 'BP_PMT_*|BP_RCPT_*');
        SetDomesticCustomerFilter(CustLedgEntry, CustomerFilter);
        if CustLedgEntry.FindSet() then
            repeat
                CustLedgEntry.CalcFields("Original Amt. (LCY)");
                TotalCash += Abs(CustLedgEntry."Original Amt. (LCY)");
            until CustLedgEntry.Next() = 0;

        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::" ");
        CustLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        CustLedgEntry.SetFilter("Document No.", 'BP_RCPT_*');
        SetDomesticCustomerFilter(CustLedgEntry, CustomerFilter);
        if CustLedgEntry.FindSet() then
            repeat
                CustLedgEntry.CalcFields("Amount (LCY)");
                TotalCash += Abs(CustLedgEntry."Amount (LCY)");
            until CustLedgEntry.Next() = 0;

        exit(TotalCash);
    end;

    // ---------------------------------------------------------------
    // OUTSTANDING – DOMESTIC
    // Open (unpaid) domestic invoices as at EndDate
    // ---------------------------------------------------------------
    procedure CalcOutstandingDomestic(
        StartDate: Date;
        EndDate: Date;
        CustomerFilter: Code[20]): Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        TotalOutstanding: Decimal;
    begin
        TotalOutstanding := 0;
        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
        CustLedgEntry.SetRange(Open, true);
        CustLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        SetDomesticCustomerFilter(CustLedgEntry, CustomerFilter);
        if CustLedgEntry.FindSet() then
            repeat
                CustLedgEntry.CalcFields("Remaining Amount");
                TotalOutstanding += CustLedgEntry."Remaining Amount";
            until CustLedgEntry.Next() = 0;
        exit(TotalOutstanding);
    end;

    // ---------------------------------------------------------------
    // EXPENSES – PO / INVOICES
    // Posted Purchase Invoices within period (LCY)
    // ---------------------------------------------------------------
    procedure CalcPurchaseInvoices(StartDate: Date; EndDate: Date): Decimal
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        Total: Decimal;
    begin
        Total := 0;

        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        if VendLedgEntry.FindSet() then
            repeat
                VendLedgEntry.CalcFields("Original Amt. (LCY)");
                Total += Abs(VendLedgEntry."Original Amt. (LCY)");
            until VendLedgEntry.Next() = 0;

        exit(Total);
    end;

    // ---------------------------------------------------------------
    // EXPENSES – REQUISITIONS
    // Approved Purchase Requisitions (Purchase Lines not yet ordered)
    // ---------------------------------------------------------------
    procedure CalcRequisitions(StartDate: Date; EndDate: Date): Decimal
    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        Total: Decimal;
    begin
        Total := 0;

        PurchHeader.Reset();
        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Quote);
        PurchHeader.SetRange("Requisition Type", PurchHeader."Requisition Type"::Service); // key filter
        PurchHeader.SetRange("Document Date", StartDate, EndDate);
        if PurchHeader.FindSet() then
            repeat
                PurchLine.Reset();
                PurchLine.SetRange("Document Type", PurchLine."Document Type"::Quote);
                PurchLine.SetRange("Document No.", PurchHeader."No.");
                if PurchLine.FindSet() then
                    repeat
                        Total += PurchLine."Amount Including VAT";
                    until PurchLine.Next() = 0;
            until PurchHeader.Next() = 0;

        exit(Total);
    end;

    // ---------------------------------------------------------------
    // EXPENSES – PAYMENTS (Vendor)
    // Vendor payment entries posted within period
    // ---------------------------------------------------------------
    procedure CalcVendorPayments(StartDate: Date; EndDate: Date): Decimal
    var
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        Total: Decimal;
    begin
        Total := 0;

        DtldVendLedgEntry.Reset();
        DtldVendLedgEntry.SetRange("Entry Type", DtldVendLedgEntry."Entry Type"::"Initial Entry");
        DtldVendLedgEntry.SetRange("Document Type", DtldVendLedgEntry."Document Type"::Payment);
        DtldVendLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        DtldVendLedgEntry.SetFilter("Document No.", 'BP_PMT_*');
        if DtldVendLedgEntry.FindSet() then
            repeat
                Total += Abs(DtldVendLedgEntry."Amount (LCY)");
            until DtldVendLedgEntry.Next() = 0;



        exit(Total);
    end;

    // ---------------------------------------------------------------
    // EXPENSES – OUTSTANDING (Vendor)
    // Open vendor invoices as at EndDate
    // ---------------------------------------------------------------
    procedure CalcVendorOutstanding(StartDate: Date; EndDate: Date): Decimal
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        Total: Decimal;
    begin
        Total := 0;
        VendLedgEntry.Reset();
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange(Open, true);
        VendLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        if VendLedgEntry.FindSet() then
            repeat
                VendLedgEntry.CalcFields("Remaining Amt. (LCY)");
                Total += Abs(VendLedgEntry."Remaining Amt. (LCY)");
            until VendLedgEntry.Next() = 0;
        exit(Total);
    end;

    // ---------------------------------------------------------------
    // EXPENSES – PETTY CASH PAYMENTS
    // G/L entries posted to the Petty Cash account within period.
    // Adjust the G/L Account No. filter to match your chart of accounts.
    // ---------------------------------------------------------------
    procedure CalcPettyCashPayments(
       StartDate: Date;
       EndDate: Date;
       PettyCashBankCode: Code[20]  // pass the Bank Account No. e.g. 'PETTY CASH'
   ): Decimal
    var
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        Total: Decimal;
    begin
        Total := 0;

        if PettyCashBankCode = '' then
            PettyCashBankCode := 'BANK_030';

        BankAccLedgEntry.Reset();
        BankAccLedgEntry.SetRange("Bank Account No.", PettyCashBankCode);
        BankAccLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        BankAccLedgEntry.SetFilter(Amount, '<0'); // negative = payments out
        if BankAccLedgEntry.FindSet() then
            repeat
                Total += Abs(BankAccLedgEntry.Amount);
            until BankAccLedgEntry.Next() = 0;

        exit(Total);
    end;

    // ---------------------------------------------------------------
    // Helper: filter Customer Ledger Entries to Domestic customers
    // Uses Customer."Currency Code" = '' (LCY = domestic)
    // ---------------------------------------------------------------
    local procedure SetDomesticCustomerFilter(
    var CustLedgEntry: Record "Cust. Ledger Entry";
    CustomerFilter: Code[20]
)
    begin
        // Filter by specific customer if provided
        if CustomerFilter <> '' then
            CustLedgEntry.SetRange("Customer No.", CustomerFilter);

        CustLedgEntry.SetFilter(
            "Customer Posting Group",
            'COOPERATE|DISTRIBUTION|RETAIL|RETAIL-ARENA MALL|WHOLESALE|RETAIL-BTM|RETAIL-CASH SALE|RETAIL-ONLINE|RETAIL-POPUP'
        );
    end;

    // ---------------------------------------------------------------
    // Build a complete day-by-day dataset for the weekly report
    // Returns a temp table populated with one row per day (MON–SUN)
    // ---------------------------------------------------------------
    procedure BuildWeeklyDataset(
        WeekStartDate: Date;
        PettyCashAccFilter: Text;
        var TempWeekLine: Record "Week Report Line" temporary
    )
    var
        DayDate: Date;
        DayStart: Date;
        DayEnd: Date;
        i: Integer;
    begin
        TempWeekLine.DeleteAll();

        GetWeekDateRange(WeekStartDate, DayStart, DayEnd);

        for i := 0 to 6 do begin  // 0=Mon .. 6=Sun
            DayDate := CalcDate(StrSubstNo('<%1D>', i), DayStart);

            TempWeekLine.Init();
            TempWeekLine."Week Start Date" := DayStart;
            TempWeekLine."Day Date" := DayDate;
            TempWeekLine."Day No." := i + 1;

            // Sales Revenue
            TempWeekLine."Domestic Invoices Net" :=
                CalcDomesticInvoicesNet(DayDate, DayDate, '');
            TempWeekLine."Cash Received Domestic" :=
                CalcCashReceivedDomestic(DayDate, DayDate, '');

            // Expenses
            TempWeekLine."PO Invoices" :=
                CalcPurchaseInvoices(DayDate, DayDate);
            TempWeekLine.Requisitions :=
                CalcRequisitions(DayDate, DayDate);
            TempWeekLine.Payments :=
                CalcVendorPayments(DayDate, DayDate);
            TempWeekLine."Petty Cash Payments" :=
                CalcPettyCashPayments(DayDate, DayDate, PettyCashAccFilter);

            // Outstanding is a snapshot at end of that day (cumulative open)
            TempWeekLine."Outstanding Domestic" := CalcOutstandingDomestic(DayStart, DayDate, '');
            TempWeekLine."Outstanding Vendor" := CalcVendorOutstanding(DayStart, DayDate);

            TempWeekLine.Insert();
        end;
    end;

    // apply filters on page
    procedure ApplyDomesticInvoicesFilter(
    var CustLedgEntry: Record "Cust. Ledger Entry";
    StartDate: Date;
    EndDate: Date)
    begin
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
        CustLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        SetDomesticCustomerFilter(CustLedgEntry, '');
    end;

    procedure ApplyCashReceivedFilter(
    var CustLedgEntry: Record "Cust. Ledger Entry";
    StartDate: Date;
    EndDate: Date)
    begin
        CustLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        CustLedgEntry.SetFilter(
            "Document Type", '%1|%2',
            CustLedgEntry."Document Type"::Payment,
            CustLedgEntry."Document Type"::" ");
        CustLedgEntry.SetFilter("Document No.", '*|BP_RCPT_*');
        SetDomesticCustomerFilter(CustLedgEntry, '');
    end;

    procedure ApplyOutstandingDomesticFilter(
        var CustLedgEntry: Record "Cust. Ledger Entry";
        StartDate: Date;
        EndDate: Date)
    begin
        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice);
        CustLedgEntry.SetRange(Open, true);
        CustLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        SetDomesticCustomerFilter(CustLedgEntry, '');
    end;

    procedure ApplyPOInvoicesFilter(
    var VendLedgEntry: Record "Vendor Ledger Entry";
    StartDate: Date;
    EndDate: Date)
    begin
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange("Posting Date", StartDate, EndDate);
    end;

    procedure ApplyVendorPaymentsFilter(
    var DtldVendEntry: Record "Detailed Vendor Ledg. Entry";
    StartDate: Date;
    EndDate: Date)
    begin
        DtldVendEntry.SetRange("Entry Type", DtldVendEntry."Entry Type"::"Initial Entry");
        DtldVendEntry.SetRange("Document Type", DtldVendEntry."Document Type"::Payment);
        DtldVendEntry.SetRange("Posting Date", StartDate, EndDate);
        DtldVendEntry.SetFilter("Document No.", 'BP_PMT_*');
    end;

    procedure ApplyOutstandingVendorFilter(
        var VendLedgEntry: Record "Vendor Ledger Entry";
        StartDate: Date;
        EndDate: Date)
    begin
        VendLedgEntry.SetRange("Document Type", VendLedgEntry."Document Type"::Invoice);
        VendLedgEntry.SetRange(Open, true);
        VendLedgEntry.SetRange("Posting Date", StartDate, EndDate);
    end;

    procedure ApplyPettyCashFilter(
    var BankAccLedgEntry: Record "Bank Account Ledger Entry";
    StartDate: Date;
    EndDate: Date;
    BankCode: Code[20])
    begin
        if BankCode = '' then BankCode := 'BANK_030';
        BankAccLedgEntry.SetRange("Bank Account No.", BankCode);
        BankAccLedgEntry.SetRange("Posting Date", StartDate, EndDate);
        BankAccLedgEntry.SetFilter(Amount, '<0');
    end;
}
