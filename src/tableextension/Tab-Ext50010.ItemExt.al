tableextension 50010 "ItemExt" extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Inventory Value"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
            "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"),
            "Lot No." = FIELD("Lot No. Filter"), "Serial No." = FIELD("Serial No. Filter"), "Posting Date" = FIELD("Date Filter")));
        }
        field(50001; "HS Code"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Appearance Method"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Appearance Unit"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(50004; "Appearance Specification"; Code[50])
        {
        }
        field(50005; "Odour Method"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Odour Unit"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(50007; "Odour Specification"; Code[50])
        {
        }
        field(50008; "PH value Method"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "PH value Unit"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(50010; "PH value Specification"; Code[50])
        {
        }
        field(50011; "Total viable count Method"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Total viable count Unit"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(50013; "Total viable count Spec"; Code[50])
        {
        }
        field(50014; "Yeast and mould count Method"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Yeast and mould count Unit"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(50016; "Yeast and mould count Spec"; Code[50])
        {
        }
        field(50017; "Lather volume Method"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Lather volume Unit"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(50019; "Lather volume Spec"; Code[50])
        {
        }
        field(50020; "Spec gravity at 20⁰C Method"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Spec gravity at 20⁰C Unit"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(50022; "Spec gravity at 20⁰C-Spec"; Code[50])
        {
        }
        field(50023; "Consumption Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Entry Type" = const(Consumption)));
            DecimalPlaces = 0 : 5;
        }
        field(50024; "Negative Adjustments"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Entry Type" = const("Negative Adjmt.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50025; "Sales Shipment Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Entry Type" = const(Sale), "Document Type" = const("Sales Shipment")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50026; "Sales Invoice Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Entry Type" = const(Sale), "Document Type" = filter('Sales Shipment|Sales Invoice')));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50027; "Purchase  Return Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Entry Type" = const(Purchase), "Document Type" = const("Purchase Credit Memo")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50028; "Purchase Receipt Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Entry Type" = const(Purchase), "Document Type" = const("Purchase Receipt")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50029; "Positive Adjustment Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Entry Type" = const("Positive Adjmt.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50030; "Production Output Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Entry Type" = const("Output")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50031; "Sales Credit Memo Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Entry Type" = const(Sale), "Document Type" = const("Sales Credit Memo")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50032; "Finished Goods Location"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE(
        "Item No." = FIELD("No."),
        "Location Code" = CONST('FIN-WHS')
        ));
            Editable = false;
        }

        field(50033; "Damages Location"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE(
        "Item No." = FIELD("No."),
        "Location Code" = CONST('DAM-WHS')
        ));
            Editable = false;
        }

        field(50034; "Arena Mall"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE(
        "Item No." = FIELD("No."),
        "Location Code" = CONST('ARENA MALL')
         ));
            Editable = false;
        }

        field(50035; "Popups Location"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE(
        "Item No." = FIELD("No."),
        "Location Code" = CONST('SALES REP1')
        ));
            Editable = false;
        }

        field(50036; "Transactional Locations"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula =
        Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
        "Location Code" = FILTER(
            'SALES REP2|SALES REP3|SALES REP4|SALES REP6|SALESREP5|SALESREP7|SALES REP8|S.MANAGER|EXPORTS'
        )));
            Editable = false;
        }

        field(50037; "Raw Materials Location"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE(
        "Item No." = FIELD("No."),
        "Location Code" = CONST('RM-WHS')
        ));
            Editable = false;
        }
        field(50038; "Packaging Location"; Decimal)
        {
            Caption = 'Packaging Location';
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE(
                "Item No." = FIELD("No."),
                "Location Code" = CONST('PACK-WHS')
            ));
            Editable = false;
        }
        field(50040; "Vendor Count"; Integer)
        {
            Caption = 'Vendors Supplying Item';
            FieldClass = FlowField;
            CalcFormula = Count("Item Vendor" where("Item No." = field("No.")));
            Editable = false;
        }
        field(50041; "Packaging Stock"; Decimal)
        {
            Caption = 'Packaging Stock';
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Location Code" = const('PACK-WHS')));
            Editable = false;
        }
        field(50042; "Export Sales Qty"; Decimal)
        {
            Caption = 'Export Sales Qty';
            FieldClass = FlowField;
            CalcFormula = - Sum("Value Entry"."Invoiced Quantity" WHERE("Item Ledger Entry Type" = CONST(Sale),
                                                                        "Item No." = FIELD("No."),
                                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                        "Location Code" = FIELD("Location Filter"),
                                                                        "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                        "Variant Code" = FIELD("Variant Filter"),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "Gen. Bus. Posting Group" = filter('FOREIGN')));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50043; "Domestic Sales Invoiced Qty"; Decimal)
        {
            Caption = 'Domestic Sales Invoice Qty';
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Entry Type" = const(Sale), "Location Code" = filter('<>EXPORT')));
            Editable = false;
        }
        field(50044; "Export Invoiced Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry"."Invoiced Quantity" where("Item No." = field("No.")));
            Editable = false;
        }
        field(50045; "Negative Adj Sales"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Entry Type" = const("Negative Adjmt.")));
            Editable = false;
        }
        field(50046; "Domestic Sales Qty"; Decimal)
        {
            Caption = 'Domestic Sales Qty';
            FieldClass = FlowField;
            CalcFormula = - Sum("Value Entry"."Invoiced Quantity" WHERE("Item Ledger Entry Type" = CONST(Sale),
                                                                        "Item No." = FIELD("No."),
                                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                        "Location Code" = FIELD("Location Filter"),
                                                                        "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                        "Variant Code" = FIELD("Variant Filter"),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "Gen. Bus. Posting Group" = filter('DOMESTIC|RETAIL-ARENA MALL|COOPERATE|DISTRIBUTION|RETAIL|WHOLESALE')));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }



        field(50047; "Expected Production Output Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Prod. Order Line"."Remaining Quantity"
        where(
            "Item No." = field("No."),
            Status = const(Released)
        ));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }

        field(50048; "No. of Purch. Orders"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Purchase Line" WHERE("Document Type" = CONST(Order),
                                               Type = CONST(Item),
                                               "No." = FIELD("No."),
                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                               "Location Code" = FIELD("Location Filter"),
                                               "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                               "Variant Code" = FIELD("Variant Filter"),
                                               "Expected Receipt Date" = FIELD("Date Filter"),
                                               "Unit of Measure Code" = FIELD("Unit of Measure Filter")));
            Caption = 'No. of Purch. Orders';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50049; "No. of Sales Orders"; Integer)
        {
            CalcFormula = Count("Sales Line" WHERE("Document Type" = CONST(Order),
                                           Type = CONST(Item),
                                           "No." = FIELD("No."),
                                           "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                           "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                           "Location Code" = FIELD("Location Filter"),
                                           "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                           "Variant Code" = FIELD("Variant Filter"),
                                           "Shipment Date" = FIELD("Date Filter"),
                                           "Unit of Measure Code" = FIELD("Unit of Measure Filter")));
            Caption = 'No. of Sales Orders';
            Editable = false;
            FieldClass = FlowField;
        }


        field(50050; "Qty. on Sales Orders"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Quantity (Base)" WHERE("Document Type" = CONST(Order),
                                                                    Type = CONST(Item),
                                                                    "No." = FIELD("No."),
                                                                    "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                    "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                    "Location Code" = FIELD("Location Filter"),
                                                                    "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                    "Variant Code" = FIELD("Variant Filter"),
                                                                    "Shipment Date" = FIELD("Date Filter"),
                                                                    "Unit of Measure Code" = FIELD("Unit of Measure Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }

        field(50051; "Qty. on Purchase Orders"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Quantity (Base)" WHERE("Document Type" = CONST(Order),
                                                                    Type = CONST(Item),
                                                                    "No." = FIELD("No."),
                                                                    "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                    "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                    "Location Code" = FIELD("Location Filter"),
                                                                    "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                    "Variant Code" = FIELD("Variant Filter"),
                                                                    "Expected Receipt Date" = FIELD("Date Filter"),
                                                                    "Unit of Measure Code" = FIELD("Unit of Measure Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }



    }
    fieldgroups
    {
        addlast(DropDown; "Vendor Item No.")
        {
        }
    }
}