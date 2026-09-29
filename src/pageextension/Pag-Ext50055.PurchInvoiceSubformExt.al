pageextension 50055 "Purch. Invoice SubformExt" extends "Purch. Invoice Subform"
{
    layout{
        addafter("Line Discount %"){
          field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}
