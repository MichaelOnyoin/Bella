report 50057 "Item Cost Tracker"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Item Cost Tracker.rdlc';

    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            RequestFilterFields = "Item No.", "Posting Date", "Item Ledger Entry Type", "Document Type";

            column(ItemNo_ValueEntry; "Item No.")
            {
            }
            column(ItemName; ItemName)
            {
            }
            column(PostingDate_ValueEntry; "Posting Date")
            {
            }
            column(DocumentNo_ValueEntry; "Document No.")
            {
            }
            // column(ItemName_ValueEntry; "Item Name")
            // {
            // }
            column(ItemLedgerEntryType_ValueEntry; "Item Ledger Entry Type")
            {
            }
            column(DocumentType_ValueEntry; "Document Type")
            {
            }
            column(ItemLedgerEntryQuantity_ValueEntry; "Item Ledger Entry Quantity")
            {
            }
            column(InvoicedQuantity_ValueEntry; "Invoiced Quantity")
            {
            }
            column(ValuedQuantity_ValueEntry; "Valued Quantity")
            {
            }
            column(CostperUnit_ValueEntry; "Cost per Unit")
            {
            }
            column(CostAmountActual_ValueEntry; "Cost Amount (Actual)")
            {
            }
            column(CostPostedtoGL_ValueEntry; "Cost Posted to G/L")
            {
            }
            column(CostAmountActualACY_ValueEntry; "Cost Amount (Actual) (ACY)")
            {
            }
            column(CostperUnitACY_ValueEntry; "Cost per Unit (ACY)")
            {
            }
            Column(CompanyInfo_Name; CompanyInfo.Name) { }
            Column(CompanyInfo_Address; CompanyInfo.Address) { }
            Column(CompanyInfo_Address_2; CompanyInfo."Address 2") { }
            Column(CompanyInfo_City; CompanyInfo.City) { }
            Column(CompanyInfo_Phone_No_; CompanyInfo."Phone No.") { }
            Column(CompanyInfo_Fax_No_; CompanyInfo."Fax No.") { }
            Column(CompanyInfo_Home_Page; CompanyInfo."Home Page") { }
            Column(CompanyInfo_E_Mail; CompanyInfo."E-Mail") { }
            Column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_TIN; CompanyInfo."VAT Registration No.") { }

            trigger OnAfterGetRecord()
            var
                Item: Record Item;

            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
                Item.Reset();
                Item.SetRange("No.", "Item No.");
                if Item.FindFirst() then begin
                    ItemName := Item.Description;
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
        CompanyInfo: Record "Company Information";
        ItemName: Text;
}