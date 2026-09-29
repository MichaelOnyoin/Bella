pageextension 50009 "General Ledger Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Amount)
        {
            /* field(VendorName; VendorName)
            {
                ApplicationArea = All;
                Caption = 'Vendor Name';
            } */
        }
        addafter("G/L Account No.")
        {
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;
            }
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = All;

            }
           field(SourceName; SourceName)
            {
                ApplicationArea = All;
                Caption = 'Source Name';
                Editable = false;
            }
        }
        addafter(Amount)
        {
            
            field("Vendor Name"; VendorName)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Name field.';
            }
            field("System-Created Entry"; Rec."System-Created Entry")
            {
                ApplicationArea = All;
            }
            field("Authorised by"; Rec."Authorised by")
            {
                ApplicationArea = All;
            }
            field("Paid To/Received From"; Rec."Paid To/Received From")
            {
                ApplicationArea = All;
                Caption = 'Working Description';
            }
            field("Requested by"; Rec."Requested by")
            {
                ApplicationArea = All;
            }
            field("Reviewed by"; Rec."Reviewed by")
            {
                ApplicationArea = All;
            }
            field("Approved by"; Rec."Approved by")
            {
                ApplicationArea = All;
            }
            field("Prepared by"; Rec."Prepared by")
            {
                ApplicationArea = All;
            }/*
            field("Branch Code"; Rec."Branch Code")
            {
                ApplicationArea = All;
            } */
            field(ShortcutDimension3; ShortcutDimension3)
            {
                Caption = 'Shortcut Dimension 3 Code';
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(3));
                ApplicationArea = All;
            }
            field(ShortcutDimension4; ShortcutDimension4)
            {
                Caption = 'Shortcut Dimension 4 Code';
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(4));
                ApplicationArea = All;
            }
            field(ShortcutDimension5; ShortcutDimension5)
            {
                Caption = 'Shortcut Dimension 5 Code';
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(5));
                ApplicationArea = All;
            }
            field(ShortcutDimension6; ShortcutDimension6)
            {
                Caption = 'Shortcut Dimension 6 Code';
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(6));
                ApplicationArea = All;
            }
            field(ShortcutDimension7; ShortcutDimension7)
            {
                Caption = 'Shortcut Dimension 7 Code';
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(7));
                ApplicationArea = All;
            }
            field(ShortcutDimension8; ShortcutDimension8)
            {
                Caption = 'Shortcut Dimension 8 Code';
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(8));
                ApplicationArea = All;
            }
        }
        addafter("G/L Account No.")
        {

        }
    }
    trigger OnAfterGetRecord()
    var
        DimMgt: Codeunit DimensionManagement;
        SourceName: Codeunit "Source Name";
        ShortcutDimensionCode: array[8] of Code[20];
        SourceNameHelper: Codeunit "Source Name"; 
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimensionCode);
        ShortcutDimension3 := ShortcutDimensionCode[3];
        ShortcutDimension4 := ShortcutDimensionCode[4];
        ShortcutDimension5 := ShortcutDimensionCode[5];
        ShortcutDimension6 := ShortcutDimensionCode[6];
        ShortcutDimension7 := ShortcutDimensionCode[7];
        ShortcutDimension8 := ShortcutDimensionCode[8];
        SourceName.GetSourceName(Rec."Source Type", Rec."Source No.");

        //Get Vendor Name

        case Rec."Document Type" of
            Rec."Document Type"::Invoice:
                begin
                    IF PurchInvHeader.Get(Rec."Document No.") then begin
                        VendorName := PurchInvHeader."Buy-from Vendor Name";
                    end
                    else
                        exit;
                end;
            Rec."Document Type"::"Credit Memo":
                begin
                    IF PurchCrHeader.Get(Rec."Document No.") then begin
                        VendorName := PurchCrHeader."Buy-from Vendor Name";
                    end
                    else
                        exit;
                end;
            Rec."Document Type"::" ":
                begin
                    IF PurchInvHeader.Get(Rec."Document No.") then begin
                        VendorName := PurchInvHeader."Buy-from Vendor Name";
                    end
                    else
                        IF PurchRcptHeader.Get(Rec."Document No.") then begin
                            VendorName := PurchRcptHeader."Buy-from Vendor Name";
                        end
                        else
                            exit;
                end;
        end;
    end;

    var
        ShortcutDimension3: Code[20];
        ShortcutDimension4: Code[20];
        ShortcutDimension5: Code[20];
        ShortcutDimension6: Code[20];
        ShortcutDimension7: Code[20];
        ShortcutDimension8: Code[20];
        VendorName: Text;
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrHeader: Record "Purch. Cr. Memo Hdr.";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        SourceName: Text[100];
}
