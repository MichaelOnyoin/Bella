page 50085 "Bellazuri Weekly Overview"
{
    PageType = Card;
    Caption = 'Bellazuri Weekly Performance Overview';
    Editable = false;
    UsageCategory = Documents;
    ApplicationArea = All;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            // ── WEEK SELECTOR ──────────────────────────────────────
            group(WeekSelector)
            {
                Caption = 'Week Selection';
                ShowCaption = true;

                field(WeekStartDateFld; WeekStartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Any Date in Target Week';
                    ToolTip = 'Enter any date within the week you want to view. The page will automatically load Monday to Sunday of that week.';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        LoadData(WeekStartDate);
                        WeekRangeText := GetWeekRangeText(WeekStartDate);
                        PettyCashBankCode := 'BANK_030';
                    end;
                }
                field(WeekRangeText; WeekRangeText)
                {
                    ApplicationArea = All;
                    Caption = 'Week Range';
                    Editable = false;
                    Style = Strong;
                }
                field(PettyCashBankCodeFld; PettyCashBankCode)
                {
                    ApplicationArea = All;
                    Caption = 'Petty Cash Bank Account';
                    ToolTip = 'Bank Account No. for Petty Cash e.g. BANK_030';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        LoadData(WeekStartDate);
                    end;
                }
            }

            // ── SALES REVENUE SECTION ──────────────────────────────
            group(SalesSection)
            {
                Caption = 'Sales Revenue';
                ShowCaption = true;

                part(SalesLines; "Bellazuri Weekly Sales Part")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    UpdatePropagation = Both;
                }
            }

            // ── EXPENSES SECTION ───────────────────────────────────
            group(ExpensesSection)
            {
                Caption = 'Expenses';
                ShowCaption = true;

                part(ExpenseLines; "Bellazuri Weekly Expenses Part")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    UpdatePropagation = Both;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Refresh)
            {
                ApplicationArea = All;
                Caption = 'Refresh';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Reload data for the selected week.';

                trigger OnAction()
                begin
                    LoadData(WeekStartDate);
                    WeekRangeText := GetWeekRangeText(WeekStartDate);
                end;
            }
            action(PreviousWeek)
            {
                ApplicationArea = All;
                Caption = '< Previous Week';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    WeekStartDate := CalcDate('<-7D>', WeekStartDate);
                    LoadData(WeekStartDate);
                    WeekRangeText := GetWeekRangeText(WeekStartDate);
                end;
            }
            action(NextWeek)
            {
                ApplicationArea = All;
                Caption = 'Next Week >';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    WeekStartDate := CalcDate('<7D>', WeekStartDate);
                    LoadData(WeekStartDate);
                    WeekRangeText := GetWeekRangeText(WeekStartDate);
                end;
            }
            action(CurrentWeek)
            {
                ApplicationArea = All;
                Caption = 'Current Week';
                Image = Today;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    WeekStartDate := Today();
                    LoadData(WeekStartDate);
                    WeekRangeText := GetWeekRangeText(WeekStartDate);
                end;
            }
            action(PrintReport)
            {
                ApplicationArea = All;
                Caption = 'Print / Preview Report';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Print or preview the weekly performance report for the selected week.';

                trigger OnAction()
                var
                    BellazuriReport: Report "Weekly Perf Report";
                begin
                    BellazuriReport.SetWeekDate(WeekStartDate, PettyCashBankCode);
                    BellazuriReport.Run();
                end;
            }
            action(RunDiagnostic)
            {
                ApplicationArea = All;
                Caption = 'Run Diagnostic';
                Image = CheckRulesSyntax;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Run diagnostic to compare report figures against BC source tables.';
            }
        }
    }

    var
        WeekStartDate: Date;
        WeekRangeText: Text;
        PettyCashBankCode: Code[20];
        GlobalTempLine: Record "Week Report Line" temporary;

    trigger OnOpenPage()
    begin
        WeekStartDate := Today();
        PettyCashBankCode := 'BANK_030';
        WeekRangeText := GetWeekRangeText(WeekStartDate);
        LoadData(WeekStartDate);
    end;

    local procedure LoadData(ForDate: Date)
    var
        BellazuriMgt: Codeunit "Weekly Report Mgt";
    begin
        BellazuriMgt.BuildWeeklyDataset(ForDate, PettyCashBankCode, GlobalTempLine);

        // Push data to subpages
        CurrPage.SalesLines.Page.LoadLines(GlobalTempLine);
        CurrPage.ExpenseLines.Page.LoadLines(GlobalTempLine);
    end;

    local procedure GetWeekRangeText(ForDate: Date): Text
    var
        BellazuriMgt: Codeunit "Weekly Report Mgt";
        StartDate: Date;
        EndDate: Date;
    begin
        BellazuriMgt.GetWeekDateRange(ForDate, StartDate, EndDate);
        exit(StrSubstNo('%1 to %2',
            Format(StartDate, 0, '<Day,2>/<Month,2>/<Year4>'),
            Format(EndDate, 0, '<Day,2>/<Month,2>/<Year4>')));
    end;

    // Public setter so the report can pass the week date back
    procedure SetWeekDate(NewDate: Date; BankCode: Code[20])
    begin
        WeekStartDate := NewDate;
        PettyCashBankCode := BankCode;
    end;
}

