report 50083 "Inventory Sales Statistics Ext"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Rep50083.InvSalesStatisticsExt.rdlc';
    // RDLCLayout = './InventorySalesStatistics.rdlc'
    ApplicationArea = Suite;
    Caption = 'Inventory Sales Statistics by Gen. Bus. Posting Group';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("Inventory Posting Group");
            RequestFilterFields = "No.", "Search Description", "Assembly BOM", "Inventory Posting Group", "Statistics Group", "Base Unit of Measure", "Date Filter";
            column(PeriodTextCaption; StrSubstNo(Text000, PeriodText))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(PrintAlsoWithoutSale; PrintAlsoWithoutSale)
            {
            }
            column(ItemFilterCaption; StrSubstNo('%1: %2', TableCaption, ItemFilter))
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(InventoryPostingGrp_Item; "Inventory Posting Group")
            {
            }
            column(No_Item; "No.")
            {
                IncludeCaption = true;
            }
            column(Description_Item; Description)
            {
                IncludeCaption = true;
            }
            column(AssemblyBOM_Item; Format("Assembly BOM"))
            {
            }
            column(BaseUnitofMeasure_Item; "Base Unit of Measure")
            {
                IncludeCaption = true;
            }
            column(UnitCost; UnitCost)
            {
            }
            column(UnitPrice; UnitPrice)
            {
            }
            column(SalesQty; SalesQty)
            {
            }
            column(SalesAmount; SalesAmount)
            {
            }
            column(ItemProfit; ItemProfit)
            {
                AutoFormatType = 1;
            }
            column(ItemProfitPct; ItemProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(GenBusPostingGroup; GenBusPostingGroupFilter)
            {
            }

            trigger OnAfterGetRecord()
            var
                ValueEntry: Record "Value Entry";
            begin
                CalcFields("Assembly BOM");

                // Filter by Gen. Bus. Posting Group if specified
                if GenBusPostingGroupFilter <> '' then begin
                    ValueEntry.Reset();
                    ValueEntry.SetRange("Item No.", "No.");
                    ValueEntry.SetRange("Gen. Bus. Posting Group", GenBusPostingGroupFilter);
                    ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
                    if ValueEntry.IsEmpty() then
                        CurrReport.Skip();
                end;

                SetFilters();
                Calculate();

                if (SalesAmount = 0) and not PrintAlsoWithoutSale then
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                Clear(SalesQty);
                Clear(SalesAmount);
                Clear(COGSAmount);
                Clear(ItemProfit);
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
                    field(PrintAlsoWithoutSale; PrintAlsoWithoutSale)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Include Items Not Sold';
                        MultiLine = true;
                        ToolTip = 'Specifies if items that have not yet been sold are also included in the report.';
                    }
                    field(GenBusPostingGroupFilter; GenBusPostingGroupFilter)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Gen. Bus. Posting Group';
                        TableRelation = "Gen. Business Posting Group";
                        ToolTip = 'Specifies the Gen. Bus. Posting Group to filter item sales by e.g. DOMESTIC or EXPORT.';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        GLSetup.Get();

        ItemFilter := Item.GetFilters;
        PeriodText := Item.GetFilter("Date Filter");

        with ItemStatisticsBuf do begin
            if Item.GetFilter("Date Filter") <> '' then
                SetFilter("Date Filter", PeriodText);
            if Item.GetFilter("Location Filter") <> '' then
                SetFilter("Location Filter", Item.GetFilter("Location Filter"));
            if Item.GetFilter("Variant Filter") <> '' then
                SetFilter("Variant Filter", Item.GetFilter("Variant Filter"));
            if Item.GetFilter("Global Dimension 1 Filter") <> '' then
                SetFilter("Global Dimension 1 Filter", Item.GetFilter("Global Dimension 1 Filter"));
            if Item.GetFilter("Global Dimension 2 Filter") <> '' then
                SetFilter("Global Dimension 2 Filter", Item.GetFilter("Global Dimension 2 Filter"));
        end;
    end;

    var
        Text000: Label 'Period: %1';
        ItemStatisticsBuf: Record "Item Statistics Buffer";
        GLSetup: Record "General Ledger Setup";
        ItemFilter: Text;
        PeriodText: Text;
        SalesQty: Decimal;
        SalesAmount: Decimal;
        COGSAmount: Decimal;
        ItemProfit: Decimal;
        ItemProfitPct: Decimal;
        UnitPrice: Decimal;
        UnitCost: Decimal;
        PrintAlsoWithoutSale: Boolean;
        GenBusPostingGroupFilter: Code[20];
        InvSalesStatisticsCaptLbl: Label 'Inventory - Sales Statistics';
        PageCaptionLbl: Label 'Page';
        IncludeNotSoldItemsCaptionLbl: Label 'This report also includes items that are not sold.';
        ItemAssemblyBOMCaptionLbl: Label 'BOM';
        UnitCostCaptionLbl: Label 'Unit Cost';
        UnitPriceCaptionLbl: Label 'Unit Price';
        SalesQtyCaptionLbl: Label 'Sales (Qty.)';
        SalesAmountCaptionLbl: Label 'Sales (LCY)';
        ItemProfitCaptionLbl: Label 'Profit';
        ItemProfitPctCaptionLbl: Label 'Profit %';
        TotalCaptionLbl: Label 'Total';

    local procedure Calculate()
    begin
        SalesQty := -CalcInvoicedQty();
        SalesAmount := CalcSalesAmount();
        COGSAmount := CalcCostAmount() + CalcCostAmountNonInvnt();
        ItemProfit := SalesAmount + COGSAmount;

        if SalesAmount <> 0 then
            ItemProfitPct := Round(100 * ItemProfit / SalesAmount, 0.1)
        else
            ItemProfitPct := 0;

        UnitPrice := CalcPerUnit(SalesAmount, SalesQty);
        UnitCost := -CalcPerUnit(COGSAmount, SalesQty);
    end;


    local procedure SetFilters()
    begin
        with ItemStatisticsBuf do begin
            SetRange("Item Filter", Item."No.");
            SetRange("Item Ledger Entry Type Filter", "Item Ledger Entry Type Filter"::Sale);
            SetFilter("Entry Type Filter", '<>%1', "Entry Type Filter"::Revaluation);
        end;
    end;

    local procedure CalcSalesAmount(): Decimal
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.Reset();
        ValueEntry.SetRange("Item No.", Item."No.");
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
        ValueEntry.SetFilter("Entry Type", '<>%1', ValueEntry."Entry Type"::Revaluation);
        if GenBusPostingGroupFilter <> '' then
            ValueEntry.SetRange("Gen. Bus. Posting Group", GenBusPostingGroupFilter);
        if Item.GetFilter("Date Filter") <> '' then
            ValueEntry.SetFilter("Posting Date", Item.GetFilter("Date Filter"));
        ValueEntry.CalcSums("Sales Amount (Actual)");
        exit(ValueEntry."Sales Amount (Actual)");
    end;

    local procedure CalcCostAmount(): Decimal
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.Reset();
        ValueEntry.SetRange("Item No.", Item."No.");
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
        ValueEntry.SetFilter("Entry Type", '<>%1', ValueEntry."Entry Type"::Revaluation);
        if GenBusPostingGroupFilter <> '' then
            ValueEntry.SetRange("Gen. Bus. Posting Group", GenBusPostingGroupFilter);
        if Item.GetFilter("Date Filter") <> '' then
            ValueEntry.SetFilter("Posting Date", Item.GetFilter("Date Filter"));
        ValueEntry.CalcSums("Cost Amount (Actual)");
        exit(ValueEntry."Cost Amount (Actual)");
    end;

    local procedure CalcCostAmountNonInvnt(): Decimal
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.Reset();
        ValueEntry.SetRange("Item No.", Item."No.");
        if GenBusPostingGroupFilter <> '' then
            ValueEntry.SetRange("Gen. Bus. Posting Group", GenBusPostingGroupFilter);
        if Item.GetFilter("Date Filter") <> '' then
            ValueEntry.SetFilter("Posting Date", Item.GetFilter("Date Filter"));
        ValueEntry.CalcSums("Cost Amount (Non-Invtbl.)");
        exit(ValueEntry."Cost Amount (Non-Invtbl.)");
    end;

    local procedure CalcInvoicedQty(): Decimal
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.Reset();
        ValueEntry.SetRange("Item No.", Item."No.");
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
        if GenBusPostingGroupFilter <> '' then
            ValueEntry.SetRange("Gen. Bus. Posting Group", GenBusPostingGroupFilter);
        if Item.GetFilter("Date Filter") <> '' then
            ValueEntry.SetFilter("Posting Date", Item.GetFilter("Date Filter"));
        ValueEntry.CalcSums("Invoiced Quantity");
        exit(ValueEntry."Invoiced Quantity");
    end;

    local procedure CalcPerUnit(Amount: Decimal; Qty: Decimal): Decimal
    begin
        if Qty <> 0 then
            exit(Round(Amount / Abs(Qty), GLSetup."Unit-Amount Rounding Precision"));
        exit(0);
    end;
}