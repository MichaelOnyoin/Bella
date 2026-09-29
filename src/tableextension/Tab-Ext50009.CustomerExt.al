tableextension 50009 "CustomerExt" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Allow Sale Beyond Credit limit"; Boolean)
        {
        }
        field(50010; "TIN Mandatory"; Boolean)
        {
        }
        field(50011; "Post Dated Cheque Amount"; Decimal)
        {
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = SUM("Gen. Journal Line".Amount WHERE("Account No." = FIELD("No."),
                                                                "Account Type" = CONST(Customer),
                                                                "Journal Batch Name" = CONST('CUST_CHECQ'),
                                                                "Posting Date" = FIELD("Date Filter"),
                                                                "Currency Code" = FIELD("Currency Code")));
            Editable = false;
        }
        field(50012; "Post Dated Checque Amount(LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = SUM("Gen. Journal Line"."Amount (LCY)" WHERE("Account No." = FIELD("No."),
                                                                        "Account Type" = CONST(Customer),
                                                                        "Journal Batch Name" = CONST('CUST_CHECQ'),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "Currency Code" = FIELD("Currency Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
