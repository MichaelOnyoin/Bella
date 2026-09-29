codeunit 50085 "Purchase Line Qty Check"
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line",
        'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure OnAfterValidateQuantity(
        var Rec: Record "Purchase Line";
        var xRec: Record "Purchase Line";
        CurrFieldNo: Integer)
    var
        Item: Record Item;
    begin
        // Only item lines
        if Rec.Type <> Rec.Type::Item then
            exit;

        if Rec."No." = '' then
            exit;

        if not Item.Get(Rec."No.") then
            exit;

        // Ignore zero quantity while user is still entering data
        if Rec.Quantity = 0 then
            exit;

        // Minimum quantity check
        if (Item."Minimum Order Quantity" > 0) and
           (Rec.Quantity < Item."Minimum Order Quantity")
        then
            Error(
                'Item %1 - %2 requires a minimum order quantity of %3. Current quantity is %4.',
                Item."No.",
                Item.Description,
                Item."Minimum Order Quantity",
                Rec.Quantity);

        // Maximum quantity check
        if (Item."Maximum Order Quantity" > 0) and
           (Rec.Quantity > Item."Maximum Order Quantity")
        then
            Error(
                'Item %1 - %2 has a maximum order quantity of %3. Current quantity is %4.',
                Item."No.",
                Item.Description,
                Item."Maximum Order Quantity",
                Rec.Quantity);
    end;
}