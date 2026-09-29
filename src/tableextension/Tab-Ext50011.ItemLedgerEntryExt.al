tableextension 50011 "ItemLedgerEntryExt" extends "Item Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50011; "Transfer From"; Code[30]) { }
        field(50012; "Transfer To"; Code[30]) { }
        field(50013; "Transfer Reason"; Option)
        {
            OptionMembers = Normal,Damage;
        }
        field(50014; "Customer Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name WHERE("No." = FIELD("Source No.")));
        }
        field(50015; "Sender ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Approval Entry"."Sender ID" WHERE("Document No." = FIELD("Document No."), Status = CONST(Approved)));
        }
        field(50016; "Approver ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Posted Approval Entry"."Approver ID" WHERE("Document No." = FIELD("Document No."), Status = CONST(Approved)));
        }
        field(50017; "USER ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Value Entry"."User ID" WHERE("Document No." = FIELD("Document No.")));
            trigger OnLookup()
            var
                ApprovalEntry: Record "Posted Approval Entry";
            begin
                IF "USER ID" = '' then begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Document No.", Rec."Document No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                    IF ApprovalEntry.FindFirst() then
                        "USER ID" := ApprovalEntry."Sender ID";
                end;
            end;
        }
        field(50018; "Vend. Invoice No."; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Header"."Vendor Order No." WHERE("No." = FIELD("Document No.")));
        }
        field(50019; "Item Description"; Text[50])
        {
            //TableRelation = Item.Description where("No." = field("Item No."));
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
        field(50020; "Inventory Poating Group"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Inventory Posting Group" where("No." = field("Item No.")));
        }
        field(50021; "Customer Group"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Customer Posting Group" WHERE("No." = FIELD("Source No.")));
        }
       
    }
}