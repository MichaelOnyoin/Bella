pageextension 50002 "ASL.InventoryManager" extends "Whse. Basic Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("Posted Documents")
        {
            group("Employee Self Service")
            {
                action("Cash Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Requisitions';
                    Image = ReceiptLines;
                    RunObject = page "AdvancePurchase RequisitionsSS";
                }
                action("Purchase Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Requisitions';
                    Image = ReceiptLines;
                    RunObject = page "Purchase Requisitions Self";
                }
            }

            group(Requisitions)
            {
                action("Purchase Requisition Archives")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Requisition Archives';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Archive;
                    RunObject = page "Purchase Requisition Archives";
                }
                action(RequestsToApprove)
                {
                    ApplicationArea = All;
                    Caption = 'Requests to Approve';
                    RunObject = page "Requests to Approve";
                    Image = SendApprovalRequest;
                }
            }
        }
    }
}