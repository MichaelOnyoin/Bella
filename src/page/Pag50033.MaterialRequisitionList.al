page 50033 "Material Requisition List"
{
    ApplicationArea = All;
    Caption = 'Material Requisition List';
    PageType = List;
    SourceTable = "Material Requisition Header";
    UsageCategory = Lists;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    CardPageId = "Material Requisition";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No. field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field("Transfered To Journals"; Rec."Transfered To Journals")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfered To Journals field.', Comment = '%';
                }
            }
        }
    }
}
