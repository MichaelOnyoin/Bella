table 50081 "Item Sales Target Entry"
{
    Caption = 'Item Sales Target Entry';
    TableType = Temporary;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No." where("Inventory Posting Group" = const('FINISHED'));
            NotBlank = true;

            trigger OnValidate()
            var
                ItemRec: Record Item;
            begin
                if ItemRec.Get("Item No.") then
                    "Item Description" := ItemRec.Description
                else
                    "Item Description" := '';
            end;
        }
        field(2; "Item Description"; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(3; "Sales Target Qty"; Decimal)
        {
            Caption = 'Sales Target Qty';
            MinValue = 1;
            InitValue = 1;
        }
    }

    keys
    {
        key(PK; "Item No.") { Clustered = true; }
    }
}