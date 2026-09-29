pageextension 50025 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        modify("Quote No.")
        {
            Caption = 'Requestion No.';
        }
        modify(Status)

        {
            Editable = POEdit;
        }

        addafter("Vendor Invoice No.")
        {
            field("Manufacturer Invoice No"; Rec."Manufacturer Invoice No")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Prepayment No."; Rec."Prepayment No.")
            {
                ApplicationArea = All;
                Visible = true;
                Editable = true;
            }
            field("Po Close Remarks";Rec."Po Close Remarks"){
                ApplicationArea = All;
                Visible = true;
                Editable = true;
            }
            /* field("Reference No."; Rec."Reference No.")
            {
                ToolTip = 'Specifies the value of the Reference No. field.';
                ApplicationArea = All;
            } */
        }
        addafter("Posting Description")
        {
            /* field("Order Type"; Rec."OrderTypeBIA")
            {
                Caption = 'Order Type';
                ApplicationArea = All;
            } */
            /* field("Activate Import Tracking"; Rec."Activate Import Tracking")
            {
                ApplicationArea = All;
                Visible = false;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    IF Rec."Activate Import Tracking" then
                        ImportTracking := true
                    else
                        ImportTracking := false;
                end;
            } */
            /* field("Activate LC Mgt"; Rec."Activate LC Mgt")
            {
                ApplicationArea = All;
                Visible = False;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    IF Rec."Activate LC Mgt" then
                        LCTracking := true
                    else
                        LCTracking := false;
                end;
            } */
            field("Prepayment Adjustment"; Rec."Prepayment Adjustment")
            {
                ApplicationArea = All;
            }
        }

        addafter(Status)
        {
            field("Purchase Description"; Rec."Purchase Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies a brief Summary of your purchases', Comment = '%';
                ShowMandatory = true;
            }
            field("Working Description"; Rec."Working Description")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }

        addafter(Control71)
        {
            group(ImportsTracking)
            {
                Caption = 'Imports - Tracking';
                Visible = ImportTracking;

                field(ContainerSize; Rec.ContainerSize)
                {
                    Caption = 'Container Size';
                    ApplicationArea = All;
                }
                field(ClearingAgent; Rec.ClearingAgent)
                {
                    Caption = 'Clearing Agent';
                    ApplicationArea = All;
                }
                field(ArrivalDate; Rec.ArrivalDate)
                {
                    Caption = 'Arrival Date';
                    ApplicationArea = Suite;
                }
            }
            group(LettersOfCredit)
            {
                Caption = 'Letters Of Credit';
                Visible = LCTracking;

                field(MaturityDate; Rec.MaturityDate)
                {
                    Caption = 'Maturity Date';
                    ApplicationArea = All;
                }
                field(TransactionRef; Rec.TransactionRef)
                {
                    Caption = 'Transaction Ref';
                    ApplicationArea = All;
                }
                field("B/L No."; Rec."B/L No.")
                {
                    ApplicationArea = All;
                }
                field("LC Order Pmt. Terms"; Rec."LC Order Pmt. Terms")
                {
                    ToolTip = 'Specifies the value of the LC Order Pmt. Terms field';
                    ApplicationArea = All;
                }
            }
        }
        modify(Control71)
        {
            Visible = false;
        }
        modify("Vendor Invoice No.")
        {
            trigger OnAfterValidate()
            begin
                IF xRec."Vendor Invoice No." <> Rec."Vendor Invoice No." then
                    Rec."Vendor Order No." := Rec."Vendor Invoice No.";
            end;
        }
        modify("Vendor Order No.")
        {
            trigger OnAfterValidate()
            begin
                IF xRec."Vendor Order No." <> Rec."Vendor Order No." then
                    Rec."Vendor Invoice No." := Rec."Vendor Order No.";
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            Enabled = false;
            Visible = false;
        }
        modify("&Print")
        {
            Visible = false;
            Enabled = false;
        }
        modify(Reopen)
        {
            Enabled = false;
            trigger onbeforeAction()
            var
            begin
                Error('You are not allowed to Reopen released POs. Contact Systems Administrator');
            end;
        }
        addfirst("P&osting")
        {
            action("Post Order")
            {
                ApplicationArea = Suite;
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
                    PostDocumentMod(CODEUNIT::"Purch.-Post Modified", NavigateAfterPost::"Posted Document");
                end;
            }

            action("Print Order")
            {
                ApplicationArea = Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                var
                    PurchaseInvHeader: Record "Purchase Header";
                    PurchaseOrderPrint: Report "Purchase Order - Print";
                    GenLedgerSetup: Record "General Ledger Setup";
                begin

                    GenLedgerSetup.Get();
                    IF GenLedgerSetup."ASL.Print only Released Docs" then begin
                        Rec.TestField(Rec.Status, Rec.Status::Released);
                    end;

                    PurchaseInvHeader.RESET;
                    PurchaseInvHeader.SETRANGE(PurchaseInvHeader."No.", Rec."No.");
                    PurchaseInvHeader.SetRange(PurchaseInvHeader."Document Type", Rec."Document Type");
                    PurchaseInvHeader.SetRange(PurchaseInvHeader."Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                    PurchaseOrderPrint.SETTABLEVIEW(PurchaseInvHeader);
                    PurchaseOrderPrint.RUN;
                end;
            }

            action("Print Order GL")
            {
                ApplicationArea = Suite;
                Caption = '&PrintGL';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                var
                    PurchaseInvHeader: Record "Purchase Header";
                    PurchaseOrderPrint: Report "Purchase Order Print GL";
                begin
                    if Rec.Status = Rec.Status::Open then begin
                        Error('You cannot print Open PO');
                    end;
                    if Rec.Status = Rec.Status::"Pending Approval" then begin
                        Error('You cannot print a PO whose status is Pending Approval');

                    end;
                    //Rec.TestField(Rec.Status, Rec.Status::Released);                    
                    PurchaseInvHeader.RESET;
                    PurchaseInvHeader.SETRANGE(PurchaseInvHeader."No.", Rec."No.");
                    PurchaseInvHeader.SetRange(PurchaseInvHeader."Document Type", Rec."Document Type");
                    PurchaseInvHeader.SetRange(PurchaseInvHeader."Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                    PurchaseOrderPrint.SETTABLEVIEW(PurchaseInvHeader);
                    PurchaseOrderPrint.RUN;
                end;
            }
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                PurchLines: Record "Purchase Line";
                PurchLines2: Record "Purchase Line";
                PurchLines3: Record "Purchase Line";
            begin
                // Rec.TestField(Rec."Location Code");
                Rec.TestField("Purchase Description");
                Rec.TestField(Rec."Shipment Method Code");
                Rec.TestField(Rec."Expected Receipt Date");
                Rec.TestField(Rec."Vendor Invoice No.");

                PurchLines.Reset();
                PurchLines.SetRange("Document Type", PurchLines."Document Type"::Order);
                PurchLines.SetRange("Document No.", Rec."No.");
                PurchLines.SetRange(Type, PurchLines.Type::Item);
                IF PurchLines.Find('-') then
                    repeat
                        PurchLines.TestField(PurchLines."Location Code");
                    until PurchLines.Next() = 0;
                //New Code Added
                if PurchLines.Type = PurchLines.Type::Item then begin
                    if PurchLines."Location Code" <> 'QUARANTINE' then begin
                        Error('Newly created Orders must have QUARANTINE Locaion');
                        //New Code Addded
                    end;
                end;
                PurchLines2.Reset();
                PurchLines2.SetRange("Document Type", PurchLines."Document Type"::Order);
                PurchLines2.SetRange("Document No.", Rec."No.");
                PurchLines2.SetRange(Type, PurchLines.Type::"G/L Account");
                IF PurchLines2.Find('-') then begin
                    repeat
                        PurchLines2.TestField("Gen. Prod. Posting Group");
                        PurchLines2.TestField("Working Description");
                    until PurchLines2.Next() = 0;
                end;

                PurchLines3.Reset();
                PurchLines3.SetRange("Document Type", PurchLines."Document Type"::Order);
                PurchLines3.SetRange("Document No.", Rec."No.");
                PurchLines3.SetRange(Type, PurchLines.Type::"Fixed Asset");
                IF PurchLines3.Find('-') then begin
                    repeat
                        PurchLines3.TestField("Depreciation Book Code");
                    until PurchLines3.Next() = 0;
                end;
            end;
        }
        addafter(CopyDocument)
        {
             action("Close Po")
            {
                ApplicationArea = suite;
                Caption = 'Close Po';
                Promoted = true;
                PromotedCategory = Process;
                Image = Create;
                Visible = true;

                trigger OnAction()
                var
                    ArchiveManagement: Codeunit ArchiveManagement;
                    PurchaseHeader: Record "Purchase Header";
                    PurchaseLines: Record "Purchase Line";
                    Text_002: Label 'Please give any PO Closed Remark for the Purchase Order';
                    Text003: Label 'Do you want to short close this purchase order';
                begin
                    Rec.TestField(Status, Rec.Status::Released);
                    if (Rec."Po Close Remarks" = '') then Error(Text_002, Rec."No.");
                    if Confirm(Text003, true) then begin
                        //Rec."Po Status" := Rec."Po Status"::"Short close";
                        //Rec."Po Close By User ID" := UserId;
                        Rec."Po Close Date" := Today;

                        if Rec.Status = Rec.Status::Released then begin
                            xRec.Status := Rec.Status::Open;
                            xRec.Modify();
                        end;

                        PurchaseLines.Reset();
                        PurchaseLines.SetRange("Document No.", Rec."No.");
                        PurchaseLines.SetRange("Buy-from Vendor No.", rec."Buy-from Vendor No.");
                        if PurchaseLines.FindFirst() then begin
                            repeat
                                PurchaseLines."Outstanding Qty. (Base)" := 0;
                                PurchaseLines."Outstanding Quantity" := 0;
                                PurchaseLines.Validate(Quantity, PurchaseLines."Quantity Received");
                                PurchaseLines.Modify();
                            until PurchaseLines.Next() = 0;

                            if xRec.Status = xRec.Status::Open then begin
                                xRec.Status := Rec.Status::Released;
                                xRec.Modify();
                            end;
                        end;

                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.Update(false);

                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
                        PurchaseHeader.SetRange("No.", Rec."No.");
                        if PurchaseHeader.FindFirst() then
                            PurchaseHeader.Delete();

                        CurrPage.Close();
                        Editable := false;
                    end;
                end;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean;
    var
    begin
        if Rec.Status <> Rec.Status::Open then
            Error('You Cannot Delete this PO');
    end;

    var
        ImportTracking: Boolean;
        LCTracking: Boolean;
        NavigateAfterPost: Option "Posted Document","New Document","Do Nothing";
        DocumentIsPosted: Boolean;
        OpenPostedPurchaseOrderQst: Label 'The order is posted as number %1 and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        Usersetup: Record "User Setup";
        POEdit: Boolean;

    trigger OnClosePage()
    begin
        IF Rec."Activate Import Tracking" then begin
            IF Format(Rec.ContainerSize) = '' then
                IF Confirm('Import Tracking has been activated, Do you want to close before specifying the details?') then
                    CurrPage.Close();
        end;
        IF Rec."Activate LC Mgt" then begin
            IF Format(Rec.MaturityDate) = '' then
                IF Confirm('LC Mgt Tracking has been activated, Do you want to close before specifying the details?') then
                    CurrPage.Close();
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Activate Import Tracking" then
            ImportTracking := true
        else
            ImportTracking := false;
        IF Rec."Activate LC Mgt" then
            LCTracking := true
        else
            LCTracking := false;
    end;

    trigger OnopenPage()
    var
        purchaseLine: Record "Purchase Line";
    begin
        Usersetup.Reset();
        Usersetup.SetRange(Usersetup."User ID", UserId);
        if Usersetup.FindFirst() then begin
            if (Usersetup."Edit PO" = true) then
                POEdit := true
            else
                POEdit := false;
        end;

        purchaseLine.Reset();
        purchaseLine.SetRange(purchaseLine."Document No.", Rec."No.");
        purchaseLine.SetRange(purchaseLine."Document Type", purchaseLine."Document Type"::Order);
        if purchaseLine.FindFirst() then
            repeat
                purchaseLine.validate("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                purchaseLine.Validate("Pay-to Vendor No.", Rec."Pay-to Vendor No.");
                purchaseLine.Modify();
            until purchaseLine.Next() = 0;
    end;

    local procedure PostDocumentMod(PostingCodeunitID: Integer; Navigate: Option)
    var
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        IsScheduledPosting: Boolean;
    begin
        if ApplicationAreaMgmtFacade.IsFoundationEnabled then
            LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not PurchaseHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;

        if IsScheduledPosting then
            CurrPage.Close;
        CurrPage.Update(false);

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post Modified" then
            exit;

        case Navigate of
            NavigateAfterPost::"Posted Document":
                if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
                    ShowPostedConfirmationMessageMod();
            NavigateAfterPost::"New Document":
                if DocumentIsPosted then begin
                    Clear(PurchaseHeader);
                    PurchaseHeader.Init();
                    PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
                    PurchaseHeader.Insert(true);
                    PAGE.Run(PAGE::"Purchase Order", PurchaseHeader);
                end;
        end;
    end;

    local procedure ShowPostedConfirmationMessageMod()
    var
        OrderPurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not OrderPurchaseHeader.Get(Rec."Document Type", Rec."No.") then begin
            PurchInvHeader.SetRange("No.", Rec."Last Posting No.");
            if PurchInvHeader.FindFirst then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchaseOrderQst, PurchInvHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode)
                then
                    PAGE.Run(PAGE::"Posted Purchase Invoice", PurchInvHeader);
        end;
    end;
}