report 50084 "ASL Transfer Delivery Note"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'TransferDeliveryNote.rdl';
    Caption = 'Delivery Note';

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Posted Transfer Shipment';

            column(No_TransferShipmentHeader; "No.") { }
            column(TransferOrderNo; "Transfer Order No.") { }
            column(PostingDate; Format("Posting Date", 0, 4)) { }
            column(TransferFromCode; "Transfer-from Code") { }
            column(TransferToCode; "Transfer-to Code") { }
            column(TransferFromName; "Transfer-from Name") { }
            column(TransferFromName2; "Transfer-from Name 2") { }
            column(TransferFromAddress; "Transfer-from Address") { }
            column(TransferFromAddress2; "Transfer-from Address 2") { }
            column(TransferFromCity; "Transfer-from City") { }
            column(TransferFromPostCode; "Transfer-from Post Code") { }
            column(TransferToName; "Transfer-to Name") { }
            column(TransferToName2; "Transfer-to Name 2") { }
            column(TransferToAddress; "Transfer-to Address") { }
            column(TransferToAddress2; "Transfer-to Address 2") { }
            column(TransferToCity; "Transfer-to City") { }
            column(TransferToPostCode; "Transfer-to Post Code") { }

            // Company Info columns
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyAddress2; CompanyInfo."Address 2") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(CompanyHomePage; CompanyInfo."Home Page") { }
            column(CompanyVATRegNo; CompanyInfo."VAT Registration No.") { }
            column(CompanyGiroNo; CompanyInfo."Giro No.") { }
            column(CompanyBankName; CompanyInfo."Bank Name") { }
            column(CompanyBankAccNo; CompanyInfo."Bank Account No.") { }
            column(CompanyPicture; CompanyInfo.Picture) { }

            // Labels
            column(DeliveryNoteCaption; DeliveryNoteLbl) { }
            column(PageCaption; PageLbl) { }
            column(TransferFromCaption; TransferFromLbl) { }
            column(TransferToCaption; TransferToLbl) { }
            column(DocumentDateCaption; DocumentDateLbl) { }
            column(ShipmentNoCaption; ShipmentNoLbl) { }
            column(TransferOrderNoCaption; TransferOrderNoLbl) { }
            column(PhoneNoCaption; PhoneNoLbl) { }
            column(HomePageCaption; HomePageLbl) { }
            column(EmailCaption; EmailLbl) { }
            column(VATRegNoCaption; VATRegNoLbl) { }
            column(GiroNoCaption; GiroNoLbl) { }
            column(BankCaption; BankLbl) { }
            column(AccountNoCaption; AccountNoLbl) { }
            column(DeliveredByCaption; DeliveredByLbl) { }
            column(ReceivedByCaption; ReceivedByLbl) { }
            column(OutputNo; OutputNo) { }

            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                column(LineNo; "Line No.") { }
                column(ItemNo_Line; "Item No.") { }
                column(Description_Line; Description) { }
                column(Quantity_Line; Abs(Quantity)) { }
                column(UnitOfMeasure_Line; "Unit of Measure Code") { }

                // Line label columns
                column(NoCaption; FieldCaption("Item No.")) { }
                column(DescriptionCaption; FieldCaption(Description)) { }
                column(QuantityCaption; QuantityLbl) { }
                column(UOMCaption; UOMLbl) { }

                trigger OnPreDataItem()
                begin
                    // Skip blank lines
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("Item No." = '') and (Quantity = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
                OutputNo += 1;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies';
                    }
                }
            }
        }
    }

    var
        CompanyInfo: Record "Company Information";
        NoOfCopies: Integer;
        OutputNo: Integer;
        MoreLines: Boolean;
        DeliveryNoteLbl: Label 'Delivery Note';
        PageLbl: Label 'Page';
        TransferFromLbl: Label 'Transfer-from';
        TransferToLbl: Label 'Transfer-to (Delivered To)';
        DocumentDateLbl: Label 'Document Date';
        ShipmentNoLbl: Label 'Shipment No.';
        TransferOrderNoLbl: Label 'Transfer Order No.';
        PhoneNoLbl: Label 'Phone No.';
        HomePageLbl: Label 'Home Page';
        EmailLbl: Label 'Email';
        VATRegNoLbl: Label 'VAT Reg. No.';
        GiroNoLbl: Label 'Giro No.';
        BankLbl: Label 'Bank';
        AccountNoLbl: Label 'Account No.';
        DeliveredByLbl: Label 'Delivered by';
        ReceivedByLbl: Label 'Received by';
        QuantityLbl: Label 'Quantity';
        UOMLbl: Label 'Unit of Measure';
}