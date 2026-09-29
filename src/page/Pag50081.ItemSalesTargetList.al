page 50081 "Item Sales Target List"
{
    PageType = List;
    Caption = 'Item Sales Targets';
    SourceTable = "Item Sales Target Entry";
    SourceTableTemporary = true;
    InsertAllowed = true;
    DeleteAllowed = true;
    AutoSplitKey = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the finished good item.';

                    trigger OnValidate()
                    begin
                        Rec.Validate("Item No.");
                        CurrPage.Update(true);
                    end;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Auto-filled when Item No. is selected.';
                }
                field("Sales Target Qty"; Rec."Sales Target Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the target quantity for this item.';
                }
            }
        }
    }

    actions
{
    area(Processing)
    {
        action(ClearAll)
        {
            ApplicationArea = All;
            Caption = 'Clear All';
            Image = ClearLog;
            ToolTip = 'Remove all entries from the target list.';

            trigger OnAction()
            begin
                Rec.Reset();
                Rec.DeleteAll();
                CurrPage.Update(false);
            end;
        }
        
        action(ConfirmAndRun)
{
    ApplicationArea = All;
    Caption = 'Confirm & Run Report';
    Image = Confirm;
    ToolTip = 'Save targets and proceed to the report request page.';

    trigger OnAction()
    var
        ItemSalesTargetMgt: Codeunit "Item Sales Target Mgt.";
        TempEntry: Record "Item Sales Target Entry" temporary;
    begin
        Rec.Reset();
        if Rec.FindSet() then
            repeat
                TempEntry := Rec;
                if TempEntry.Insert() then;
            until Rec.Next() = 0;
        ItemSalesTargetMgt.SetTargets(TempEntry);
        CurrPage.Close(); // close the page — codeunit 50082 then continues
    end;
}
    }
}

    // Load from codeunit into page temp table on open
    trigger OnOpenPage()
    var
        ItemSalesTargetMgt: Codeunit "Item Sales Target Mgt.";
        TempEntry: Record "Item Sales Target Entry" temporary;
    begin
        ItemSalesTargetMgt.GetTargets(TempEntry);
        if TempEntry.FindSet() then
            repeat
                Rec := TempEntry;
                if Rec.Insert() then;
            until TempEntry.Next() = 0;
    end;

    // Save back to codeunit when page closes
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ItemSalesTargetMgt: Codeunit "Item Sales Target Mgt.";
        TempEntry: Record "Item Sales Target Entry" temporary;
    begin
        Rec.Reset();
        if Rec.FindSet() then
            repeat
                TempEntry := Rec;
                if TempEntry.Insert() then;
            until Rec.Next() = 0;
        ItemSalesTargetMgt.SetTargets(TempEntry);
        exit(true);
    end;
}