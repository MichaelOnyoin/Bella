tableextension 50053 "Sales Price Ext" extends "Sales Price"
{
    fields
    {
        field(50000; "Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
    }
}
