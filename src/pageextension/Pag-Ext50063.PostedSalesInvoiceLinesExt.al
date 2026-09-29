pageextension 50063 "PostedSales InvoiceLinesExt" extends "Posted Sales Invoice Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter(Amount)
        {
            field("Resource No."; Rec."Resource No.")
            {
                ApplicationArea = All;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}