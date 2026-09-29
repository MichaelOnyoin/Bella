codeunit 50086 "Transfer Posting Extension"
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment",
        'OnAfterInsertTransShptHeader', '', false, false)]
    local procedure CopyHeaderFieldsToShptHeader(
        var TransferHeader: Record "Transfer Header";
        var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        TransferShipmentHeader."Transfer Reason" := TransferHeader."Transfer Reason";
        TransferShipmentHeader."Sales Order No." := TransferHeader."Sales Order No.";
        TransferShipmentHeader.Modify();
    end;
}