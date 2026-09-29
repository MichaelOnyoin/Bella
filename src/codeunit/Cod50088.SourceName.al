codeunit 50088 "Source Name"
{
    procedure GetSourceName(SourceType: Enum "Gen. Journal Source Type"; SourceNo: Code[20]): Text[100]
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        BankAccount: Record "Bank Account";
        Employee: Record Employee;
    begin
        case SourceType of
            SourceType::Customer:
                if Customer.Get(SourceNo) then
                    exit(Customer.Name);
            SourceType::Vendor:
                if Vendor.Get(SourceNo) then
                    exit(Vendor.Name);
            SourceType::"Bank Account":
                if BankAccount.Get(SourceNo) then
                    exit(BankAccount.Name);
            
        end;
        exit('');
    end;
}