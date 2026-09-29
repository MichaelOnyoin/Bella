pageextension 50006 "Sales Order Subform Ext" extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here

        addafter("Location Code")
        {
            field("Employee No."; Rec."Resource No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Working Description"; Rec."Working Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Working Description for this line.';
            }
        }
        addafter("Line Amount")
        {
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
            }
        }
        modify("Unit Price")
        {
            Editable =true;
            Enabled = true;
        }
        modify(Description)
        {
            Editable = EditDescription;
        }
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            var
            begin
                if "Location Code" = 'QUARANTINE' then begin
                    Error('You Cannot sell from QUARANTINE location');
                end;
            end;
        }
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
