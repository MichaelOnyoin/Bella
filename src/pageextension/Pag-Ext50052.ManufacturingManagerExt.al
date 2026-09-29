pageextension 50052 "Manufacturing Manager Ext" extends "Manufacturing Manager RC"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(Group11)
        {
            group("Employee Self Service")
            {
                action("Cash Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Requisitions';
                    Image = ReceiptLines;
                    RunObject = page "AdvancePurchase RequisitionsSS";
                }
                action("Purchase Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Requisitions';
                    Image = ReceiptLines;
                    RunObject = page "Purchase Requisitions Self";
                }
            }

            group(Requisitions)
            {
                group("Cash Requests")
                {
                    group("Transfered Cash Requisitions")
                    {
                        action("Assigned Cash Requisitions")
                        {
                            ApplicationArea = All;
                            Caption = 'Assigned Transfered Cash Requisitions';
                            Image = ReceiptLines;
                            RunObject = page "Assigned Cash Requisitions";
                            RunPageView = where("Transfered To Journals" = filter(true), Status = filter(Released));
                        }
                        action("All Cash Requisitions")
                        {
                            ApplicationArea = All;
                            Caption = 'All Transfered Cash Requisitions';
                            Image = ReceiptLines;
                            RunObject = page "Advance Purchase Requisitions";
                            RunPageView = where("Transfered To Journals" = filter(true), Status = filter(Released));
                        }
                    }
                    group("Released Cash Requisitions")
                    {
                        action("AssignedR Cash Requisitions")
                        {
                            ApplicationArea = All;
                            Caption = 'Assigned Released Cash Requisitions';
                            Image = ReceiptLines;
                            RunObject = page "Assigned Cash Requisitions";
                            RunPageView = where("Transfered To Journals" = filter(false), Status = filter(Released));
                        }
                        action("AllR Cash Requisitions")
                        {
                            ApplicationArea = All;
                            Caption = 'All Released Cash Requisitions';
                            Image = ReceiptLines;
                            RunObject = page "Advance Purchase Requisitions";
                            RunPageView = where("Transfered To Journals" = filter(false), Status = filter(Released));
                        }
                    }
                    group("Pending Cash Requisitions")
                    {
                        action("AssignedP Cash Requisitions")
                        {
                            ApplicationArea = All;
                            Caption = 'Assigned Pending Cash Requisitions';
                            Image = ReceiptLines;
                            RunObject = page "Assigned Cash Requisitions";
                            RunPageView = where(Status = filter("Pending Approval"));
                        }
                        action("PendingP Cash Requisitions")
                        {
                            ApplicationArea = All;
                            Caption = 'All Pending Cash Requisitions';
                            Image = ReceiptLines;
                            RunObject = page "Advance Purchase Requisitions";
                            RunPageView = where(Status = filter("Pending Approval"));
                        }
                    }
                    group("Open Cash Requisitions")
                    {
                        action("AssignedO Cash Requisitions")
                        {
                            ApplicationArea = All;
                            Caption = 'Assigned Open Cash Requisitions';
                            Image = ReceiptLines;
                            RunObject = page "Assigned Cash Requisitions";
                            RunPageView = where(Status = filter(Open));
                        }
                        action("OpenO Cash Requisitions")
                        {
                            ApplicationArea = All;
                            Caption = 'All Open Cash Requisitions';
                            Image = ReceiptLines;
                            RunObject = page "Advance Purchase Requisitions";
                            RunPageView = where(Status = filter(Open));
                        }
                    }
                }
                group("Purchase Requests")
                {
                    group("Released Purchase Requisitions")
                    {
                        action("Assigned Released Purchase Requisitions")
                        {
                            ApplicationArea = All;
                            Image = ReceiptLines;
                            RunObject = page "Assigned Purchase Requisitions";
                            RunPageView = where(Status = filter("Released"));
                        }
                        action("All Released Purchase Requisitions")
                        {
                            ApplicationArea = All;
                            Image = ReceiptLines;
                            RunObject = page "Purchase Requisitions";
                            RunPageView = where(Status = filter("Released"));
                        }
                    }
                    group("Pending Purchase Requisitions")
                    {
                        action("Assigned Pending Purchase Requisitions")
                        {
                            ApplicationArea = All;
                            Image = ReceiptLines;
                            RunObject = page "Assigned Purchase Requisitions";
                            RunPageView = where(Status = filter("Pending Approval"));
                        }
                        action("All Pending Purchase Requisitions")
                        {
                            ApplicationArea = All;
                            Image = ReceiptLines;
                            RunObject = page "Purchase Requisitions";
                            RunPageView = where(Status = filter("Pending Approval"));
                        }
                    }
                    group("Open Purchase Requisitions")
                    {
                        action("Assigned Open Purchase Requisitions")
                        {
                            ApplicationArea = All;
                            Image = ReceiptLines;
                            RunObject = page "Assigned Purchase Requisitions";
                            RunPageView = where(Status = filter(Open));
                        }
                        action("All Open Purchase Requisitions")
                        {
                            ApplicationArea = All;
                            Image = ReceiptLines;
                            RunObject = page "Purchase Requisitions";
                            RunPageView = where(Status = filter(Open));
                        }
                    }
                }
                action("Purchase Requisition Archives")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Requisition Archives';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Archive;
                    RunObject = page "Purchase Requisition Archives";
                }
                action(RequestsToApprove)
                {
                    ApplicationArea = All;
                    Caption = 'Requests to Approve';
                    RunObject = page "Requests to Approve";
                    Image = SendApprovalRequest;
                }
            }
        }
    }
}