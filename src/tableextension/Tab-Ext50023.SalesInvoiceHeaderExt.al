tableextension 50023 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        // Add changes to table fields here
        field(50033; "Truck No."; Code[30])
        {
        }
        field(50034; "Seal No"; Code[30])
        {
        }
        field(50002; "Delivered"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Credit Limit (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Credit Limit (LCY)" where("No." = field("Bill-to Customer No.")));
        }
        field(50005; QRImage; Blob)
        {
        }
        field(50035; "MoMo Code"; Integer)
        {
        }
    }
}