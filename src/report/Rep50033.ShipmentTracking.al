report 50033 "ShipmentTracking"
{
    ApplicationArea = All;
    Caption = 'ShipmentTracking';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'ShipmentTracking.rdlc';

    dataset
    {
        dataitem("Purchase Header";
        "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Standard Purchase - Order';

            column(CompanyAddress1;
            CompanyAddr[1])
            {
            }
            column(CompanyAddress2;
            CompanyAddr[2])
            {
            }
            column(CompanyAddress3;
            CompanyAddr[3])
            {
            }
            column(CompanyAddress4;
            CompanyAddr[4])
            {
            }
            column(CompanyAddress5;
            CompanyAddr[5])
            {
            }
            column(CompanyAddress6;
            CompanyAddr[6])
            {
            }
            column(CompanyHomePage_Lbl;
            HomePageCaptionLbl)
            {
            }
            column(CompanyHomePage;
            CompanyInfo."Home Page")
            {
            }
            column(CompanyEmail_Lbl;
            EmailIDCaptionLbl)
            {
            }
            column(CompanyEMail;
            CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture;
            CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo;
            CompanyInfo."Phone No.")
            {
            }
            column(USER_ID;
            "USER ID")
            {
            }
            column(ApproverID;
            ApproverID)
            {
            }
            column(UserSignatures;
            UserSignature.Signature)
            {
            }
            column(SentApprovalDate;
            SentApprovalDate)
            {
            }
            column(ApprovedDate;
            ApprovedDate)
            {
            }
            column(No_;
            "No.")
            {
            }
            column(Posting_Date;
            Format("Posting Date", 0, 4))
            {
            }
            column(DocType_PurchHeader;
            "Document Type")
            {
            }
            column(No_PurchHeader;
            "No.")
            {
            }
            column(DocumentTitle_Lbl;
            DocumentTitleLbl)
            {
            }
            column(Amount_Lbl;
            AmountCaptionLbl)
            {
            }
            column(PurchLineInvDiscAmt_Lbl;
            PurchLineInvDiscAmtCaptionLbl)
            {
            }
            column(Subtotal_Lbl;
            SubtotalCaptionLbl)
            {
            }
            column(Total_Lbl;
            TotalCaptionLbl)
            {
            }
            column(PaymentTermsDesc_Lbl;
            PaymentTermsDescCaptionLbl)
            {
            }
            column(ShipmentMethodDesc_Lbl;
            ShipmentMethodDescCaptionLbl)
            {
            }
            column(PrepymtTermsDesc_Lbl;
            PrepymtTermsDescCaptionLbl)
            {
            }
            column(DocumentDate;
            Format("Document Date", 0, 4))
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(ExptRecptDt_PurchaseHeader;
            Format("Expected Receipt Date", 0, 4))
            {
            }
            column(OrderDate_PurchaseHeader; "Order Date")
            {
            }
            column(ReferenceText;
            ReferenceText)
            {
            }
            column(YourRef_PurchHeader;
            "Your Reference")
            {
            }
            column(BuyFrmVendNo_PurchHeader;
            "Buy-from Vendor No.")
            {
            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(PaymentTermsDesc;
            PaymentTerms.Description)
            {
            }
            column(ShipmentMethodDesc;
            ShipmentMethod.Description)
            {
            }
            column(PrepmtPaymentTermsDesc;
            PrepmtPaymentTerms.Description)
            {
            }
            column(DimText;
            DimText)
            {
            }
            column(OrderNo_Lbl;
            OrderNoCaptionLbl)
            {
            }
            column(Page_Lbl;
            PageCaptionLbl)
            {
            }
            column(DocumentDate_Lbl;
            DocumentDateCaptionLbl)
            {
            }
            column(BuyFrmVendNo_PurchHeader_Lbl;
            FieldCaption("Buy-from Vendor No."))
            {
            }
            column(SellToCustNo_PurchHeader_Lbl;
            FieldCaption("Sell-to Customer No."))
            {
            }
            column(ItemNumber_Lbl;
            ItemNumberCaptionLbl)
            {
            }
            column(ItemDescription_Lbl;
            ItemDescriptionCaptionLbl)
            {
            }
            column(ItemQuantity_Lbl;
            ItemQuantityCaptionLbl)
            {
            }
            column(ItemUnit_Lbl;
            ItemUnitCaptionLbl)
            {
            }
            column(ItemUnitPrice_Lbl;
            ItemUnitPriceCaptionLbl)
            {
            }
            column(ItemLineAmount_Lbl;
            ItemLineAmountCaptionLbl)
            {
            }
            column(ToCaption_Lbl;
            ToCaptionLbl)
            {
            }
            column(VendorIDCaption_Lbl;
            VendorIDCaptionLbl)
            {
            }
            column(ConfirmToCaption_Lbl;
            ConfirmToCaptionLbl)
            {
            }
            column(PurchOrderCaption_Lbl;
            PurchOrderCaptionLbl)
            {
            }
            column(PurchOrderNumCaption_Lbl;
            PurchOrderNumCaptionLbl)
            {
            }
            column(PurchOrderDateCaption_Lbl;
            PurchOrderDateCaptionLbl)
            {
            }
            column(OrderDate_Lbl;
            OrderDateLbl)
            {
            }
            column(VendorInvoiceNo_Lbl;
            VendorInvoiceNoLbl)
            {
            }
            column(VendorInvoiceNo;
            "Vendor Invoice No.")
            {
            }
            column(VendorOrderNo_Lbl;
            VendorOrderNoLbl)
            {
            }
            column(VendorOrderNo;
            "Vendor Order No.")
            {
            }
            column(Working_Description;
            "Working Description")
            {
            }
            column(B_L_No_; "B/L No.")
            {
            }
            column(TransactionRef; TransactionRef)
            {
            }
            column(ArrivalDate; ArrivalDate)
            {
            }
            column(MaturityDate; MaturityDate)
            {
            }
            column(ContainerSize; ContainerSize)
            {
            }
            column(ItemName; ItemName)
            {
            }
            column(Shipment_Tracking; "Activate Import Tracking")
            {
            }
            column(AmountIncludingVAT_PurchaseHeader; "Amount Including VAT")
            {
            }
            column(Amount_PurchaseHeader; Amount)
            {
            }
            dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
            {
                DataItemTableView = SORTING("No.") WHERE("Prepayment Invoice" = CONST(True), closed = CONST(True));
                DataItemLink = "Prepayment Order No." = FIELD("No.");
                DataItemLinkReference = "Purchase Header";
                column(No_InvHeader; "No.")
                {
                }
                column(PrepaymentInvoice_PurchInvHeader; "Prepayment Invoice")
                {
                }
                column(PrepaymentOrderNo_PurchInvHeader; "Prepayment Order No.")
                {
                }
                column(Amount_PurchInvHeader; Amount)
                {
                }
                column(AmountIncludingVAT_PurchInvHeader; "Amount Including VAT")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                PurchLine: Record "Purchase Line";
            begin

                i := 0;
                PurchLine.Reset();
                PurchLine.SetRange("Document No.", "Purchase Header"."No.");
                PurchLine.SetRange(Type, PurchLine.Type::Item);
                If PurchLine.FindSet() then
                    repeat
                        i := i + 1;
                        IF i > 1 then
                            ItemName := PurchLine.Description + ',' + ItemName
                        else
                            ItemName := PurchLine.Description;
                    until PurchLine.Next() = 0;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want to log this interaction.';
                        Visible = false;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            LogInteractionEnable := true;
            ArchiveDocument := PurchSetup."Archive Orders";
        end;

        trigger OnOpenPage()
        begin
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        PurchSetup.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode then
            if "Purchase Header".FindSet then
                repeat
                    SegManagement.LogDocument(13, "Purchase Header"."No.", 0, 0, DATABASE::Vendor, "Purchase Header"."Buy-from Vendor No.", "Purchase Header"."Purchaser Code", '', "Purchase Header"."Posting Description", '');
                until "Purchase Header".Next = 0;
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then InitLogInteraction;
    end;

    var
        ItemName: Text;
        i: Integer;
        OrderNoCaptionLbl: Label 'Order No.';
        PageCaptionLbl: Label 'Page';
        DocumentDateCaptionLbl: Label 'Document Date';
        AmountCaptionLbl: Label 'Amount';
        PurchLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        TotalCaptionLbl: Label 'Total';
        ApproverID: Code[100];
        UserSignature: Record "User Signature";
        SentApprovalDate: DateTime;
        ApprovedDate: DateTime;
        PaymentTermsDescCaptionLbl: Label 'Payment Terms';
        ShipmentMethodDescCaptionLbl: Label 'Shipment Method';
        PrepymtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
        HomePageCaptionLbl: Label 'Home Page';
        EmailIDCaptionLbl: Label 'Email';
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        RespCenter: Record "Responsibility Center";
        PurchSetup: Record "Purchases & Payables Setup";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        VendAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        BuyFromAddr: array[8] of Text[100];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        DimText: Text[120];
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DocumentTitleLbl: Label 'Purchase Order';
        ItemNumberCaptionLbl: Label 'Item No.';
        ItemDescriptionCaptionLbl: Label 'Description';
        ItemQuantityCaptionLbl: Label 'Quantity';
        ItemUnitCaptionLbl: Label 'Unit';
        ItemUnitPriceCaptionLbl: Label 'Unit Price';
        ItemLineAmountCaptionLbl: Label 'Line Amount';
        ToCaptionLbl: Label 'To:';
        VendorIDCaptionLbl: Label 'Vendor ID';
        ConfirmToCaptionLbl: Label 'Confirm To';
        PurchOrderCaptionLbl: Label 'PURCHASE ORDER';
        PurchOrderNumCaptionLbl: Label 'Purchase Order Number:';
        PurchOrderDateCaptionLbl: Label 'Purchase Order Date:';
        OrderDateLbl: Label 'Order Date';
        ArchiveDocument: Boolean;
        VendorOrderNoLbl: Label 'Vendor Order No.';
        VendorInvoiceNoLbl: Label 'Vendor Invoice No.';

    procedure InitializeRequest(LogInteractionParam: Boolean)
    begin
        LogInteraction := LogInteractionParam;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;

    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        if PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." then FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        with PurchaseHeader do begin
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetPurchaser(SalespersonPurchaser, "Purchaser Code", PurchaserText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, "Prepmt. Payment Terms Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
            ReferenceText := FormatDocument.SetText("Your Reference" <> '', FieldCaption("Your Reference"));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', FieldCaption("VAT Registration No."));
        end;
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';
    end;
}