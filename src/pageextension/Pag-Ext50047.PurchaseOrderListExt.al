pageextension 50047 "Purchase Order List Ext" extends "Purchase Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("Purchase Description"; Rec."Purchase Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies a brief Summary of your purchases', Comment = '%';
            }
        }
    }

    actions
    {
        modify(Print)
        {
            Visible = false;
            Enabled = false;
        }
        // Add changes to page actions here
        addfirst(Action9)
        {
            action("Print Order")
            {
                ApplicationArea = Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    PurchaseInvHeader: Record "Purchase Header";
                    PurchaseOrderPrint: Report "Purchase Order - Print";
                    GenLedgerSetup: Record "General Ledger Setup";
                begin
                    GenLedgerSetup.Get();
                    IF GenLedgerSetup."ASL.Print only Released Docs" then begin
                        Rec.TestField(Rec.Status, Rec.Status::Released);
                    end;

                    PurchaseInvHeader.RESET;
                    PurchaseInvHeader.SETRANGE(PurchaseInvHeader."No.", Rec."No.");
                    PurchaseInvHeader.SetRange(PurchaseInvHeader."Document Type", Rec."Document Type");
                    PurchaseInvHeader.SetRange(PurchaseInvHeader."Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                    PurchaseOrderPrint.SETTABLEVIEW(PurchaseInvHeader);
                    PurchaseOrderPrint.RUN;
                end;
            }
            action("Purchase Order Summary")
            {
                ApplicationArea = suite;
                Caption = 'Purchase Order Summary';
                Ellipsis = true;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = report "Purchase Order Summary";
            }
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                PurchLines: Record "Purchase Line";
            begin
                // Rec.TestField(Rec."Location Code");
                Rec.TestField(Rec."Shipment Method Code");
                Rec.TestField(Rec."Expected Receipt Date");
                Rec.TestField(Rec."Vendor Invoice No.");

                PurchLines.Reset();
                PurchLines.SetRange("Document Type", PurchLines."Document Type"::Order);
                PurchLines.SetRange("Document No.", Rec."No.");
                IF PurchLines.Find('-') then
                    repeat
                        PurchLines.TestField(PurchLines."Location Code");
                    until PurchLines.Next() = 0;
            end;
        }
    }
}