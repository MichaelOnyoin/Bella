page 50010 "User Location"
{
    Caption = 'User Location';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "User Locations";
    Permissions = tabledata "Item Ledger Entry" = RIMD, tabledata "Value Entry" = RIMD;
    // DelayedInsert = true;
    // MultipleNewLines = true;
    // LinksAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                Field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                Field("Location Name"; "Location Name")
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
                var
                    ItemLedger: Record "Item Ledger Entry";

                begin

                    ItemLedger.Get(4836);
                    ItemLedger.Validate("Sales Amount (Actual)", -1763997134.4);
                    ItemLedger.Modify();

                    ItemLedger.Get(4835);
                    ItemLedger.Validate("Sales Amount (Actual)", -1975676791);
                    ItemLedger.Modify();

                    ItemLedger.Get(4834);
                    ItemLedger.Validate("Sales Amount (Actual)", -1175998090);
                    ItemLedger.Modify();

                    ItemLedger.Get(4833);
                    ItemLedger.Validate("Sales Amount (Actual)", -1283797914);
                    ItemLedger.Modify();

                    ItemLedger.Get(4832);
                    ItemLedger.Validate("Sales Amount (Actual)", -1283797914);
                    ItemLedger.Modify();

                    ItemLedger.Get(4831);
                    ItemLedger.Validate("Sales Amount (Actual)", -1283797914);
                    ItemLedger.Modify();

                    ItemLedger.Get(4830);
                    ItemLedger.Validate("Sales Amount (Actual)", -1283797914);
                    ItemLedger.Modify();

                    ItemLedger.Get(4829);
                    ItemLedger.Validate("Sales Amount (Actual)", -1283797914);
                    ItemLedger.Modify();

                    ItemLedger.Get(4828);
                    ItemLedger.Validate("Sales Amount (Actual)", -2043296681);
                    ItemLedger.Modify();

                    ItemLedger.Get(4827);
                    ItemLedger.Validate("Sales Amount (Actual)", -2043296681);
                    ItemLedger.Modify();

                    ItemLedger.Get(4826);
                    ItemLedger.Validate("Sales Amount (Actual)", -2043296681);
                    ItemLedger.Modify();

                    ItemLedger.Get(4825);
                    ItemLedger.Validate("Sales Amount (Actual)", -2043296681);
                    ItemLedger.Modify();

                    ItemLedger.Get(4824);
                    ItemLedger.Validate("Sales Amount (Actual)", -2043296681);
                    ItemLedger.Modify();

                    ItemLedger.Get(4823);
                    ItemLedger.Validate("Sales Amount (Actual)", -1430797676);
                    ItemLedger.Modify();

                    ItemLedger.Get(4822);
                    ItemLedger.Validate("Sales Amount (Actual)", -1430797676);
                    ItemLedger.Modify();

                    ItemLedger.Get(4821);
                    ItemLedger.Validate("Sales Amount (Actual)", -1430797676);
                    ItemLedger.Modify();

                    ItemLedger.Get(4820);
                    ItemLedger.Validate("Sales Amount (Actual)", -1430797676);
                    ItemLedger.Modify();

                    ItemLedger.Get(4819);
                    ItemLedger.Validate("Sales Amount (Actual)", -1430797676);
                    ItemLedger.Modify();

                    ItemLedger.Get(4818);
                    ItemLedger.Validate("Sales Amount (Actual)", -1387677746);
                    ItemLedger.Modify();

                    ItemLedger.Get(4817);
                    ItemLedger.Validate("Sales Amount (Actual)", -1567997453);
                    ItemLedger.Modify();

                    ItemLedger.Get(4816);
                    ItemLedger.Validate("Sales Amount (Actual)", -1685597262);
                    ItemLedger.Modify();

                    ItemLedger.Get(4815);
                    ItemLedger.Validate("Sales Amount (Actual)", -2126596545);
                    ItemLedger.Modify();

                    ItemLedger.Get(4814);
                    ItemLedger.Validate("Sales Amount (Actual)", -1799432121);
                    ItemLedger.Modify();

                    ItemLedger.Get(4813);
                    ItemLedger.Validate("Sales Amount (Actual)", -2876323012.0);
                    ItemLedger.Modify();

                    ItemLedger.Get(4812);
                    ItemLedger.Validate("Sales Amount (Actual)", -1618173371);
                    ItemLedger.Modify();

                    ItemLedger.Get(4811);
                    ItemLedger.Validate("Sales Amount (Actual)", -1034878319);
                    ItemLedger.Modify();

                    ItemLedger.Get(4810);
                    ItemLedger.Validate("Sales Amount (Actual)", -1246557975);
                    ItemLedger.Modify();

                    ItemLedger.Get(4809);
                    ItemLedger.Validate("Sales Amount (Actual)", -176838221.9);
                    ItemLedger.Modify();
                    // ItemLedger.Get(818);
                    // ItemLedger.Validate("Invoiced Quantity", 728);
                    // ItemLedger.Validate("Completely Invoiced", true);
                    // ItemLedger.Modify();

                    // ItemLedger.Get(824);
                    // ItemLedger.Validate("Invoiced Quantity", 632);
                    // ItemLedger.Validate("Completely Invoiced", true);
                    // ItemLedger.Modify();

                    // ValueEnt.Get(1136);
                    // ValueEnt.Validate("Invoiced Quantity", 728);
                    // ValueEnt.Modify();

                    // ValueEnt.Get(1142);
                    // ValueEnt.Validate("Invoiced Quantity", 632);
                    // ValueEnt.Modify();

                    // ItemLedger.Get(813);
                    // ItemLedger.Validate("Invoiced Quantity", 717);
                    // ItemLedger.Validate("Completely Invoiced", true);
                    // ItemLedger.Modify();

                    // ValueEnt.Get(1131);
                    // ValueEnt.Validate("Invoiced Quantity", 717);
                    // ValueEnt.Modify();

                    // ItemLedger.Get(1611);
                    // ItemLedger.Validate("Invoiced Quantity", 11074);
                    // ItemLedger.Validate("Completely Invoiced", true);
                    // ItemLedger.Modify();

                    // ValueEnt.Get(1985);
                    // ValueEnt.Validate("Invoiced Quantity", 11074);
                    // ValueEnt.Modify();

                    // ItemLedger.Get(808);
                    // ItemLedger.Validate("Invoiced Quantity", 2813);
                    // ItemLedger.Validate("Completely Invoiced", true);
                    // ItemLedger.Modify();

                    // ValueEnt.Get(1126);
                    // ValueEnt.Validate("Invoiced Quantity", 2813);
                    // ValueEnt.Modify();

                    // ItemLedger.Get(264);
                    // ItemLedger.Validate("Invoiced Quantity", 4880);
                    // ItemLedger.Validate("Completely Invoiced", true);
                    // ItemLedger.Modify();

                    // ValueEnt.Get(324);
                    // ValueEnt.Validate("Invoiced Quantity", 4880);
                    // ValueEnt.Modify();

                    // ItemLedger.Get(457);
                    // ItemLedger.Validate("Invoiced Quantity", 1766);
                    // ItemLedger.Validate("Completely Invoiced", true);
                    // ItemLedger.Modify();

                    // ValueEnt.Get(558);
                    // ValueEnt.Validate("Invoiced Quantity", 1766);
                    // ValueEnt.Modify();

                    // ItemLedger.Get(469);
                    // ItemLedger.Validate("Invoiced Quantity", 1339);
                    // ItemLedger.Validate("Completely Invoiced", true);
                    // ItemLedger.Modify();

                    // ValueEnt.Get(602);
                    // ValueEnt.Validate("Invoiced Quantity", 1339);
                    // ValueEnt.Modify();
                end;
            }
        }
    }
}