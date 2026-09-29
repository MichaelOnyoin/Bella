table 50008 "Material Requisition Line"
{
    Caption = 'Material Requisition Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Requisition No."; Code[20])
        {
            Caption = 'Requisition No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(6; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            trigger OnValidate()
            begin
                SetItemDefaults();
            end;
        }
        field(7; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(8; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            Editable = true;
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                TestField("Item No.");
                if "Location Code" <> '' then
                    Item.TestField(Type, Item.Type::Inventory);
            end;
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0:4;
        }
        field(10; "Unit of Measure"; Code[20])
        {
            TableRelation = "Unit of Measure".Code;
            DataClassification = ToBeClassified;
        }
        field(11; "Unit Amount"; Decimal)
        {
            Caption = 'Unit Amount';
        }
        field(12; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(14; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            Editable = false;
        }
        field(15; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            Editable = false;
        }
        field(16; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";
            Editable = false;
        }
        field(17; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
            Editable = false;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(481; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(482; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(483; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(484; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(6)));
        }
        field(485; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(7)));
        }
        field(486; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(8)));
        }
        field(7010; "Attached Doc Count"; Integer)
        {
            BlankNumbers = DontBlank;
            CalcFormula = Count("Document Attachment" WHERE("Table ID" = CONST(70616007),
                                                             "No." = FIELD("Requisition No."),
                                                             "Line No." = FIELD("Line No.")));
            Caption = 'Attached Doc Count';
            FieldClass = FlowField;
            InitValue = 0;
        }
    }

    keys
    {
        key(PK; "Requisition No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        MaterialRequisitionHeader.Get("Requisition No.");

        if "Document Date" = 0D then
            "Document Date" := MaterialRequisitionHeader."Document Date";
        if "Posting Date" = 0D then
            "Posting Date" := MaterialRequisitionHeader."Posting Date";
        "Gen. Bus. Posting Group" := MaterialRequisitionHeader.Department;
        if "Item No." <> '' then
            "Location Code":=MaterialRequisitionHeader."Location Code";
        "Journal Template Name":=MaterialRequisitionHeader."Journal Template Name";
        "Journal Batch Name":=MaterialRequisitionHeader."Journal Batch Name";    
    end;

    local procedure GetGLSetup()
    begin
        if not GotGLSetup then begin
            GLSetup.Get();
            GotGLSetup := true;
        end;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode, IsHandled);
        if IsHandled then
            exit;

        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    end;

    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeShowDimensions(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('Material Requisition %2 %3', "Requisition No.", "Line No."));

        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IsChanged := OldDimSetID <> "Dimension Set ID";

        OnAfterShowDimensions(Rec, xRec);
    end;

    procedure SetItemDefaults()
    var
        Item: Record Item;
        DefaultDim: Record "Default Dimension";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        if Item.Get(Rec."Item No.") then begin
            Rec.Description := Item.Description;
            Rec."Unit of Measure" := Item."Base Unit of Measure";
            Rec."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
            Rec.Quantity := 1;
            Rec."Unit Cost" := Item."Unit Cost";
            DefaultDim.SetRange("Table ID", DATABASE::Item);
            DefaultDim.SetRange("No.", Rec."Item No.");
            if DefaultDim.FindSet() then begin
                repeat
                    case DefaultDim."Dimension Code" of
                        'D1':
                            Rec."Shortcut Dimension 1 Code" := DefaultDim."Dimension Value Code";
                        'D2':
                            Rec."Shortcut Dimension 2 Code" := DefaultDim."Dimension Value Code";
                        'D3':
                            Rec."Shortcut Dimension 3 Code" := DefaultDim."Dimension Value Code";
                        'D4':
                            Rec."Shortcut Dimension 4 Code" := DefaultDim."Dimension Value Code";
                        'D5':
                            Rec."Shortcut Dimension 5 Code" := DefaultDim."Dimension Value Code";
                        'D6':
                            Rec."Shortcut Dimension 6 Code" := DefaultDim."Dimension Value Code";
                        'D7':
                            Rec."Shortcut Dimension 7 Code" := DefaultDim."Dimension Value Code";
                        'D8':
                            Rec."Shortcut Dimension 8 Code" := DefaultDim."Dimension Value Code";
                    end;
                until DefaultDim.Next() = 0;
            end;
            ItemUnitOfMeasure.SetRange("Item No.", Rec."Item No.");
            if ItemUnitOfMeasure.FindSet() then begin
            end;
            Rec.Amount := Rec.Quantity * Rec."Unit Cost";
        end;
    end;

    procedure SelectActiveItems(): Text
    var
        Item: Record Item;
    begin
        Item.SetRange("Sales Blocked", false);
        exit(SelectInItemList(Item));
    end;

    procedure SelectInItemList(var Item: Record Item): Text
    var
        ItemListPage: Page "Item List";
    begin
        Item.SetRange(Blocked, false);
        // Item.SetFilter("Inventory Posting Group", '%1', 'FINISHED');
        ItemListPage.SetTableView(Item);
        ItemListPage.LookupMode(true);
        if ItemListPage.RunModal = ACTION::LookupOK then
            exit(ItemListPage.GetSelectionFilter);
    end;

    procedure SelectMultipleItems()
    var
        SelectionFilter: Text;
    begin
        OnBeforeSelectMultipleItems(Rec);
        SelectionFilter := SelectActiveItems();
        
        if SelectionFilter <> '' then
            AddItems(SelectionFilter);
        OnAfterSelectMultipleItems(Rec);
    end;

    procedure AddItems(SelectionFilter: Text)
    var
        Item: Record Item;
        MaterialReqLine: Record "Material Requisition Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeAddItems(Rec, SelectionFilter, IsHandled);
        if IsHandled then
            exit;

        InitNewLine(MaterialReqLine);
        Item.SetFilter("No.", SelectionFilter);
        if Item.FindSet() then
            repeat
                AddItem(MaterialReqLine, Item."No.");
            until Item.Next() = 0;
    end;

    procedure AddItem(var MaterialReqLine: Record "Material Requisition Line"; ItemNo: Code[20])
    begin
        MaterialReqLine.Init();
        MaterialReqLine."Line No." += 10000;
        MaterialReqLine.Validate("Item No.", ItemNo);
        MaterialReqLine.Insert(true);

        ProcessMaterialRequisitionLine(MaterialReqLine);
    end;

    procedure ProcessMaterialRequisitionLine(var MaterialReqLine: Record "Material Requisition Line")
    var
        LastMaterialReqLine: Record "Material Requisition Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeProcessMaterialRequisitionLine(MaterialReqLine, IsHandled);
        if not IsHandled then begin
            
        end;

        OnAfterAddItem(MaterialReqLine, LastMaterialReqLine);
    end;

    procedure InitNewLine(var NewMaterialReqLine: Record "Material Requisition Line")
    var
        MaterialReqLine: Record "Material Requisition Line";
    begin
        NewMaterialReqLine.Copy(Rec);
        MaterialReqLine.SetRange("Requisition No.", Rec."Requisition No.");
        if MaterialReqLine.FindLast() then
            NewMaterialReqLine."Line No." := MaterialReqLine."Line No." + 10000
        else
            NewMaterialReqLine."Line No." := 10000;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateShortcutDimCode(var MaterialRequisitionLine: Record "Material Requisition Line"; var "; var xMaterialRequisitionLine: Record ": Record "Material Requisition Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShortcutDimCode(var MaterialRequisitionLine: Record "Material Requisition Line"; var "; var xMaterialRequisitionLine: Record ": Record "Material Requisition Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowDimensions(var MaterialRequisitionLine: Record "Material Requisition Line"; xMaterialRequisitionLine: Record "Material Requisition Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterShowDimensions(var MaterialRequisitionLine: Record "Material Requisition Line"; xMaterialRequisitionLine: Record "Material Requisition Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSelectMultipleItems(var MaterialReqLine: Record "Material Requisition Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSelectMultipleItems(var MaterialReqLine: Record "Material Requisition Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAddItems(var MaterialReqLine: Record "Material Requisition Line"; SelectionFilter: Text; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAddItem(var MaterialReqLine: Record "Material Requisition Line"; LastMaterialReqLine: Record "Material Requisition Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeProcessMaterialRequisitionLine(var MaterialReqLine: Record "Material Requisition Line"; var IsHandled: Boolean)
    begin
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        MaterialRequisitionHeader: Record "Material Requisition Header";
        GLSetup: Record "General Ledger Setup";
        GotGLSetup: Boolean;
}
