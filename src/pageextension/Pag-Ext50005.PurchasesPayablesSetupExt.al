pageextension 50005 "Purchases & Payables Setup Ext" extends "Purchases & Payables Setup"
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
            field("Allow Direct Invoices"; Rec."Allow Direct Invoices")
            {
                ApplicationArea = All;
            }

            field("Default Vendor"; Rec."Default Vendor")
            {
                ApplicationArea = All;
            }
            field("Payment Requisition Nos."; Rec."Payment Requisition Nos.")
            {
                ApplicationArea = All;
            }
            field("Payment Requistion Journal"; Rec."Payment Requistion Journal")
            {
                ApplicationArea = All;
                Visible = false;
            }

            field("Use User Location"; Rec."Use User Location")
            {
                ApplicationArea = All;
            }
            field("Print Only Released POs"; Rec."Print Only Released POs")
            {
                ToolTip = 'Specifies the value of the Print Only Released POs field.';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}