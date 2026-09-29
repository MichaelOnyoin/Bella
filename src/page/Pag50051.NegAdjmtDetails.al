page 50051 "Neg Adjmt Details"
{
    PageType = StandardDialog;
    Caption = 'Negative Adjustment Details';
    SourceTable = "Value Entry";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Bus. Posting Group';
                    Editable = false;
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        ValueEntry: Record "Value Entry";
                        ValueEntries: Page "Value Entries";
                    begin
                        ValueEntry.Reset();
                        ValueEntry.SetRange("Item No.", Rec."Item No.");
                        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::"Negative Adjmt.");
                        ValueEntry.SetRange("Gen. Bus. Posting Group", Rec."Gen. Bus. Posting Group");
                        ValueEntries.SetTableView(ValueEntry);
                        ValueEntries.Run();
                    end;
                }
            }
        }
    }

    procedure LoadData(ItemNo: Code[20])
    var
        ValueEntry: Record "Value Entry";
        TempValueEntry: Record "Value Entry" temporary;
        EntryNo: Integer;
    begin
        EntryNo := 1;

        ValueEntry.Reset();
        ValueEntry.SetRange("Item No.", ItemNo);
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::"Negative Adjmt.");

        if ValueEntry.FindSet() then
            repeat
                TempValueEntry.SetRange("Gen. Bus. Posting Group", ValueEntry."Gen. Bus. Posting Group");
                if TempValueEntry.FindFirst() then begin
                    TempValueEntry."Invoiced Quantity" += ValueEntry."Invoiced Quantity";
                    TempValueEntry.Modify();
                end else begin
                    TempValueEntry.Init();
                    TempValueEntry."Entry No." := EntryNo;
                    TempValueEntry."Item No." := ItemNo;
                    TempValueEntry."Gen. Bus. Posting Group" := ValueEntry."Gen. Bus. Posting Group";
                    TempValueEntry."Invoiced Quantity" := ValueEntry."Invoiced Quantity";
                    TempValueEntry.Insert();
                    EntryNo += 1;
                end;
            until ValueEntry.Next() = 0;

        // Clear filters and go to first record before copying
        TempValueEntry.Reset();
        TempValueEntry.FindFirst();

        Rec.Copy(TempValueEntry, true);
        CurrPage.Update(false);
    end;
}