page 50031 "Material Requisition"
{
    Caption = 'Material Requisition';
    PromotedActionCategories = 'New,Process,Report,Release,Approval,Request Approval';
    PageType = Card;
    SourceTable = "Material Requisition Header";
    UsageCategory = Documents;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = Rec.Status = Rec.Status::Open;

                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No. field.', Comment = '%';
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                group(Comments)
                {
                    field(ApprovalComments; Rec.Comments)
                    {
                        Editable = false;
                        ShowCaption = false;
                        Importance = Additional;
                    }
                }
                field("Transfered To Journals"; Rec."Transfered To Journals")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                group("Work Description")
                {
                    Caption = 'Description';
                    field(WorkDescription; WorkDescription)
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the products or service being offered.';

                        trigger OnValidate()
                        begin
                            Rec.SetWorkDescription(WorkDescription);
                        end;
                    }
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    Style = Strong;
                    Editable = false;
                }
            }
            part(MaterialRequisitionLines; "Material Requisition Subform")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                Enabled = Rec.Department <> '';
                Editable = Rec."Requisition No." <> '';
                SubPageLink = "Requisition No." = field("Requisition No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send Approval Request';
                Enabled = Rec.Status = Rec.Status::Open;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Request approval of the Material Requisition.';

                trigger OnAction()
                begin
                    "Validate Material Requisition"(Rec);
                    Variant := Rec;
                    if ApprovalsHandler.CheckApprovalsWorkflowEnabled(Variant) then
                        ApprovalsHandler.OnSendDocForApproval(Variant);
                end;
            }
            action("Cancel")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Request';
                Enabled = Rec.Status = Rec.Status::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Cancel approval of the Material Requisition.';

                trigger OnAction()
                begin
                    Variant := Rec;
                    ApprovalsHandler.OnCancelDocApprovalRequest(Variant);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Approve the requested changes.';
                Visible = OpenApprovalEntriesExistForCurrUser;

                trigger OnAction()
                begin
                    ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Reject the approval request.';
                Visible = OpenApprovalEntriesExistForCurrUser;

                trigger OnAction()
                begin
                    ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(Delegate)
            {
                ApplicationArea = All;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = true;
                ToolTip = 'Delegate the approval to a substitute approver.';
                Visible = OpenApprovalEntriesExistForCurrUser;

                trigger OnAction()
                begin
                    ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(Release)
            {
                ApplicationArea = Suite;
                Caption = 'Re&lease';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = Rec."Transfered To Journals" = false;
                ShortCutKey = 'Ctrl+F9';
                ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                trigger OnAction()
                begin
                    ReleaseMaterialRequisition();
                end;
            }
            action(Reopen)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Re&open';
                Enabled = Rec.Status <> Rec.Status::Open;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Visible = Rec."Transfered To Journals" = false;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                trigger OnAction()
                begin
                    ReOpenMaterialRequisition();
                end;
            }
            action("Transfer to Journals")
            {
                ApplicationArea = Basic, Suite;
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    "Transfer Material Requisition To Journals"(Rec);
                end;
            }
            action("Print Material Requisition")
            {
                ApplicationArea = Basic, Suite;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    Rec.TestField("Journal Template Name");
                    Rec.TestField("Journal Batch Name");

                   PrintMaterialRequisition();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        WorkDescription := Rec.GetWorkDescription();
        SetControlAppearance();
    end;

    local procedure PrintMaterialRequisition()
    var
        MaterialRequisitionHeader: Record "Material Requisition Header";
    begin
        MaterialRequisitionHeader.Reset();
        MaterialRequisitionHeader.SetRange("Requisition No.", Rec."Requisition No.");
        if MaterialRequisitionHeader.FindFirst() then
            Report.Run(50074, true, false, MaterialRequisitionHeader);
    end;

    local procedure ReleaseMaterialRequisition()
    begin
        if not Confirm(ReleaseQuestion) then exit;
        Rec.Status := Rec.Status::Released;
        Rec.Modify();
    end;

    local procedure ReOpenMaterialRequisition()
    begin
        if not Confirm(ReopenQuestion) then exit;
        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Document No.", Rec."Requisition No.");
        if ApprovalEntries.FindFirst() then begin
            repeat begin
                if (ApprovalEntries.Status in [ApprovalEntries.Status::Open, ApprovalEntries.Status::Created, ApprovalEntries.Status::Rejected, ApprovalEntries.Status::Approved]) then begin
                    ApprovalEntries.Status := ApprovalEntries.Status::Canceled;
                    ApprovalEntries.Modify();
                end;
            end until ApprovalEntries.Next() = 0;
        end;
        Rec.Status := Rec.Status::Open;
        Rec.Modify();
    end;

    local procedure SetControlAppearance()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Document No.", Rec."Requisition No.");
        if ApprovalEntries.FindFirst() then begin
            repeat begin
                if (ApprovalEntries.Status in [ApprovalEntries.Status::Rejected]) then begin
                    ApprovalCommentLine.SetRange("Record ID to Approve", ApprovalEntries."Record ID to Approve");
                    if ApprovalCommentLine.FindSet() then begin
                        Rec.Comments := ApprovalCommentLine.Comment;
                        Rec.Modify();
                    end;
                end;
            end until ApprovalEntries.Next() = 0;
        end;
    end;

    local procedure "Validate Material Requisition"(var MaterialRequisitionHeader: Record "Material Requisition Header")
    begin
        MaterialRequisitionHeader.TestField("Transfered To Journals", false);
        MaterialRequisitionHeader.TestField("Document Date");
        MaterialRequisitionHeader.TestField("Posting Date");
        MaterialRequisitionHeader.TestField(Department);
        MaterialRequisitionHeader.TestField(Description);
        MaterialRequisitionHeader.TestField("Location Code");
        MaterialRequisitionHeader.TestField("Journal Template Name");
        MaterialRequisitionHeader.TestField("Journal Batch Name");
        MaterialRequisitionLine.Reset();
        MaterialRequisitionLine.SetRange("Requisition No.", MaterialRequisitionHeader."Requisition No.");
        if MaterialRequisitionLine.FindSet() then begin
            repeat begin
                MaterialRequisitionLine.TestField("Posting Date");
                MaterialRequisitionLine.TestField("Item No.");
                MaterialRequisitionLine.TestField("Location Code");
                MaterialRequisitionLine.TestField("Gen. Bus. Posting Group");
                MaterialRequisitionLine.TestField("Journal Template Name");
                MaterialRequisitionLine.TestField("Journal Batch Name");
            end until MaterialRequisitionLine.Next() = 0;
        end;
    end;

    local procedure "Clear General Journal Line"()
    begin
        if not ItemJournalLine.IsEmpty then
            ItemJournalLine.DeleteAll();
    end;

    local procedure "Get default item journal template and batch"()
    begin
        if ItemJnlTemplate.Get(MaterialRequisitionLine."Journal Template Name") then begin
            DefaultJournalTemplate := ItemJnlTemplate.Name;
            if ItemJnlBatch.Get(DefaultJournalTemplate, MaterialRequisitionLine."Journal Batch Name") then begin
                DefaultJournalBatch := ItemJnlBatch.Name;
            end else
                Error(Text001, DefaultJournalBatch, DefaultJournalTemplate);
        end else
            Error(Text002);
    end;

    local procedure "Get Item Journal Document No."(var MaterialRequisitionHeader: Record "Material Requisition Header")
    begin
        if ItemJnlBatch."No. Series" <> '' then begin
            DocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", MaterialRequisitionHeader."Posting Date", false);
        end
        else
            DocNo := MaterialRequisitionHeader."Requisition No.";
    end;

    local procedure "Transfer Material Requisition To Journals"(var MaterialRequisitionHeader: Record "Material Requisition Header")
    begin
        "Validate Material Requisition"(MaterialRequisitionHeader);
        MaterialRequisitionLine.Reset();
        MaterialRequisitionLine.SetRange("Requisition No.", MaterialRequisitionHeader."Requisition No.");
        if MaterialRequisitionLine.FindSet() then begin
            "Clear General Journal Line"();
            LineNo := 10000;
            "Get default item journal template and batch"();
            "Get Item Journal Document No."(MaterialRequisitionHeader);
            repeat begin
                ItemJournalLine.Init();
                ItemJournalLine.Validate("Journal Template Name", DefaultJournalTemplate);
                ItemJournalLine.Validate("Journal Batch Name", DefaultJournalBatch);
                ItemJournalLine.Validate("Posting Date", MaterialRequisitionHeader."Posting Date");
                ItemJournalLine.Validate("Line No.", LineNo);
                ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::Transfer);
                ItemJournalLine.Validate("Type Entry", ItemJournalLine."Type Entry"::"Negative Adjmt.");
                ItemJournalLine.Validate("Document No.", DocNo);
                ItemJournalLine.Validate("Item No.", MaterialRequisitionLine."Item No.");
                ItemJournalLine.Validate("Location Code", MaterialRequisitionLine."Location Code");
                ItemJournalLine.Validate("New Location Code", '');
                ItemJournalLine.Validate(Quantity, MaterialRequisitionLine.Quantity);
                ItemJournalLine.Validate("Unit Amount", MaterialRequisitionLine."Unit Amount");
                ItemJournalLine.Validate(Amount, MaterialRequisitionLine.Amount);
                ItemJournalLine.Validate("Unit Cost", MaterialRequisitionLine."Unit Cost");
                ItemJournalLine.Validate("Gen. Bus. Posting Group", MaterialRequisitionLine."Gen. Bus. Posting Group");
                ItemJournalLine.Validate("Gen. Prod. Posting Group", MaterialRequisitionLine."Gen. Prod. Posting Group");
                ItemJournalLine.Validate("Shortcut Dimension 1 Code", MaterialRequisitionLine."Shortcut Dimension 1 Code");
                ItemJournalLine.Validate("Shortcut Dimension 2 Code", MaterialRequisitionLine."Shortcut Dimension 2 Code");
                ItemJournalLine.Validate("New Shortcut Dimension 1 Code", MaterialRequisitionLine."Shortcut Dimension 3 Code");
                ItemJournalLine.Validate("New Shortcut Dimension 2 Code", MaterialRequisitionLine."Shortcut Dimension 4 Code");
                ItemJournalLine.Insert();
                LineNo += 10000;
            end until MaterialRequisitionLine.Next() = 0;
        end;
        ItemJournal.Run();
    end;

    var
        WorkDescription: Text;
        MaterialRequisitionLine: Record "Material Requisition Line";
        ItemJournalLine: Record "Item Journal Line";
        LineNo: Integer;
        ItemJournal: Page "Item Journal";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        DefaultJournalTemplate, DefaultJournalBatch, DocNo : Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: Label 'Default journal batch %1 not found for template %2';
        Text002: Label 'Default item journal template not found.';
        ReleaseQuestion: Label 'Are you sure you want to release this Material Requisition?';
        ReopenQuestion: Label 'Are you sure you want to reopen this Material Requisition?';
        ApprovalEntries: Record "Approval Entry";
        ApprovalCommentLine: Record "Approval Comment Line";
        ApprovalComments: Page "Approval Comments";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser, OpenApprovalEntriesExist, CanCancelApprovalForRecord : Boolean;
        ApprovalsHandler: Codeunit "Material Req Approvals Handler";
        Variant: Variant;
}