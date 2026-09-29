page 50029 "Production Order Details"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Prod. Order Component";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Production Details")
            {
                field("Finished Date"; Rec."Finished Date")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")               
                {
                      Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the related production order.';
                }
                field(Status; Rec.Status)
                {
                     Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the production order to which the component list belongs.';
                }
                field("OutPut Item No."; Rec."OutPut Item No.")
                {
                     Visible = true;
                    ApplicationArea = All;
                }
                field("Output Item Name"; Rec."Output Item Name")
                {
                     Visible = true;
                    ApplicationArea = All;
                }
                field("Output Qty"; Rec."Output Qty")
                {
                     Visible = true;
                    ApplicationArea = All;
                }
                field("Standartd Cost"; Rec."Standartd Cost")
                {
                     Visible = true;
                    ApplicationArea = All;
                }
                field("BOM No."; Rec."BOM No.")
                {
                     Visible = true;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                     Visible = true;
                    ApplicationArea = All;
                    Caption = 'Raw. Material No.';
                    ToolTip = 'Specifies the number of the item that is a component in the production order component list.';
                }
                field(Description; Rec.Description)
                {
                     Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the item that is a component on the line.';
                }
                field("Quantity per"; Rec."Quantity per")
                {
                     Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the component are required to produce the parent item.';
                }
                field("Expected Quantity"; Rec."Expected Quantity")
                {
                     Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of the component expected to be consumed during the production of the quantity on this line.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                     Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                     Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total cost on the line by multiplying the unit cost by the Expected Quantity.';
                    Caption = 'Cost Amount Expected';
                }
                field("Act. Consumption (Qty)"; Rec."Act. Consumption (Qty)")
                {
                     Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of the component consumed during the production of the quantity on this line.';
                }
                // field("Actual Cost"; "Actual Cost")
                // {
                // }
                field(ActualCost2; ActualCost2)
                {
                     Visible = true;
                    ApplicationArea = All;                   
                    Caption = 'Cost Amount Actual';
                }
                field(VarUnits; VarUnits)
                {
                    ApplicationArea = all;
                    Caption = 'Var Units';
                }
                field("Over Fill"; Rec."Over Fill")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Over Fill field.', Comment = '%';
                }
                field("Under Fill"; Rec."Under Fill")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Under Fill field.', Comment = '%';
                }
                field("QC Samoples"; Rec."QC Samoples")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the QC Samoples field.', Comment = '%';
                }
                field("Machine Damage"; Rec."Machine Damage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Machine Damage field.', Comment = '%';
                }
                // field(varCost; varCost)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Var Cost';
                // }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var

    begin
        //Rec.Reset();
        Rec.CalcFields("Act. Consumption (Qty)");
        ActualCost2 := Rec."Act. Consumption (Qty)" * Rec."Unit Cost";
        VarUnits := Rec."Act. Consumption (Qty)" - Rec."Expected Quantity";
        // varCost := VarUnits * Rec."Unit Cost";

        //end;
    end;

    var
        ActualCost2: Decimal;
        VarUnits: Decimal;
}