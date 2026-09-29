table 50007 "Material Requisition Header"
{
    Caption = 'Material Requisition Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Requisition No."; Code[20])
        {
            Caption = 'Requisition No.';
            trigger OnValidate()
            begin
                if "Requisition No." <> xRec."Requisition No." then begin
                    SalesReceivablesSetup.Get();
                    NoSeriesMgt.TestManual(SalesReceivablesSetup."Requisition Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; Description; BLOB)
        {
            Caption = 'Description';
        }
        field(5; Department; Code[20])
        {
            Caption = 'Department';
            TableRelation = "Gen. Business Posting Group";
        }
        field(6; "Transfered To Journals"; Boolean)
        {
        }
        field(7; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(8; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";
        }
        field(9; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(10; Status; Enum "Material Requisition Status")
        {
            Caption = 'Status';
        }
        field(11; Comments; Text[500])
        {

        }
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Requisition No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Requisition No." = '' then begin
            SalesReceivablesSetup.Get();
            SalesReceivablesSetup.TestField("Requisition Nos.");
            NoSeriesMgt.InitSeries(SalesReceivablesSetup."Requisition Nos.", xRec."Requisition No.", 0D, "Requisition No.", "No. Series");
        end;

        Rec."Posting Date" := WorkDate();
        Rec."Document Date" := WorkDate();
    end;

    procedure SetWorkDescription(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Description);
        Description.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify;
    end;

    procedure GetWorkDescription() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields(Description);
        Description.CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), WorkDescription) then
            Message(ReadingDataSkippedMsg, FieldCaption(Description));
    end;

    var
        ReadingDataSkippedMsg: Label 'Loading field %1 will be skipped because there was an error when reading the data.\To fix the current data, contact your administrator.\Alternatively, you can overwrite the current data by entering data in the field.', Comment = '%1=field caption';
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
