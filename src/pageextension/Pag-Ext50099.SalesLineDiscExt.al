pageextension 50099 "Sales LineDiscExt" extends "Sales Line Discounts"
{
    layout
    {
        addafter(Code)
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description field.', Comment = '%';
            }
        }
    }
}
