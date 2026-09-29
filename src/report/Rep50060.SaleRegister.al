Report 50060 "Sale Register"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Daily Sales Register';
    RDLCLayout = './Report Layout/SaleRegister.rdl';

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            RequestFilterFields = "Posting Date", "Sell-to Customer No.", "No.", "Location Code", "Document No.";

            column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
            {
            }
            column(PostingDate_SalesInvoiceLine; Format("Sales Invoice Line"."Posting Date"))
            {
            }
            column(Description; "Sales Invoice Line".Description)
            {
            }
            column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Line_Amnt; LineAmt)
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Line_Discount_Amount; "Sales Invoice Line"."Line Discount Amount")
            {
            }
            column(Inv__Discount_Amount; "Inv. Discount Amount")
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(No_; "No.")
            {
            }
            column(GetCurrencyCode; CurrencyCode)
            {
            }
            column(CusName; CusName)
            {
            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {
            }
            column(VAtAmnt; VAtAmnt)
            {
            }
            column(exciseAmnt; exciseAmnt)
            {
            }
            column(ShowDetails; ShowDetails)
            {
            }
            column(CompanyName; compinfo.Name)
            {
            }
            column(Companyadress; compinfo.Address)
            {
            }
            column(Companyadress2; compinfo."Address 2")
            {
            }
            column(Companypincode; compinfo."Post Code")
            {
            }
            column(Companyphone; compinfo."Phone No.")
            {
            }
            column(Companypicture; compinfo.Picture)
            {
            }
            column(Companycity; compinfo.City)
            {
            }

            trigger OnAfterGetRecord()
            var
                PSI: Record "Sales Invoice Header";
            begin
                compinfo.Get();
                compinfo.CalcFields(Picture);
                if Customer.Get("Sales Invoice Line"."Sell-to Customer No.") then CusName := Customer.Name;
                exciseAmnt := 0;
                VAtAmnt := 0;
                if ("Sales Invoice Line"."No." = '20241') or ("Sales Invoice Line"."No." = '20252') then exciseAmnt := "Sales Invoice Line"."Line Amount";
                If "Sales Invoice Line".GetCurrencyCode() <> '' then
                    CurrencyCode := "Sales Invoice Line".GetCurrencyCode()
                else
                    CurrencyCode := 'UGX';
                VAtAmnt := "Sales Invoice Line"."Amount Including VAT" - "Sales Invoice Line".Amount;
                SaleInvHeader.Reset();
                SaleInvHeader.SetRange("No.", "Sales Invoice Line"."Document No.");
                SaleInvHeader.SetRange("Prices Including VAT", false);
                If SaleInvHeader.FindFirst() then
                    LineAmt := "Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price"
                else
                    LineAmt := "Sales Invoice Line"."VAT Base Amount";
                PSI.Reset();
                PSI.SetRange("No.", "Sales Invoice Line"."Document No.");
                if PSI."Currency Code" <> '' then begin
                    ExchangeRate := 1 / PSI."Currency Factor";
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
                group(Options)
                {
                    field("Show Details"; ShowDetails)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        Customer: Record Customer;
        CusName: Text;
        compinfo: Record 79;
        exciseAmnt: Decimal;
        VAtAmnt: Decimal;
        CurrencyCode: Code[10];
        LineAmt: Decimal;
        SaleInvHeader: Record 112;
        ExchangeRate: Decimal;
        ShowDetails: Boolean;
}
