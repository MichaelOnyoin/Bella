page 50082 "Firming"
{
    PageType = Card;
    Caption = 'Firming';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(Instructions)
            {
                Caption = 'Firming';
                InstructionalText = 'Click "Enter Targets & Run" below to enter your item sales targets and run the report.';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(EnterTargetsAndRun)
            {
                ApplicationArea = All;
                Caption = 'Enter Targets && Run';
                Image = Report;
                ToolTip = 'Enter item sales targets then run the Firming report.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"Run BOM Report With Targets");
                end;
            }
        }
    }
}