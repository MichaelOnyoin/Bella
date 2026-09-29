pageextension 50045 "Purchase Order Subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Expected Receipt Date")
        {
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("VAT ProdPosting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Caption = 'VAT Prod Posting Group';
            }
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }

            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Depreciation Book Code"; Rec."Depreciation Book Code")
            {
                ApplicationArea = All;
            }
            field("FA Posting Type"; Rec."FA Posting Type")
            {
                ToolTip = 'Specifies the date that will be used on related fixed asset ledger entries.';
                ApplicationArea = All;
            }
            field("FA Posting Date"; Rec."FA Posting Date")
            {
                ToolTip = 'Specifies the value of the FA Posting Date field.';
                ApplicationArea = All;
            }
            field("Common Item No."; Rec."Common Item No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Common Item No. field.';
            }
        }
        addafter(Description)
        {
            field("Working Description"; Rec."Working Description")
            {
                ApplicationArea = All;
                Caption = 'Working Description';
            }
        }
        modify(Description)
        {
            Editable = false;
        }

        modify("Unit Cost (LCY)")
        {
            Editable = false;
        }
        // modify(Description)
        // {
        //     Editable = EditDescription;
        // }
        addafter("No.")
        {
            field("Vendor Item No."; Rec."Vendor Item No.")
            {
                ToolTip = 'Specifies the value of the Vendor Item No. field.';
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure")
        {
            field("No of Packs"; Rec."No of Packs")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No of Packs field.';
            }
            field("Manufacturing Date"; Rec."Manufacturing Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Manufacturing Date field.';
                ShowMandatory = true;
            }
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                Item: Record Item;
            begin
                Item.Reset();
                Item.SetRange("No.", Rec."No.");
                if Item.FindFirst() then begin
                    Rec."Common Item No." := Item."Common Item No.";
                end;
            end;
        }
        modify("Location Code")
        {
            Editable = true;
            trigger OnBeforeValidate()
            var
                Location: Record Location;
            begin
                Location.Reset();
                Location.SetRange(Location.Code, Rec."Location Code");
                Location.SetRange(Restricted, true);
                if Location.FindFirst() then begin
                    Error('You cannot received items from this Location');
                end;
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        EditDescription: Boolean;

    trigger OnAfterGetRecord()
    var
    begin
        if Rec.Type = Rec.Type::Item then
            EditDescription := false
        else
            EditDescription := true;
    end;
}