tableextension 50049 "Finance Cue Ext" extends "Finance Cue"
{
    fields
    {
        field(50000; "Item Expiry"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" where("Expiration Date" = filter('CD' .. 'CD+4M')));
        }
    }
}