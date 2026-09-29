tableextension 50006 "VendorExt" extends Vendor
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Bank Name"; Text[100])
        {
        }
        field(50002; "Name Of Beneficiary"; Text[100])
        {
        }
        field(50003; "Bank Account No."; Text[30])
        {
        }
        field(50004; "Bank Code"; Text[30])
        {
        }
        field(50005; "Mobile Money Number"; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(50010; "Booking No."; Code[30])
        {
        }
        field(50020; "Vendor Type"; Option)
        {
            OptionMembers = " ",DOMESTIC,FOREIGN;
        }
        field(50025; "VAT Registration Nos."; Text[20])
        {
            Caption = 'VAT Registration No.';
            NotBlank = true;

            trigger OnValidate()
            begin
                "VAT Registration No." := UpperCase("VAT Registration Nos.");
            end;
        }
        field(50030; "TIN Mandatory"; Boolean)
        {
        }
        field(50011; "Post Dated Cheque Amount"; Decimal)
        {
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = SUM("Gen. Journal Line"."Amount (LCY)" WHERE("Account No." = FIELD("No."),
                                                                        "Account Type" = CONST(Vendor),
                                                                        "Journal Batch Name" = CONST('VEND_CHECQ'),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "Currency Code" = FIELD("Currency Code")));
            Editable = false;
        }
        field(50012; "Post Dated Checque Amount(LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = SUM("Gen. Journal Line"."Amount (LCY)" WHERE("Account No." = FIELD("No."),
                                                                        "Account Type" = CONST(Vendor),
                                                                        "Journal Batch Name" = CONST('VEND_CHECQ'),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "Currency Code" = FIELD("Currency Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; "Minimum Order Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    trigger OnModify()
    begin
    end;
}
