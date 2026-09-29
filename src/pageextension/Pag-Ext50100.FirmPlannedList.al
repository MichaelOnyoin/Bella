pageextension 50100 "Firm Planned List" extends "Firm Planned Prod. Orders"
{
    layout
    {

    }
    actions
    {
        modify(ProdOrderMaterialRequisition)
        {
            Visible = false;
            Enabled = false;
        }
    }

}
