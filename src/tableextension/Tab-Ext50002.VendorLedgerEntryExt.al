tableextension 50002 "VendorLedgerEntryExt" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Vendor Shipment No."; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Header"."Vendor Shipment No." WHERE("No." = FIELD("Document No.")));
        }
        field(50001; "Vendor Name."; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
        }
        field(50510; "Paid To/Received From"; Text[50]) { }
    }
}
