codeunit 50007 "Workflow Approval Mgt."
{
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";

    procedure InitCustomApprovalWorkflows()
    var
        WorkflowResponse: Record "Workflow Response";
        ExtApprovalsHandler: Codeunit "Material Req Approvals Handler";
    begin
        if WorkflowResponse.Get(UpperCase('ASLSendApprovalRequestForApproval')) then
            WorkflowResponse.Delete();
        if WorkflowResponse.Get(UpperCase('ASLCancelAllApprovalRequests')) then
            WorkflowResponse.Delete();

        OnAddExtWorkflowEventsToLibrary();
        OnAddExtflowResponsesToLibrary();
        OnAddBaseWorkflowResponsePredecessorsToLibrary();
        OnInsertExtWorkflowCategories();
        OnInsertExtWorkflowTemplates();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAddExtWorkflowEventsToLibrary()
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAddExtflowResponsesToLibrary()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAddBaseWorkflowResponsePredecessorsToLibrary()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInsertExtWorkflowCategories()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnInsertExtWorkflowTemplates()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        OnAddExtWorkflowEventsToLibrary();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsesToLibrary()
    begin
        OnAddExtflowResponsesToLibrary();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]
    local procedure OnAddWorkflowCategoriesToLibrary()
    begin
        OnInsertExtWorkflowCategories();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]
    local procedure OnInsertWorkflowTemplates()
    begin
        OnInsertExtWorkflowTemplates();
    end;
}
