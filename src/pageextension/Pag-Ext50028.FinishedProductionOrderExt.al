pageextension 50028 "Finished Production Order Ext" extends "Finished Production Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Last Date Modified")
        {
            field("Work Shift"; Rec."Work Shift")
            {
                ApplicationArea = All;
            }
        }
        addfirst(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5405),
                              "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}