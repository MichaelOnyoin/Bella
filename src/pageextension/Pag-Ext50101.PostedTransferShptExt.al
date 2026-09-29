pageextension 50101 "Posted Transfer Shpt. Ext" extends "Posted Transfer Shipment"
{
    actions
    {
        addlast("&Shipment")
        {
            action("Print Delivery Note")
            {
                ApplicationArea = All;
                Caption = 'Print Delivery Note';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TransShptHeader: Record "Transfer Shipment Header";
                    DeliveryNote: Report "ASL Transfer Delivery Note";
                begin
                    TransShptHeader := Rec;
                    TransShptHeader.SetRecFilter();
                    DeliveryNote.SetTableView(TransShptHeader);
                    DeliveryNote.Run();
                end;
            }
        }
    }
}