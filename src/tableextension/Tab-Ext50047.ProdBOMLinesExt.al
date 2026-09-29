tableextension 50047 "Prod.BOM Lines Ext" extends "Production BOM Line"
{
    fields
    {
        field(50008; "Percentage Per"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;

            trigger OnValidate()
            var
            // NewQty: Decimal;
            begin
                Rec.Validate(Rec."Quantity per", "Percentage Per" / 100);
                Rec.Modify();
            end;
        }
        field(50009; "Common Item No"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Common Item No." where("No." = field("No.")));
        }
    }
}