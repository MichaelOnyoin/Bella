pageextension 50064 "Posted Purchase Invoices Ext" extends "Posted Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
        addafter("Vendor Invoice No.")
        {
            field("Purchase Description"; Rec."Purchase Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Description field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify("&Print")
        {
            Visible = false;
            Enabled = false;
        }
        addbefore(AttachAsPDF)
        {
            action("_Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                Visible = true;

                trigger OnAction()

                var
                    PurchaseInvHeader: Record "Purch. Inv. Header";
                    PostedPurchInv: Report "Purchase Invoice - Print";
                begin
                    PurchaseInvHeader.Reset();
                    PurchaseInvHeader.SetRange(PurchaseInvHeader."No.", Rec."No.");
                    PurchaseInvHeader.SetRange(PurchaseInvHeader."Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                    PostedPurchInv.SetTableView(PurchaseInvHeader);
                    PostedPurchInv.Run();
                end;
            }
        }
    }
}