codeunit 50083 "Purch Line Flow Handler"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
        'OnBeforePurchRcptLineInsert', '', false, false)]
    local procedure CopyWorkingDescToRcptLine(
        var PurchRcptLine: Record "Purch. Rcpt. Line";
        var PurchLine: Record "Purchase Line")
    begin
        PurchRcptLine."Working Description" := PurchLine."Working Description";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post",
    'OnBeforePurchInvHeaderInsert', '', false, false)]
    local procedure CopyWorkingDescToInvHeader(
    var PurchInvHeader: Record "Purch. Inv. Header";
    var PurchHeader: Record "Purchase Header")
    begin
        PurchInvHeader."Working Description" := PurchHeader."Working Description";
    end;
}