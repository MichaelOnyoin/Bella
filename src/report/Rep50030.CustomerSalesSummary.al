report 50030 "CustomerSalesSummary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerSalesSummary.rdl';
    Caption = 'CustomerSalesSummary';
    dataset
    {
        dataitem(ValueEntry; "Value Entry")
        {
            column(DocumentNo; "Document No.")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(InvoicedQuantity; "Invoiced Quantity")
            {
            }
            column(SalesAmountActual; "Sales Amount (Actual)")
            {
            }
            column(SourceNo; "Source No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
        }
        dataitem(SalesInvLine; "Sales Invoice Line")
        {
            column(No_SalesInvLine; "No.")
            {
            }
            column(BilltoCustomerNo_SalesInvLine; "Bill-to Customer No.")
            {
            }
            column(DocumentNo_SalesInvLine; "Document No.")
            {
            }
            column(UnitofMeasure_SalesInvLine; "Unit of Measure")
            {
            }
            column(AmountIncludingVAT_SalesInvLine; "Amount Including VAT")
            {
            }
            column(UnitPrice_SalesInvLine; "Unit Price")
            {
            }
            column(Description_SalesInvLine; Description)
            {
            }
            column(DocumentNoLbl; DocumentNoLbl)
            {
            }
            column(InvoicedQtyLbl; InvoicedQtyLbl)
            {
            }
            column(ItemLbl; ItemLbl)
            {
            }
            column(UnitOfMeasureLbl; UnitOfMeasureLbl)
            {
            }
            column(CustomerNameLbl; CustomerNameLbl)
            {
            }
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
        DocumentNoLbl: Label 'Document No';
        CustomerNameLbl: Label 'Customer';
        ItemLbl: Label 'Item';
        InvoicedQtyLbl: Label 'Quatity';
        UnitOfMeasureLbl: Label 'Unit of Measure';
}
