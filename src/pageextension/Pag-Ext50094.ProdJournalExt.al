pageextension 50094 "Prod Journal Ext" extends "Production Journal"
{
    layout
    {
        modify("Location Code")
        {
            Editable = true;
        }
        addafter("No.")
        {
            field("Lot No."; Rec."Lot No.")
            {
                ApplicationArea = All;
                Caption = 'Batch No';
            }
            field("Under Fill"; Rec."Under Fill")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Under Fill field.';
            }
            field("Over Fill"; Rec."Over Fill")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Over Fill field.';
            }
            field("Machine Damage"; Rec."Machine Damage")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Machine Damage field.';
            }
            field("QC Samples"; Rec."QC Samples")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the QC Samples field.';
            }
        }
        addafter("Consump. Qty.")
        {
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                ProdComponents: Record "Prod. Order Component";
            begin
                ProdComponents.Reset();
                ProdComponents.SetRange("Prod. Order No.", Rec."Document No.");
                ProdComponents.SetRange("OutPut Item No.", Rec."Item No.");
                if ProdComponents.FindFirst() then begin

                    ProdComponents."Under Fill" := Rec."Under Fill";
                    ProdComponents."Over Fill" := Rec."Over Fill";
                    ProdComponents."QC Samoples" := Rec."QC Samples";
                    ProdComponents."Machine Damage" := Rec."Machine Damage";
                    ProdComponents.Modify();
                end;
            end;
        }
    }
}