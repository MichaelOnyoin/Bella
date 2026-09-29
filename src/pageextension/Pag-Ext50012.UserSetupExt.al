pageextension 50012 "User Setup Ext" extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(PhoneNo)
        {
            Field("Leave Administrator"; Rec."Leave Administrator")
            {
                ApplicationArea = All;
            }
            Field("HR Administrator"; Rec."HR Administrator")
            {
                ApplicationArea = All;
            }
            Field("Finance Administrator"; Rec."Finance Administrator")
            {
                ApplicationArea = All;
            }
            field("Creat VCI"; "Creat VCI")
            {
                ApplicationArea = all;
            }
            field("Restrict Sales Invoicing"; Rec."Restrict Sales Invoicing")
            {
                ApplicationArea = All;
            }
            field("Restrict Sales Shipment"; Rec."Restrict Sales Shipment")
            {
                ApplicationArea = All;
            }
            field("Restrict Purchase Invoicing"; Rec."Restrict Purchase Invoicing")
            {
                ApplicationArea = All;
            }
            field("Restrict Purchase Shipment"; Rec."Restrict Purchase Shipment")
            {
                ApplicationArea = All;
            }

            //POint of Sale field

            Field("Location Code"; Rec."Location Code")
            {
                // ApplicationArea = All;
            }
            Field("Sell-to Customer No."; Rec."Sell-to Customer No.")
            {
                // ApplicationArea = All;
            }
            Field("Sales Order Nos."; Rec."Sales Order Nos.")
            {
                //ApplicationArea = All;
            }
            Field("Receipt Nos."; Rec."Receipt Nos.")
            {
                // ApplicationArea = All;
            }
            Field("Journal Template Name"; Rec."Journal Template Name")
            {
                //ApplicationArea = All;
            }
            Field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                // ApplicationArea = All;
            }
            Field("Receipt Journal Nos."; Rec."Receipt Journal Nos.")
            {
                //ApplicationArea = All;
            }
            Field("Receiving Bank"; Rec."Receiving Bank")
            {
                //ApplicationArea = All;
            }
            Field("Custom authorizer Password"; Rec."Custom authorizer Password")
            {
                // ApplicationArea = All;
            }
            Field("Expense Nos."; Rec."Expense Nos.")
            {
                //ApplicationArea = All;
            }
            Field("Expense Template Name"; Rec."Expense Template Name")
            {
                // ApplicationArea = All;
            }
            Field("Custom Sales Authorizer"; Rec."Custom Sales Authorizer")
            {
                // ApplicationArea = All;
            }
            Field("Expense Batch Name"; Rec."Expense Batch Name")
            {
                // ApplicationArea = All;
            }
            Field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                //ApplicationArea = All;
            }
            Field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                // ApplicationArea = All;
            }
        }
        addafter("Restrict Purchase Shipment")
        {

            field("Edit PO"; Rec."Edit PO")
            {
                ApplicationArea = ALL;
            }

            field("Create Vendor"; Rec."Create Vendor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Create Vendor field.', Comment = '%';
            }
            field("Create Customer"; Rec."Create Customer")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Create Customer field.', Comment = '%';
            }

            field("Create Sales Order"; Rec."Create Sales Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Create Sales Order field.', Comment = '%';
            }

            field("Create Sales Credit Memo"; Rec."Create Sales Credit Memo")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Create Sales Credit Memo field.', Comment = '%';
            }
            field("Default Sell-to Customer No."; Rec."Default Sell-to Customer No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the customer that will be pre-selected on new Cash Sales for this user.';
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }
}