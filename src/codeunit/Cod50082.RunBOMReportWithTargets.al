codeunit 50082 "Run BOM Report With Targets"
{
    trigger OnRun()
    var
        ItemSalesTargetMgt: Codeunit "Item Sales Target Mgt.";
        BOMReport: Report "Firming";
    begin
        // Clear any leftover targets from previous run
        ItemSalesTargetMgt.ClearTargets();

        // Open target list — user enters items + qtys and clicks Confirm & Run
        // The page's ConfirmAndRun action calls SetTargets before closing
        Page.RunModal(Page::"Item Sales Target List");

        // Check something was actually entered
        if not ItemSalesTargetMgt.HasTargets() then begin
            // User closed without confirming — ask if they want all items
            if not Confirm('No targets entered. Run for ALL finished goods at qty 1?') then
                exit;
        end;

        // Run the report — OnPreReport will call GetTargets internally
        BOMReport.RunModal();
    end;
}