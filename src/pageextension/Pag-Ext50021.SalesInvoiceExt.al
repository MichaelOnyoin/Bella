pageextension 50021 "Sales Invoice Ext" extends "Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Customer Name")
        {
            // field("Branch Code"; Rec."Branch Code")
            // {
            //     ApplicationArea = All;

            // }
        }

        addafter("Posting Description")
        {
            field("Truck No."; Rec."Truck No.")
            {
                ApplicationArea = All;
            }

            field("Seal No."; Rec."Seal No")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        ASL00001: Label 'You are not allowed to Create a direct Sales invoice please contact your Systems Administrator';
        SalesSetup: Record "Sales & Receivables Setup";

    trigger OnOpenPage()
    begin
        //Avoid the direct creation of invoices
        SalesSetup.GET;
        IF SalesSetup."Allow Direct Invoicing" = FALSE THEN
            ERROR(ASL00001);
    end;
}