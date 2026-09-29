report 50007 "Init Req Approval Workflow"
{
    Caption = 'Initialize Material Requisition Approval Workflow';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    trigger OnPostReport()
    var
        CustomApprovalsMgt: Codeunit "Workflow Approval Mgt.";
    begin
        CustomApprovalsMgt.InitCustomApprovalWorkflows();
    end;
}