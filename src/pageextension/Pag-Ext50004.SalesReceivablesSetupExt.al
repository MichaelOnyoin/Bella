pageextension 50004 "Sales & Receivables Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Payment-Invoice App. Mandatory"; Rec."Payment-Invoice App. Mandatory")
            {
                ApplicationArea = All;
            }

            field("Allow Direct Invoicing"; Rec."Allow Direct Invoicing")
            {
                ApplicationArea = All;
            }

            field(" Use User Location"; Rec."Use User Location")
            {
                ApplicationArea = All;
            }
            field("POS Counter Nos."; Rec."POS Counter Nos.")
            {
                ApplicationArea = All;
            }
            field(QrCodeUrl; Rec.QrCodeUrl)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the QrCodeUrl field.';
            }
        }

        addafter("Posted Shipment Nos.")
        {
            field("Requisition Nos."; Rec."Requisition Nos.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Requisition Nos.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}