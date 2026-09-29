pageextension 50080 "Cust Stat FactBox Ext" extends "Customer Statistics FactBox"
{
    layout
    {
        // Add changes to page layout here
        addafter(GetInvoicedPrepmtAmountLCY)
        {
            group("Uncleared Cheques")
            {
                field("Post Dated Cheque Amount"; Rec."Post Dated Cheque Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Uncleared Cheques - Amount';
                    ToolTip = 'Shows the Customer total amount on Posted Checques';

                    trigger OnDrillDown()
                    var
                        CustomerChecques: Record "Gen. Journal Line";
                        ViewChecques: Page "Uncleared Cheques";
                    begin
                        Clear(CustomerChecques);
                        CustomerChecques.SetRange("Account No.", Rec."No.");
                        ViewChecques.SetTableView(CustomerChecques);
                        ViewChecques.Run();
                    end;
                }
                field("Post Dated Cheque Amount(LCY)"; Rec."Post Dated Checque Amount(LCY)")
                {
                    ApplicationArea = All;
                    Caption = 'Uncleared Cheques - Amount(LCY)';
                    ToolTip = 'Shows the Customer total amount on Posted Checques';

                    trigger OnDrillDown()
                    var
                        CustomerChecques: Record "Gen. Journal Line";
                        ViewChecques: Page "Uncleared Cheques";
                    begin
                        Clear(CustomerChecques);
                        CustomerChecques.SetRange("Account No.", Rec."No.");
                        ViewChecques.SetTableView(CustomerChecques);
                        ViewChecques.Run();
                    end;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}