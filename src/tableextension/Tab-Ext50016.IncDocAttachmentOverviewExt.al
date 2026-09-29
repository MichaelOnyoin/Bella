tableextension 50016 "IncDoc Attachment Overview Ext" extends "Inc. Doc. Attachment Overview"
{
    fields
    {
        // Add changes to table fields here
    }

    var
        SortingOrder: Integer;
        IncomingDocumentAttachment: Record "Incoming Document Attachment";

    local procedure AssignSortingNo(VAR TempIncDocAttachmentOverview: Record "Inc. Doc. Attachment Overview" TEMPORARY; VAR SortingOrder: Integer)
    begin
        SortingOrder += 1;
        TempIncDocAttachmentOverview."Sorting Order" := SortingOrder;
    end;

    procedure InsertFromEmployeeIncomingDoc(VAR IncomingDcoument: Record "Incoming Document"; VAR TempIncDocAttachmentOverview: Record "Inc. Doc. Attachment Overview" TEMPORARY)
    begin
        CLEAR(TempIncDocAttachmentOverview);
        IncomingDocumentAttachment.SETRANGE("Incoming Document Entry No.", IncomingDcoument."Entry No.");
        IF IncomingDocumentAttachment.FINDSET THEN BEGIN
            TempIncDocAttachmentOverview.INIT;
            TempIncDocAttachmentOverview.TRANSFERFIELDS(IncomingDocumentAttachment);
            AssignSortingNo(TempIncDocAttachmentOverview, SortingOrder);
            TempIncDocAttachmentOverview."Attachment Type" := TempIncDocAttachmentOverview."Attachment Type"::"Main Attachment";
            TempIncDocAttachmentOverview.Indentation := 0;
            TempIncDocAttachmentOverview.INSERT(TRUE);
        END;
    end;
}