pageextension 50085 "Production BOM Line Ext" extends "Production BOM Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            /* field("Last Modified"; Rec."Last Modified By")
            {
                ApplicationArea = All;
                Editable = false;
            } */

            field("Percentage Per"; Rec."Percentage Per")
            {
                ToolTip = 'Specifies the value of the Percentage Per field.';
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Common Item No"; Rec."Common Item No")
            {
            }
        }
        modify("Quantity per")
        {
            // Visible = false;
            Editable = true;
        }
        // modify("No.")
        // {
        //      trigger OnBeforeValidate()
        //     var
        //     Item:Record Item;
        //     begin
        //         Item.Reset();
        //         Item.SetRange("No.",Rec."No.");
        //         if Item.FindFirst() then begin
        //             Rec."Common Item No" := Item."Common Item No.";
        //         end;

        //     end;

        // }
    }

    actions
    {
        // Add changes to page actions here
    }
}