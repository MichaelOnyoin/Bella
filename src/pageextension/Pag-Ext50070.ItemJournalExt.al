pageextension 50070 "Item Journal Ext" extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit Cost")
        {
            field("Qty Requested"; Rec."Qty Requested")
            {
                ApplicationArea = All;
            }

            field("Equipment/Vehicle No"; Rec."Equipment/Vehicle No")
            {
                ApplicationArea = All;
            }
            field("Equipment/Vehicle Name"; Rec."Equipment/Vehicle Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Requested By"; Rec."Requested By")
            {
                ApplicationArea = All;
            }
            field("Authorized By"; Rec."Authorized By")
            {
                ApplicationArea = All;
            }
            field("Issued By"; Rec."Issued By")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                "Check if Gen. Bus. Posting Group is not Empty"();
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                "Check if Gen. Bus. Posting Group is not Empty"();
            end;
        }
        // Add changes to page actions here
        addafter("&Print")
        {
            action("Fuel Issue Form")
            {
                ApplicationArea = All;
                Caption = 'Print Fuel Issue Form';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;
                trigger OnAction()
                // FuelIssueForm: Report "Fuel Issue Form";
                begin
                    /* ItemJurnalLine.Reset();
                    ItemJurnalLine.SetRange(ItemJurnalLine."Journal Template Name", Rec."Journal Template Name");
                    ItemJurnalLine.SetRange(ItemJurnalLine."Journal Batch Name", Rec."Journal Batch Name");
                    ItemJurnalLine.SetRange(ItemJurnalLine."Document No.", Rec."Document No.");
                    FuelIssueForm.SetTableView(ItemJurnalLine);
                    FuelIssueForm.Run(); */
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        "Set Entry Type to Negative Adjustment"();
    end;

    local procedure "Check if Gen. Bus. Posting Group is not Empty"()
    begin
        if (Rec."Entry Type" = Rec."Entry Type"::"Positive Adjmt.") or (Rec."Entry Type" = Rec."Entry Type"::"Negative Adjmt.") then begin
            if Rec."Gen. Bus. Posting Group" = '' then
                Rec.TestField("Gen. Bus. Posting Group");
        end;
    end;

    local procedure "Set Entry Type to Negative Adjustment"()
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        if ItemJournalLine.FindSet() then begin
            repeat begin
                ItemJournalLine."Entry Type" := ItemJournalLine."Type Entry"::"Negative Adjmt.";
                ItemJournalLine.Modify();
            end until ItemJournalLine.Next() = 0;
        end;
    end;
}