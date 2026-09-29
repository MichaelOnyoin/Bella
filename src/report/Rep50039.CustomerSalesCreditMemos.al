report 50039 "Customer Sales Credit Memos"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Customer Sales Credit Notes.rdlc';
    ApplicationArea = Basic, Suite;
    Caption = 'Customer Sales Credit Memos';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer;
        Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group";

            column(STRSUBSTNO_Text000_PeriodText_;
            StrSubstNo(Text000, PeriodText))
            {
            }
            column(COMPANYNAME;
            COMPANYPROPERTY.DisplayName)
            {
            }
            column(PrintOnlyOnePerPage;
            PrintOnlyOnePerPage)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter;
            TableCaption + ': ' + CustFilter)
            {
            }
            column(CustFilter;
            CustFilter)
            {
            }
            column(Value_Entry__TABLECAPTION__________ItemLedgEntryFilter;
            "Value Entry".TableCaption + ': ' + ValueEntryFilter)
            {
            }
            column(ItemLedgEntryFilter;
            ValueEntryFilter)
            {
            }
            column(Customer__No__;
            "No.")
            {
            }
            column(Customer_Name;
            Name)
            {
            }
            column(Customer__Phone_No__;
            "Phone No.")
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual__;
            ValueEntryBuffer."Sales Amount (Actual)")
            {
            }
            column(ValueEntryBuffer__Discount_Amount_;
            -ValueEntryBuffer."Discount Amount")
            {
            }
            column(Profit;
            Profit)
            {
                AutoFormatType = 1;
            }
            column(ProfitPct;
            ProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(Customer_Item_SalesCaption;
            Customer_Item_SalesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;
            CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption;
            All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Item_No__Caption;
            ValueEntryBuffer__Item_No__CaptionLbl)
            {
            }
            column(Item_DescriptionCaption;
            Item_DescriptionCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Invoiced_Quantity_Caption;
            ValueEntryBuffer__Invoiced_Quantity_CaptionLbl)
            {
            }
            column(Item__Base_Unit_of_Measure_Caption;
            Item__Base_Unit_of_Measure_CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual___Control44Caption;
            ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Discount_Amount__Control45Caption;
            ValueEntryBuffer__Discount_Amount__Control45CaptionLbl)
            {
            }
            column(Profit_Control46Caption;
            Profit_Control46CaptionLbl)
            {
            }
            column(ProfitPct_Control47Caption;
            ProfitPct_Control47CaptionLbl)
            {
            }
            column(Customer__Phone_No__Caption;
            FieldCaption("Phone No."))
            {
            }
            column(TotalCaption;
            TotalCaptionLbl)
            {
            }
            dataitem("Value Entry";
            "Value Entry")
            {
                DataItemLink = "Source No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Source Type", "Source No.", "Item No.", "Variant Code", "Posting Date") WHERE("Source Type" = CONST(Customer), "Item Charge No." = CONST(''), "Expected Cost" = CONST(false), Adjustment = CONST(false), "Document Type" = const("Sales Invoice"));
                RequestFilterFields = "Item No.", "Posting Date";

                column(Document_No_;
                "Document No.")
                {
                }
                column(PostingDate_Value_Entry;
                "Posting Date")
                {
                }
                column(Item_No_;
                "Item No.")
                {
                }
                column(Sales_Amount__Actual_;
                "Sales Amount (Actual)")
                {
                }
                column(Item_Ledger_Entry_Quantity;
                ABS("Invoiced Quantity"))
                {
                }
                column(Item_Description;
                ItemDescription)
                {
                }
                column(UOM_Value_Entry;
                UOM)
                {
                }
                column(SalesPrice_Value_Entry;
                "Sales Price")
                {
                }
                column(SalesAmount_Value_Entry;
                "Sales Amount")
                {
                }
            }
            dataitem("Integer";
            "Integer")
            {
                DataItemTableView = SORTING(Number);

                column(ValueEntryBuffer__Item_No__;
                ValueEntryBuffer."Item No.")
                {
                }
                column(ValueEntryBuffer__Invoiced_Quantity_;
                -ValueEntryBuffer."Invoiced Quantity")
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ValueEntryBuffer__Sales_Amount__Actual___Control44;
                ValueEntryBuffer."Sales Amount (Actual)")
                {
                    AutoFormatType = 1;
                }
                column(ValueEntryBuffer__Discount_Amount__Control45;
                -ValueEntryBuffer."Discount Amount")
                {
                    AutoFormatType = 1;
                }
                column(Profit_Control46;
                Profit)
                {
                    AutoFormatType = 1;
                }
                column(ProfitPct_Control47;
                ProfitPct)
                {
                    DecimalPlaces = 1 : 1;
                }
                column(Item__Base_Unit_of_Measure_;
                Item."Base Unit of Measure")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then
                        ValueEntryBuffer.Find('-')
                    else
                        ValueEntryBuffer.Next;
                    Profit := ValueEntryBuffer."Sales Amount (Actual)" + ValueEntryBuffer."Cost Amount (Actual)" + ValueEntryBuffer."Cost Amount (Non-Invtbl.)";
                    if Item.Get(ValueEntryBuffer."Item No.") then;
                end;

                trigger OnPreDataItem()
                begin
                    ValueEntryBuffer.Reset();
                    SetRange(Number, 1, ValueEntryBuffer.Count);
                    Clear(Profit);
                end;
            }
        }
        dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
        {
            //PrintOnlyIfDetail = true;
            column(Credi_Memo_No_; "Document No.")
            {
            }
            column(Posting_Date_Cr; "Posting Date")
            {
            }
            column(Sell_toCRCustomerNo; "Sell-to Customer No.")
            {
            }
            column(CustomerName_Cr; "Customer Name")
            {
            }
            column(AppliestoDoc_Cr; "Applies-to Doc No.")
            {
            }
            column(ItemDesc_Cr; Description)
            {
            }
            column(UnitPrice_Cr; "Unit Price")
            {
            }
            column(Quantity_Cr; "Quantity (Base)")
            {
            }
            column(UOM_Cr; "Unit of Measure")
            {
            }
            column(CRAmount; Amount)
            {
            }
            column(AmountCRIncluding_VAT; "Amount Including VAT")
            {
            }
            trigger OnAfterGetRecord()
            begin
                //if DateFilter <> '' then
                //"Sales Cr.Memo Header".
                //"Sales Cr.Memo Header".SetFilter("Posting Date", '%1', "Sales Invoice Header"."Posting Date");
                //else
                //  "Sales Cr.Memo Header".SetFilter("Posting Date", '%1..%2', 20180325D, Today);
                If not IncluedeCrMem then
                    CurrReport.Skip();
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
                group(Options)
                {
                    Caption = 'Options';

                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Customer';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
                    }
                    field(IncluedeCrMem; IncluedeCrMem)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Cr. Memo';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }

    var

        IncluedeCrMem: Boolean;
        Text000: Label 'Period: %1';
        Item: Record Item;
        ValueEntryBuffer: Record "Value Entry" temporary;
        CustFilter: Text;
        ValueEntryFilter: Text;
        PeriodText: Text;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        Customer_Item_SalesCaptionLbl: Label 'Customer/Item Sales';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        ValueEntryBuffer__Item_No__CaptionLbl: Label 'Item No.';
        Item_DescriptionCaptionLbl: Label 'Description';
        ValueEntryBuffer__Invoiced_Quantity_CaptionLbl: Label 'Invoiced Quantity';
        Item__Base_Unit_of_Measure_CaptionLbl: Label 'Unit of Measure';
        ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl: Label 'Amount';
        ValueEntryBuffer__Discount_Amount__Control45CaptionLbl: Label 'Discount Amount';
        Profit_Control46CaptionLbl: Label 'Profit';
        ProfitPct_Control47CaptionLbl: Label 'Profit %';
        TotalCaptionLbl: Label 'Total';

    procedure InitializeRequest(NewPagePerCustomer: Boolean)
    begin
        PrintOnlyOnePerPage := NewPagePerCustomer;
    end;
}
