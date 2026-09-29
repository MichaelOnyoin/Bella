pageextension 50035 "Bus. Manager Role Center Ext" extends "Business Manager Role Center"
{
    actions
    {
        // Add changes to page actions here
        addafter(Action41)
        {
            group("Employee Self Service")
            {
                action("Cash Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Requisitions';
                    Image = ReceiptLines;
                    RunObject = page "AdvancePurchase RequisitionsSS";
                }
                action("Purchase Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Requisitions';
                    Image = ReceiptLines;
                    RunObject = page "Purchase Requisitions Self";
                }
                /*    action("Sales Summary")
                             {
                                 ApplicationArea = All;
                                 Caption = 'Sales Summary';
                                 Image = Report;
                                 RunObject = Report SalesSummary;
                             } */
            }
        }
        addafter("Chart of Accounts")
        {
            action("Sales Summary")
            {
                ApplicationArea = All;
                Caption = 'Sales Summary';
                Image = Report;
                RunObject = Report SalesSummary;
            }
        }
        addafter("Income Statement")
        {
            action("Profit & Loss")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Profit/Loss Statement';
                Image = "Report";
                RunObject = Report "Account Schedule";
                ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
            }
            action("Trial Balance cust1")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Trial Balance';
                Image = "Report";
                RunObject = Report "Trial Balance";
                ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
            }
            action("Trial Balance cust2")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Trial Balance Finance';
                Image = "Report";
                RunObject = Report "Trial Balance Finance";
                ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
            }
        }
        addafter("Financial Statements")
        {
            group("Customer Reports")
            {
                Caption = 'Customer Reports';
                Image = Customer;
                group(General)
                {
                    Caption = 'General';
                    Image = "Report";
                    action("Customer List")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer List';
                        Image = "Report";
                        RunObject = Report "Customer - List";
                        ToolTip = 'View various kinds of basic information for customers, such as customer posting group, discount group, finance charge and payment information, salesperson, the customer''s default currency and credit limit (in LCY), and the customer''s current balance (in LCY).';
                    }
                    action("Customer Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Register';
                        Image = "Report";
                        RunObject = Report "Customer Register";
                        ToolTip = 'View posted customer ledger entries divided into, and sorted according to, registers. By using a filter, you can select exactly the entries in the registers that you need to see. If you have created many entries and you do not set a filter, the report will print a large amount of information.';
                    }
                    action("Customer - Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Top 10 List';
                        Image = "Report";
                        RunObject = Report "Customer - Top 10 List";
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                }
                group(FinanceReports)
                {
                    Caption = 'Finance Reports';
                    Image = "Report";
                    action(CustomerStatement)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Statement';
                        Image = "Report";
                        RunObject = Report "Statement MOD";
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    }
                    action(ReportCustomerBalanceToDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Balance to Date';
                        Image = "Report";
                        RunObject = Report "Customer - Balance to Date";
                        ToolTip = 'View a list with customers'' payment history up until a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                    }
                    action(ReportCustomerTrialBalance)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Trial Balance';
                        Image = "Report";
                        RunObject = Report "Customer - Trial Balance";
                        ToolTip = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                    }
                    action(ReportCustomerDetailTrial)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Detail Trial Bal.';
                        Image = "Report";
                        RunObject = Report "Customer - Detail Trial Bal.";
                        ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';
                    }
                    action(ReportCustomerSummaryAging)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Summary Aging';
                        Image = "Report";
                        RunObject = Report "Customer - Summary Aging";
                        ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    }
                    action(ReportCustomerDetailedAging)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Detailed Aging';
                        Image = "Report";
                        RunObject = Report "Customer Detailed Aging";
                        ToolTip = 'View, print, or save a detailed list of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    }
                    action(ReportAgedAccountsReceivable)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        Image = "Report";
                        RunObject = Report "Aged Accounts Receivable";
                        ToolTip = 'View an overview of when customer payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                    }
                    action(ReportCustomerPaymentReceipt)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Payment Receipt';
                        Image = "Report";
                        RunObject = Report "Customer - Payment Receipt";
                        ToolTip = 'View a document showing which customer ledger entries that a payment has been applied to. This report can be used as a payment receipt that you send to the customer.';
                    }
                }
            }
            group("Vendor Reports")
            {
                Caption = 'Vendor Reports';
                Image = Vendor;
                group("General - Vendors")
                {
                    Caption = 'General';
                    Image = "Report";
                    action("Vendor - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - List';
                        Image = "Report";
                        RunObject = Report "Vendor - List";
                        ToolTip = 'View various kinds of basic information for vendors, such as vendor posting group, discount and payment information, priority level and the vendor''s default currency, and the vendor''s current balance (in LCY). The report can be used, for example, to maintain the information in the Vendor table.';
                    }
                    action("Vendor Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Register';
                        Image = "Report";
                        RunObject = Report "Vendor Register";
                        ToolTip = 'View vendor ledger entries that have been posted in connection with a general ledger register. The entries are divided into, and sorted according to, G/L registers. By using a filter, you can select exactly the entries in the registers that you need to see. The report can be used to document the contents of the various registers for internal or external audits.';
                    }
                    action("Vendor Item Catalog")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor Item Catalog';
                        Image = "Report";
                        RunObject = Report "Vendor Item Catalog";
                        ToolTip = 'View a list of the items that your vendors supply.';
                    }
                    action("Vendor - Labels")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Labels';
                        Image = "Report";
                        RunObject = Report "Vendor - Labels";
                        ToolTip = 'View mailing labels with the vendors'' names and addresses.';
                    }
                    action("Vendor - Top 10 List")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Top 10 List';
                        Image = "Report";
                        RunObject = Report "Vendor - Top 10 List";
                        ToolTip = 'View a list of the vendors from whom you purchase the most or to whom you owe the most.';
                    }
                }
                group(Action5)
                {
                    Caption = 'Orders';
                    Image = "Report";
                    action("Vendor - Order Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Order Summary';
                        Image = "Report";
                        RunObject = Report "Vendor - Order Summary";
                        ToolTip = 'View the order detail (the quantity not yet received) for each vendor in three periods of 30 days each, starting from a selected date. There are also columns with orders before and after the three periods and a column with the total order detail for each vendor. The report can be used to analyze a company''s expected purchase volume.';
                    }
                    action("Vendor - Order Detail")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Order Detail';
                        Image = "Report";
                        RunObject = Report "Vendor - Order Detail";
                        ToolTip = 'View a list of items that have been ordered, but not yet received, from each vendor. The order amounts are totaled for each vendor and for the entire list. The report can be used, for example, to obtain an overview of purchases over the short term or to analyze possible receipt problems.';
                    }
                }
                group(Purchase)
                {
                    Caption = 'Purchase';
                    Image = Purchase;
                    action("Vendor - Purchase List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Purchase List';
                        Image = "Report";
                        RunObject = Report "Vendor - Purchase List";
                        ToolTip = 'View a list of vendor purchases for a selected period.';
                    }
                    action("Vendor/Item Purchases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor/Item Purchases';
                        Image = "Report";
                        RunObject = Report "Vendor/Item Purchases";
                        ToolTip = 'View a list of item entries for each vendor in a selected period.';
                    }
                    action("Purchase Statistics")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Statistics';
                        Image = "Report";
                        RunObject = Report "Purchase Statistics";
                        ToolTip = 'View a list of amounts for purchases, invoice discount and payment discount in $ for each vendor.';
                    }
                }
                group("Financial Management - Vendors")
                {
                    Caption = 'Financial Management';
                    Image = "Report";
                    action("Payments on Hold")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Payments on Hold';
                        Image = "Report";
                        RunObject = Report "Payments on Hold";
                        ToolTip = 'View a list of all vendor ledger entries on which the On Hold field is marked.';
                    }
                    action("Vendor - Summary Aging")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Summary Aging';
                        Image = "Report";
                        RunObject = Report "Vendor - Summary Aging";
                        ToolTip = 'View, print, or save a summary of the payables owed to each vendor, divided into three time periods.';
                    }
                    action("Aged Accounts Payable")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Payable';
                        Image = "Report";
                        RunObject = Report "Aged Accounts Payable";
                        ToolTip = 'View a list of aged remaining balances for each vendor.';
                    }
                    action("Vendor - Balance to Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Balance to Date';
                        Image = "Report";
                        RunObject = Report "Vendor - Balance to Date";
                        ToolTip = 'View, print, or save a detail balance to date for selected vendors.';
                    }
                    action("Vendor - Trial Balance")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Trial Balance';
                        Image = "Report";
                        RunObject = Report "Vendor - Trial Balance";
                        ToolTip = 'View the beginning and ending balance for vendors with entries within a specified period. The report can be used to verify that the balance for a vendor posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                    }
                    action("Vendor - Detail Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Detail Trial Balance';
                        Image = "Report";
                        RunObject = Report "Vendor - Detail Trial Balance";
                        ToolTip = 'View a detail trial balance for selected vendors.';
                    }
                }
            }
            group("Inventory Reports")
            {
                Caption = 'Inventory Reports';
                Image = Item;
                group(AssemblyProduction)
                {
                    Caption = 'Assembly/Production';
                    Image = "Report";
                    action("Assemble to Order - Sales")
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Assemble to Order - Sales';
                        Image = "Report";
                        RunObject = Report "Assemble to Order - Sales";
                        ToolTip = 'View key sales figures for assembly components that may be sold either as part of assembly items in assemble-to-order sales or as separate items directly from inventory. Use this report to analyze the quantity, cost, sales, and profit figures of assembly components to support decisions, such as whether to price a kit differently or to stop or start using a particular item in assemblies.';
                    }
                    action("Where-Used (Top Level)")
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Where-Used (Top Level)';
                        Image = "Report";
                        RunObject = Report "Where-Used (Top Level)";
                        ToolTip = 'View where and in what quantities the item is used in the product structure. The report only shows information for the top-level item. For example, if item "A" is used to produce item "B", and item "B" is used to produce item "C", the report will show item B if you run this report for item A. If you run this report for item B, then item C will be shown as where-used.';
                    }
                    action("Quantity Explosion of BOM")
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Quantity Explosion of BOM';
                        Image = "Report";
                        RunObject = Report "Quantity Explosion of BOM";
                        ToolTip = 'View an indented BOM listing for the item or items that you specify in the filters. The production BOM is completely exploded for all levels.';
                    }
                    group(Costing)
                    {
                        Caption = 'Costing';
                        Image = ItemCosts;
                        action("Inventory Valuation - WIP")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory Valuation - WIP';
                            Image = "Report";
                            RunObject = Report "Inventory Valuation - WIP";
                            ToolTip = 'View inventory valuation for selected production orders in your WIP inventory. The report also shows information about the value of consumption, capacity usage and output in WIP. The printed report only shows invoiced amounts, that is, the cost of entries that have been posted as invoiced.';
                        }
                        action("Cost Shares Breakdown")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cost Shares Breakdown';
                            Image = "Report";
                            RunObject = Report "Cost Shares Breakdown";
                            ToolTip = 'View the item''s cost broken down in inventory, WIP, or COGS, according to purchase and material cost, capacity cost, capacity overhead cost, manufacturing overhead cost, subcontracted cost, variance, indirect cost, revaluation, and rounding. The report breaks down cost at a single BOM level and does not roll up the costs from lower BOM levels. The report does not calculate the cost share from items that use the Average costing method.';
                        }
                        action("Detailed Calculation")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Detailed Calculation';
                            Image = "Report";
                            RunObject = Report "Detailed Calculation";
                            ToolTip = 'View the list of all costs for the item taking into account any scrap during production.';
                        }
                        action("Rolled-up Cost Shares")
                        {
                            ApplicationArea = Manufacturing;
                            Caption = 'Rolled-up Cost Shares';
                            Image = "Report";
                            RunObject = Report "Rolled-up Cost Shares";
                            ToolTip = 'View the cost shares of all items in the parent item''s product structure, their quantity and their cost shares specified in material, capacity, overhead, and total cost. Material cost is calculated as the cost of all items in the parent item''s product structure. Capacity and subcontractor costs are calculated as the costs related to produce all of the items in the parent item''s product structure. Material cost is calculated as the cost of all items in the item''s product structure. Capacity and subcontractor costs are the cost related to the parent item only.';
                        }
                        action("Single-Level Cost Shares")
                        {
                            ApplicationArea = Manufacturing;
                            Caption = 'Single-Level Cost Shares';
                            Image = "Report";
                            RunObject = Report "Single-level Cost Shares";
                            ToolTip = 'View the cost shares of all items in the item''s product structure, their quantity and their cost shares specified in material, capacity, overhead, and total cost. Material cost is calculated as the cost of all items in the parent item''s product structure. Capacity and subcontractor costs are calculated as the costs related to produce all of the items in the parent item''s product structure.';
                        }
                    }
                }
                group(Inventory)
                {
                    Caption = 'Inventory';
                    Image = "Report";
                    action("Inventory - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - List';
                        Image = "Report";
                        RunObject = Report "Inventory - List";
                        ToolTip = 'View various information about the item, such as name, unit of measure, posting group, shelf number, vendor''s item number, lead time calculation, minimum inventory, and alternate item number. You can also see if the item is blocked.';
                    }
                    action("Inventory - Availability Plan")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Availability Plan';
                        Image = ItemAvailability;
                        RunObject = Report "Inventory - Availability Plan";
                        ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
                    }
                    action("Item/Vendor Catalog")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item/Vendor Catalog';
                        Image = "Report";
                        RunObject = Report "Item/Vendor Catalog";
                        ToolTip = 'View a list of the vendors for the selected items. For each combination of item and vendor, it shows direct unit cost, lead time calculation and the vendor''s item number.';
                    }
                    action("Phys. Inventory List")
                    {
                        ApplicationArea = Warehouse;
                        Caption = 'Phys. Inventory List';
                        Image = "Report";
                        RunObject = Report "Phys. Inventory List";
                        ToolTip = 'View a list of the lines that you have calculated in the Phys. Inventory Journal window. You can use this report during the physical inventory count to mark down actual quantities on hand in the warehouse and compare them to what is recorded in the program.';
                    }
                    action("Catalog Item Sales")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Catalog Item Sales';
                        Image = "Report";
                        RunObject = Report "Catalog Item Sales";
                        ToolTip = 'View a list of item sales for each catalog item during a selected time period. It can be used to review a company''s sale of catalog items.';
                    }
                    action("Item Substitutions")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Item Substitutions';
                        Image = "Report";
                        RunObject = Report "Item Substitutions";
                        ToolTip = 'View or edit any substitute items that are set up to be traded instead of the item in case it is not available.';
                    }
                    action("Price List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Price List';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = Category9;
                        RunObject = Report "Price List";
                        ToolTip = 'View, print, or save a list of your items and their prices, for example, to send to customers. You can create the list for specific customers, campaigns, currencies, or other criteria.';
                    }
                    action("Inventory Cost and Price List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Cost and Price List';
                        Image = "Report";
                        RunObject = Report "Inventory Cost and Price List";
                        ToolTip = 'View, print, or save a list of your items and their price and cost information. The report specifies direct unit cost, last direct cost, unit price, profit percentage, and profit.';
                    }
                    action("Inventory Availability")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Availability';
                        Image = "Report";
                        RunObject = Report "Inventory Availability";
                        ToolTip = 'View, print, or save a summary of historical inventory transactions with selected items, for example, to decide when to purchase the items. The report specifies quantity on sales order, quantity on purchase order, back orders from vendors, minimum inventory, and whether there are reorders.';
                    }
                    group("Item Register")
                    {
                        Caption = 'Item Register';
                        Image = ItemRegisters;
                        action("Item Register - Quantity")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Register - Quantity';
                            Image = "Report";
                            RunObject = Report "Item Register - Quantity";
                            ToolTip = 'View one or more selected item registers showing quantity. The report can be used to document a register''s contents for internal or external audits.';
                        }
                        action("Item Register - Value")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Register - Value';
                            Image = "Report";
                            RunObject = Report "Item Register - Value";
                            ToolTip = 'View one or more selected item registers showing value. The report can be used to document the contents of a register for internal or external audits.';
                        }
                    }
                    group(Action130)
                    {
                        Caption = 'Costing';
                        Image = ItemCosts;
                        action("Inventory - Cost Variance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Cost Variance';
                            Image = ItemCosts;
                            RunObject = Report "Inventory - Cost Variance";
                            ToolTip = 'View information about selected items, unit of measure, standard cost, and costing method, as well as additional information about item entries: unit amount, direct unit cost, unit cost variance (the difference between the unit amount and unit cost), invoiced quantity, and total variance amount (quantity * unit cost variance). The report can be used primarily if you have chosen the Standard costing method on the item card.';
                        }
                        action("Invt. Valuation - Cost Spec.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Invt. Valuation - Cost Spec.';
                            Image = "Report";
                            RunObject = Report "Invt. Valuation - Cost Spec.";
                            ToolTip = 'View an overview of the current inventory value of selected items and specifies the cost of these items as of the date specified in the Valuation Date field. The report includes all costs, both those posted as invoiced and those posted as expected. For each of the items that you specify when setting up the report, the printed report shows quantity on stock, the cost per unit and the total amount. For each of these columns, the report specifies the cost as the various value entry types.';
                        }
                        action("Compare List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Compare List';
                            Image = "Report";
                            RunObject = Report "Compare List";
                            ToolTip = 'View a comparison of components for two items. The printout compares the components, their unit cost, cost share and cost per component.';
                        }
                    }
                    group("Inventory Details")
                    {
                        Caption = 'Inventory Details';
                        Image = "Report";
                        action("Inventory - Transaction Detail")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Transaction Detail';
                            Image = "Report";
                            RunObject = Report "Inventory - Transaction Detail";
                            ToolTip = 'View transaction details with entries for the selected items for a selected period. The report shows the inventory at the beginning of the period, all of the increase and decrease entries during the period with a running update of the inventory, and the inventory at the close of the period. The report can be used at the close of an accounting period, for example, or for an audit.';
                        }
                        action("Item Charges - Specification")
                        {
                            ApplicationArea = ItemCharges;
                            Caption = 'Item Charges - Specification';
                            Image = "Report";
                            RunObject = Report "Item Charges - Specification";
                            ToolTip = 'View a specification of the direct costs that your company has assigned and posted as item charges. The report shows the various value entries that have been posted as item charges. It includes all costs, both those posted as invoiced and those posted as expected.';
                        }
                        action("Item Age Composition - Quantity")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Age Composition - Quantity';
                            Image = "Report";
                            RunObject = Report "Item Age Composition - Qty.";
                            ToolTip = 'View, print, or save an overview of the current age composition of selected items in your inventory.';
                        }
                        action("Item Expiration - Quantity")
                        {
                            ApplicationArea = ItemTracking;
                            Caption = 'Item Expiration - Quantity';
                            Image = "Report";
                            RunObject = Report "Item Expiration - Quantity";
                            ToolTip = 'View an overview of the quantities of selected items in your inventory whose expiration dates fall within a certain period. The list shows the number of units of the selected item that will expire in a given time period. For each of the items that you specify when setting up the report, the printed document shows the number of units that will expire during each of three periods of equal length and the total inventory quantity of the selected item.';
                        }
                    }
                    group("Other Inventory - Reports")
                    {
                        Caption = 'Inventory Statistics';
                        Image = "Report";
                        action("Inventory - Sales Statistics")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Inventory - Sales Statistics';
                            Image = "Report";
                            RunObject = Report "Inventory - Sales Statistics";
                            ToolTip = 'View, print, or save a summary of selected items'' sales per customer, for example, to analyze the profit on individual items or trends in revenues and profit. The report specifies direct unit cost, unit price, sales quantity, sales in LCY, profit percentage, and profit.';
                        }
                        action("Inventory - Customer Sales")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Inventory - Customer Sales';
                            Image = "Report";
                            RunObject = Report "Inventory - Customer Sales";
                            ToolTip = 'View, print, or save a list of customers that have purchased selected items within a selected period, for example, to analyze customers'' purchasing patterns. The report specifies quantity, amount, discount, profit percentage, and profit.';
                        }
                        action("Inventory - Top 10 List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Top 10 List';
                            Image = "Report";
                            RunObject = Report "Inventory - Top 10 List";
                            ToolTip = 'View information about the items with the highest or lowest sales within a selected period. You can also choose that items that are not on hand or have not been sold are not included in the report. The items are sorted by order size within the selected period. The list gives a quick overview of the items that have sold either best or worst, or the items that have the most or fewest units on inventory.';
                        }
                    }
                    group("Finance Reports")
                    {
                        Caption = 'Finance Reports';
                        Image = "Report";
                        action("Inventory Valuation")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory Valuation';
                            Image = "Report";
                            RunObject = Report "Inventory Valuation";
                            ToolTip = 'View, print, or save a list of the values of the on-hand quantity of each inventory item.';
                        }
                        action(Status)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Status';
                            Image = "Report";
                            RunObject = Report Status;
                            ToolTip = 'View, print, or save the status of partially filled or unfilled orders so you can determine what effect filling these orders may have on your inventory.';
                        }
                        action("Item Age Composition - Value")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Age Composition - Value';
                            Image = "Report";
                            RunObject = Report "Item Age Composition - Value";
                            ToolTip = 'View, print, or save an overview of the current age composition of selected items in your inventory.';
                        }
                    }
                }
                group(Orders)
                {
                    Caption = 'Orders';
                    Image = "Report";
                    action("Inventory Order Details")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Order Details';
                        Image = "Report";
                        RunObject = Report "Inventory Order Details";
                        ToolTip = 'View a list of the orders that have not yet been shipped or received and the items in the orders. It shows the order number, customer''s name, shipment date, order quantity, quantity on back order, outstanding quantity and unit price, as well as possible discount percentage and amount. The quantity on back order and outstanding quantity and amount are totaled for each item. The report can be used to find out whether there are currently shipment problems or any can be expected.';
                    }
                    action("Inventory Purchase Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Purchase Orders';
                        Image = "Report";
                        RunObject = Report "Inventory Purchase Orders";
                        ToolTip = 'View a list of items on order from vendors. It also shows the expected receipt date and the quantity and amount on back orders. The report can be used, for example, to see when items should be received and whether a reminder of a back order should be issued.';
                    }
                    action("Inventory - Vendor Purchases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Vendor Purchases';
                        Image = "Report";
                        RunObject = Report "Inventory - Vendor Purchases";
                        ToolTip = 'View a list of the vendors that your company has purchased items from within a selected period. It shows invoiced quantity, amount and discount. The report can be used to analyze a company''s item purchases.';
                    }
                    action("Inventory - Reorders")
                    {
                        ApplicationArea = Planning;
                        Caption = 'Inventory - Reorders';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        RunObject = Report "Inventory - Reorders";
                        ToolTip = 'View a list of items with negative inventory that is sorted by vendor. You can use this report to help decide which items have to be reordered. The report shows how many items are inbound on purchase orders or transfer orders and how many items are in inventory. Based on this information and any defined reorder quantity for the item, a suggested value is inserted in the Qty. to Order field.';
                    }
                    action("Inventory - Sales Back Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Sales Back Orders';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        RunObject = Report "Inventory - Sales Back Orders";
                        ToolTip = 'Shows a list of order lines with shipment dates that are exceeded. The report also shows if there are other items for the customer on back order.';
                    }
                }
            }
            group("Bank Reports")
            {
                Caption = 'Bank Reports';
                Image = Bank;
                action("Detail Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Detail Trial Balance';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    RunObject = Report "Bank Acc. - Detail Trial Bal.";
                    ToolTip = 'View a detailed trial balance for selected checks.';
                }
                action("Bank Acc. Trans. Detail")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Acc. Trans. Detail';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    RunObject = Report "Bank Acc. Trans Detail";
                    ToolTip = 'View a detailed cumulative balance for the selected Bank.';
                }
                action("Check Details")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Check Details';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Bank Account - Check Details";
                    ToolTip = 'View a detailed trial balance for selected checks.';
                }
                action("Trial Balance by Period")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance by Period';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    RunObject = Report "Trial Balance by Period";
                    ToolTip = 'View a detailed trial balance for selected checks within a selected period.';
                }
                action(List)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    RunObject = Report "Bank Account - List";
                    ToolTip = 'View a list of general information about bank accounts, such as posting group, currency code, minimum balance, and balance.';
                }
                action("Receivables-Payables")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Receivables-Payables';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Receivables-Payables";
                    ToolTip = 'View a summary of the receivables and payables for the account, including customer and vendor balance due amounts.';
                }
                action("Trial Balance")
                {
                    ApplicationArea = Suite;
                    Caption = 'Trial Balance';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Trial Balance";
                    ToolTip = 'View a detailed trial balance for the selected bank account.';
                }
                action("Bank Account Statements")
                {
                    ApplicationArea = Suite;
                    Caption = 'Bank Account Statements';
                    Image = "Report";
                    RunObject = Report "Bank Account Statement";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
            }
            group("Production Reports")
            {
                Caption = 'Production Reports';
                Image = Production;
                action("Prod. Order - Detail Calc.")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Prod. Order - Detail Calc.';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Prod. Order - Detailed Calc.";
                    ToolTip = 'View a list of the production orders. This list contains the expected costs and the quantity per production order or per operation of a production order.';
                }
                action("Prod. Order - Precalc. Time")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Prod. Order - Precalc. Time';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Prod. Order - Precalc. Time";
                    ToolTip = 'View a list of information about capacity requirement, starting and ending time, etc. per operation, per production order, or per production order line.';
                }
                action("Production Order - Comp. and Routing")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Production Order - Comp. and Routing';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Prod. Order Comp. and Routing";
                    ToolTip = 'View information about components and operations in production orders. For released production orders, the report shows the remaining quantity if parts of the quantity have been posted as output.';
                }
                action("Production Order - Picking List")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Production Order - Picking List';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Prod. Order - Picking List";
                    ToolTip = 'View a detailed list of items that must be picked for a particular production order, from which location (and bin, if the location uses bins) they must be picked, and when the items are due for production.';
                }
                action("Production Order List")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Production Order List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Prod. Order - List";
                    ToolTip = 'View a list of the production orders contained in the system. Information such as order number, number of the item to be produced, starting/ending date and other data are shown or printed.';
                }
                action("Production Order Statistics")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Production Order Statistics';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Production Order Statistics";
                    ToolTip = 'View statistical information about the production order''s direct material and capacity costs and overhead as well as its capacity need in the time unit of measure.';
                }
            }
            group("Business Analysis Reports")
            {
                Image = AnalysisView;

                group("General Analysis")
                {
                    Image = Report;

                    action("Analysis-1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Sales Analysis-Per Date';
                        Image = Report;
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedOnly = true;
                        RunObject = Report "Sales Analysis-Per Date";
                        ToolTip = 'View a detailed analysis of the customer sales per date.';
                    }
                    action("Analysis-2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Sales Analysis-Per Month';
                        Image = Report;
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedOnly = true;
                        RunObject = Report "Sales Analysis-PerMonth";
                        ToolTip = 'View a detailed analysis of the customer sales per month.';
                    }
                }
                group("Customer Sales")
                {
                    Image = Sales;
                    Caption = 'Customer Sales';
                    action("Analysis-3")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Sales Per Item';
                        Image = Report;
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedOnly = true;
                        RunObject = Report "Customer Sales Per Item";
                        ToolTip = 'View a general overview of the customer sales over the selected time period.';
                    }
                    action("Analysis-4")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Sales/Item - Overview';
                        Image = Report;
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedOnly = true;
                        RunObject = Report "Customer Sales/Item - Overview";
                        ToolTip = 'View a general overview of the customer sales over the selected time period with Sales Credit Memos.';
                    }
                    action("Analysis-5")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Item Sales Per Route';
                        Image = Report;
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedOnly = true;
                        RunObject = Report "Customer Item Sales Per Route";
                        ToolTip = 'View a overview of the customer sales per route over the selected time period.';
                    }
                    action("Analysis-6")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Item Sales Summary';
                        Image = Report;
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedOnly = true;
                        RunObject = Report "Inventory - Customer Sales";
                        ToolTip = 'View Item Sales Summary per item as purchased by the various customers.';
                    }
                    action("Analysis-7")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Customer - Sales List';
                        Image = Report;
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedOnly = true;
                        RunObject = Report "Customer - Sales List";
                        ToolTip = 'View a general lis of the customer sales the selected time period.';
                    }
                }
            }
        }
    }
}
