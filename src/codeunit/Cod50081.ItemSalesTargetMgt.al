codeunit 50081 "Item Sales Target Mgt."
{
    // We use SingleInstance = true so the same codeunit instance
    // is reused across all callers in the same session — variables persist
    SingleInstance = true;

    var
        TempSharedTargets: Record "Item Sales Target Entry" temporary;

    procedure SetTargets(var TempEntry: Record "Item Sales Target Entry" temporary)
    begin
        TempSharedTargets.Reset();
        TempSharedTargets.DeleteAll();
        if TempEntry.FindSet() then
            repeat
                TempSharedTargets := TempEntry;
                TempSharedTargets.Insert();
            until TempEntry.Next() = 0;
    end;

    procedure GetTargets(var TempEntry: Record "Item Sales Target Entry" temporary)
    begin
        TempEntry.Reset();
        TempEntry.DeleteAll();
        TempSharedTargets.Reset();
        if TempSharedTargets.FindSet() then
            repeat
                TempEntry := TempSharedTargets;
                TempEntry.Insert();
            until TempSharedTargets.Next() = 0;
    end;

    procedure ClearTargets()
    begin
        TempSharedTargets.Reset();
        TempSharedTargets.DeleteAll();
    end;

    procedure HasTargets(): Boolean
    begin
        TempSharedTargets.Reset();
        exit(not TempSharedTargets.IsEmpty());
    end;
}