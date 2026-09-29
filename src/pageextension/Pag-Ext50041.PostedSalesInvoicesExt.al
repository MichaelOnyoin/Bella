pageextension 50041 "Posted Sales Invoices Ext" extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                ApplicationArea = All;
            }
            /* field("Branch Code"; Rec."Branch Code")
            {
                ApplicationArea = All;
            }
            field("Truck No."; Rec."Truck No.")
            {
                ApplicationArea = All;
            }

            field("Seal No"; Rec."Seal No")
            {
                ApplicationArea = All;
            }*/
            field("Delivered"; Rec."Delivered")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("MoMo Code"; Rec."MoMo Code")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addfirst(processing)
        {
            action("Print Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category7;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                //Visible = NOT IsOfficeAddin;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                    PostedSalesInvoicePrint: Report "Sales - Invoice Print";
                begin
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE(SalesInvHeader."No.", Rec."No.");
                    SalesInvHeader.SetRange(SalesInvHeader."Bill-to Customer No.", Rec."Bill-to Customer No.");
                    PostedSalesInvoicePrint.SETTABLEVIEW(SalesInvHeader);
                    PostedSalesInvoicePrint.RUN;
                end;
            }
        }
        // Add changes to page actions here
        modify(Print)
        {
            Visible = false;
            Enabled = false;
        }
    }

    trigger OnAfterGetRecord()
    begin
        AttachmentDoc.Reset();
        AttachmentDoc.SetRange("No.", Rec."No.");
        AttachmentDoc.SetRange("Table ID", Database::"Sales Invoice Header");
        if AttachmentDoc.FindFirst() then begin
            Rec."Delivered" := true;
        end;
    end;

    var
        AttachmentDoc: Record "Document Attachment";
}