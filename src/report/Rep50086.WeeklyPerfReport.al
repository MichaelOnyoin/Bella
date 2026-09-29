report 50086 "Weekly Perf Report"
{
    // ---------------------------------------------------------------
    // Bellazuri Weekly Performance Report
    // Layout  : RDLC
    // Dataset : Temp table populated by Codeunit 50100
    // Columns : MON–SUN   (one column per day)
    // Rows    : Domestic Invoices Net, Cash Received Domestic,
    //           Outstanding Domestic, PO/Invoices, Requisitions,
    //           Payments, Vendor Outstanding, Petty Cash Payments
    // ---------------------------------------------------------------

    Caption = 'Bellazuri Weekly Performance Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'BellazuriWeeklyPerfReport.rdl';

    dataset
    {
        dataitem(WeekLine; "Week Report Line")
        {
            // All columns exposed so RDLC can bind to them
            column(WeekStartDate; "Week Start Date") { }
            column(DayDate; "Day Date") { }
            column(DayNo; "Day No.") { }
            column(DomesticInvoicesNet; "Domestic Invoices Net") { }
            column(CashReceivedDomestic; "Cash Received Domestic") { }
            column(OutstandingDomestic; "Outstanding Domestic") { }
            column(POInvoices; "PO Invoices") { }
            column(Requisitions; "Requisitions") { }
            column(Payments; "Payments") { }
            column(OutstandingVendor; "Outstanding Vendor") { }
            column(PettyCashPayments; "Petty Cash Payments") { }

            // ── Calculated caption columns for RDLC header row ──
            column(ReportTitle; ReportTitleTxt) { }
            column(CompanyName; CompanyName()) { }
            column(WeekRangeText; WeekRangeText) { }
            column(PrintedBy; UserId()) { }
            column(PrintDateTime; Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4> <Hours24>:<Minutes,2>')) { }
        }
    }


    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Report Options';

                    field(WeekStartDateFld; WeekStartDateReq)
                    {
                        ApplicationArea = All;
                        Caption = 'Any Date in Target Week';
                        ToolTip = 'Enter any date within the week you want to report on. The report will automatically use Monday–Sunday of that week.';
                    }
                    // field(PettyCashAccFld; PettyCashAccFilterReq)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Petty Cash Bank Account Code';
                    //     ToolTip = 'Enter the Bank Account code for Petty Cash e.g. PETTY CASH';
                    // }
                }
            }
        }

        trigger OnOpenPage()
        begin
            // Default to the current week
            if WeekStartDateReq = 0D then
                WeekStartDateReq := Today();
            if PettyCashAccFilterReq = '' then
                PettyCashAccFilterReq := 'BANK_030';
        end;
    }

    trigger OnPreReport()
    var
        BellazuriMgt: Codeunit "Weekly Report Mgt";
        TempLine: Record "Week Report Line" temporary;
        StartDate: Date;
        EndDate: Date;
    // Diag: Codeunit "Report Diagnostic";
    begin
        if WeekStartDateReq = 0D then
            WeekStartDateReq := Today();

        BellazuriMgt.GetWeekDateRange(WeekStartDateReq, StartDate, EndDate);
        WeekRangeText := StrSubstNo('%1 to %2',
            Format(StartDate, 0, '<Day,2>/<Month,2>/<Year4>'),
            Format(EndDate, 0, '<Day,2>/<Month,2>/<Year4>'));

        // BellazuriMgt.DebugCashReceived(StartDate, EndDate);

        // Populate temp table
        BellazuriMgt.BuildWeeklyDataset(WeekStartDateReq, PettyCashAccFilterReq, TempLine);

        // Copy into the dataitem source
        WeekLine.Reset();
        WeekLine.DeleteAll();
        if TempLine.FindSet() then
            repeat
                WeekLine := TempLine;
                WeekLine.Insert();
            until TempLine.Next() = 0;

        // run diagnostic report
        // if GuiAllowed then
        //     Diag.RunFullDiagnostic(WeekStartDateReq);
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin

    end;

    var
        WeekStartDateReq: Date;
        PettyCashAccFilterReq: Text;
        WeekRangeText: Text;
        ReportTitleTxt: Label 'BELLAZURI OVERVIEW – WEEK ON WEEK PERFORMANCE', Locked = false;

    procedure SetWeekDate(NewWeekDate: Date; NewPettyCashBankCode: Code[20])
    begin
        WeekStartDateReq := NewWeekDate;
        PettyCashAccFilterReq := NewPettyCashBankCode;
    end;
}
