page 50084 "FG Items Where Used"
{
    Caption = 'FG Item List';
    DataCaptionExpression = SetCaption;
    PageType = Worksheet;
    SourceTable = "Where-Used Line";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(CalculateDate; CalculateDate)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Calculation Date';
                    ToolTip = 'Specifies the date for which you want to show the where-used lines.';
                    trigger OnValidate()
                    begin
                        BuildForm();
                        CurrPage.Update(false);
                    end;
                }
                field(ShowLevel; ShowLevel)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Levels';
                    OptionCaption = 'Multi,Single';
                    ToolTip = 'Specifies the level of detail for the where-used lines.';
                    trigger OnValidate()
                    begin
                        BuildForm();
                        CurrPage.Update(false);
                    end;
                }
            }
            repeater(Control1)
            {
                Editable = false;
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                ShowCaption = false;
                field("Item No."; Rec."Item No.") { ApplicationArea = Manufacturing; }
                field("Version Code"; Rec."Version Code") { ApplicationArea = Manufacturing; }
                field(Description; Rec.Description) { ApplicationArea = Manufacturing; }
                field("Quantity Needed"; Rec."Quantity Needed") { ApplicationArea = Manufacturing; }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DescriptionIndent := Rec."Level Code" - 1;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(WhereUsedMgt.FindRecord(Which, Rec));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        exit(WhereUsedMgt.NextRecord(Steps, Rec));
    end;

    trigger OnOpenPage()
    begin
        BuildForm();
    end;

    var
        Item: Record Item;
        ProdBOM: Record "Production BOM Header";
        WhereUsedMgt: Codeunit "Where-Used Management";
        ShowLevel: Option Multi,Single;
        CalculateDate: Date;
        DescriptionIndent: Integer;

    procedure SetItem(NewItem: Record Item; NewCalcDate: Date)
    begin
        Item := NewItem;
        CalculateDate := NewCalcDate;
    end;

    procedure SetProdBOM(NewProdBOM: Record "Production BOM Header"; NewCalcDate: Date)
    begin
        ProdBOM := NewProdBOM;
        CalculateDate := NewCalcDate;
    end;

    local procedure BuildForm()
    var
        FilterItem: Record Item;
    begin
        if ProdBOM."No." <> '' then
            WhereUsedMgt.WhereUsedFromProdBOM(ProdBOM, CalculateDate, ShowLevel = ShowLevel::Multi)
        else
            WhereUsedMgt.WhereUsedFromItem(Item, CalculateDate, ShowLevel = ShowLevel::Multi);

        // Remove non-FINISHED items from temp table
        Rec.Reset();
        if Rec.FindSet() then
            repeat
                if FilterItem.Get(Rec."Item No.") then begin
                    if FilterItem."Inventory Posting Group" <> 'FINISHED' then
                        Rec.Delete();
                end else
                    Rec.Delete();
            until Rec.Next() = 0;
    end;

    procedure SetCaption(): Text
    begin
        if ProdBOM."No." <> '' then
            exit(ProdBOM."No." + ' ' + ProdBOM.Description);
        exit(Item."No." + ' ' + Item.Description);
    end;
}