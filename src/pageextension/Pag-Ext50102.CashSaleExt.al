pageextension 50102 "Cash Sale Ext" extends "ASL.POS.CashSale"
{
    trigger OnAfterGetCurrRecord()
    var
        UserSetup: Record "User Setup";
        Customer: Record Customer;
        CashSaleHeader: Record "ASL.POS.CashSaleHeader";
    begin
        if not UserSetup.Get(UserId()) then
            exit;

        if UserSetup."Default Sell-to Customer No." = '' then
            exit;

        CashSaleHeader.SetRange("No.", Rec."No.");
        if not CashSaleHeader.FindFirst() then
            exit;

        if CashSaleHeader."Sell-to Customer No." <> UserSetup."Default Sell-to Customer No." then begin
            if Customer.Get(UserSetup."Default Sell-to Customer No.") then begin
                CashSaleHeader.Validate("Sell-to Customer No.", Customer."No.");
                if Customer."Gen. Bus. Posting Group" <> '' then
                    CashSaleHeader.Validate("Gen. Bus. Posting Group", Customer."Gen. Bus. Posting Group");
                if Customer."VAT Bus. Posting Group" <> '' then
                    CashSaleHeader.Validate("VAT Bus. Posting Group", Customer."VAT Bus. Posting Group");
                CashSaleHeader.Modify(true);
            end;
        end;

        CurrPage.Update(false);
    end;
}