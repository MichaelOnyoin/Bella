report 50074 "Material Requisition"
{
    ApplicationArea = All;
    Caption = 'Material Requisition';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout=RDLC;
    RDLCLayout='MaterialRequisition.rdl';

    dataset
    {
        dataitem(MaterialRequisitionHeader; "Material Requisition Header")
        {
            column(CompanyPicture; CompanyInfo.Picture)
            {

            }
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(CompanyAddress; CompanyInfo.Address)
            {

            }
            column(RequisitionNo; "Requisition No.")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Description; GetWorkDescription)
            {
            }
            column(Department; Department)
            {
            }
            column(TransferedToJournals; "Transfered To Journals")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(JournalTemplateName; "Journal Template Name")
            {
            }
            column(JournalBatchName; "Journal Batch Name")
            {
            }
            dataitem("Material Requisition Line";"Material Requisition Line")
            {
                DataItemLink="Requisition No."=field("Requisition No.");
                column(Item_No_;"Item No.")
                {

                }
                column(ItemName;Description)
                {

                }
                column(Location_Code;"Location Code")
                {

                }
                column(Quantity;Quantity)
                {

                }
                column(Unit_of_Measure;"Unit of Measure")
                {

                }
                column(Unit_Cost;"Unit Cost")
                {

                }
                column(Amount;Amount)
                {

                }
                column(GrossWeight;GrossWeight)
                {

                }
                column(NetWeightorQtyIssued;NetWeightorQtyIssued)
                {

                }
                column(IssuedDate;IssuedDate)
                {

                }
            }
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
            area(Processing)
            {
            }
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        if MaterialRequisitionHeader.Get() then
            GetWorkDescription:=MaterialRequisitionHeader.GetWorkDescription()
    end;

    var
        CompanyInfo: Record "Company Information";
        GrossWeight, NetWeightorQtyIssued: Text;
        IssuedDate: Date;
        GetWorkDescription: Text;
}
