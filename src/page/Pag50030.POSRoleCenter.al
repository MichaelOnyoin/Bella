page 50030 "POS Role Center"
{
    Caption = 'POS Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Headline; "Headline RC Business Manager")
            {
                ApplicationArea = Basic, Suit;
            }
        }
    }
    actions
    {
        area(Sections)
        {
            group("Point of Sale")
            {
                action("Cash Sales")
                {
                    ApplicationArea = All;
                    RunObject = page "ASL.POS.CashSale";
                }
            }
        }
    }
}
