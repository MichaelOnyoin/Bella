pageextension 50096 "Sales Price Ext" extends "Sales Prices"
{
    layout
    {
        addafter("Item No.")
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
            }
        }
    }
}
