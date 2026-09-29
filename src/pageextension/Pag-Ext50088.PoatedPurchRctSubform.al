pageextension 50088 "Poated Purch RctSubform" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
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
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}