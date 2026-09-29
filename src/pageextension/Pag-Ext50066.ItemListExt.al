pageextension 50066 "Item List Ext" extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field("Common Item No."; Rec."Common Item No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(InventoryField)
        {

            field("Purchase Receipt Qty"; Rec."Purchase Receipt Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Receipt Qty field.', Comment = '%';
                Editable = false;
                Visible = false;
            }
            field("Purchases (Qty.)"; Rec."Purchases (Qty.)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchases (Qty.) field.', Comment = '%';
                Editable = false;
            }
            field("Positive Adjustment Qty"; Rec."Positive Adjustment Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Positive Adjustment Qty field.', Comment = '%';
                Editable = false;
                Visible = false;
            }
            field("Production Output Qty"; Rec."Production Output Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production Output Qty field.', Comment = '%';
                Editable = false;
            }

            field("Positive Adjmt. (Qty.)"; Rec."Positive Adjmt. (Qty.)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Positive Adjmt. (Qty.) field.', Comment = '%';
                Editable = false;
            }
            field("Negative Adjmt. (Qty.)"; Rec."Negative Adjmt. (Qty.)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Negative Adjmt. (Qty.) field.', Comment = '%';
                Editable = false;
            }

            field("Consumption Quantuy"; Rec."Consumption Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consumption Quantuy field.', Comment = '%';
                Editable = false;
            }
            field("Negative Adjustments"; Rec."Negative Adjustments")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Negative Adjustments field.', Comment = '%';
                Editable = false;
                Visible = false;
            }
            field("Negative Adjmt. (LCY)"; Rec."Negative Adjmt. (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Negative Adjmt. (LCY) field.', Comment = '%';
                Editable = false;
                Visible = false;
            }

            field("Positive Adjmt. (LCY)"; Rec."Positive Adjmt. (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Positive Adjmt. (LCY) field.', Comment = '%';
                Editable = false;
                Visible = false;
            }
            field("Sales Invoice Qty"; Rec."Sales Invoice Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Invoice Qty field.', Comment = '%';
                Editable = false;
            }
            field("Sales Credit Memo Qty"; Rec."Sales Credit Memo Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Credit Memo Qty field.', Comment = '%';
                Editable = false;
            }
            field("Sales (Qty.)"; Rec."Sales (Qty.)")
            {
                ApplicationArea = All;
                Caption = 'Net Sales (Qty)';
                ToolTip = 'Specifies the value of the Sales (Qty.) field.', Comment = '%';
                Editable = false;
            }
            field("Sales Shipment Qty"; Rec."Sales Shipment Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Shipment Qty field.', Comment = '%';
                Editable = false;
                Visible = false;
            }
            field("Purchases (LCY)"; Rec."Purchases (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchases (LCY) field.', Comment = '%';
                Editable = false;
                Visible = false;
            }

            field("Purchase  Return Qty"; Rec."Purchase  Return Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase  Return Qty field.', Comment = '%';
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Inventory - Sales Statistics")
        {
            action("Item Availabity By location2")
            {
                //ApplicationArea = Suite;
                ApplicationArea = Planning;
                Promoted = true;
                PromotedCategory = "Report";
                Caption = 'Item Availability By Location';
                Image = "Report";
                RunObject = Report "Item Availability By Location";
                ToolTip = 'Item Availability By Location';
            }

            action("Item Stock Card")
            {
                ApplicationArea = Planning;
                Promoted = true;
                PromotedCategory = "Report";
                Caption = 'Item Stock Card';
                Image = Card;
                ToolTip = 'Item Stock Card';
                trigger OnAction()
                var
                    Item: Record Item;
                    ItemStockcard: Report "Item Stock Card";
                begin
                    Item.Reset();
                    Item.SetRange(Item."No.", Rec."No.");
                    Item.SetRange(Item."Item Category Code", Rec."Item Category Code");
                    ItemStockcard.SetTableView(Item);
                    ItemStockcard.Run();
                end;
            }

            action(ItemMovement)
            {
                ApplicationArea = Planning;
                Promoted = true;
                PromotedCategory = "Report";
                Caption = 'Item Movement';
                Image = Card;
                ToolTip = 'Item Movement Including Inbound and Outbound Transactions';
                RunObject = report "Item Movement";
            }
            action("Inventory Availability Analysis")
            {
                ApplicationArea = Planning;
                Promoted = true;
                PromotedCategory = "Report";
                Caption = 'Inventory Availabilty Analysis';
                Image = Card;
                RunObject = report 50064;
            }
        }

        addlast(processing)
        {
            action(ShowBlockedItems)
            {
                ApplicationArea = All;
                Caption = 'Show Blocked';
                Image = Filter;
                Visible = not ShowBlocked;
                trigger OnAction()
                begin
                    BlockedFilterMgmt.ToggleFilter(ShowBlocked);
                    BlockedFilterMgmt.ApplyItemFilter(Rec, ShowBlocked);
                    CurrPage.Update(false);
                end;
            }
            action(HideBlockedItems)
            {
                ApplicationArea = All;
                Caption = 'Hide Blocked';
                Image = Filter;
                Visible = ShowBlocked;
                trigger OnAction()
                begin
                    BlockedFilterMgmt.ToggleFilter(ShowBlocked);
                    BlockedFilterMgmt.ApplyItemFilter(Rec, ShowBlocked);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    /* trigger OnAfterGetRecord()
    var
    begin
        Item.Reset();
        Rec.SetView('Sorting("No.") Order(Ascending) WHERE (Blocked = False)');
    end; */

     trigger OnOpenPage()
    begin
        BlockedFilterMgmt.ApplyItemFilter(Rec, ShowBlocked);
    end;

    var
        ShowBlocked: Boolean;
        BlockedFilterMgmt: Codeunit "Blocked Filter Mgmt";
}