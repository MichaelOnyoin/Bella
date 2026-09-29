report 50058 "Vendor Statement"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Permissions = tabledata "Vendor Ledger Entry" = rimd;
    RDLCLayout = 'Vendor Statement.rdlc';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Vendor No.", "Posting Date";
            DataItemTableView = where(Open = filter(true), "Document Type" = filter('Invoice'));
            column(Posting_Date; "Posting Date") { }
            column(Document_Type; "Document Type") { }
            column(Document_No_; "Document No.") { }
            column(Vendor_No_; "Vendor No.") { }
            column(Vendor_Name; "Vendor Name") { }
            column(Vendor_Name_; "Vendor Name.") { }
            column(Original_Amount; "Original Amount") { }
            column(Remaining_Amount; "Remaining Amount") { }
            column(Currency_Code; "Currency Code") { }
            column(PrintVendorPerPage; PrintVendorPerPage) { }
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
            area(Content)
            {
                group(Options)
                {
                    field(PrintVendorPerPage; PrintVendorPerPage)
                    {
                        ApplicationArea = Basic, Suite;
                    }
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
        Companyinfo: Record "Company Information";
        PrintVendorPerPage: Boolean;

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    procedure InitializeRequest(NewPagePerCustomer: Boolean)
    begin
        PrintVendorPerPage := NewPagePerCustomer;
    end;
}