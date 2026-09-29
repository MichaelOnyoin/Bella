page 50004 "Vendor Uncleared Cheques"
{
    Caption = 'Vendor Uncleared Cheques';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Gen. Journal Line";
    SourceTableView = WHERE("Journal Batch Name" = CONST('VEND_CHECQ'));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    Caption = 'Account No.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field(HasComment; HasComment)
                {
                    ApplicationArea = All;
                    Caption = 'Has Comment';
                }
                field(Comments; Comments)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        Comment: Record "Cheques Comment Line";
                        CommentList: Page "Cheques Comment Sheet";
                    begin
                        Comment.SetRange("No.", Rec."Document No.");
                        CommentList.SetTableView(Comment);
                        CommentList.Run();
                    end;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Vendor")
            {
                Caption = 'Vendor';
                Image = Vendor;
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action(DimensionsSingle)
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(18),
                                      "No." = FIELD("Account No.");
                        ShortCutKey = 'Alt+D';
                        ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
                    }
                    action(DimensionsMultiple)
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                        trigger OnAction()
                        var
                            Cust: Record Customer;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SetSelectionFilter(Cust);
                            DefaultDimMultiple.SetMultiRecord(Cust, Rec.FieldNo("Account No."));
                            DefaultDimMultiple.RunModal;
                        end;
                    }
                }
                action("Bank Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Customer Bank Account List";
                    RunPageLink = "Customer No." = FIELD("Account No.");
                    ToolTip = 'View or set up the customer''s bank accounts. You can set up any number of bank accounts for each customer.';
                }
                action("Direct Debit Mandates")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Direct Debit Mandates';
                    Image = MakeAgreement;
                    RunObject = Page "SEPA Direct Debit Mandates";
                    RunPageLink = "Customer No." = FIELD("Account No.");
                    ToolTip = 'View the direct-debit mandates that reflect agreements with customers to collect invoice payments from their bank account.';
                }
                action(ShipToAddresses)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ship-&to Addresses';
                    Image = ShipAddress;
                    RunObject = Page "Ship-to Address List";
                    RunPageLink = "Customer No." = FIELD("Account No.");
                    ToolTip = 'View or edit alternate shipping addresses where the customer wants items delivered if different from the regular address.';
                }
            }

            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Vendor Ledger Entries")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = FIELD("Account No.");
                    RunPageView = SORTING("Vendor No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action(Statistics)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = FIELD("Account No.");
                    //"Date Filter" = FIELD("Date Filter"),
                    //"Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                    //"Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("S&ales")
                {
                    ApplicationArea = Advanced;
                    Caption = 'S&ales';
                    Image = Sales;
                    RunObject = Page "Vendor Purchases";
                    RunPageLink = "No." = FIELD("Account No.");
                    //"Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                    //"Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ToolTip = 'Shows a summary of customer ledger entries. You select the time interval in the View by field. The Period column on the left contains a series of dates that are determined by the time interval you have selected.';
                }
                action("Entry Statistics")
                {
                    ApplicationArea = Suite;
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page "Vendor Entry Statistics";
                    RunPageLink = "No." = FIELD("Account No.");
                    //"Date Filter" = FIELD("Date Filter"),
                    //"Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                    //"Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ToolTip = 'View entry statistics for the record.';
                }
                action("Statistics by C&urrencies")
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics by C&urrencies';
                    Image = Currencies;
                    RunObject = Page "Vend. Stats. by Curr. Lines";
                    RunPageLink = "Vendor Filter" = FIELD("Account No.");
                    //"Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                    //"Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                    //"Date Filter" = FIELD("Date Filter");
                    ToolTip = 'View statistics for customers that use multiple currencies.';
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Quotes)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Quotes';
                    Image = Quote;
                    RunObject = Page "Purchase Quotes";
                    RunPageLink = "Buy-from Vendor No." = FIELD("Account No.");
                    RunPageView = SORTING("Buy-from Vendor No.");
                    ToolTip = 'View a list of ongoing sales quotes.';
                }
                action(Orders)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Order List";
                    RunPageLink = "Sell-to Customer No." = FIELD("Account No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                    ToolTip = 'View a list of ongoing sales orders for the customer.';
                }
                action("Return Orders")
                {
                    ApplicationArea = PurchaseReturnOrder;
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    ;
                    RunObject = Page "Purchase Return Order List";
                    RunPageLink = "Buy-from Vendor No." = FIELD("Account No.");
                    RunPageView = SORTING("Buy-from Vendor No.");
                    ToolTip = 'Open the list of ongoing return orders.';
                }
            }
        }
        area(processing)
        {
            group(Action104)
            {
                Caption = 'History';
                Image = History;
                action(VendorLedgerEntriesHistory)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = FIELD("Account No.");
                    RunPageView = SORTING("Vendor No.");
                    Scope = Repeater;
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Promoted = true;
                    PromotedIsBig = true;
                    Image = ViewComments;
                    RunObject = Page "Cheques Comment Sheet";
                    RunPageLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                    ToolTip = 'View or add comments for the record.';
                }
            }
            action(PaymentRegistration)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Make Vendor Payments';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payment Registration";
                RunPageLink = "Source No." = FIELD("Account No.");
                ToolTip = 'Process your customer payments by matching amounts received on your bank account with the related unpaid sales invoices, and then post the payments.';
            }
            action(ClearChecque)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post Vendor Checques';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Process your Vendor cheque by matching amounts received on your bank account with the related unpaid sales invoices, and then post the checque.';

                trigger OnAction()
                var
                    VendorChecques: Record "Gen. Journal Line";
                    ViewChecques: Page "General Journal";
                begin
                    // VendorChecques.Reset();
                    VendorChecques.SETFILTER(VendorChecques."Account No.", Rec."Account No.");
                    VendorChecques.SetRange("Document No.", Rec."Document No.");
                    VendorChecques.SETRANGE(VendorChecques."Posting Date", Rec."Posting Date");
                    // CustomerChecques.SETRANGE(CustomerChecques."Journal Batch Name", '*CHECQ');
                    IF VendorChecques.FindFirst() THEN begin
                        IF Rec."Account Type" = Rec."Account Type"::Vendor then begin
                            ViewChecques.SetTableView(VendorChecques);
                            ViewChecques.Run();
                        end;
                    end;
                end;
            }
        }
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
                group(SalesReports)
                {
                    Caption = 'Purchase Reports';
                    Image = "Report";
                    action(ReportVendorTop10List)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Top 10 List';
                        Image = "Report";
                        RunObject = Report "Customer - Top 10 List";
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    /* action("Customer Statement")
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
                            Customer.SETRANGE(Customer."No.", Rec."Account No.");
                            CustStatement.SetTableView(Customer);
                            CustStatement.RUN;
                        end;
                    } */
                    action(UnclearedChequesPrint)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Vendor Checques - list';
                        Image = PrintChecklistReport;
                        Promoted = true;
                        PromotedCategory = Report;
                        PromotedIsBig = true;
                        RunObject = Report "UnclearedCheques-List";
                        ToolTip = 'Print a list of all the available Vendor uncleared cheques.';
                    }
                    action(ReportVendorPurchaseList)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Purchase List';
                        Image = "Report";
                        RunObject = Report "Vendor - Purchase List";
                        ToolTip = 'View Vendor sales for a period, for example, to report sales activity to customs and tax authorities. You can choose to include only customers with total sales that exceed a minimum amount. You can also specify whether you want the report to show address details for each customer.';
                    }
                    action(ReportPurchaseStatistics)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Statistics';
                        Image = "Report";
                        RunObject = Report "Purchase Statistics";
                        ToolTip = 'View Vendors'' total costs, sales, and profits over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted costs, sales, profits, invoice discounts, payment discounts, and profit percentage in three adjustable periods.';
                    }
                }
                group(FinanceReports)
                {
                    Caption = 'Finance Reports';
                    Image = "Report";
                    /* action(Statement)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement';
                        Image = "Report";
                        RunObject = Report "Customer Statement";
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    } */

                    action(ReportVendorBalanceToDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Balance to Date';
                        Image = "Report";
                        RunObject = Report "Vendor - Balance to Date";
                        ToolTip = 'View a list with Vendors'' payment history up until a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                    }
                    action(ReportVendorTrialBalance)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Trial Balance';
                        Image = "Report";
                        RunObject = Report "Vendor - Trial Balance";
                        ToolTip = 'View the beginning and ending balance for Vendor with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                    }
                    action(ReportVendorDetailTrial)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Detail Trial Bal.';
                        Image = "Report";
                        RunObject = Report "Customer - Detail Trial Bal.";
                        ToolTip = 'View the balance for Vendors with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';
                    }
                    action(ReportVendorSummaryAging)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Summary Aging';
                        Image = "Report";
                        RunObject = Report "Vendor - Summary Aging";
                        ToolTip = 'View, print, or save a summary of each Vendor''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    }
                    /* action(ReportVendorDetailedAging)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Detailed Aging';
                        Image = "Report";
                        RunObject = Report Vendor det;
                        ToolTip = 'View, print, or save a detailed list of each Vendor''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    } */
                    action(ReportAgedAccountsPayable)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Payable';
                        Image = "Report";
                        RunObject = Report "Aged Accounts Payable";
                        ToolTip = 'View an overview of when Vendor payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                    }
                    action(ReportVendorPaymentReceipt)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Payment Receipt';
                        Image = "Report";
                        RunObject = Report "Vendor - Payment Receipt";
                        ToolTip = 'View a document showing which vendor ledger entries that a payment has been applied to. This report can be used as a payment receipt that you send to the vendor.';
                    }
                }
                /*action(Reminder)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reminder';
                    Image = Reminder;
                    RunObject = Report Reminder;
                    ToolTip = 'Create a new reminder for the customer.';
                }*/
            }
            group(General)
            {
                Caption = 'General';
                action("Vendor List")
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor List';
                    Image = "Report";
                    RunObject = Report "Customer - List";
                    ToolTip = 'View various kinds of basic information for vendors, such as vendor posting group, discount group, finance charge and payment information, salesperson, the vendor''s default currency and credit limit (in LCY), and the customer''s current balance (in LCY).';
                }
                action("Vendor Register")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Register';
                    Image = "Report";
                    RunObject = Report "Vendor Register";
                    ToolTip = 'View posted Vendor ledger entries divided into, and sorted according to, registers. By using a filter, you can select exactly the entries in the registers that you need to see. If you have created many entries and you do not set a filter, the report will print a large amount of information.';
                }
                action("CustVendoromer - Top 10 List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Top 10 List';
                    Image = "Report";
                    RunObject = Report "Vendor - Top 10 List";
                    ToolTip = 'View which vendors purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                }
            }
            group(Purchases)
            {
                Caption = 'Purchases';
                Image = Sales;
                action("Vendor - Order Summary")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Order Summary';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Order Summary";
                    ToolTip = 'View the order detail (the quantity not yet shipped) for each vendor in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.';
                }
                action("Vendor - Order Detail")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Order Detail';
                    Image = "Report";
                    RunObject = Report "Vendor - Order Detail";
                    ToolTip = 'View a list of orders divided by vendor. The order amounts are totaled for each customer and for the entire list. The report can be used, for example, to obtain an overview of sales over the short term or to analyze possible shipment problems.';
                }
                action("Vendor - Sales List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor - Sales List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Vendor - Purchase List";
                    ToolTip = 'View Vendor purchases for a period, for example, to report sales activity to customs and tax authorities. You can choose to include only customers with total sales that exceed a minimum amount. You can also specify whether you want the report to show address details for each customer.';
                }
                action("Purchases Statistics")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchases Statistics';
                    Image = "Report";
                    RunObject = Report "Purchase Statistics";
                    ToolTip = 'View vendors'' total costs, sales, and profits over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted costs, sales, profits, invoice discounts, payment discounts, and profit percentage in three adjustable periods.';
                }
                /* action("Vendor/Item Sales")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor/Item Sales';
                    Image = "Report";
                    RunObject = Report "Vendor/Item Sales";
                    ToolTip = 'View a list of item sales for each customer during a selected time period. The report contains information on quantity, sales amount, profit, and possible discounts. It can be used, for example, to analyze a company''s customer groups.';
                } */
            }
        }
    }

    var
        HasComment: Boolean;
        Comments: Integer;

    trigger OnAfterGetRecord()
    var
        CommentLine: Record "Cheques Comment Line";
    begin
        CommentLine.SetRange("No.", Rec."Document No.");
        IF not CommentLine.FindFirst() then
            HasComment := false
        else
            HasComment := true;
        Comments := CommentLine.Count();
    end;
}