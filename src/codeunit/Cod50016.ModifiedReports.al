codeunit 50016 "Modified Reports"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', true, true)]
    local procedure MyProcedure(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Customer Statement" then
            NewReportId := Report::"Statement MOD";
        if ReportId = Report::"Standard Sales - Credit Memo" then
            NewReportId := Report::"StandardSales - Credit Memo";
        //...Customer Balance to date................
        If ReportId = Report::"Customer - Balance to Date" then
            NewReportId := Report::"New Customer - Balance to Date";
        //....Fixed Asset List Report.........................
        If ReportId = Report::"Fixed Asset - List" then
            NewReportId := Report::"New Fixed Asset List";

        /* if ReportId = Report::"Standard Sales - Order Conf." then
            NewReportId := Report::"Sales-Order Confirmation"; */
        if ReportId = Report::"Customer - Summary Aging" then
            NewReportId := Report::"Customer Summary Aging";
        if ReportId = Report::"Vendor - Balance to Date" then
            NewReportId := Report::"DetailedVendorBalance to Date";
        IF ReportId = Report::"Vendor - Summary Aging" then
            NewReportId := Report::"Detail-Vendor Summary Aging";
        IF ReportId = Report::"Standard Sales - Quote" then
            NewReportId := Report::"Standard Sales - QuotePrint";
        IF ReportId = Report::"Order" then
            NewReportId := Report::"Purchase Order - Print";
        IF ReportId = Report::"Purchase - Receipt" then
            NewReportId := Report::"ASL.GRN";
        if ReportId = Report::"Transfer Order" then
            NewReportId := Report::"Transfer Order Print";
        If ReportId = Report::"Transfer Shipment" then
            NewReportId := Report::"New Transfer Shipment";
        IF ReportId = Report::"Detail Trial Balance" then
            NewReportId := Report::"Detail Trial Balance 2";
        IF ReportId = Report::"G/L Register" then
            NewReportId := Report::"G L Register 2";
    end;

    [EventSubscriber(ObjectType::Page, Page::"ASL.POS.CashSale", 'OnGetESCPOSPrintRequest', '', false, false)]
    local procedure OnGetESCPOSPrintRequest(var SalesInvoiceHeader: Record "Sales Invoice Header"; var ESCPOSRequest: JsonObject; var Handled: Boolean)
    var
        CompanyInfo: Record "Company Information";
        SalesInvoiceLine: Record "Sales Invoice Line";
        Teller: Record "ASL.POS.Teller";
        ESCPOSRequestBuilder: Codeunit "ASL.POS.ESCPOSRequestBuilder";

        ItemsTable: JsonObject;
        TableRow: JsonObject;

    begin
        CompanyInfo.Get();

        ESCPOSRequestBuilder.LineFeed(ESCPOSRequest);
        ESCPOSRequestBuilder.PrintText(
            ESCPOSRequest,
            CompanyInfo.Name,
            true,
            "ASL.POS.ESCPOSFont"::B,
            "ASL.POS.FontSize"::_1,
            "ASL.POS.FontSize"::_0,
            "ASL.POS.TextStyle"::NORMAL,
            "ASL.POS.TextAlign"::CT,
            34
        );
        ESCPOSRequestBuilder.PrintText(
            ESCPOSRequest,
            CompanyInfo.Address,
            true,
            "ASL.POS.ESCPOSFont"::" ",
            "ASL.POS.FontSize"::_0,
            "ASL.POS.FontSize"::_0,
            "ASL.POS.TextStyle"::NORMAL,
            "ASL.POS.TextAlign"::CT,
            42
        );
        ESCPOSRequestBuilder.PrintText(
            ESCPOSRequest, CompanyInfo."Address 2", true, "ASL.POS.TextStyle"::NORMAL, "ASL.POS.TextAlign"::CT, 42
        );

        ESCPOSRequestBuilder.LineFeed(ESCPOSRequest);

        // posted invoice number
        ESCPOSRequestBuilder.PrintText(
            ESCPOSRequest, 'No.: ' + SalesInvoiceHeader."No.", true, "ASL.POS.TextStyle"::NORMAL, "ASL.POS.TextAlign"::RT, 42
        );

        ESCPOSRequestBuilder.LineFeed(ESCPOSRequest);

        // header
        ESCPOSRequestBuilder.AddTable(ESCPOSRequest, 42, "ASL.POS.TextAlign"::CT, ItemsTable);
        ESCPOSRequestBuilder.AddTableColumn(ItemsTable, 14, 'Code', "ASL.POS.TextAlign"::LT);
        ESCPOSRequestBuilder.AddTableColumn(ItemsTable, 5, 'Qty', "ASL.POS.TextAlign"::RT);
        ESCPOSRequestBuilder.AddTableColumn(ItemsTable, 12, 'Amount', "ASL.POS.TextAlign"::RT);

        // body
        SalesInvoiceLine.Reset();
        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.FindSet();
        repeat
            if (SalesInvoiceLine."No." <> '') and (SalesInvoiceLine.Quantity > 0) then begin
                ESCPOSRequestBuilder.AddTableRow(ItemsTable, TableRow);
                ESCPOSRequestBuilder.AddRowCell(TableRow, SalesInvoiceLine."No.");
                ESCPOSRequestBuilder.AddRowCell(TableRow, Format(SalesInvoiceLine.Quantity));
                ESCPOSRequestBuilder.AddRowCell(TableRow, Format(SalesInvoiceLine."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>'));

                ESCPOSRequestBuilder.AddTableRow(ItemsTable, TableRow);
                ESCPOSRequestBuilder.AddRowCell(TableRow, SalesInvoiceLine.Description + ' (' + (SalesInvoiceLine."Unit of Measure Code") + ')', 3);
            end;
        until SalesInvoiceLine.Next() = 0;

        // footer
        SalesInvoiceHeader.CalcFields("Amount Including VAT", "ASL.POS.TotalAmountExclVAT");
        ESCPOSRequestBuilder.AddTableRow(ItemsTable, true, true, TableRow);
        ESCPOSRequestBuilder.AddRowCell(TableRow, 'Total: ');
        ESCPOSRequestBuilder.AddRowCell(TableRow, Format(SalesInvoiceHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>'), "ASL.POS.TextAlign"::" ", 2);

        ESCPOSRequestBuilder.LineFeed(ESCPOSRequest);

        ESCPOSRequestBuilder.AddTableRow(ItemsTable, TableRow);
        ESCPOSRequestBuilder.AddRowCell(TableRow, 'Total Exl. VAT: ');
        ESCPOSRequestBuilder.AddRowCell(TableRow, Format(SalesInvoiceHeader."ASL.POS.TotalAmountExclVAT", 0, '<Precision,2:2><Standard Format,0>'), "ASL.POS.TextAlign"::" ", 2);

        ESCPOSRequestBuilder.AddTableRow(ItemsTable, TableRow);
        ESCPOSRequestBuilder.AddRowCell(TableRow, 'Total VAT: ');
        ESCPOSRequestBuilder.AddRowCell(TableRow, Format(SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader."ASL.POS.TotalAmountExclVAT", 0, '<Precision,2:2><Standard Format,0>'), "ASL.POS.TextAlign"::" ", 2);

        ESCPOSRequestBuilder.AddTableRow(ItemsTable, false, true, TableRow);
        ESCPOSRequestBuilder.AddRowCell(TableRow, 'Total Incl. VAT: ');
        ESCPOSRequestBuilder.AddRowCell(TableRow, Format(SalesInvoiceHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>'), "ASL.POS.TextAlign"::" ", 2);

        // if (Tendered > 0) then begin
        //     ESCPOSRequestBuilder.AddTableRow(ItemsTable, false, false, TableRow);
        //     ESCPOSRequestBuilder.AddRowCell(TableRow, 'Tendered: ');
        //     ESCPOSRequestBuilder.AddRowCell(TableRow, Format(Tendered, 0, '<Precision,2:2><Standard Format,0>'), "ASL.POS.TextAlign"::" ", 2);

        //     ESCPOSRequestBuilder.AddTableRow(ItemsTable, false, false, TableRow);
        //     ESCPOSRequestBuilder.AddRowCell(TableRow, 'Change: ');
        //     ESCPOSRequestBuilder.AddRowCell(TableRow, Format(Tendered - SalesInvoiceHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>'), "ASL.POS.TextAlign"::" ", 2);
        // end;

        // QR Code

        ESCPOSRequestBuilder.DrawQRImage(
            ESCPOSRequest,
            SalesInvoiceHeader."ASL.EFRIS.QRCode"
        );

        Teller.Reset();
        Teller.SetRange("User ID", UserId);
        Teller.FindFirst();
        ESCPOSRequestBuilder.PrintText(ESCPOSRequest, 'Served By: ' + Teller.Name, true, "ASL.POS.TextStyle"::NORMAL, "ASL.POS.TextAlign"::CT);

        ESCPOSRequestBuilder.PrintText(ESCPOSRequest, 'Thank you for choosing us', true, "ASL.POS.TextStyle"::NORMAL, "ASL.POS.TextAlign"::CT);

        ESCPOSRequestBuilder.LineFeed(ESCPOSRequest, 2);

        Handled := true;
    end;

    // Enable Transfered to journals to true when posting material requisition
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterPostItemJnlLine', '', false, false)]
    local procedure OnAfterPostItemJnlLine(var ItemJournalLine: Record "Item Journal Line")
    var
        MaterialRequisitionHeader: Record "Material Requisition Header";
        ItemJnlLineFilter: Record "Item Journal Line";
    begin
        ItemJnlLineFilter.Reset();
        ItemJnlLineFilter.SetRange("Journal Template Name", ItemJournalLine."Journal Template Name");
        ItemJnlLineFilter.SetRange("Document No.", ItemJournalLine."Document No.");
        if ItemJnlLineFilter.FindSet() then begin
            repeat
                MaterialRequisitionHeader.Reset();
                MaterialRequisitionHeader.SetRange("Requisition No.", ItemJnlLineFilter."Document No.");
                if MaterialRequisitionHeader.FindSet() then begin
                    repeat
                        MaterialRequisitionHeader."Transfered To Journals" := true;
                        MaterialRequisitionHeader.Modify();
                    until MaterialRequisitionHeader.Next() = 0;
                end;
            until ItemJnlLineFilter.Next() = 0;
        end;
    end;

    trigger OnRun()
    begin
    end;
}