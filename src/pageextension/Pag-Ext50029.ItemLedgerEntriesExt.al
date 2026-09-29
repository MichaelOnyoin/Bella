pageextension 50029 "Item Ledger Entries Ext" extends "Item Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter(Open)
        {
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
            }
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;
            }
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
            }
            field("Customer Group"; Rec."Customer Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Group field.', Comment = '%';
            }
        }
        addafter("Item No.")
        {
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("Remaining Quantity")
        {
            field("Sender ID"; Rec."Sender ID")
            {
                ToolTip = 'Specifies the value of the Sender ID field';
                ApplicationArea = All;
            }
            field("Approver ID"; Rec."Approver ID")
            {
                ToolTip = 'Specifies the value of the Approver ID field';
                ApplicationArea = All;
            }
            field("USER ID"; Rec."USER ID")
            {
                ToolTip = 'Specifies the value of the USER ID field';
                ApplicationArea = All;
            }
            field("Inventory Poating Group"; Rec."Inventory Poating Group")
            {
                ApplicationArea = All;
            }
             
        }
        addafter("Document No.")
        {
            field("Vend. Invoice No."; Rec."Vend. Invoice No.")
            {
                ToolTip = 'Specifies the value of the Vend. Invoice No. field.';
                ApplicationArea = All;
            }
            
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}