// ──────────────────────────────────────────────────────────────────────────────
// SALES SUBPAGE
// ──────────────────────────────────────────────────────────────────────────────
page 50086 "Bellazuri Weekly Sales Part"
{
    PageType = ListPart;
    SourceTable = "Week Report Line";
    SourceTableTemporary = true;
    Caption = 'Sales Revenue';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Day Date"; Rec."Day Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                    Style = Strong;
                }
                field(DayName; Format(Rec."Day Date", 0, '<Weekday Text>'))
                {
                    ApplicationArea = All;
                    Caption = 'Day';
                }
                field("Domestic Invoices Net"; Rec."Domestic Invoices Net")
                {
                    ApplicationArea = All;
                    Caption = 'Domestic Invoices (Net)';
                    DrillDown = true;
                    Style = Favorable;

                    trigger OnDrillDown()
                    begin
                        DrillDownDomesticInvoices(Rec."Day Date");
                    end;
                }
                field("Cash Received Domestic"; Rec."Cash Received Domestic")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Received(Domestic)';
                    DrillDown = true;
                    Style = Favorable;

                    trigger OnDrillDown()
                    begin
                        DrillDownCashReceived(Rec."Day Date");
                    end;
                }
                field("Outstanding Domestic"; Rec."Outstanding Domestic")
                {
                    ApplicationArea = All;
                    Caption = 'Outstanding (Customer)';
                    DrillDown = true;
                    Style = Attention;

                    trigger OnDrillDown()
                    begin
                        DrillDownOutstandingDomestic(Rec."Day Date");
                    end;
                }
            }
        }
    }

    procedure LoadLines(var TempLine: Record "Week Report Line" temporary)
    begin
        Rec.Reset();
        Rec.DeleteAll();
        if TempLine.FindSet() then
            repeat
                Rec := TempLine;
                Rec.Insert();
            until TempLine.Next() = 0;
        CurrPage.Update(false);
    end;

    local procedure DrillDownDomesticInvoices(DayDate: Date)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntries: Page "Customer Ledger Entries";
        BellazuriMgt: Codeunit "Weekly Report Mgt";
    begin
        BellazuriMgt.ApplyDomesticInvoicesFilter(CustLedgEntry, DayDate, DayDate);
        CustLedgEntries.SetTableView(CustLedgEntry);
        CustLedgEntries.RunModal();
    end;

    local procedure DrillDownCashReceived(DayDate: Date)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntries: Page "Customer Ledger Entries";
        BellazuriMgt: Codeunit "Weekly Report Mgt";
    begin
        BellazuriMgt.ApplyCashReceivedFilter(CustLedgEntry, DayDate, DayDate);
        CustLedgEntries.SetTableView(CustLedgEntry);
        CustLedgEntries.RunModal();
    end;

    local procedure DrillDownOutstandingDomestic(DayDate: Date)
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntries: Page "Customer Ledger Entries";
        BellazuriMgt: Codeunit "Weekly Report Mgt";
    begin
        BellazuriMgt.ApplyOutstandingDomesticFilter(CustLedgEntry, DayDate, DayDate);
        CustLedgEntries.SetTableView(CustLedgEntry);
        CustLedgEntries.RunModal();
    end;
}

