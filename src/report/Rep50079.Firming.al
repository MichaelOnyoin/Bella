report 50079 "Firming"
{
    UsageCategory = None;
    DefaultLayout = RDLC;
    RDLCLayout = 'Firming.rdlc';
    Caption = 'Firming';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = WHERE("Inventory Posting Group" = FILTER('FINISHED'));

            column(Item_No; "No.") { }
            column(Item_Description; Description) { }
            column(Item_BaseUOM; "Base Unit of Measure") { }
            column(Company_Name; CompanyInfo.Name) { }
            column(Company_Address; CompanyInfo.Address) { }
            column(Company_Picture; CompanyInfo.Picture) { }
            column(Company_Email; CompanyInfo."E-Mail") { }
            column(Company_PhoneNo; CompanyInfo."Phone No.") { }
            column(PrintDate; Today) { }
            column(ItemSalesTarget; CurrentTargetQty) { }
            column(NewPagePerItem; OneItemPerPage) { }

            dataitem(RawMatLoop; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 999999));

                column(Raw_Level; TempBOMBuffer.Level) { }
                column(Raw_ComponentNo; TempBOMBuffer."Component No.") { }
                column(Raw_Description; TempBOMBuffer.Description) { }
                column(Raw_UOM; TempBOMBuffer."Unit of Measure Code") { }
                column(Raw_QtyPer; TempBOMBuffer."Quantity per") { }
                column(Raw_TotalQty; TempBOMBuffer."Total Quantity") { }

                trigger OnPreDataItem()
                begin
                    TempBOMBuffer.Reset();
                    TempBOMBuffer.SetRange("Item No.", Item."No.");
                    TempBOMBuffer.SetRange("Component IPG", 'RAW MATERIALS');
                    if not TempBOMBuffer.FindFirst() then
                        CurrReport.Break();
                end;

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then begin
                        TempBOMBuffer.Reset();
                        TempBOMBuffer.SetRange("Item No.", Item."No.");
                        TempBOMBuffer.SetRange("Component IPG", 'RAW MATERIALS');
                        if not TempBOMBuffer.FindFirst() then
                            CurrReport.Break();
                    end else
                        if TempBOMBuffer.Next() = 0 then
                            CurrReport.Break();
                end;
            }

            dataitem(PackagingLoop; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 999999));

                column(Pkg_Level; TempBOMBuffer.Level) { }
                column(Pkg_ComponentNo; TempBOMBuffer."Component No.") { }
                column(Pkg_Description; TempBOMBuffer.Description) { }
                column(Pkg_UOM; TempBOMBuffer."Unit of Measure Code") { }
                column(Pkg_QtyPer; TempBOMBuffer."Quantity per") { }
                column(Pkg_TotalQty; TempBOMBuffer."Total Quantity") { }

                trigger OnPreDataItem()
                begin
                    TempBOMBuffer.Reset();
                    TempBOMBuffer.SetRange("Item No.", Item."No.");
                    TempBOMBuffer.SetRange("Component IPG", 'PACKAGING MATERIALS');
                    if not TempBOMBuffer.FindFirst() then
                        CurrReport.Break();
                end;

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then begin
                        TempBOMBuffer.Reset();
                        TempBOMBuffer.SetRange("Item No.", Item."No.");
                        TempBOMBuffer.SetRange("Component IPG", 'PACKAGING MATERIALS');
                        if not TempBOMBuffer.FindFirst() then
                            CurrReport.Break();
                    end else
                        if TempBOMBuffer.Next() = 0 then
                            CurrReport.Break();
                end;
            }

            trigger OnPreDataItem()
            begin
                BuildItemFilter();
            end;

            trigger OnAfterGetRecord()
            var
                VisitedBOMs: List of [Code[20]];
            begin
                if "Production BOM No." = '' then
                    CurrReport.Skip();

                CurrentTargetQty := 1;

                if HasUserTargets then begin
                    if TempTargets.Get("No.") then
                        CurrentTargetQty := TempTargets."Sales Target Qty"
                    else
                        CurrReport.Skip();
                end;

                TempBOMBuffer.Reset();
                TempBOMBuffer.DeleteAll();
                EntryNo := 0;
                Clear(VisitedBOMs);

                // Step 1: Explode this item's BOM into TempBOMBuffer
                ExplodeBOM("No.", "Production BOM No.", 1, CurrentTargetQty, VisitedBOMs);
                CollapseBuffer("No.");
                // Step 2: Accumulate top-level components into summary dictionaries
                CountComponentsForItem("No.");
            end;
        }

        // ── SUMMARY SECTION ──────────────────────────────────────────────────────
        // Runs once after ALL items are processed.
        // Shows only components that appear in more than one finished good's BOM.
        // ─────────────────────────────────────────────────────────────────────────
        dataitem(SummaryLoop; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 .. 999999));

            // Component identification
            column(Sum_ComponentNo; TempSummaryBuffer."Component No.") { }
            column(Sum_UOM; TempSummaryBuffer."Unit of Measure Code") { }
            column(Sum_IPG; TempSummaryBuffer."Component IPG") { }
            column(Sum_TotalQty; TempSummaryBuffer."Total Quantity") { }

            // Level field repurposed: stores the count of FG items that use this component
            column(Sum_BOMCount; TempSummaryBuffer.Level) { }

            // Description field repurposed: stores the component's real description
            column(Sum_Description; TempSummaryBuffer.Description) { }

            // "Quantity per" (Decimal) is NOT used for its original purpose here;
            // the FG items list is stored as text in a dedicated global variable
            // and surfaced via the Sum_FGItems column below.
            column(Sum_FGItems; SummaryCurrentFGItems) { }

            trigger OnPreDataItem()
            var
                CompNo: Code[20];
                BOMCount: Integer;
                Qty: Decimal;
                Desc: Text[100];
                UOM: Code[10];
                IPG: Code[20];
                FGList: Text;
            begin
                TempSummaryBuffer.Reset();
                TempSummaryBuffer.DeleteAll();
                SummaryEntryNo := 0;

                foreach CompNo in SummaryCountDict.Keys() do begin
                    SummaryCountDict.Get(CompNo, BOMCount);
                    if BOMCount >= 1 then begin
                        SummaryQtyDict.Get(CompNo, Qty);
                        SummaryDescDict.Get(CompNo, Desc);
                        SummaryUOMDict.Get(CompNo, UOM);
                        SummaryIPGDict.Get(CompNo, IPG);
                        SummaryFGItemsDict.Get(CompNo, FGList);

                        SummaryEntryNo += 1;
                        TempSummaryBuffer.Init();
                        TempSummaryBuffer."Entry No." := SummaryEntryNo;
                        TempSummaryBuffer."Component No." := CompNo;
                        TempSummaryBuffer.Description := CopyStr(Desc, 1, MaxStrLen(TempSummaryBuffer.Description));
                        TempSummaryBuffer."Unit of Measure Code" := UOM;
                        TempSummaryBuffer."Component IPG" := IPG;
                        TempSummaryBuffer."Total Quantity" := Qty;
                        TempSummaryBuffer.Level := BOMCount;
                        TempSummaryBuffer.Insert();
                    end;
                end;

                // ↓ ADD THIS LINE HERE
                // Message('Dict keys: %1, Shared components (count>1): %2', SummaryCountDict.Count(), SummaryEntryNo);

                if not TempSummaryBuffer.FindFirst() then
                    CurrReport.Break();

                UpdateSummaryCurrentFGItems();
            end;

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then begin
                    TempSummaryBuffer.Reset();
                    if not TempSummaryBuffer.FindFirst() then
                        CurrReport.Break();
                end else
                    if TempSummaryBuffer.Next() = 0 then
                        CurrReport.Break();

                // Refresh the FG items text for the current summary row
                UpdateSummaryCurrentFGItems();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(OneItemPerPageFld; OneItemPerPage)
                    {
                        ApplicationArea = All;
                        Caption = 'One Item Per Page';
                        ToolTip = 'Print each finished good item on its own page.';
                    }
                }
                group(Targets)
                {
                    Caption = 'Item Sales Targets';
                    field(TargetSummary; TargetSummaryText)
                    {
                        ApplicationArea = All;
                        Caption = 'Items Entered';
                        Editable = false;
                    }
                }
            }
        }

        trigger OnInit()
        begin
            UpdateTargetSummary();
        end;
    }

    var
        CompanyInfo: Record "Company Information";
        TempBOMBuffer: Record "BOM Explosion Line Buffer" temporary;
        TempSummaryBuffer: Record "BOM Explosion Line Buffer" temporary;
        TempTargets: Record "Item Sales Target Entry" temporary;
        EntryNo: Integer;
        SummaryEntryNo: Integer;
        CurrentTargetQty: Decimal;
        OneItemPerPage: Boolean;
        TargetSummaryText: Text;
        HasUserTargets: Boolean;

        // ── Summary dictionaries — all keyed by Component No. (Code[20]) ──────────
        SummaryCountDict: Dictionary of [Code[20], Integer];       // # of FG items that use this component
        SummaryQtyDict: Dictionary of [Code[20], Decimal];         // total qty across all FG items
        SummaryDescDict: Dictionary of [Code[20], Text[100]];      // component description
        SummaryUOMDict: Dictionary of [Code[20], Code[10]];        // unit of measure
        SummaryIPGDict: Dictionary of [Code[20], Code[20]];        // inventory posting group
        SummaryFGItemsDict: Dictionary of [Code[20], Text];        // ← unbounded Text, no truncation

        // Holds the FG items list for the row currently being rendered in SummaryLoop
        SummaryCurrentFGItems: Text;

    // ── Called by the codeunit that launches this report ─────────────────────────
    procedure SetTargets(var TempEntry: Record "Item Sales Target Entry" temporary)
    begin
        TempTargets.Reset();
        TempTargets.DeleteAll();
        HasUserTargets := false;

        if TempEntry.FindSet() then begin
            repeat
                TempTargets := TempEntry;
                TempTargets.Insert();
            until TempEntry.Next() = 0;
            HasUserTargets := true;
        end;

        UpdateTargetSummary();
    end;

    local procedure UpdateTargetSummary()
    begin
        TempTargets.Reset();
        if TempTargets.IsEmpty() then
            TargetSummaryText := ' '
        else
            TargetSummaryText := Format(TempTargets.Count()) + ' item(s) entered with target quantities.';
    end;

    local procedure CountSharedComponents(): Integer
    var
        CompNo: Code[20];
        BOMCount: Integer;
        Cnt: Integer;
    begin
        foreach CompNo in SummaryCountDict.Keys() do begin
            SummaryCountDict.Get(CompNo, BOMCount);
            if BOMCount > 1 then
                Cnt += 1;
        end;
        exit(Cnt);
    end;

    local procedure BuildItemFilter()
    var
        FilterText: Text;
    begin
        if not HasUserTargets then
            exit;

        TempTargets.Reset();
        if TempTargets.FindSet() then
            repeat
                if FilterText = '' then
                    FilterText := TempTargets."Item No."
                else
                    FilterText += '|' + TempTargets."Item No.";
            until TempTargets.Next() = 0;

        if FilterText <> '' then
            Item.SetFilter("No.", FilterText);
    end;

    // ── Sets SummaryCurrentFGItems for the current TempSummaryBuffer row ─────────
    local procedure UpdateSummaryCurrentFGItems()
    var
        FGList: Text;
    begin
        SummaryCurrentFGItems := '';
        if SummaryFGItemsDict.ContainsKey(TempSummaryBuffer."Component No.") then begin
            SummaryFGItemsDict.Get(TempSummaryBuffer."Component No.", FGList);
            SummaryCurrentFGItems := FGList;
        end;
    end;

    // ── Called once per FG item after ExplodeBOM ─────────────────────────────────
    // Reads the top-level rows in TempBOMBuffer for this item and updates all
    // five summary dictionaries.  Only Level = 1 rows are counted so that
    // sub-assembly components are not double-counted.
    // local procedure CountComponentsForItem(FGItemNo: Code[20])
    // var
    //     CompNo: Code[20];
    //     ExistingCount: Integer;
    //     ExistingQty: Decimal;
    //     ExistingFGList: Text;
    //     SeenInThisItem: List of [Code[20]];
    //     ComponentItem: Record Item;
    // begin
    //     TempBOMBuffer.Reset();
    //     TempBOMBuffer.SetRange("Item No.", FGItemNo);
    //     TempBOMBuffer.SetRange(Level, 1);          // top-level BOM lines only
    //     if not TempBOMBuffer.FindSet() then
    //         exit;

    //     repeat
    //         CompNo := TempBOMBuffer."Component No.";

    //         // ── Accumulate total quantity (every Level-1 row for this component) ──
    //         if SummaryQtyDict.ContainsKey(CompNo) then begin
    //             SummaryQtyDict.Get(CompNo, ExistingQty);
    //             SummaryQtyDict.Set(CompNo, ExistingQty + TempBOMBuffer."Total Quantity");
    //         end else
    //             SummaryQtyDict.Add(CompNo, TempBOMBuffer."Total Quantity");

    //         // ── Per-component, per-FG-item bookkeeping (only once per FG item) ───
    //         if not SeenInThisItem.Contains(CompNo) then begin
    //             SeenInThisItem.Add(CompNo);

    //             // Increment the count of distinct FG items that use this component
    //             if SummaryCountDict.ContainsKey(CompNo) then begin
    //                 SummaryCountDict.Get(CompNo, ExistingCount);
    //                 SummaryCountDict.Set(CompNo, ExistingCount + 1);
    //             end else
    //                 SummaryCountDict.Add(CompNo, 1);

    //             // Store description / UOM / IPG on first encounter
    //             if not SummaryDescDict.ContainsKey(CompNo) then begin
    //                 if ComponentItem.Get(CompNo) then
    //                     SummaryDescDict.Add(CompNo, ComponentItem.Description)
    //                 else
    //                     SummaryDescDict.Add(CompNo, TempBOMBuffer.Description);
    //                 SummaryUOMDict.Add(CompNo, TempBOMBuffer."Unit of Measure Code");
    //                 SummaryIPGDict.Add(CompNo, TempBOMBuffer."Component IPG");
    //             end;

    //             // Append this FG item to the shared-component list (unbounded Text)
    //             if SummaryFGItemsDict.ContainsKey(CompNo) then begin
    //                 SummaryFGItemsDict.Get(CompNo, ExistingFGList);
    //                 SummaryFGItemsDict.Set(CompNo, ExistingFGList + ', ' + FGItemNo);
    //             end else
    //                 SummaryFGItemsDict.Add(CompNo, FGItemNo);
    //         end;

    //     until TempBOMBuffer.Next() = 0;
    // end;


    local procedure CountComponentsForItem(FGItemNo: Code[20])
    var
        CompNo: Code[20];
        ExistingCount: Integer;
        ExistingQty: Decimal;
        ExistingFGList: Text;
        SeenInThisItem: List of [Code[20]];
        ComponentItem: Record Item;
    begin
        TempBOMBuffer.Reset();
        TempBOMBuffer.SetRange("Item No.", FGItemNo);
        // ↓ Removed SetRange(Level, 1) — level is now irrelevant since ExplodeBOM
        // only writes RAW MATERIALS and PACKAGING MATERIALS to TempBOMBuffer anyway
        if not TempBOMBuffer.FindSet() then
            exit;

        repeat
            CompNo := TempBOMBuffer."Component No.";

            if SummaryQtyDict.ContainsKey(CompNo) then begin
                SummaryQtyDict.Get(CompNo, ExistingQty);
                SummaryQtyDict.Set(CompNo, ExistingQty + TempBOMBuffer."Total Quantity");
            end else
                SummaryQtyDict.Add(CompNo, TempBOMBuffer."Total Quantity");

            if not SeenInThisItem.Contains(CompNo) then begin
                SeenInThisItem.Add(CompNo);

                if SummaryCountDict.ContainsKey(CompNo) then begin
                    SummaryCountDict.Get(CompNo, ExistingCount);
                    SummaryCountDict.Set(CompNo, ExistingCount + 1);
                end else
                    SummaryCountDict.Add(CompNo, 1);

                if not SummaryDescDict.ContainsKey(CompNo) then begin
                    if ComponentItem.Get(CompNo) then
                        SummaryDescDict.Add(CompNo, ComponentItem.Description)
                    else
                        SummaryDescDict.Add(CompNo, TempBOMBuffer.Description);
                    SummaryUOMDict.Add(CompNo, TempBOMBuffer."Unit of Measure Code");
                    SummaryIPGDict.Add(CompNo, TempBOMBuffer."Component IPG");
                end;

                if SummaryFGItemsDict.ContainsKey(CompNo) then begin
                    SummaryFGItemsDict.Get(CompNo, ExistingFGList);
                    SummaryFGItemsDict.Set(CompNo, ExistingFGList + ', ' + FGItemNo);
                end else
                    SummaryFGItemsDict.Add(CompNo, FGItemNo);
            end;
        until TempBOMBuffer.Next() = 0;
    end;

    // ── Recursively explodes a Production BOM into TempBOMBuffer ─────────────────
    // Unchanged from the working version — only writes to TempBOMBuffer.

    local procedure ExplodeBOM(FGItemNo: Code[20]; BOMNo: Code[20]; Level: Integer; ParentQty: Decimal; var VisitedBOMs: List of [Code[20]])
    var
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        ComponentItem: Record Item;
        ScaledQty: Decimal;
    begin
        if VisitedBOMs.Contains(BOMNo) then
            exit;
        if not ProdBOMHeader.Get(BOMNo) then
            exit;
        if ProdBOMHeader.Status <> ProdBOMHeader.Status::Certified then
            exit;

        VisitedBOMs.Add(BOMNo);

        ProdBOMLine.Reset();
        ProdBOMLine.SetRange("Production BOM No.", BOMNo);
        ProdBOMLine.SetRange("Version Code", '');
        ProdBOMLine.SetRange(Type, ProdBOMLine.Type::Item);
        if not ProdBOMLine.FindSet() then
            exit;

        repeat
            ScaledQty := ParentQty * ProdBOMLine."Quantity per";

            if ComponentItem.Get(ProdBOMLine."No.") then begin

                // ↓ ONLY write to TempBOMBuffer if it is a raw or packaging material
                // Sub-assemblies (SEMI FINISHED / FINISHED) are NOT written — they
                // are only used to recurse deeper into their own BOM.
                if ComponentItem."Inventory Posting Group" in ['RAW MATERIALS', 'PACKAGING MATERIALS'] then begin
                    EntryNo += 1;
                    TempBOMBuffer.Init();
                    TempBOMBuffer."Entry No." := EntryNo;
                    TempBOMBuffer."Item No." := FGItemNo;
                    TempBOMBuffer."Component No." := ProdBOMLine."No.";
                    TempBOMBuffer.Description := ProdBOMLine.Description;
                    TempBOMBuffer."Unit of Measure Code" := ProdBOMLine."Unit of Measure Code";
                    TempBOMBuffer."Quantity per" := ProdBOMLine."Quantity per";
                    TempBOMBuffer."Total Quantity" := ScaledQty;
                    TempBOMBuffer.Level := Level;
                    TempBOMBuffer."Component IPG" := ComponentItem."Inventory Posting Group";
                    TempBOMBuffer.Insert();
                end;

                // Always recurse into sub-assemblies regardless of whether we wrote a row
                if (ComponentItem."Production BOM No." <> '') and
                   (ComponentItem."Inventory Posting Group" <> 'FINISHED') then
                    ExplodeBOM(FGItemNo, ComponentItem."Production BOM No.", Level + 1, ScaledQty, VisitedBOMs);
            end;
        until ProdBOMLine.Next() = 0;
    end;

    local procedure CollapseBuffer(FGItemNo: Code[20])
    var
        TempCollapsed: Record "BOM Explosion Line Buffer" temporary;
        CollapseEntryNo: Integer;
        CollapseQty: Decimal;
    begin
        // First pass: sum quantities per component+IPG into TempCollapsed
        TempBOMBuffer.Reset();
        TempBOMBuffer.SetRange("Item No.", FGItemNo);
        if not TempBOMBuffer.FindSet() then
            exit;

        repeat
            TempCollapsed.Reset();
            TempCollapsed.SetRange("Item No.", FGItemNo);
            TempCollapsed.SetRange("Component No.", TempBOMBuffer."Component No.");
            if TempCollapsed.FindFirst() then begin
                TempCollapsed."Total Quantity" += TempBOMBuffer."Total Quantity";
                TempCollapsed.Modify();
            end else begin
                CollapseEntryNo += 1;
                TempCollapsed := TempBOMBuffer;
                TempCollapsed."Entry No." := CollapseEntryNo;
                TempCollapsed."Quantity per" := TempBOMBuffer."Quantity per"; // keep first-found QtyPer
                TempCollapsed."Total Quantity" := TempBOMBuffer."Total Quantity";
                TempCollapsed.Level := 1; // normalise level
                TempCollapsed.Insert();
            end;
        until TempBOMBuffer.Next() = 0;

        // Replace TempBOMBuffer rows for this FG item with collapsed rows
        TempBOMBuffer.Reset();
        TempBOMBuffer.SetRange("Item No.", FGItemNo);
        TempBOMBuffer.DeleteAll();

        TempCollapsed.Reset();
        TempCollapsed.SetRange("Item No.", FGItemNo);
        if TempCollapsed.FindSet() then
            repeat
                TempBOMBuffer := TempCollapsed;
                TempBOMBuffer.Insert();
            until TempCollapsed.Next() = 0;
    end;

    trigger OnPreReport()
    var
        ItemSalesTargetMgt: Codeunit "Item Sales Target Mgt.";
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        EntryNo := 0;
        SummaryEntryNo := 0;

        ItemSalesTargetMgt.GetTargets(TempTargets);
        HasUserTargets := not TempTargets.IsEmpty();
        UpdateTargetSummary();
        ItemSalesTargetMgt.ClearTargets();
    end;
}
