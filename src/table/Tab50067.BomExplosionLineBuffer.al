table 50067 "BOM Explosion Line Buffer"
{
    TableType = Temporary;
    Caption = 'BOM Explosion Line Buffer';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(3; "Component No."; Code[20])
        {
            Caption = 'Component No.';
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(5; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(6; "Quantity per"; Decimal)
        {
            Caption = 'Quantity per';
        }
        field(7; "Total Quantity"; Decimal)
        {
            Caption = 'Total Quantity';
        }
        field(8; Level; Integer)
        {
            Caption = 'BOM Level';
        }
        field(50079; "Component IPG"; Code[20])
        {
            Caption = 'Component Inventory Posting Group';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Entry No.") { Clustered = true; }
        key(Key2; "Item No.", "Entry No.") { }
    }
}