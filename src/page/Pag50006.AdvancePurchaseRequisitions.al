page 50006 "Advance Purchase Requisitions"
{
    Caption = 'Advance Purchase Requisitions';
    PageType = List;
    UsageCategory = Lists;
    CardPageId = "Advance Purchase Requisition";
    ApplicationArea = All;
    SourceTable = "Purchase Header";
    Editable = false;
    SourceTableView = WHERE("Document Type" = CONST(Quote), "Requisition Type" = CONST(Advance));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                Field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                Field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnLookup(VAR Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                Field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(VAR Text: Text): Boolean
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                Field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                }
                Field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                Field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                Field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("User ID"; Rec."USER ID")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Working Description"; Rec."Working Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Approver Name"; Rec."Approver Name")
                {
                    ToolTip = 'Specifies the value of the Approver Name field.';
                    ApplicationArea = All;
                }
                Field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Date field.';
                }
            }
        }
        area(Factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                Visible = false;
                ApplicationArea = All;
            }
            part("Vendor Details FactBox"; "Vendor Details FactBox")
            {
                Visible = true;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."), "Date Filter" = FIELD("Date Filter");
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }

            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
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
            group(Conversion)
            {
                group("Convert to")
                {
                    action(Payment)
                    {
                        ApplicationArea = All;
                        Caption = '&Transfer To Journals';
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
                action(Print)
                {
                    ApplicationArea = All;
                    Caption = '&Print';
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Print;
                    Ellipsis = true;
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
                group(Releases)
                {
                    action(Release)
                    {
                        ApplicationArea = All;
                        Caption = 'Re&lease';
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
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
                }
                group("Request Approval")
                {
                    action(SendApprovalRequest)
                    {
                        ApplicationArea = All;
                        Caption = 'Send A&pproval Request';
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            Rec.TestField("Working Description");
                            //---------------------------ASL BUDGET V1.0.0----------------------------
                            //CheckBudget(FALSE);
                            //---------------------------ASL BUDGET V1.0.0----------------------------
                            IF ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) THEN
                                ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                        end;
                    }
                    action(CancelApprovalRequest)
                    {
                        ApplicationArea = All;
                        Caption = 'Cancel Approval Re&quest';
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
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
        area(Reporting)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                Caption = 'Requistion Summary Aging';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report;
                Ellipsis = true;
                //RunObject = Report "Requisition Summary Aging";
                trigger OnAction()
                begin
                end;
            }
        }
    }
    var

        DimMgt: Codeunit DimensionManagement;
        OpenApprovalEntriesExist: Boolean;

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;
}