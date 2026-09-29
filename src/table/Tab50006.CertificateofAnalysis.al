table 50006 "Certificate of Analysis"
{
    DataClassification = ToBeClassified;
    Permissions = tabledata 50006 = rimd;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item No"; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(3; "Item Name"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item.Description where("No." = field("Item No")));
        }
        field(4; "Formaulation Number"; Code[30])
        {
        }
        field(5; "AR No."; code[40])
        {
        }
        field(6; "Batch No"; Code[30])
        {
        }
        field(7; Machine; Code[20])
        {
        }
        field(8; Date; Date)
        {
        }
        field(9; "Batch Size"; Code[20])
        {
        }
        field(10; Appearance; Text[50])
        {
        }
        field(11; Odour; Text[50])
        {
        }
        field(12; "PH Value"; Text[50])
        {
        }
        field(13; "Total Viable Count"; Text[50])
        {
        }
        field(14; "Yeast and Mould"; Text[50])
        {
        }
        field(15; Initiator; Text[50])
        {
        }
        field(16; Date1; Date)
        {
        }
        field(17; Signature1; Blob)
        {
        }
        field(18; Approver; Text[50])
        {
        }
        field(19; Date2; Date)
        {
        }
        field(20; Signature2; Blob)
        {
        }
        field(50022; "Appearance Method"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Appearance Method" where("No." = field("Item No")));
        }
        field(50023; "Appearance Unit"; Code[10])
        {
            //TableRelation = "Unit of Measure".Code;
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Appearance Unit" where("No." = field("Item No")));
        }
        field(50024; "Appearance Specification"; Code[50])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Appearance Specification" where("No." = field("Item No")));
        }
        field(50025; "Odour Method"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Odour Method" where("No." = field("Item No")));
        }
        field(50026; "Odour Unit"; Code[10])
        {
            //TableRelation = "Unit of Measure".Code;
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Odour Unit" where("No." = field("Item No")));
        }
        field(50027; "Odour Specification"; Code[50])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Odour Specification" where("No." = field("Item No")));
        }
        field(50028; "PH value Method"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."PH value Method" where("No." = field("Item No")));
        }
        field(50029; "PH value Unit"; Code[10])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."PH value Unit" where("No." = field("Item No")));
        }
        field(50030; "PH value Specification"; Code[50])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."PH value Specification" where("No." = field("Item No")));
        }
        field(50031; "Total viable count Method"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Total viable count Method" where("No." = field("Item No")));
        }
        field(50032; "Total viable count Unit"; Code[10])
        {
            //TableRelation = "Unit of Measure".Code;

            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Total viable count Unit" where("No." = field("Item No")));
        }
        field(50033; "Total viable count Spec"; Code[50])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Total viable count Spec" where("No." = field("Item No")));
        }
        field(50034; "Yeast and mould count Method"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Yeast and mould count Method" where("No." = field("Item No")));
        }
        field(50035; "Yeast and mould count Unit"; Code[10])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Yeast and mould count Unit" where("No." = field("Item No")));
        }
        field(50036; "Yeast and mould count Spec"; Code[50])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Yeast and mould count Spec" where("No." = field("Item No")));
        }
        field(50037; "Lather volume Method"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Lather volume Method" where("No." = field("Item No")));
        }
        field(50038; "Lather volume Unit"; Code[10])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Lather volume Unit" where("No." = field("Item No")));
        }
        field(50039; "Lather volume Spec"; Code[50])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Lather volume Spec" where("No." = field("Item No")));
        }
        field(50040; "Spec gravity at 20⁰C Method"; Text[100])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Spec gravity at 20⁰C Method" where("No." = field("Item No")));
        }
        field(50041; "Spec gravity at 20⁰C Unit"; Code[10])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Spec gravity at 20⁰C Unit" where("No." = field("Item No")));
        }
        field(50042; "Spec gravity at 20⁰C-Spec"; Code[50])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Spec gravity at 20⁰C-Spec" where("No." = field("Item No")));
        }
        field(40043; "Appearace Value"; Code[10])
        {
        }
        field(40044; "Odour Value"; Code[10])
        {
        }
        field(40045; "PH Val"; Code[10])
        {
        }
        field(40046; "Vaible Count Value"; Code[10])
        {
        }
        field(40047; "Yeast&Mold Value"; Code[10])
        {
        }
        field(40048; "LatherVol Value"; Code[10])
        {
        }
        field(40049; "SpecGrav Value"; Code[10])
        {
        }
        field(40050; "No. Series"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(key2; "Item No")
        {
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        InventorySetup: Record "Inventory Setup";
        NoSerieMgt: Codeunit NoSeriesManagement;

        CertificateOfAnalysis: Record "Certificate of Analysis";

    trigger OnInsert()
    begin
        InventorySetup.Get();
        InventorySetup.TestField("COA Number");
        if Rec."No." = '' then begin
            NoSerieMgt.InitSeries(InventorySetup."COA Number", xRec."No.", 0D, Rec."No.", Rec."No. Series");
        end;
    end;

    procedure AssistEdit(OldCOA: Record "Certificate of Analysis"): Boolean
    begin
        if CertificateOfAnalysis.FindSet() then begin
            CertificateOfAnalysis := Rec;
            InventorySetup.Get();
            InventorySetup.TestField("COA Number");
            if NoSerieMgt.SelectSeries(InventorySetup."COA Number", OldCOA."No. Series", Rec."No. Series") then begin
                InventorySetup.Get();
                InventorySetup.TestField("COA Number");
                NoSerieMgt.SetSeries("No.");
                Rec := CertificateOfAnalysis;
                exit(true);
            end;
        end;
    end;

    // trigger OnModify()
    // begin

    // end;

    // trigger OnDelete()
    // begin

    // end;

    // trigger OnRename()
    // begin

    // end;
}