page 50079 "Sales Invoice Breakdown"
{
    PageType = StandardDialog;
    Caption = 'Sales Invoice Breakdown';
    SourceTable = Item;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Domestic Sales Qty"; Rec."Domestic Sales Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Domestic Sales Inv Qty';
                    Editable = false;
                }
                field("Export Sales Qty"; Rec."Export Sales Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Export Sales Inv Qty';
                    Editable = false;
                }
            }
        }
    }
}