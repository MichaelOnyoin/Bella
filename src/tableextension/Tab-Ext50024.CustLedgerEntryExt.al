tableextension 50024 "Cust. Ledger Entry Ext" extends "Cust. Ledger Entry"
{
    fields
    {
        // Add changes to table fields here

        /* field(50035; "Return Branch Code"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Header"."Branch Code" where("No." = field("Document No.")));
        } */
        field(50000; Contact; Text[100])
        {
            Caption = 'Contact';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Bill-to Contact" where("No." = field("Document No.")));
        }
        field(50001; "Cash Sale Receipt No."; Code[20])
        {
            Caption = 'Cash Sale Receipt No.';
            DataClassification = CustomerContent;
        }
        field(50002; Narration; Text[250])
        {
            Caption = 'Narration';
            DataClassification = CustomerContent;
        }
    }
}