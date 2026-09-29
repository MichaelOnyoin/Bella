pageextension 50076 "Posted Sales Shipment Ext" extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
        addafter("Order No.")
        {
            field("User ID"; Rec."User ID")
            {
                Caption = ' User ID';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addfirst(processing)
        {
            action("PrintSalesShipment")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Print the shipping notice.';

                trigger OnAction()
                var
                    SalesShptHeader: Record "Sales Shipment Header";
                    PostedSalesShptPrint: Report "Sales - Shipment Print";
                begin
                    SalesShptHeader.RESET;
                    SalesShptHeader.SETRANGE(SalesShptHeader."No.", Rec."No.");
                    SalesShptHeader.SetRange(SalesShptHeader."Bill-to Customer No.", Rec."Bill-to Customer No.");
                    PostedSalesShptPrint.SETTABLEVIEW(SalesShptHeader);
                    PostedSalesShptPrint.RUN;
                end;
            }
        }
        modify("&Print")
        {
            Visible = false;
            Enabled = false;
        }
    }
}