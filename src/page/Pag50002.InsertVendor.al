page 50002 "Insert Vendor"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Field("Purchase Vendor No."; Rec."Purchase Vendor No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        VendorGroup: Record Vendor;
                    begin
                        VendorGroup.SetRange(VendorGroup."No.", Rec."Purchase Vendor No.");

                        IF VendorGroup.FindFirst() then
                            repeat
                                Rec."Gen. Bus. Posting Group" := VendorGroup."Gen. Bus. Posting Group";
                            until
                            VendorGroup.Next() = 0;
                    end;
                }
                Field("Purchase Vendor Name"; Rec."Purchase Vendor Name")
                {
                    ApplicationArea = All;
                }
                Field("Contract Purch. Agreement No."; Rec."Contract Purch. Agreement No.")
                {
                    ApplicationArea = All;
                }
                Field("Certificate No."; Rec."Certificate No.")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                end;
            }
        }
    }

    //////=======================
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        purchaseLine: Record "Purchase Line";
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN begin

            purchaseLine.Reset();
            purchaseLine.SetRange(purchaseLine."Document No.", Rec."No.");
            if purchaseLine.FindFirst() then
                repeat
                    purchaseLine."Buy-from Vendor No." := Rec."Purchase Vendor No.";
                    purchaseLine."Pay-to Vendor No." := Rec."Purchase Vendor No.";
                    purchaseLine."Gen. Bus. Posting Group" := Rec."Gen. Bus. Posting Group";
                    purchaseLine.Modify();
                until purchaseLine.Next() = 0;

            IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN begin
                CODEUNIT.RUN(CODEUNIT::"PurchQuote to Order (Yes/No)", Rec);
            end;
        end;
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ContractCertficateShow: Boolean;

    //====================================
    procedure IsContractCertLPO(ContractCertificate: Boolean)
    begin
        ContractCertficateShow := ContractCertificate;
    end;
}