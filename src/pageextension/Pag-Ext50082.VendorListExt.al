pageextension 50082 "Vendor List Ext" extends "Vendor List"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Balance (LCY)")
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
    }
    actions
    {
    }
    var

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CreateVAI();
    end;

    procedure CreateVAI()
    var
    BEGIN
        usersetup.Reset();
        usersetup.SetRange(usersetup."User ID", UserId);
        if (usersetup."Creat VCI" = false) then begin
            Error('Test message');
        end;
    END;

    var
        usersetup: Record "User Setup";
}