// ──────────────────────────────────────────────────────────────────────────────
// EXPENSES SUBPAGE
// ──────────────────────────────────────────────────────────────────────────────
page 50087 "Bellazuri Weekly Expenses Part"
{
    PageType = ListPart;
    SourceTable = "Week Report Line";
    SourceTableTemporary = true;
    Caption = 'Expenses';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Day Date"; Rec."Day Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                    Style = Strong;
                }
                field(DayName; Format(Rec."Day Date", 0, '<Weekday Text>'))
                {
                    ApplicationArea = All;
                    Caption = 'Day';
                }
                field("PO Invoices"; Rec."PO Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'PO / Invoices';
                    DrillDown = true;
                    Style = Unfavorable;

                    trigger OnDrillDown()
                    begin
                        DrillDownPOInvoices(Rec."Day Date");
                    end;
                }
                field("Payments"; Rec."Payments")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Payments';
                    DrillDown = true;
                    Style = Unfavorable;

                    trigger OnDrillDown()
                    begin
                        DrillDownVendorPayments(Rec."Day Date");
                    end;
                }
                field("Outstanding Vendor"; Rec."Outstanding Vendor")
                {
                    ApplicationArea = All;
                    Caption = 'Outstanding (Vendor)';
                    DrillDown = true;
                    Style = Attention;

                    trigger OnDrillDown()
                    begin
                        DrillDownOutstandingVendor(Rec."Day Date");
                    end;
                }
                field("Petty Cash Payments"; Rec."Petty Cash Payments")
                {
                    ApplicationArea = All;
                    Caption = 'Petty Cash';
                    DrillDown = true;
                    Style = Unfavorable;

                    trigger OnDrillDown()
                    begin
                        DrillDownPettyCash(Rec."Day Date");
                    end;
                }
            }
        }
    }

    procedure LoadLines(var TempLine: Record "Week Report Line" temporary)
    begin
        Rec.Reset();
        Rec.DeleteAll();
        if TempLine.FindSet() then
            repeat
                Rec := TempLine;
                Rec.Insert();
            until TempLine.Next() = 0;
        CurrPage.Update(false);
    end;

    local procedure DrillDownPOInvoices(DayDate: Date)
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntries: Page "Vendor Ledger Entries";
        BellazuriMgt: Codeunit "Weekly Report Mgt";
    begin
        BellazuriMgt.ApplyPOInvoicesFilter(VendLedgEntry, DayDate, DayDate);
        VendLedgEntries.SetTableView(VendLedgEntry);
        VendLedgEntries.RunModal();
    end;

    local procedure DrillDownVendorPayments(DayDate: Date)
    var
        DtldVendEntry: Record "Detailed Vendor Ledg. Entry";
        DtldVendEntries: Page "Detailed Vendor Ledg. Entries";
        BellazuriMgt: Codeunit "Weekly Report Mgt";
    begin
        BellazuriMgt.ApplyVendorPaymentsFilter(DtldVendEntry, DayDate, DayDate);
        DtldVendEntries.SetTableView(DtldVendEntry);
        DtldVendEntries.RunModal();
    end;

local procedure DrillDownOutstandingVendor(DayDate: Date)
var
    VendLedgEntry: Record "Vendor Ledger Entry";
    VendLedgEntries: Page "Vendor Ledger Entries";
    BellazuriMgt: Codeunit "Weekly Report Mgt";
begin
    BellazuriMgt.ApplyOutstandingVendorFilter(VendLedgEntry, DayDate, DayDate);
    VendLedgEntries.SetTableView(VendLedgEntry);
    VendLedgEntries.RunModal();
end;

    local procedure DrillDownPettyCash(DayDate: Date)
    var
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        BankAccLedgEntries: Page "Bank Account Ledger Entries";
        BellazuriMgt: Codeunit "Weekly Report Mgt";
    begin
        BellazuriMgt.ApplyPettyCashFilter(BankAccLedgEntry, DayDate, DayDate, 'BANK_030');
        BankAccLedgEntries.SetTableView(BankAccLedgEntry);
        BankAccLedgEntries.RunModal();
    end;
}
