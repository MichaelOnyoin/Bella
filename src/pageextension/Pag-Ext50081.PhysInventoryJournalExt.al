pageextension 50081 "Phys. Inventory Journal Ext" extends "Phys. Inventory Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify("Post and &Print")
        {
            Visible = false;
        }
        addlast(Reporting)
        {
            action(PrintCust)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Phys. Inventory-List';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                Scope = Repeater;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    ItemJournalBatch: Record "Item Journal Batch";
                begin
                    ItemJournalBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
                    ItemJournalBatch.SetRange(Name, Rec."Journal Batch Name");
                    REPORT.RunModal(REPORT::"Phys. Inventory-List", true, false, ItemJournalBatch);
                end;
            }
        }
    }
}