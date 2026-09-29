page 50028 "COA ListPage"
{
    ApplicationArea = Basic, suite, service;
    //Caption = 'Cartificate of Analysis';
    CardPageID = "COA CardPage";
    Editable = false;
    PageType = List;
    // QueryCategory = 'KPI List';
    RefreshOnActivate = true;
    UsageCategory = Lists;
    SourceTable = "Certificate of Analysis";
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                }
                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                }
                field("AR No."; Rec."AR No.")
                {
                    ApplicationArea = All;
                }
                field("Formaulation Number"; Rec."Formaulation Number")
                {
                }
                field("Batch No"; Rec."Batch No")
                {
                    ApplicationArea = All;
                }
                field(Machine; Rec.Machine)
                {
                    ApplicationArea = All;
                }
                field("Batch Size"; Rec."Batch Size")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                end;
            }
        }
    }
}