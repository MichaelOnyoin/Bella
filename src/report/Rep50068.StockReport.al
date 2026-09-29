report 50068 "Stock Report"
{
    ApplicationArea = All;
    Caption = 'Stock Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Inventory Poating Group", "Location Code", "Item No.";
            DataItemTableView = where(Open = filter(true));
            column(ItemNo_ItemLedgerEntry; "Item No.")
            {
            }
            column(ItemDescription_ItemLedgerEntry; "Item Description")
            {
            }
            column(LocationCode_ItemLedgerEntry; "Location Code")
            {
            }
            column(RemainingQuantity_ItemLedgerEntry; "Remaining Quantity")
            {
            }
            column(Open_ItemLedgerEntry; Open)
            {
            }
            column(LotNo_ItemLedgerEntry; "Lot No.")
            {
            }
            column(ExpirationDate_ItemLedgerEntry; "Expiration Date")
            {
            }
            column(InventoryPoatingGroup_ItemLedgerEntry; "Inventory Poating Group")
            {
            }
            column(PostingDate_ItemLedgerEntry; "Posting Date")
            {
            }
            Column(Company_Name; CompanyInfo.Name) { }
            Column(Company_Address; CompanyInfo.Address) { }
            Column(Company_PhoneNo; CompanyInfo."Phone No.") { }
            Column(Company_Picture; CompanyInfo.Picture) { }
            Column(Company_Email; CompanyInfo."E-Mail") { }
            Column(Company_HomePage; CompanyInfo."Home Page") { }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
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
            }
        }
    }
    var
        Companyinfo: Record "Company Information";

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;
}
