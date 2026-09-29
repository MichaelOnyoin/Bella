enum 50000 "Material Requisition Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; "Pending Approval")
    {

        Caption = 'Pending Approval';
    }
    value(2; Released)
    {
        Caption = 'Released';
    }
    value(3; Canceled)
    {
        Caption = 'Canceled';
    }
    value(4; Rejected)
    {
        Caption = 'Rejected';
    }
    value(5; Closed)
    {
        Caption = 'Closed';
    }
}
