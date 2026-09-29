codeunit 50084 "Blocked Filter Mgmt"
{
    procedure ToggleFilter(var ShowBlocked: Boolean)
    begin
        ShowBlocked := not ShowBlocked;
    end;

    procedure ApplyItemFilter(var Rec: Record Item; ShowBlocked: Boolean)
    begin
        if ShowBlocked then
            Rec.SetRange(Blocked)
        else
            Rec.SetRange(Blocked, false);
    end;

    procedure ApplyCustomerFilter(var Rec: Record Customer; ShowBlocked: Boolean)
    begin
        if ShowBlocked then
            Rec.SetRange(Blocked)
        else
            Rec.SetRange(Blocked, Rec.Blocked::" ");
    end;
}