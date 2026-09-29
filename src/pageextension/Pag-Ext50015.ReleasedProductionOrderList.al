pageextension 50015 "Released Production Order List" extends "Released Production Orders"
{
    actions
    {
        modify(ProdOrderMaterialRequisition)
        {
            Visible = false;
        }
        addafter("&Update Unit Cost")
        {
            action("Mat. Requisition")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Production Order - Material Requisition';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'View a list of material requirements per production order. The report shows you the status of the production order, the quantity of end items and components with the corresponding required quantity. You can view the due date and location code of each component.';

                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                begin
                    ProductionOrder.Reset();
                    ProductionOrder.SetRange("No.", Rec."No.");
                    if Rec."Batch No." = '' then
                        Rec.TestField("Batch No.");
                    if ProductionOrder.FindFirst() then
                        Report.Run(50073, true, false, ProductionOrder);
                end;
            }
        }
    }
}