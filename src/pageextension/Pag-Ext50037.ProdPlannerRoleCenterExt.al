pageextension 50037 "Prod. Planner Role Center Ext" extends "Production Planner Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(Worksheets)
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
        }
    }
}