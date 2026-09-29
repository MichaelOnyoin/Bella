pageextension 50027 "Released Production Order Ext" extends "Released Production Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Last Date Modified")
        {
            field("Work Shift"; Rec."Work Shift")
            {
                ApplicationArea = All;
            }
        }
        addafter("Search Description")
        {
            field("Batch No."; Rec."Batch No.")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        addfirst(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5405),
                              "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        modify("Mat. &Requisition")
        {
            Visible = false;
        }
        addafter("&Update Unit Cost")
        {
            action("Mat. Requisition")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Mat. &Requisition';
                Ellipsis = true;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
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