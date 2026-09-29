query 50000 "Commitments Encumberances"
{
    QueryType = Normal;

    elements
    {
        dataitem(PurchaseLine; "Purchase Line")
        {
            column(DocumentType; "Document Type")
            {
            }
            // filter(FilterName; SourceFieldName)
            // {
            // }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}