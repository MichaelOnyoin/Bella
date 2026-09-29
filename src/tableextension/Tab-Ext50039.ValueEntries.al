tableextension 50039 "ValueEntries" extends "Value Entry"
{
    fields
    {
        field(50001; ItemDescription; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Line".Description WHERE("Document No." = field("Document No."), "Line No." = field("Document Line No.")));
        }
        field(50002; UOM; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Line"."Unit of Measure Code" WHERE("Document No." = FIELD("Document No."), "Line No." = field("Document Line No.")));
        }
        field(50003; "Sales Price"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Line"."Unit Price" WHERE("Document No." = FIELD("Document No."), "Line No." = field("Document Line No.")));
        }
        field(50004; "Sales Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Line"."Line Amount" WHERE("Document No." = FIELD("Document No."), "Line No." = field("Document Line No.")));
        }
    }
}
