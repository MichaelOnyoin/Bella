pageextension 50051 "Requests to Approve Ext" extends "Requests to Approve"
{
    layout
    {
        // Add changes to page layout here
        addafter(Details)
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
            }
        }

        addafter(Comment)
        {
            field("ASL.Sender Name"; Rec."ASL.Sender Name")
            {
                Caption = 'Sender Name';
                ApplicationArea = All;
            }
            field("ASL.Approver Name"; Rec."ASL.Approver Name")
            {
                Caption = 'Approver Name';
                ApplicationArea = All;
            }

            /* field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = All;
            } */
            field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
            {
                ApplicationArea = All;
            }

            field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
            {
                ApplicationArea = All;
            }

            field("Last Modified By User ID"; Rec."Last Modified By User ID")
            {
                ApplicationArea = All;
            }
        }
        modify(ToApprove)
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(Reject)
        {
            trigger OnBeforeAction()
            begin
                if Rec.Comment <> true then
                    Rec.TestField(Comment);
            end;
        }
        addafter(Record)
        {
            action("Requisition Details")
            {
                ApplicationArea = Suite;
                Caption = 'Open Requisition Details';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Open the document, journal line, or card that the approval is requested for.';

                trigger OnAction()
                begin
                    PurchHeader.SetRange("No.", Rec."Document No.");
                    PurchHeader.SetRange("Document Type", "Document Type"::Quote);
                    IF PurchHeader.FindFirst() then begin
                        PurchLines.SetRange("Document No.", PurchHeader."No.");
                        IF (PurchLines.FindFirst()) AND (PurchLines."Location Code" = '') then begin // repeat
                            case PurchLines."Requisition Type" of
                                PurchLines."Requisition Type"::Advance:
                                    begin
                                        CashRequisition.SetRecord(PurchHeader);
                                        CashRequisition.Run();
                                    end;
                                PurchLines."Requisition Type"::Service:
                                    begin
                                        PurchRequisition.SetRecord(PurchHeader);
                                        PurchRequisition.Run();
                                    end;
                            end;
                        end; // until PurchLines.Next() = 0;
                    end;
                end;
            }
        }
    }

    var
        PurchHeader: Record "Purchase Header";
        PurchLines: Record "Purchase Line";
        PurchRequisition: Page "Purchase Requisition";
        CashRequisition: Page "Cash Requisition";
}