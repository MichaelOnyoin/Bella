pageextension 50086 "ASL.Approval Entries" extends "Approval Entries"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("ASL.EFRIS.RefundReason"; GetEFRISRefundReason())
            {
                Caption = 'Reason';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(Record)
        {
            trigger OnAfterAction()
            begin
            end;
        }
    }

     var
        SalesHeader: Record "Sales Header";

    local procedure GetEFRISRefundReason(): Text
    begin
        if Rec."Table ID" = Database::"Sales Header" then
            if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
                exit(SalesHeader."ASL.EFRIS.RefundReason");
        exit('');
    end;


}