tableextension 50055 "Sales LineDiscount Ext" extends "Sales line Discount"
{
    fields
    {
        field(50000; "Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field(Code)));
        }
    }
}
