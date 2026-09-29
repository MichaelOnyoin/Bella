pageextension 50018 "Vendor Card Ext" extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Last Date Modified")
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    Rec.OpenVendorLedgerEntries(true);
                end;
            }
        }
        addafter("Vendor Posting Group")
        {
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = All;
                Importance = Promoted;
            }
        }
        addafter("Balance Due (LCY)")
        {
            field("TIN Mandatory"; Rec."TIN Mandatory")
            {
                ApplicationArea = All;
            }
            field("Posted Dated Cheque Amount"; Rec."Post Dated Cheque Amount")
            {
                ApplicationArea = All;
                Caption = 'Uncleared Cheques - Amount';
                ToolTip = 'Shows the Customer total amount on Posted Checques';

                trigger OnDrillDown()
                var
                    VendorCheques: Record "Gen. Journal Line";
                    ViewChecques: Page "Uncleared Cheques";
                begin
                    VendorCheques.SETRANGE(VendorCheques."Account No.", Rec."No.");
                    VendorCheques.SetRange(VendorCheques."Account Type", VendorCheques."Account Type"::Vendor);
                    VendorCheques.SETRANGE(VendorCheques."Journal Batch Name", 'VEND_CHECQ');
                    Rec.CopyFilter("Currency Filter", VendorCheques."Currency Code");
                    ViewChecques.SetTableView(VendorCheques);
                    ViewChecques.Run();
                end;
            }
            field("Post Dated Checque Amount(LCY)"; Rec."Post Dated Checque Amount(LCY)")
            {
                ApplicationArea = All;
                Caption = 'Uncleared Cheques - Amount(LCY)';
                ToolTip = 'Shows the Customer total amount on Posted Checques in LCY';

                trigger OnDrillDown()
                var
                    VendorCheques: Record "Gen. Journal Line";
                    ViewChecques: Page "Uncleared Cheques";
                begin
                    VendorCheques.SetFilter(VendorCheques."Account No.", Rec."No.");
                    VendorCheques.SetRange(VendorCheques."Account Type", VendorCheques."Account Type"::Vendor);
                    VendorCheques.SETRANGE(VendorCheques."Journal Batch Name", 'VEND_CHECQ');
                    Rec.CopyFilter("Currency Filter", VendorCheques."Currency Code");
                    ViewChecques.SetTableView(VendorCheques);
                    ViewChecques.Run();
                end;
            }
        }
        addfirst(Invoicing)
        {
            field("VAT Registration Nos."; Rec."VAT Registration Nos.")
            {
                ApplicationArea = VAT;
                ToolTip = 'Specifies the vendor''s VAT registration number.';
                Visible = false;

                trigger OnDrillDown()
                var
                    VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
                begin
                    VATRegistrationLogMgt.AssistEditVendorVATReg(Rec);
                end;
            }
        }
        addafter("Balance Due (LCY)")
        {
            field("Minimum Order Qty"; Rec."Minimum Order Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Minimum Order Qty field.', Comment = '%';
            }
        }
    }

    var
        Usersetup: Record "User Setup";

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    
    begin
        /*      Usersetup.Reset();
             Usersetup.SetRange(Usersetup."User ID", UserId);
             if Usersetup.FindFirst() then begin
                 if Usersetup."Creat VCI" = true then begin
                     if Usersetup."Creat VCI" = false then begin
                         Error('Error messGE');
                     end;
                 end;
             end;
      */
        Usersetup.Reset();
        Usersetup.SetRange(Usersetup."User ID",UserId);
        if Usersetup.FindFirst() then begin
        if Usersetup."Create Vendor" = false then begin 
            Error('You are not allowed to Create a Vendor');
        end;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        if (Usersetup."Creat VCI" = false) then begin
            Error('Error 33');
        end;
    end;
}
