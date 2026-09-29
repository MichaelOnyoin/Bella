pageextension 50020 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Customer Name")
        {
            // field("Branch Code"; Rec."Branch Code")
            // {
            //     ApplicationArea = All;
            // }
        }
        addafter("Salesperson Code")
        {
            field("MoMo Code"; Rec."MoMo Code")
            {
            }
            field("Moved To Transfer"; Rec."Moved To Transfer")
            {
                Visible = SOEdit;
                Editable = true;
            }
        }

        addafter("Posting Description")
        {
            field("Truck No."; Rec."Truck No.")
            {
                ApplicationArea = All;
            }

            field("Seal No."; Rec."Seal No")
            {
                ApplicationArea = All;
            }
            field("Shipping No. Series"; Rec."Shipping No. Series")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Customer Disc. Group"; Rec."Customer Disc. Group")
            {
                ApplicationArea = All;
            }
        }
        modify("Salesperson Code")
        {
            ShowMandatory = True;
            trigger OnBeforeValidate()
            var
                SalesPerson: Record "Salesperson/Purchaser";
            begin
                SalesPerson.Reset();
                SalesPerson.SetRange(Code, REC."Salesperson Code");
                IF SalesPerson.FindFirst() then begin
                    Rec."MoMo Code" := SalesPerson."MoMo Code";
                end;
            end;
        }
    }

    actions
    {
        addafter("Create Inventor&y Put-away/Pick")
        {
            action("Create Transfer Order")
            {
                ApplicationArea = All;
                Caption = 'Create Transfer Order';
                Ellipsis = true;
                Image = CreateInventoryPickup;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Create a Transfer Order for the Items on the current Sales Order';

                trigger OnAction()
                var
                    TransferHeader: Record "Transfer Header";
                    TextA0001: Label 'Do you want to open Transfer Order';
                    TransferPage: Page "Transfer Order";
                    TransHeader2: Record "Transfer Header";
                    SalesLines: Record "Sales Line";
                    TransferNO: Code[20];
                begin
                    Rec.TestField(Status, Rec.Status::Released);
                    If Rec."Moved To Transfer" = true then
                        Error('Transfer order for,%1, was created already', Rec."No.");

                    SalesLines.Reset();
                    SalesLines.SetRange("Document No.", Rec."No.");
                    SalesLines.SetRange("Document Type", SalesLines."Document Type"::Order);
                    SalesLines.SetRange(Type, SalesLines.Type::Item);
                    if SalesLines.FindFirst() then begin
                        //Create Transfer Header
                        TransferHeader.Init();
                        TransferHeader.Validate("Transfer-from Code", 'FIN-WHS');
                        TransferHeader.Validate("Transfer-to Code", SalesLines."Location Code");
                        TransferHeader.Validate("In-Transit Code", 'TRANSIT');
                        TransferHeader.Validate("Sales Order No.", Rec."No.");
                        TransferHeader.Insert(true);

                        Rec."Moved To Transfer" := true;
                        TransferNO := TransferHeader."No.";
                        Message('Transfer  Order has been created with No,%1', TransferNO);
                    end;

                    if Confirm('Do you want to Open Transfer order?') then begin
                        TransHeader2.Reset();
                        TransHeader2.SetRange("No.", TransferHeader."No.");
                        if TransHeader2.FindFirst() then begin
                            TransferPage.SetTableView(TransHeader2);
                            TransferPage.Run();
                        end;
                    end
                end;
            }
        }
        addafter(PostAndNew)
        {
            action("Batch No.")
            {
                ApplicationArea = All;
                Image = PostBatch;
                Caption = 'Assign Lot Numbers';
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    SaleLine: Record "Sales Line";
                    Item: Record Item;
                    ItemTrackingCode: Record "Item Tracking Code";
                    ItemUnitOfMeasure: Record "Item Unit of Measure";
                    ReservationEntry: Record "Reservation Entry";
                    ItemLedgEntry: Record "Item Ledger Entry";

                    UntrackedQuantity: Decimal;
                    RemainingItemLdgEntryQty: Decimal;
                    MoreOpenEntries: Boolean;

                    SNSalesOutboundTracking: Boolean;
                    SNInboundTracking: Boolean;
                    LotSalesOutboundTracking: Boolean;
                    LotInboundTracking: Boolean;
                    EntryNo: Integer;
                begin

                    Rec.TestField("Salesperson Code");
                    SaleLine.Reset();
                    SaleLine.SetRange("Document Type", SaleLine."Document Type"::Order);
                    SaleLine.SetRange("Document No.", Rec."No.");
                    SaleLine.SetRange(Type, SaleLine.Type::Item);
                    if SaleLine.FindSet() then
                        if Rec."Batch Assigned" = true then begin
                            Message('Lot numbers were already assigned');
                            exit;
                        end;
                    repeat
                        EntryNo := 0;
                        Item.Get(SaleLine."No.");
                        if Item."Item Tracking Code" <> '' then begin
                            ItemTrackingCode.Get(Item."Item Tracking Code");
                            LotInboundTracking := ItemTrackingCode."Lot Manuf. Inbound Tracking" or
                                                  ItemTrackingCode."Lot Assembly Inbound Tracking" or
                                                  ItemTrackingCode."Lot Purchase Inbound Tracking" or
                                                  ItemTrackingCode."Lot Pos. Adjmt. Inb. Tracking";

                            SNInboundTracking := ItemTrackingCode."SN Manuf. Inbound Tracking" or
                                                  ItemTrackingCode."SN Assembly Inbound Tracking" or
                                                  ItemTrackingCode."SN Purchase Inbound Tracking" or
                                                  ItemTrackingCode."SN Pos. Adjmt. Inb. Tracking";

                            LotSalesOutboundTracking := ItemTrackingCode."Lot Sales Outbound Tracking";

                            SNSalesOutboundTracking := ItemTrackingCode."SN Sales Outbound Tracking";

                            if (LotSalesOutboundTracking or SNSalesOutboundTracking) and (LotInboundTracking or SNInboundTracking) then begin
                                UntrackedQuantity := SaleLine.Quantity;
                                ItemLedgEntry.Reset();
                                ItemLedgEntry.SetCurrentKey("Item No.", "Posting Date");
                                ItemLedgEntry.SetRange("Item No.", Item."No.");
                                ItemLedgEntry.SetRange("Location Code", SaleLine."Location Code");
                                ItemLedgEntry.SetRange(Positive, true);
                                ItemLedgEntry.SetRange(Open, true);
                                if not ItemLedgEntry.FindSet() then
                                    Error(NoOpenEntriesFoundErr, Item."No.");

                                MoreOpenEntries := true;
                                while MoreOpenEntries and (UntrackedQuantity > 0) do begin
                                    RemainingItemLdgEntryQty := ItemLedgEntry.Quantity;
                                    while (RemainingItemLdgEntryQty > 0) and (UntrackedQuantity > 0) do begin
                                        ReservationEntry.Init();
                                        ReservationEntry."Entry No." := EntryNo;
                                        ReservationEntry."Item No." := Item."No.";
                                        ReservationEntry."Location Code" := SaleLine."Location Code";
                                        ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Prospect;
                                        if SNSalesOutboundTracking then begin
                                            ReservationEntry."Serial No." := ItemLedgEntry."Serial No.";
                                            if ItemLedgEntry."Lot No." <> '' then
                                                ReservationEntry."Lot No." := ItemLedgEntry."Lot No.";
                                            ReservationEntry.Validate("Quantity (Base)", -1);
                                            UntrackedQuantity -= 1;
                                            RemainingItemLdgEntryQty -= 1;
                                        end else
                                            if LotSalesOutboundTracking then begin
                                                ReservationEntry."Lot No." := ItemLedgEntry."Lot No.";
                                                if RemainingItemLdgEntryQty > UntrackedQuantity then begin
                                                    ReservationEntry.Validate("Quantity (Base)", -UntrackedQuantity);
                                                    UntrackedQuantity := 0;
                                                    RemainingItemLdgEntryQty -= UntrackedQuantity;
                                                end else begin
                                                    ReservationEntry.Validate("Quantity (Base)", -RemainingItemLdgEntryQty);
                                                    UntrackedQuantity -= RemainingItemLdgEntryQty;
                                                    RemainingItemLdgEntryQty := 0;
                                                end;
                                            end;

                                        if ItemLedgEntry."Expiration Date" <> 0D then
                                            ReservationEntry."Expiration Date" := ItemLedgEntry."Expiration Date";
                                        if Item."Base Unit of Measure" <> SaleLine."Unit of Measure Code" then begin
                                            ItemUnitOfMeasure.Get(Item."No.", SaleLine."Unit of Measure");
                                            ReservationEntry.Validate("Qty. per Unit of Measure", ItemUnitOfMeasure."Qty. per Unit of Measure");
                                        end;
                                        ReservationEntry.SetSource(
                                            Database::"Sales Line",
                                            "Sales Document Type"::Order.AsInteger(),
                                            Rec."No.",
                                            SaleLine."Line No.",
                                            '',
                                            0
                                        );
                                        ReservationEntry."Shipment Date" := Rec."Shipment Date";
                                        ReservationEntry.Positive := false;
                                        ReservationEntry.Insert(true);
                                        EntryNo += 1;

                                        if RemainingItemLdgEntryQty = 0 then
                                            MoreOpenEntries := ItemLedgEntry.Next() <> 0;
                                    end;
                                end;
                            end;
                        end;
                    until SaleLine.Next() = 0;
                    Message('Lot numbers assigned successfully');
                    Rec."Batch Assigned" := true;
                    Rec.Modify();
                end;
            }
        }

        // Add changes to page actions here
        modify("P&osting")
        {
            Enabled = false;
            Visible = false;
            // trigger OnBeforeAction()
            // var
            //     myInt: Integer;
            // begin
            //     Rec.TestField("Salesperson Code");

            // end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Salesperson Code");
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                SalesLine: Record "Sales Line";
            begin
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", Rec."No.");
                if SalesLine.FindFirst() then begin
                    if SalesLine."Location Code" = 'FIN-WHS' then begin
                        Error('You cannot Sell from a Finished Goods Wharehouse.Use your own Location');
                    end;
                end;
            end;
        }
        addfirst("P&osting")
        {
            action("Post Order")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Ellipsis = true;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                begin
                    // Rec.TestField("Branch Code");
                    Rec.TestField("Salesperson Code");
                    /*  SalesLine.Reset();
                     SalesLine.SetRange("Document No.", Rec."No.");
                     IF SalesLine.FindSet() then
                         repeat
                             IF SalesLine."Unit Cost" > SalesLine."Unit Price" then
                                 SalesLine.FieldError("Unit Price", 'specified is less than the current Unit Cost, Please Update.');
                             SalesLine.TestField("SALESPERSON CODE");
                         until SalesLine.Next() = 0; */
                    PostDocumentModified(CODEUNIT::"Sales-Post Modified", NavigateAfterPost::"Posted Document");
                end;
            }
        }
    }

    var
        NavigateAfterPost: Option "Posted Document","New Document","Do Nothing";
        NoOpenEntriesFoundErr: Label 'No open entries foud for item %1', Comment = '%1 Item No.';
        Usersetup: Record "User Setup";
        SOEdit: Boolean;

    local procedure PostDocumentModified(PostingCodeunitID: Integer; Navigate: Option)
    var
        SalesHeader: Record "Sales Header";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        InstructionMgt: Codeunit "Instruction Mgt.";
        DocumentIsScheduledForPosting: Boolean;
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        DocumentIsPosted: Boolean;
    begin
        if ApplicationAreaMgmtFacade.IsFoundationEnabled then
            LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        DocumentIsScheduledForPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not SalesHeader.Get(Rec."Document Type", Rec."No.")) or DocumentIsScheduledForPosting;

        CurrPage.Update(false);

        if PostingCodeunitID <> CODEUNIT::"Sales-Post Modified" then
            exit;

        case Navigate of
            NavigateAfterPost::"Posted Document":
                begin
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
                        ShowPostedConfirmationMessageMod();

                    if DocumentIsScheduledForPosting then
                        CurrPage.Close();
                end;
            NavigateAfterPost::"New Document":
                if DocumentIsPosted then begin
                    Clear(SalesHeader);
                    SalesHeader.Init();
                    SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.Insert(true);
                    PAGE.Run(PAGE::"Sales Order", SalesHeader);
                end;
        end;
    end;

    local procedure ShowPostedConfirmationMessageMod()
    var
        OrderSalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        OpenPostedSalesOrderQst: Label 'The order is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
    begin
        if not OrderSalesHeader.Get(Rec."Document Type", Rec."No.") then begin
            SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.");
            if SalesInvoiceHeader.FindFirst then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesOrderQst, SalesInvoiceHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode)
                then
                    PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end;
    end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // var
    // UserID:Code[50];
    // begin
    //    UserID:= Database.UserId;
    //    Rec."Salesperson Code":=UserID;

    // end;

    trigger OnOpenPage()
    begin
        Usersetup.Reset();
        Usersetup.SetRange(Usersetup."User ID", UserId);
        if Usersetup.FindFirst() then begin
            if (Usersetup."Edit PO" = true) then
                SOEdit := true
            else
                SOEdit := false;
        end;

       if Usersetup.FindFirst() then begin
        if Usersetup."Create Sales Order" = false then begin 
            Error('You are not allowed to Create a Sales Order');
        end;
        end;
    end;

    
}