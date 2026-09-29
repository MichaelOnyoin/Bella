tableextension 50051 "Prod Order Component Ext" extends "Prod. Order Component"
{
    fields
    {
        field(50000; "Actual Units"; Decimal)
        {
        }
        field(50001; "OutPut Item No."; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order"."Source No." where("No." = field("Prod. Order No.")));
        }
        field(50002; "Output Item Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order".Description where("No." = field("Prod. Order No.")));
        }
        field(50003; "BOM No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Prod. Order Line"."Production BOM No." where("Prod. Order No." = field("Prod. Order No.")));
        }
        field(50004; "Output Qty"; Decimal)
        {
            CalcFormula = lookup("Prod. Order Line".Quantity where("Prod. Order No." = field("Prod. Order No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Var Quantity"; Decimal)
        {
        }
        field(50007; "Actual Cost"; Decimal)
        {
        }
        field(5008; "Finished Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order"."Finished Date" where("No." = field("Prod. Order No.")));
        }
        field(5009; "Standartd Cost"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Production Order"."Cost Amount" where("No." = field("Prod. Order No.")));
        }
        modify("Expected Quantity")
        {
            trigger OnBeforeValidate()
            var
            begin
                "Actual Cost" := "Act. Consumption (Qty)" * "Unit Cost";
            end;
        }
        field(50061; "Under Fill"; Integer)
        {
        }
        field(50062; "Over Fill"; Integer)
        {
        }
        field(50063; "Machine Damage"; Integer)
        {
        }
        field(50064; "QC Samoples"; Integer)
        {
        }
    }
}