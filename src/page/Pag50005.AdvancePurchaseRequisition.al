page 50005 "Advance Purchase Requisition"
{
    PageType = Document;
    Caption = 'Cash Requisitions';
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote), "Requisition Type" = CONST(Advance));
    PromotedActionCategoriesML = ENU = 'New, Process, Report, Approve';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                Field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                Field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Importance = Additional;
                }
                Field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Importance = Additional;
                }
                Field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Importance = Additional;
                }
                Field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Importance = Additional;
                }
                Field("Buy-from City"; Rec."Buy-from City")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Importance = Additional;
                }
                Field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Importance = Additional;
                }
                Field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                Field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                Field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Visible = false;
                }
                Field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Working Description"; Rec."Working Description")
                {
                    ApplicationArea = All;
                }
                Field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                Field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                Field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                Field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                field("USER ID"; Rec."USER ID")
                {
                    ApplicationArea = All;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field("Approver Id"; Rec."Approver Id")
                {
                    ApplicationArea = All;
                }
                field("Approver Name"; Rec."Approver Name")
                {
                    ApplicationArea = All;
                }
                field("Transfered To Journals"; Rec."Transfered To Journals")
                {
                    ApplicationArea = All;
                }
                field("Responsible User"; Rec."Responsible User")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                Field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "Advance Purchase Req Subform")
            {
                ApplicationArea = Suite;
                Caption = 'Lines';
                SubPageLink = "Document No." = FIELD("No."), "Requisition Type" = FIELD("Requisition Type");
                UpdatePropagation = Both;
            }

            group(Invoicing)
            {
                Field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Importance = Promoted;
                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                Field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Pay-to Address"; Rec."Pay-to Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                Field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                Field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Importance = Additional;
                }
                Field("Pay-to City"; Rec."Pay-to City")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                Field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                Field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                Field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                Field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                Field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                Field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                Field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = All;
                }
                Field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = All;
                }
                Field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;
                }
                Field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                Field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
            }

            group(Shipping)
            {
                Field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                Field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                Field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                Field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
                Field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                Field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                Field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                Field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                Field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }

            group("Foreign Trade")
            {
                Field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                Field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                Field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                Field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                Field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec."Area")
                {
                    ApplicationArea = All;
                }
            }
        }

        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(38),
                              "No." = FIELD("No."),
                              "Document Type" = FIELD("Document Type");
            }
            part(Control13; "Pending Approval FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part(Control5; "Purchase Line FactBox")
            {
                ApplicationArea = Suite;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Suite;
                ShowFilter = false;
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&Quote")
            {
                action(Statistics)
                {
                    ApplicationArea = All;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortcutKey = F7;
                    trigger OnAction();
                    begin
                        Rec.CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = All;
                    Image = Vendor;
                    ShortcutKey = 'Shift+F7';
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    trigger OnAction()
                    begin
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = ViewComments;
                    RunObject = page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                    trigger OnAction()
                    begin
                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData Dimension = R;
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';
                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Image = Approvals;
                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Purchase Header", "Document Type", Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
            }
        }
        area(Processing)
        {
            group(Approval)
            {
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Image = Approve;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Image = Reject;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Caption = 'Delegate';
                    Promoted = true;
                    PromotedCategory = Category4;
                    Image = Delegate;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Caption = 'Caption';
                    Image = ViewComments;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Table ID" = CONST(38), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                    trigger OnAction()
                    begin
                    end;
                }
            }
            action(Print)
            {
                ApplicationArea = All;
                Caption = '&Print';
                Promoted = true;
                PromotedCategory = Process;
                Ellipsis = true;
                Image = Print;
                trigger OnAction()
                var
                    PurchaseInvHeader: Record "Purchase Header";
                    PurchaseRequistion: Report "Purchase - Requisition";
                begin
                    PurchaseInvHeader.RESET;
                    PurchaseInvHeader.SETRANGE(PurchaseInvHeader."No.", Rec."No.");
                    PurchaseInvHeader.SetRange(PurchaseInvHeader."Document Type", Rec."Document Type");
                    PurchaseRequistion.SETTABLEVIEW(PurchaseInvHeader);
                    PurchaseRequistion.RUN;
                end;
            }

            group(Conversion)
            {
                group("Convert to")
                {
                    action(Payment)
                    {
                        ApplicationArea = All;
                        Caption = '&Transfer to Journals';
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        Image = Payment;
                        trigger OnAction()
                        begin
                            Rec.ConvertToAdvanceRequisition();
                        end;
                    }
                }
            }

            group(Releases)
            {
                action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    Image = ReleaseDoc;
                    ShortcutKey = 'CTRL+F9';
                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = ReOpen;
                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                action("Budget Check")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = CheckRulesSyntax;
                    trigger OnAction()
                    begin
                        //CheckBudget(TRUE);
                    end;
                }
            }

            //=================================
            group("F&unctions")
            {
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
                action(CalculateInvoiceDiscount)
                {
                    ApplicationArea = All;
                    Caption = 'Calculate &Invoice Discount';
                    AccessByPermission = TableData "Vendor Invoice Disc." = R;
                    Image = CalculateInvoiceDiscount;
                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;
                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                action("Copy Document")
                {
                    ApplicationArea = All;
                    Caption = 'Copy Document';
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = CopyDocument;
                    Visible = false;
                    Ellipsis = true;
                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = All;
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Advance Accountability")
                {
                    ApplicationArea = All;
                    Caption = '&Accountability';
                    Image = Allocate;
                    //RunObject = Page "Advance Accountability";
                    //RunPageLink = Document Type=FILTER(Advance Accountability),No.=FIELD(No.),Document Line No.=CONST(0);
                    trigger OnAction()
                    begin
                    end;
                }
                action("Posted Advance Accountability")
                {
                    ApplicationArea = All;
                    Caption = '&Posted Accountability';
                    Image = Account;
                    //RunObject = Page "Advance Accountability";
                    //RunPageLink = Document Type=FILTER(Posted Accountability),No.=FIELD(No.);
                    trigger OnAction()
                    begin
                    end;
                }
                group(Documents)
                {
                    group("Incoming Documents")
                    {
                        action("View Incoming Document")
                        {
                            ApplicationArea = All;
                            Caption = 'View Incoming Document';
                            Image = ViewOrder;
                            trigger OnAction()
                            var
                                IncomingDocument: Record "Incoming Document";
                            begin
                                IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                            end;
                        }
                        action("Select Incoming Document")
                        {
                            ApplicationArea = All;
                            Caption = 'Select Incoming Document';
                            Image = SelectLineToApply;
                            AccessByPermission = TableData "Incoming Document" = R;
                            trigger OnAction()
                            var
                                IncomingDocument: Record "Incoming Document";
                            begin
                                Rec.VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument("Incoming Document Entry No.", Rec.RECORDID));
                            end;
                        }
                        action("Create Incoming Document from File")
                        {
                            ApplicationArea = All;
                            Caption = 'Create Incoming Document from File';
                            Ellipsis = true;
                            Enabled = NOT HasIncomingDocument;
                            Image = Attach;
                            trigger OnAction()
                            var
                                IncomingDocumentAttachment: Record "Incoming Document Attachment";
                            begin
                                IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                            end;
                        }
                        action("Remove Incoming Document")
                        {
                            ApplicationArea = All;
                            Caption = 'Remove Incoming Document';
                            Enabled = HasIncomingDocument;
                            Image = RemoveLine;
                            trigger OnAction()
                            begin
                            end;
                        }
                    }
                }
            }

            group("Request Approvals")
            {
                action("Send A&pproval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //-----------------------ASL BUDGET V1.0.0---------------------------
                        //CheckBudget(FALSE);
                        //-----------------------ASL BUDGET V1.0.0---------------------------
                        IF ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) THEN
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = All;
                    Enabled = OpenApprovalEntriesExist;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
    //================================Triggers=======================
    trigger OnOpenPage()
    var
        ApprovalEntry: Record "Approval Entry";
        User: Record User;
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FILTERGROUP(0);
        END;

        ApprovalEntry.SetRange(ApprovalEntry."Document Type", ApprovalEntry."Document Type"::Quote);
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", Rec."No.");
        if ApprovalEntry.FindLast() then begin
            User.Reset();
            User.SetRange(User."User Name", ApprovalEntry."Approver ID");
            if User.FindFirst() then
                Rec.Validate("Approver Name", User."Full Name");
            Rec.Validate("Approver Id", ApprovalEntry."Approver ID");
            Rec.Modify();
        end;

        SetDocNoVisible;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Requisition Type" := Rec."Requisition Type"::Advance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Requisition Type" := Rec."Requisition Type"::Advance
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);
    end;
    //========================Functions======================
    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                Rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin

        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Quote, Rec."No.");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
    end;

    local procedure CreatePaymentJournal()
    begin
    end;
}