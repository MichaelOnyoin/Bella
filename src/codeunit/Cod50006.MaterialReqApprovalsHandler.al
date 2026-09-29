codeunit 50006 "Material Req Approvals Handler"
{
    var
        WorkflowSetup: Codeunit "Workflow Setup";
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        BlankDateFormula: DateFormula;

        ASLWorkflowTemplateToken: Label 'AS-', Locked = true;
        ReqLWorkflowCategoryTxt: Label 'PURCH', Locked = true;
        ReqWorkflowCategoryDescTxt: Label 'Material Requisition Management';
        ReqApprWorkflowCodeTxt: Label 'PURCH', Locked = true;
        ReqWorkflowDescriptionTxt: Label 'Material Requisition Workflow';

        SendMaterialRequisitionForApprovalEventDescTxt: Label 'Approval of a Material Requisition is requested.';
        MaterialRequisitionCancelledEventDescTxt: Label 'An approval request for a Material Requisition is canceled.';

        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';

    procedure CheckApprovalsWorkflowEnabled(var Variant: Variant): Boolean
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Material Requisition Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendMaterialRequisitionForApprovalCode));
            else
                Error(NoWorkflowEnabledErr, RecRef.Caption);
        end;
    end;

    procedure CheckApprovalsWorkflowEnabledCode(var Variant: Variant; CheckApprovalsWorkflowTxt: Text): Boolean
    begin
        begin
            if not WorkflowManagement.CanExecuteWorkflow(Variant, CheckApprovalsWorkflowTxt) then
                Error(NoWorkflowEnabledErr);
            exit(true);
        end;
    end;

    procedure ReqWorkflowCodeTxt(): Code[17]
    begin
        exit(ReqApprWorkflowCodeTxt);
    end;

    procedure RunWorkflowOnSendMaterialRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMaterialRequisitionForApprovalCode'));
    end;

    procedure RunWorkflowOnCancelMaterialRequisitionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMaterialRequisitionApprovalRequest'));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendDocForApproval(var Variant: Variant)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelDocApprovalRequest(var Variant: Variant)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Material Req Approvals Handler", 'OnSendDocForApproval', '', false, false)]
    procedure RunWorkflowOnSendApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Material Requisition Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMaterialRequisitionForApprovalCode, Variant);
            else
                Error(NoWorkflowEnabledErr, RecRef.Caption);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Material Req Approvals Handler", 'OnCancelDocApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Material Requisition Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMaterialRequisitionApprovalRequestCode, Variant);
            else
                Error(NoWorkflowEnabledErr, RecRef.Caption);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Approval Mgt.", 'OnAddExtWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddExtWorkflowEventsToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendMaterialRequisitionForApprovalCode, DATABASE::"Material Requisition Header", SendMaterialRequisitionForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelMaterialRequisitionApprovalRequestCode, DATABASE::"Material Requisition Header", MaterialRequisitionCancelledEventDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Approval Mgt.", 'OnAddExtflowResponsesToLibrary', '', true, true)]
    local procedure OnAddExtflowResponsesToLibrary()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Approval Mgt.", 'OnAddBaseWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddBaseWorkflowResponsePredecessorsToLibrary()
    begin
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, RunWorkflowOnSendMaterialRequisitionForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, RunWorkflowOnSendMaterialRequisitionForApprovalCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, RunWorkflowOnCancelMaterialRequisitionApprovalRequestCode);
        WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, RunWorkflowOnCancelMaterialRequisitionApprovalRequestCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Approval Mgt.", 'OnInsertExtWorkflowCategories', '', true, true)]
    local procedure OnInsertExtWorkflowCategories()
    begin
        WorkflowSetup.InsertWorkflowCategory(ReqApprWorkflowCodeTxt, ReqWorkflowCategoryDescTxt);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Approval Mgt.", 'OnInsertExtWorkflowTemplates', '', true, true)]
    local procedure OnInsertExtWorkflowTemplates()
    var
        Workflow: Record "Workflow";
        WorkflowStep: Record "Workflow Step";
    begin
        if Workflow.Get(ASLWorkflowTemplateToken + ReqWorkflowCodeTxt) then begin
            WorkflowStep.Reset();
            WorkflowStep.SetRange("Workflow Code", Workflow.Code);
            if WorkflowStep.FindSet() then
                WorkflowStep.DeleteAll();
            Workflow.Delete();
        end;
        InsertApprovalsTableRelations();
        WorkflowSetup.SetCustomTemplateToken(ASLWorkflowTemplateToken);
        InsertMaterialRequisitionApprovalWorkflowTemplate();
        WorkflowSetup.SetCustomTemplateToken('');
    end;

    local procedure InsertApprovalsTableRelations()
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        WorkflowSetup.InsertTableRelation(DATABASE::"Material Requisition Header", 0, DATABASE::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    local procedure InsertMaterialRequisitionApprovalWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, ReqApprWorkflowCodeTxt, ReqWorkflowDescriptionTxt, ReqLWorkflowCategoryTxt);
        InsertMaterialRequisitionApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
    end;

    local procedure InsertMaterialRequisitionApprovalWorkflowDetails(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
    begin
        InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateFormula, true);
        WorkflowSetup.InsertRecApprovalWorkflowSteps(Workflow, 'Valid MaterialRequisition Created', RunWorkflowOnSendMaterialRequisitionForApprovalCode(), WorkflowResponseHandling.CreateApprovalRequestsCode(), WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), RunWorkflowOnCancelMaterialRequisitionApprovalRequestCode(), WorkflowStepArgument, true, true);
    end;

    local procedure InitWorkflowStepArgument(var WorkflowStepArgument: Record "Workflow Step Argument"; ApproverType: Enum "Workflow Approver Type"; ApproverLimitType: Enum "Workflow Approver Limit Type"; ApprovalEntriesPage: Integer; WorkflowUserGroupCode: Code[20]; DueDateFormula: DateFormula; ShowConfirmationMessage: Boolean)
    begin
        WorkflowStepArgument.Init();
        WorkflowStepArgument.Type := WorkflowStepArgument.Type::Response;
        WorkflowStepArgument."Approver Type" := ApproverType;
        WorkflowStepArgument."Approver Limit Type" := ApproverLimitType;
        WorkflowStepArgument."Workflow User Group Code" := WorkflowUserGroupCode;
        WorkflowStepArgument."Due Date Formula" := DueDateFormula;
        WorkflowStepArgument."Link Target Page" := ApprovalEntriesPage;
        WorkflowStepArgument."Show Confirmation Message" := ShowConfirmationMessage;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', true, true)]
    local procedure OnExecuteWorkflowResponse(var ResponseExecuted: Boolean; var Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    begin
    end;

    procedure ReOpen(var RecRef: RecordRef; Handled: Boolean)
    var
        MaterialRequisition: Record "Material Requisition Header";
        Variant: Variant;
    begin
        case RecRef.Number of
            Database::"Material Requisition Header":
                begin
                    RecRef.SetTable(MaterialRequisition);
                    MaterialRequisition.Validate(Status, MaterialRequisition.Status::Open);
                    MaterialRequisition.Modify;
                    Variant := MaterialRequisition;
                    Handled := true;
                end;
        end;
    end;

    procedure Release(RecRef: RecordRef; var Handled: Boolean)
    var
        MaterialRequisition: Record "Material Requisition Header";
        Variant: Variant;
    begin
        case RecRef.Number of
            Database::"Material Requisition Header":
                begin
                    RecRef.SetTable(MaterialRequisition);
                    MaterialRequisition.Validate(Status, MaterialRequisition.Status::Released);
                    MaterialRequisition.Modify;
                    Variant := MaterialRequisition;
                    Handled := true;
                end;
        end
    end;

    procedure SetStatusToPending(RecRef: RecordRef; var Variant: Variant; IsHandled: Boolean)
    var
        MaterialRequisition: Record "Material Requisition Header";
    begin
        case RecRef.Number of
            Database::"Material Requisition Header":
                begin
                    RecRef.SetTable(MaterialRequisition);
                    MaterialRequisition.Validate(Status, MaterialRequisition.Status::"Pending Approval");
                    MaterialRequisition.Modify;
                    Variant := MaterialRequisition;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    procedure PopulateApprovalEntryArgument(RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance"; var ApprovalEntryArgument: Record "Approval Entry")
    var
        IncomingDocument: Record "Incoming Document";
        MaterialRequisition: Record "Material Requisition Header";
    begin
        ApprovalEntryArgument.INIT;
        ApprovalEntryArgument."Table ID" := RecRef.Number;
        ApprovalEntryArgument."Record ID to Approve" := RecRef.RECORDID;
        ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
        ApprovalEntryArgument."Approval Code" := WorkflowStepInstance."Workflow Code";
        ApprovalEntryArgument."Workflow Step Instance ID" := WorkflowStepInstance.ID;

        case RecRef.Number of
            Database::"Incoming Document":
                begin
                    RecRef.SetTable(IncomingDocument);
                    ApprovalEntryArgument."Document No." := Format(IncomingDocument."Entry No.");
                end;
            Database::"Material Requisition Header":
                begin
                    RecRef.SetTable(MaterialRequisition);
                    ApprovalEntryArgument."Document No." := MaterialRequisition."Requisition No.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeDelegateApprovalRequests', '', false, false)]
    local procedure OnBeforeDelegateApprovalRequests(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean);
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CustomApproval: Codeunit "Material Req Approvals Handler";
    begin
        CustomApproval.ReOpen(RecRef, true);
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        CustomApproval: Codeunit "Material Req Approvals Handler";
    begin
        CustomApproval.Release(RecRef, Handled);
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        CustomApproval: Codeunit "Material Req Approvals Handler";
    begin
        CustomApproval.SetStatusToPending(RecRef, Variant, true);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageID(RecordRef);
    end;

    local procedure GetConditionalCardPageID(RecRef: RecordRef): Integer
    begin
        case RecRef.Number of
            Database::"Material Requisition Header":
                exit(Page::"Material Requisition");
        end;
    end;
}
