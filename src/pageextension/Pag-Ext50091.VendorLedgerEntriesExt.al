pageextension 50091 "VendorLedgerEntriesExt" extends "Vendor Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("External Document No.")
        {
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ToolTip = 'Specifies the value of the Vendor Shipment No. field';
                ApplicationArea = All;
            }
        }
        addafter("Vendor No.")
        {
            field("Vendor Name."; Rec."Vendor Name.")
            {
            }
            field("Paid To/Received From"; Rec."Paid To/Received From")
            {
                ApplicationArea = All;
                Caption = 'Working Description';
            }
        }
    }

    actions
    {
    }
}
