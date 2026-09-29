pageextension 50056 "VAT Entries Ext" extends "VAT Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bill-to/Pay-to No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }

            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}