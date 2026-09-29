tableextension 50015 "Sales Invoice Line Ext" extends "Sales Invoice Line"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "Resource No."; Code[50])
        {
            TableRelation = Resource."No." WHERE(Type = FILTER(Person));
        }
        field(50800; "Booking No."; Code[30])
        {
        }
        field(50010; "Line Profit"; Decimal)
        {
        }
        field(50015; "Line Deduction"; Decimal)
        {
        }
        field(50065; "Sales Unit Price"; Decimal)
        {
        }
        field(50075; "Sub Total"; Decimal)
        {
        }
        field(65100; "Sale Time"; Time)
        {
        }
        field(65200; "Available Quantities"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD(UPPERLIMIT("No.")), "Location Code" = FIELD("Location Code")));
        }
        field(65300; "SALESPERSON CODE"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = CustomerContent;
        }
        field(65310; "DEPARTMENT"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = CustomerContent;
        }
    }
}
