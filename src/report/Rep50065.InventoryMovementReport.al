report 50065 "Inventory Movement Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Inventory Movement2.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Inventory Posting Group";
            column(NegAdjustValue; NegAdjustValue) { }
            column(SalesValue; SalesValue) { }
            column(CreditNoteValue; CreditNoteValue) { }
            column(No_; "No.") { }
            column(Description; Description) { }
            column(Base_Unit_of_Measure; "Base Unit of Measure") { }
            column(Unit_Cost; "Unit Cost") { }
            column(Inventory_Posting_Group; "Inventory Posting Group") { }
            column(ProductionOutput; ProductionOutput) { }
            column(PostiveAdjustmentValue; PostiveAdjustmentValue) { }
            column(TransferReceiptValue; TransferReceiptValue) { }
            column(SalesReturnReceiptValue; SalesReturnReceiptValue) { }
            column(SalesCreditMemoValue; SalesCreditMemoValue) { }
            column(PurchaseReceiptValue; PurchaseReceiptValue) { }
            column(ProductionConsumption; ProductionConsumption) { }
            column(NegAdjustmentValue; NegAdjustmentValue) { }
            column(TransferShipmentValue; TransferShipmentValue) { }
            column(SalesShipmentValue; SalesShipmentValue) { }
            column(PurchaseReturnShipmentValue; PurchaseReturnShipmentValue) { }
            column(PurchaseCreditMemoValue; PurchaseCreditMemoValue) { }
            column(SalesInvoiceValue; SalesInvoiceValue) { }
            column(PurchaseInvoiceValue; PurchaseInvoiceValue) { }
            column(InboundQuantity; InboundQuantity) { }
            column(OutboundQuantity; OutboundQuantity) { }
            column(OpeningStock; OpeningStock) { }
            column(Date1; Date1) { }
            column(Date2; Date2) { }
            Column(Company_Name; CompanyInfo.Name) { }
            Column(Company_Address; CompanyInfo.Address) { }
            Column(Company_PhoneNo; CompanyInfo."Phone No.") { }
            Column(Company_Picture; CompanyInfo.Picture) { }
            Column(Company_Email; CompanyInfo."E-Mail") { }
            Column(Company_HomePage; CompanyInfo."Home Page") { }

            // ── Visibility flag columns for RDLC ──
            column(ShowFinishedCols; ShowFinishedCols) { }
            column(ShowRawPackCols; ShowRawPackCols) { }

            trigger OnAfterGetRecord()
            begin
                /*--------------------Inbound--------------------------*/
                ProductionOutput := 0;
                PostiveAdjustmentValue := 0;
                TransferReceiptValue := 0;
                SalesReturnReceiptValue := 0;
                SalesCreditMemoValue := 0;
                PurchaseReceiptValue := 0;
                PurchaseInvoiceValue := 0;
                /*------------------------Outbound--------------------------*/
                ProductionConsumption := 0;
                NegAdjustmentValue := 0;
                TransferShipmentValue := 0;
                SalesShipmentValue := 0;
                PurchaseReturnShipmentValue := 0;
                PurchaseCreditMemoValue := 0;
                SalesInvoiceValue := 0;

                OpeningStock := 0;
                NegAdjustValue := 0;
                SalesValue := 0;
                CreditNoteValue := 0;

                /*--------------ProductionOutput----------------*/
                ItemLedger1.Reset();
                ItemLedger1.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger1.SetRange("Item No.", "No.");
                ItemLedger1.SetRange("Entry Type", ItemLedger1."Entry Type"::Output);
                if ItemLedger1.FindFirst() then begin
                    repeat
                        ProductionOutput += ItemLedger1.Quantity;
                    until ItemLedger1.Next() = 0;
                end;

                /*--------------PostiveAdjustment----------------*/
                ItemLedger2.Reset();
                ItemLedger2.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger2.SetRange("Item No.", "No.");
                ItemLedger2.SetRange("Entry Type", ItemLedger1."Entry Type"::"Positive Adjmt.");
                if ItemLedger2.FindFirst() then begin
                    repeat
                        PostiveAdjustmentValue += ItemLedger2.Quantity;
                    until ItemLedger2.Next() = 0;
                end;

                /*--------------TransferReceipt----------------*/
                ItemLedger3.Reset();
                ItemLedger3.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger3.SetRange("Item No.", "No.");
                ItemLedger3.SetRange("Entry Type", ItemLedger3."Entry Type"::Transfer);
                ItemLedger3.SetRange("Document Type", ItemLedger3."Document Type"::"Transfer Receipt");
                if ItemLedger3.FindFirst() then begin
                    repeat
                        TransferReceiptValue += ItemLedger3.Quantity;
                    until ItemLedger3.Next() = 0;
                end;

                /*--------------SalesReturnReceipt----------------*/
                ItemLedger4.Reset();
                ItemLedger4.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger4.SetRange("Item No.", "No.");
                ItemLedger4.SetRange("Entry Type", ItemLedger1."Entry Type"::Sale);
                ItemLedger4.SetRange("Document Type", ItemLedger4."Document Type"::"Sales Return Receipt");
                if ItemLedger4.FindFirst() then begin
                    repeat
                        SalesReturnReceiptValue += ItemLedger4.Quantity;
                    until ItemLedger4.Next() = 0;
                end;

                /*------------------------SalesCreditMemo---------------------------------*/
                ItemLedger5.Reset();
                ItemLedger5.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger5.SetRange("Item No.", "No.");
                ItemLedger5.SetRange("Entry Type", ItemLedger5."Entry Type"::Sale);
                ItemLedger5.SetRange("Document Type", ItemLedger5."Document Type"::"Sales Credit Memo");
                if ItemLedger5.FindFirst() then begin
                    repeat
                        ItemLedger5.CalcFields("Sales Amount (Actual)");
                        SalesCreditMemoValue += ItemLedger5.Quantity;
                        CreditNoteValue += ItemLedger5."Sales Amount (Actual)";
                    until ItemLedger5.Next() = 0;
                end;

                /*-----------------------PurchaseReceipt--------------------*/
                ItemLedger6.Reset();
                ItemLedger6.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger6.SetRange("Item No.", "No.");
                ItemLedger6.SetRange("Entry Type", ItemLedger6."Entry Type"::Purchase);
                ItemLedger6.SetRange("Document Type", ItemLedger6."Document Type"::"Purchase Receipt");
                if ItemLedger6.FindFirst() then begin
                    repeat
                        PurchaseReceiptValue += ItemLedger6.Quantity;
                    until ItemLedger6.Next() = 0;
                end;

                /*-----------------------PurchaseInvoice--------------------*/
                ItemLedger15.Reset();
                ItemLedger15.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger15.SetRange("Item No.", "No.");
                ItemLedger15.SetRange("Entry Type", ItemLedger15."Entry Type"::Purchase);
                ItemLedger15.SetRange("Document Type", ItemLedger15."Document Type"::"Purchase Invoice");
                if ItemLedger15.FindFirst() then begin
                    repeat
                        PurchaseInvoiceValue += ItemLedger15.Quantity;
                    until ItemLedger15.Next() = 0;
                end;

                /*----------------InboundTotal--------------------------------------------*/
                InboundQuantity := ProductionOutput + PostiveAdjustmentValue + TransferReceiptValue + PurchaseInvoiceValue +
                                   SalesReturnReceiptValue + SalesCreditMemoValue + PurchaseReceiptValue;

                /*----------------------ProductionConsumption------------------------------*/
                ItemLedger7.Reset();
                ItemLedger7.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger7.SetRange("Item No.", "No.");
                ItemLedger7.SetRange("Entry Type", ItemLedger7."Entry Type"::Consumption);
                if ItemLedger7.FindFirst() then begin
                    repeat
                        ProductionConsumption += ItemLedger7.Quantity;
                    until ItemLedger7.Next() = 0;
                end;

                /*-------------------------NegativeAdjustment----------------------------------*/
                ItemLedger8.Reset();
                ItemLedger8.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger8.SetRange("Item No.", "No.");
                ItemLedger8.SetRange("Entry Type", ItemLedger8."Entry Type"::"Negative Adjmt.");
                if ItemLedger8.FindFirst() then begin
                    repeat
                        ItemLedger8.CalcFields("Cost Amount (Actual)");
                        NegAdjustmentValue += ItemLedger8.Quantity;
                        NegAdjustValue += ItemLedger8."Cost Amount (Actual)";
                    until ItemLedger8.Next() = 0;
                end;

                /*---------------------------TransferShipment-------------------------------*/
                ItemLedger9.Reset();
                ItemLedger9.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger9.SetRange("Item No.", "No.");
                ItemLedger9.SetRange("Entry Type", ItemLedger9."Entry Type"::Transfer);
                ItemLedger9.SetRange("Document Type", ItemLedger9."Document Type"::"Transfer Shipment");
                if ItemLedger9.FindFirst() then begin
                    repeat
                        TransferShipmentValue += ItemLedger9.Quantity;
                    until ItemLedger9.Next() = 0;
                end;

                /*----------------------------SalesShipment-----------------------------------*/
                ItemLedger10.Reset();
                ItemLedger10.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger10.SetRange("Item No.", "No.");
                ItemLedger10.SetRange("Entry Type", ItemLedger10."Entry Type"::Sale);
                ItemLedger10.SetRange("Document Type", ItemLedger10."Document Type"::"Sales Shipment");
                if ItemLedger10.FindFirst() then begin
                    repeat
                        ItemLedger10.CalcFields("Sales Amount (Actual)");
                        SalesShipmentValue += ItemLedger10.Quantity;
                        SalesValue += ItemLedger10."Sales Amount (Actual)";
                    until ItemLedger10.Next() = 0;
                end;

                /*------------------------PurchaseReturnShipment---------------------------*/
                ItemLedger11.Reset();
                ItemLedger11.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger11.SetRange("Item No.", "No.");
                ItemLedger11.SetRange("Entry Type", ItemLedger11."Entry Type"::Purchase);
                ItemLedger11.SetRange("Document Type", ItemLedger11."Document Type"::"Purchase Return Shipment");
                if ItemLedger11.FindFirst() then begin
                    repeat
                        PurchaseReturnShipmentValue += ItemLedger11.Quantity;
                    until ItemLedger11.Next() = 0;
                end;

                /*------------------------------PurchaseCreditMemo------------------------*/
                ItemLedger12.Reset();
                ItemLedger12.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger12.SetRange("Item No.", "No.");
                ItemLedger12.SetRange("Entry Type", ItemLedger12."Entry Type"::Purchase);
                ItemLedger12.SetRange("Document Type", ItemLedger12."Document Type"::"Purchase Credit Memo");
                if ItemLedger12.FindFirst() then begin
                    repeat
                        PurchaseCreditMemoValue += ItemLedger12.Quantity;
                    until ItemLedger12.Next() = 0;
                end;

                /*------------------------SalesInvoice---------------------------------------*/
                ItemLedger14.Reset();
                ItemLedger14.SetRange("Posting Date", StartDate, EndDate);
                ItemLedger14.SetRange("Item No.", "No.");
                ItemLedger14.SetRange("Entry Type", ItemLedger14."Entry Type"::Sale);
                ItemLedger14.SetRange("Document Type", ItemLedger14."Document Type"::"Sales Invoice");
                if ItemLedger14.FindFirst() then begin
                    repeat
                        SalesInvoiceValue += ItemLedger14.Quantity;
                    until ItemLedger14.Next() = 0;
                end;

                /*----------------OutBoundTotal--------------------------------------------*/
                OutboundQuantity := ProductionConsumption + NegAdjustmentValue + TransferShipmentValue + SalesInvoiceValue +
                                    SalesShipmentValue + PurchaseReturnShipmentValue + PurchaseCreditMemoValue;

                /*--------------------------------OpeningStock----------------------------*/
                ItemLedger13.Reset();
                ItemLedger13.SetRange("Posting Date", 20190701D, StartDate - 1);
                ItemLedger13.SetRange("Item No.", "No.");
                if ItemLedger13.FindFirst() then begin
                    repeat
                        OpeningStock += ItemLedger13.Quantity;
                    until ItemLedger13.Next() = 0;
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
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Starting Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Ending Date';
                    }
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
        StartDate: Date;
        EndDate: Date;
        LocationFilter: Text[250];
        Date1: Date;
        Date2: Date;
        InboundQuantity: Decimal;
        OutboundQuantity: Decimal;
        OpeningStock: Decimal;
        NegAdjustValue: Decimal;
        SalesValue: Decimal;
        CreditNoteValue: Decimal;
        InvPostingGroupFilter: Text[250];

        // ── Visibility Flags ──
        // ShowFinishedCols = TRUE  → show Production Output, Sales columns
        // ShowRawPackCols  = TRUE  → show Production Consumption
        // Both TRUE when no filter applied (show all)
        ShowFinishedCols: Boolean;
        ShowRawPackCols: Boolean;

        /*-----------------------------Inbound--------------------------*/
        ProductionOutput: Decimal;
        PostiveAdjustmentValue: Decimal;
        TransferReceiptValue: Decimal;
        SalesReturnReceiptValue: Decimal;
        SalesCreditMemoValue: Decimal;
        PurchaseReceiptValue: Decimal;
        PurchaseInvoiceValue: Decimal;
        /*-----------------------------Outbound-------------------------*/
        ProductionConsumption: Decimal;
        NegAdjustmentValue: Decimal;
        TransferShipmentValue: Decimal;
        SalesShipmentValue: Decimal;
        PurchaseReturnShipmentValue: Decimal;
        PurchaseCreditMemoValue: Decimal;
        SalesInvoiceValue: Decimal;

        ItemLedger1: Record "Item Ledger Entry";
        ItemLedger2: Record "Item Ledger Entry";
        ItemLedger3: Record "Item Ledger Entry";
        ItemLedger4: Record "Item Ledger Entry";
        ItemLedger5: Record "Item Ledger Entry";
        ItemLedger6: Record "Item Ledger Entry";
        ItemLedger7: Record "Item Ledger Entry";
        ItemLedger8: Record "Item Ledger Entry";
        ItemLedger9: Record "Item Ledger Entry";
        ItemLedger10: Record "Item Ledger Entry";
        ItemLedger11: Record "Item Ledger Entry";
        ItemLedger12: Record "Item Ledger Entry";
        ItemLedger13: Record "Item Ledger Entry";
        ItemLedger14: Record "Item Ledger Entry";
        ItemLedger15: Record "Item Ledger Entry";

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        LocationFilter := Item.GETFILTER("Location Filter");
        Date1 := StartDate;
        Date2 := EndDate;

        // ── Detect Inventory Posting Group filter and set visibility flags ──
        InvPostingGroupFilter := UpperCase(Item.GETFILTER("Inventory Posting Group"));

        case InvPostingGroupFilter of
            'FINISHED':
                begin
                    ShowFinishedCols := true;   // Production Output, Sales columns visible
                    ShowRawPackCols := false;    // Production Consumption hidden
                end;
            'RAW MATERIALS', 'PACKAGING MATERIALS':
                begin
                    ShowFinishedCols := false;   // Production Output, Sales columns hidden
                    ShowRawPackCols := true;     // Production Consumption visible
                end;
            else begin
                // No filter or mixed — show everything
                ShowFinishedCols := true;
                ShowRawPackCols := true;
            end;
        end;
    end;
}