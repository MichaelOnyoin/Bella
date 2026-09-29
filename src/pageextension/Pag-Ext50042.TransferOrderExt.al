pageextension 50042 "Transfer Order Ext" extends "Transfer Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Assigned User ID")
        {
            /* field("Transfer Reason"; "Transfer Reason")
            {
                ApplicationArea = All;
                Visible = false;
            } */
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Order No. field.';
            }
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Inventory Posting Group field.';
            }
            field("Prod Order No."; Rec."Prod Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prod Order No. field.', Comment = '%';
            }
            field("Transfer Reason"; Rec."Transfer Reason")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer Reason field.', Comment = '%';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            Visible = false;
            Enabled = false;
        }
        addfirst("P&osting")
        {
            action("Get Sales Lines")
            {
                ApplicationArea=Basic, Suite;
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    TransferLine: Record "Transfer Line";
                begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document No.", Rec."Sales Order No.");
                    SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SetRange(Type, SalesLine.Type::Item);
                    if SalesLine.FindSet() then begin
                        repeat begin
                            TransferLine.Validate("Document No.", Rec."No.");
                            TransferLine.Validate("Line No.", SalesLine."Line No.");
                            TransferLine.Validate("Item No.", SalesLine."No.");
                            TransferLine.Validate(Quantity, SalesLine.Quantity);
                            TransferLine.Insert();
                        end until SalesLine.Next() = 0;
                    end;
                end;
            }
             action("Get Component Lines")
            {
                ApplicationArea = Basic, suit;
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    OrderComponent: Record "Prod. Order Component";
                    TransferLine: Record "Transfer Line";
                begin
                    Rec.TestField("Prod Order No.");
                    OrderComponent.Reset();
                    OrderComponent.SetRange("Prod. Order No.", Rec."Prod Order No.");
                    OrderComponent.SetRange(Status, OrderComponent.Status::Released);
                    if OrderComponent.FindSet() then begin
                        repeat begin
                            TransferLine.Validate("Document No.", Rec."No.");
                            TransferLine.Validate("Line No.", OrderComponent."Line No.");
                            TransferLine.Validate("Item No.", OrderComponent."Item No.");
                            TransferLine.Validate(Quantity, OrderComponent."Expected Quantity");
                            TransferLine.Insert();
                        end;
                        until OrderComponent.Next() = 0;


                    end;




                end;

            }
            action("Post Transfer")
            {
                ApplicationArea = Location;
                Caption = 'P&ost';
                Ellipsis = true;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                begin
                    CODEUNIT.Run(CODEUNIT::"TransferOrderPost (Yes/No)", Rec);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        LocationRec: Record Location;
    begin
        if (Rec.Status = Rec.Status::Open) and (not Rec."Direct Transfer") then begin
            if LocationRec.FindFirst() then begin
                repeat
                    if LocationRec."Use As In-Transit" then begin
                        Rec."In-Transit Code" := LocationRec.Code;
                        exit;
                    end;
                until LocationRec.Next() = 0;
            end;
        end;
    end;
}