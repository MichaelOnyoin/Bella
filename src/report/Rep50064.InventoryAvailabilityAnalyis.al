report 50064 "Inventory Availability Analyis"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Inven Availability Analysis.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Inventory Posting Group";
            column(No_; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(Qty__on_Prod__Order; "Qty. on Prod. Order")
            {
            }
            column(Qty__on_Purch__Order; "Qty. on Purch. Order")
            {
            }
            column(Qty__on_Component_Lines; "Qty. on Component Lines")
            {
            }
            column(Qty__on_Sales_Order; "Qty. on Sales Order")
            {
            }
            column(Qty__on_Service_Order; "Qty. on Service Order")
            {
            }
            column(Qty__on_Job_Order; "Qty. on Job Order")
            {
            }
            column(Qty__on_Assembly_Order; "Qty. on Assembly Order")
            {
            }
            column(Qty__on_Asm__Component; "Qty. on Asm. Component")
            {
            }
            column(Qty__on_Sales_Return; "Qty. on Sales Return")
            {
            }
            column(TotalAllocatedQty; TotalAllocatedQty)
            {
            }
            column(RemainingQty; RemainingQty)
            {
            }
            Column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            Column(CompanyInfo_Address_2; CompanyInfo."Address 2")
            {
            }
            Column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            Column(CompanyInfo_Phone_No_; CompanyInfo."Phone No.")
            {
            }
            Column(CompanyInfo_E_Mail; CompanyInfo."E-Mail")
            {
            }
            Column(CompanyInfo_Home_Page; CompanyInfo."Home Page")
            {
            }
            Column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(companyInfo; companyInfo.Name)
            {
            }

            trigger OnAfterGetRecord()
            var
                Item: Record Item;
                q1: Decimal;
                q2: Decimal;
                q3: Decimal;
                q4: Decimal;
                q5: Decimal;
                q6: Decimal;

            begin
                Item.Reset();
                Item.SetRange(Item."No.", "No.");
                if Item.FindFirst() then begin
                    Item.CalcFields(Inventory);
                    Item.CalcFields("Qty. on Sales Order");
                    Item.CalcFields("Qty. on Purch. Order");
                    Item.CalcFields("Qty. on Prod. Order");
                    Item.CalcFields("Qty. on Component Lines");
                    Item.CalcFields("Qty. on Sales Return");
                    q1 := Item."Qty. on Sales Order";
                    q2 := Item."Qty. on Purch. Order";
                    q3 := item."Qty. on Prod. Order";
                    q4 := Item."Qty. on Component Lines";
                    q5 := Item."Qty. on Sales Return";
                    q6 := Item.Inventory;
                    TotalAllocatedQty := q1 + q2 + q3 + q4;
                    Inventory2 := q6;

                    RemainingQty := Inventory2 - TotalAllocatedQty;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        TotalAllocatedQty: Decimal;
        RemainingQty: Decimal;
        Inventory2: Decimal;
        companyInfo: Record "Company Information";

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;
}