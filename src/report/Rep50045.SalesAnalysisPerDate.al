report 50045 "Sales Analysis-Per Date"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesAnalysis-PerDate.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Customer Posting Group";
            column("Customer_No"; "No.")
            {
                IncludeCaption = true;
            }
            column(Name; Name)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = Customer;
                DataItemLink = "Sell-to Customer No." = field("No.");
                RequestFilterFields = "SALESPERSON CODE", "Posting Date";
                column(Document_No_; "Document No.")
                {
                }
                column(Sell_to_Customer_No; "Sell-to Customer No.")
                {
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(Item_No; "No.")
                {
                }
                column(Item_Description; Description)
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Quantity_Invoiced; "Quantity (Base)")
                {
                }
                column(SALESPERSON_CODE; "SALESPERSON CODE")
                {
                }
                column(Unit_Price_ExclVAT; "Unit Price")
                {
                }
                column(Amount_ExclVAT; Amount)
                {
                }
                column(Amount_Including_VAT; "Amount Including VAT")
                {
                }
            }
        }
    }

    requestpage
    {
        SaveValues = true;
        Caption = 'Customer Sales Analysis-Per Date';
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

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;
}