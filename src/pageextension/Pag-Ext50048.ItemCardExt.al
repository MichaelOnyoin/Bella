pageextension 50048 "Item Card Ext" extends "Item Card"
{
    layout
    {
        modify(Inventory)
        {
            Visible = false;
            Caption = 'Inventory (Available Stock)';
        }

        modify("Net Weight")
        {
            Visible = true;
        }

        addafter("Search Description")
        {
            field(Inventory_; Inventory)
            {
                ApplicationArea = Basic, Suite;
                Enabled = IsInventoriable;
                HideValue = IsNonInventoriable;
                Importance = Promoted;
                ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.';
                Caption = 'Inventory (Available Stock)';

                // Visible = IsFoundationEnabled;

                trigger OnAssistEdit()
                var
                    AdjustInventory: Page "AdjustInventory";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);

                    if RecRef.IsDirty() then begin
                        Modify(true);
                        Commit();
                    end;

                    AdjustInventory.SetItem("No.");
                    if AdjustInventory.RunModal() in [ACTION::LookupOK, ACTION::OK] then
                        Get("No.");
                    CurrPage.Update()
                end;
            }
        }

        modify("Gross Weight")
        {
            Visible = false;
        }

        modify("Unit Volume")
        {
            Visible = false;
        }

        modify("Over-Receipt Code")
        {
            Visible = false;
        }

        modify("Shelf No.")
        {
            Visible = false;
        }

        modify("Qty. on Sales Order")
        {
            Visible = false;
        }

        modify("Qty. on Service Order")
        {
            Visible = false;
        }

        modify("Qty. on Job Order")
        {
            Visible = false;
        }

        modify("Qty. on Assembly Order")
        {
            Visible = false;
        }

        modify("Qty. on Asm. Component")
        {
            Visible = false;
        }
        modify("Qty. on Component Lines")
        {
            Visible = false;
        }
        modify(StockoutWarningDefaultYes)
        {
            Visible = false;
        }
        modify(PreventNegInventoryDefaultYes)
        {
            Visible = false;
        }

        modify("Qty. on Prod. Order")
        {
            Caption = 'Target Purchase Order Qty (Firmed)';
            Visible = ShowRawMaterial or ShowPackaging;
        }

        modify("Qty. on Purch. Order")
        {
            Visible = ShowRawMaterial or ShowPackaging;
        }
        // Add changes to page layout here
        addafter(Inventory)
        {
            field("Finished Goods Location"; Rec."Finished Goods Location")
            {
                ApplicationArea = All;
                Visible = ShowFinished;
            }

            /*field("Popups Location"; Rec."Popups Location")
            {
                ApplicationArea = All;
                Visible = ShowFinished;
            }*/

            field("Arena Mall"; Rec."Arena Mall")
            {
                ApplicationArea = All;
                Visible = ShowFinished;
            }

            /*field("Transactional Locations"; Rec."Transactional Locations")
            {
                ApplicationArea = All;
                Visible = ShowFinished;
            }*/

            field("Raw Materials Location"; Rec."Raw Materials Location")
            {
                ApplicationArea = All;
                Visible = ShowRawMaterial;
            }

            field("Packaging Location"; Rec."Packaging Location")
            {
                ApplicationArea = All;
                Visible = ShowPackaging;
            }

            field("Damages Location"; Rec."Damages Location")
            {
                ApplicationArea = All;
                Visible = ShowFinished or ShowRawMaterial or ShowPackaging;
            }

            field("Production Output Qty"; Rec."Production Output Qty")
            {
                ApplicationArea = All;
                Visible = ShowFinished;
            }

            field("Production Consumption"; Rec."Consumption Quantity")
            {
                ApplicationArea = All;
                Caption = 'Production Consumption';
                Visible = ShowRawMaterial;
            }

            field("Expected Production Output Qty"; Rec."Expected Production Output Qty")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Expected quantity from released production orders.';
                Visible = ShowFinished;

            }
            field("Positive Adjmt. (Qty.)"; Rec."Positive Adjmt. (Qty.)")
            {
                ApplicationArea = All;
            }

            field("Negative Adjmt. (Qty.)"; Rec."Negative Adjmt. (Qty.)")
            {
                ApplicationArea = All;

                trigger OnAssistEdit()
                var
                    NegAdjmtBreakdown: Page "Neg Adjmt Details";
                begin
                    NegAdjmtBreakdown.LoadData(Rec."No.");
                    NegAdjmtBreakdown.RunModal();
                end;
            }

            // field("Purchases (Qty.)"; Rec."Purchases (Qty.)")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Purchase Receipts (Qty) Resale';
            //     Visible = ShowRawMaterial or (Rec."Replenishment System" = Rec."Replenishment System"::Purchase);
            // }

            field("Purchases (Qty.) Resale"; Rec."Purchases (Qty.)")
            {
                ApplicationArea = All;
                Caption = 'Purchase Receipts (Qty) Resale';
                Visible = ShowFinished;
            }



            field("Purchases (Qty.) NoResale"; Rec."Purchases (Qty.)")
            {
                ApplicationArea = All;
                Caption = 'Purchase Receipts (Qty)';
                Visible = ShowRawMaterial or ShowPackaging;
            }

            field("Qty. on Purch. Order Firm Planned"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
                Caption = 'Purchase Orders (Qty)';
                Visible = ShowRawMaterial or ShowPackaging;
                // Visible = false;
            }

            field("No. of Purch. Orders"; Rec."No. of Purch. Orders")
            {
                ApplicationArea = All;
                Caption = 'Purchase Orders (No.)';
                Visible = ShowRawMaterial or ShowPackaging;
                ToolTip = 'Number of Purchase orders created';
            }

            field("No. of Sales. Orders"; Rec."No. of Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders (No.)';
                Visible = ShowFinished;
                ToolTip = 'Number of Sales orders created';
            }

            field("Qty. on Sales Orders"; Rec."Qty. on Sales Orders")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies how many units of the item are allocated to sales orders, meaning listed on quantity sales orders lines.';
                Visible = ShowFinished;
                Caption = 'Quantity on Sales';
            }

            field("Qty. on Purchase Orders"; Rec."Qty. on Purchase Orders")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies how many units of the item are on purchase orders, meaning listed on quantity purchase orders lines.';
                Visible = ShowFinished;
                Caption = 'Qty. on Purch. Order (Resale Items)';
            }

            field("Vendor Count"; Rec."Vendor Count")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendors Supplying Item field.', Comment = '%';
                Visible = ShowRawMaterial or ShowPackaging;

                trigger OnDrillDown()
                var
                    ItemVendor: Record "Item Vendor";
                begin
                    ItemVendor.Reset();
                    ItemVendor.FilterGroup(2);
                    ItemVendor.SetRange("Item No.", Rec."No.");
                    Page.Run(Page::"Item Vendor Catalog", ItemVendor);
                    ItemVendor.FilterGroup(0);
                end;
            }
            field(UsedInFinishedGoods; ViewLabel)
            {
                ApplicationArea = All;
                DrillDown = true;
                Editable = false;
                Caption = 'FG Item List';
                Style = AttentionAccent;
                Visible = ShowRawMaterial or ShowPackaging;

                trigger OnDrillDown()
                var
                    FGWhereUsed: Page "Used In Semi/Finished Goods";
                begin
                    FGWhereUsed.SetItem(Rec, WorkDate);
                    FGWhereUsed.RunModal();
                end;
            }
            field(ExpiryDates; ViewLabel)
            {
                ApplicationArea = All;
                DrillDown = true;
                Editable = false;
                Caption = 'Expiry Dates';
                Style = AttentionAccent;
                Visible = ShowRawMaterial;

                trigger OnDrillDown()
                var
                    ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                begin
                    ItemTrackingDocMgt.ShowItemTrackingForEntity(3, '', Rec."No.", '', '');
                end;
            }

            field("Domestic Invoiced Qty"; Rec."Domestic Sales Invoiced Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Domestic Invoiced Qty field.', Comment = '%';
                //Visible = ShowFinished or (not ShowRawMaterial);
                Visible = false;
            }
            field("Export Invoiced Qty"; Rec."Export Invoiced Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Export Invoiced Qty field.', Comment = '%';
                //Visible = ShowFinished or (not ShowRawMaterial);
                Visible = false;
            }
            field("Sales (Qty.)"; Rec."Sales (Qty.)")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoices (Qty)';
                ToolTip = 'Specifies the value of the Sales Invoices (Qty.) field.', Comment = '%';
                Editable = false;
                Visible = ShowFinished;


                trigger OnAssistEdit()
                var
                    SalesInvoiceBreakdown: Page "Sales Invoice Breakdown";
                begin
                    SalesInvoiceBreakdown.SetRecord(Rec);
                    SalesInvoiceBreakdown.RunModal();
                end;
            }
            field("Domestic Sales Qty"; Rec."Domestic Sales Qty")
            {
                ApplicationArea = All;
                Caption = 'Domestic Sales Inv Qty';
                ToolTip = 'Specifies the value of the Domestic Sales Invoice Qty field.', Comment = '%';
                Visible = ShowFinished and ShowInvoiceDetails;
                ;
            }
            field("Export Sales Qty"; Rec."Export Sales Qty")
            {
                ApplicationArea = All;
                Caption = 'Export Sales Inv Qty';
                ToolTip = 'Specifies the value of the Export Sales Invoice Qty field.', Comment = '%';
                Visible = ShowFinished and ShowInvoiceDetails;
            }

            field("Negative Adj Sales"; Rec."Negative Adj Sales")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Negative Adj Sales field.', Comment = '%';
                //Visible = not ShowRawMaterial;
                Visible = false;
            }
            field("Purchase Receipt Qty"; Rec."Purchase Receipt Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Receipt Qty field.', Comment = '%';
                Editable = false;
                Visible = false;
            }
            field("Positive Adjustment Qty"; Rec."Positive Adjustment Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Positive Adjustment Qty field.', Comment = '%';
                Editable = false;
                Visible = false;
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
                //Visible = ShowRawMaterial or ShowPackaging or (not ShowRawMaterial);
                Visible = false;
            }
            field("Sales Credit Memo Qty"; Rec."Sales Credit Memo Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Credit Memo Qty field.', Comment = '%';
                Editable = false;
                //Visible = not ShowRawMaterial;
                Visible = false;

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
                Visible = ShowRawMaterial or ShowPackaging;

            }

            field("Purchase  Return Qty Resale"; Rec."Purchase  Return Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase  Return Qty field.', Comment = '%';
                Editable = false;
                Visible = ShowFinished;
                Caption = 'Purchase Return Qty (Resale)';
            }

        }
        addafter("Last Date Modified")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = All;
                Caption = 'Spare Part No.';
            }
        }
        addafter(Description)
        {
            field("HS Code"; Rec."HS Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Warehouse)
        {
            group("Characteristics & Specifications")
            {
                field("Appearance Method"; Rec."Appearance Method")
                {
                    ApplicationArea = All;
                }
                field("Appearance Unit"; Rec."Appearance Unit")
                {
                    ApplicationArea = All;
                }
                field("Appearance Specification"; Rec."Appearance Specification")
                {
                    ApplicationArea = All;
                }
                field("Odour Method"; Rec."Odour Method")
                {
                    ApplicationArea = All;
                }
                field("Odour Unit"; Rec."Odour Unit")
                {
                    ApplicationArea = All;
                }
                field("Odour Specification"; Rec."Odour Specification")
                {
                    ApplicationArea = All;
                }
                field("PH value Method"; Rec."PH value Method")
                {
                    ApplicationArea = All;
                }
                field("PH value Unit"; Rec."PH value Unit")
                {
                    ApplicationArea = All;
                }
                field("PH value Specification"; Rec."PH value Specification")
                {
                    ApplicationArea = All;
                }
                field("Total viable count Method"; Rec."Total viable count Method")
                {
                    ApplicationArea = All;
                }
                field("Total viable count Unit"; Rec."Total viable count Unit")
                {
                    ApplicationArea = All;
                }
                field("Total viable count Spec"; Rec."Total viable count Spec")
                {
                    ApplicationArea = All;
                }
                field("Yeast and mould count Method"; Rec."Yeast and mould count Method")
                {
                    ApplicationArea = All;
                }
                field("Yeast and mould count Unit"; Rec."Yeast and mould count Unit")
                {
                    ApplicationArea = All;
                }
                field("Yeast and mould count Spec"; Rec."Yeast and mould count Spec")
                {
                    ApplicationArea = All;
                }
                field("Lather volume Method"; Rec."Lather volume Method")
                {
                    ApplicationArea = All;
                }
                field("Lather volume Unit"; Rec."Lather volume Unit")
                {
                    ApplicationArea = All;
                }
                field("Lather volume Spec"; Rec."Lather volume Spec")
                {
                    ApplicationArea = All;
                }
                field("Spec gravity at 20⁰C Method"; Rec."Spec gravity at 20⁰C Method")
                {
                    ApplicationArea = All;
                }
                field("Spec gravity at 20⁰C Unit"; Rec."Spec gravity at 20⁰C Unit")
                {
                    ApplicationArea = All;
                }
                field("Spec gravity at 20⁰C-Spec"; Rec."Spec gravity at 20⁰C-Spec")
                {
                    ApplicationArea = All;
                }


            }
        }

    }

    actions
    {

    }

    trigger OnOpenPage()
    begin
        ViewLabel := 'View';
        RefreshUIControls();
    end;

    trigger OnAfterGetRecord()
    begin
        RefreshUIControls();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RefreshUIControls();
    end;

    var
        FinishedGoods: Label 'FINISHED', Locked = true;
        PackagingMaterialsGoods: Label 'PACKAGING MATERIALS', Locked = true;
        RawMaterialsGoods: Label 'RAW MATERIALS', Locked = true;
        ShowFinished: Boolean;
        ShowPackaging: Boolean;
        ShowRawMaterial: Boolean;
        ViewLabel: Text[100];
        ShowInvoiceDetails: Boolean;

    local procedure RefreshUIControls()
    begin
        ShowFinished := false;
        ShowPackaging := false;
        ShowRawMaterial := false;

        case Rec."Inventory Posting Group" of

            FinishedGoods:
                ShowFinished := true;

            RawMaterialsGoods:
                ShowRawMaterial := true;

            PackagingMaterialsGoods:
                ShowPackaging := true;

        end;
    end;
}