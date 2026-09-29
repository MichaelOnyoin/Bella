report 50071 "Excise Duty"
{
    ApplicationArea = All;
    Caption = 'Excise Duty Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './ExciseDuty.rdl';

    dataset
    {
        dataitem(SalesInvoiceLine; "Sales Invoice Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.");
            RequestFilterHeading = 'Sales Invoice Line';
            RequestFilterFields = "Posting Date";
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(UnitPrice; "Unit Price")
            {
            }
            column(Amount; Amount)
            {
            }
            column(PostingDate; Format("Posting Date"))
            {
            }
            column(UnitofMeasureCode; "Unit of Measure Code")
            {
            }
            column(ASLEFRISLineAmtExclExcise; "ASL.EFRIS.LineAmtExcl.Excise")
            {
            }
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}