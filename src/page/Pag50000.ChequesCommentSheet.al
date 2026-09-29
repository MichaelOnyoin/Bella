page 50000 "Cheques Comment Sheet"
{
    AutoSplitKey = true;
    Caption = 'Cheques Comment Sheet';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Cheques Comment Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field';
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine();
    end;
}
