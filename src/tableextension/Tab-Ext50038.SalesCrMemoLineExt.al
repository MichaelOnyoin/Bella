tableextension 50038 "SalesCrMemoLineExt" extends "Sales Cr.Memo Line"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "Resource No."; Code[50])
        {
            TableRelation = Resource."No." WHERE(Type = FILTER(Person));
        }
        field(50110; "Customer Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name WHERE("No." = field("Sell-to Customer No.")));
        }
        field(50112; "Applies-to Doc No."; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Header"."Applies-to Doc. No." WHERE("No." = FIELD("Document No.")));
        }
    }
}
