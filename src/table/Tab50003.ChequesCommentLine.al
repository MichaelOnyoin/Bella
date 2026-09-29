table 50003 "Cheques Comment Line"
{
    Caption = 'Cheques Comment Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
        }
        field(7; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
    }

    keys
    {
        key(Key1; "No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure SetUpNewLine()
    var
        ChequeCommentLine: Record "Cheques Comment Line";
    begin
        ChequeCommentLine.SetRange("No.", "No.");
        ChequeCommentLine.SetRange("Document Line No.", "Document Line No.");
        ChequeCommentLine.SetRange("Line No.", Rec."Line No.");
        ChequeCommentLine.SetRange(Date, WorkDate);
        if not ChequeCommentLine.FindFirst then
            Date := WorkDate;

        OnAfterSetUpNewLine(Rec, ChequeCommentLine);
    end;

    procedure CopyComments(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        ChequeCommentLine: Record "Cheques Comment Line";
        ChequeCommentLine2: Record "Cheques Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCopyComments(ChequeCommentLine, ToDocumentType, IsHandled, FromDocumentType, FromNumber, ToNumber);
        if IsHandled then
            exit;

        ChequeCommentLine.SetRange("No.", FromNumber);
        if ChequeCommentLine.FindSet() then
            repeat
                Clear(ToNumber);
                ChequeCommentLine2 := ChequeCommentLine;
                ChequeCommentLine2."No." += ToNumber;
                ChequeCommentLine2.Insert();
            until ChequeCommentLine.Next() = 0;
    end;

    procedure CopyLineComments(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; FromDocumentLineNo: Integer; ToDocumentLineNo: Integer)
    var
        ChequeCommentLineSource: Record "Cheques Comment Line";
        ChequeCommentLineTarget: Record "Cheques Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCopyLineComments(
          ChequeCommentLineTarget, IsHandled, FromDocumentType, ToDocumentType, FromNumber, ToNumber, FromDocumentLineNo, ToDocumentLineNo);
        if IsHandled then
            exit;

        ChequeCommentLineSource.SetRange("No.", FromNumber);
        ChequeCommentLineSource.SetRange("Document Line No.", FromDocumentLineNo);
        if ChequeCommentLineSource.FindSet() then
            repeat
                ChequeCommentLineTarget := ChequeCommentLineSource;
                ChequeCommentLineTarget."No." := ToNumber;
                ChequeCommentLineTarget."Document Line No." := ToDocumentLineNo;
                ChequeCommentLineTarget.Insert();
            until ChequeCommentLineSource.Next() = 0;
    end;

    procedure CopyHeaderComments(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        ChequeCommentLineSource: Record "Cheques Comment Line";
        ChequeCommentLineTarget: Record "Cheques Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCopyHeaderComments(ChequeCommentLineTarget, IsHandled, FromDocumentType, ToDocumentType, FromNumber, ToNumber);
        if IsHandled then
            exit;

        ChequeCommentLineSource.SetRange("No.", FromNumber);
        ChequeCommentLineSource.SetRange("Document Line No.", 0);
        if ChequeCommentLineSource.FindSet() then
            repeat
                ChequeCommentLineTarget := ChequeCommentLineSource;
                ChequeCommentLineTarget."No." := ToNumber;
                ChequeCommentLineTarget.Insert();
            until ChequeCommentLineSource.Next() = 0;
    end;

    procedure DeleteComments(DocType: Option; DocNo: Code[20])
    begin
        SetRange("No.", DocNo);
        if not IsEmpty then
            DeleteAll();
    end;

    procedure ShowComments(DocType: Option; DocNo: Code[20]; DocLineNo: Integer)
    var
        ChequesCommentSheet: Page "Cheques Comment Sheet";
    begin
        SetRange("No.", DocNo);
        SetRange("Document Line No.", DocLineNo);
        Clear(ChequesCommentSheet);
        ChequesCommentSheet.SetTableView(Rec);
        ChequesCommentSheet.RunModal;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetUpNewLine(var ChequesCommentLineRec: Record "Cheques Comment Line"; var ChequesCommentLineFilter: Record "Cheques Comment Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyComments(var ChequesCommentLine: Record "Cheques Comment Line"; ToDocumentType: Integer; var IsHandled: Boolean; FromDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyLineComments(var ChequesCommentLine: Record "Cheques Comment Line"; var IsHandled: Boolean; FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; FromDocumentLineNo: Integer; ToDocumentLine: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyHeaderComments(var ChequesCommentLine: Record "Cheques Comment Line"; var IsHandled: Boolean; FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    begin
    end;
}
