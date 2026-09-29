table 50082 "Week Report Line"
{
    // ---------------------------------------------------------------
    // Temporary table – holds one row per day (Mon–Sun) for the
    // Bellazuri Weekly Performance Report.
    // TableType = Temporary ensures no physical table is created.
    // ---------------------------------------------------------------
    Caption = 'Bellazuri Week Report Line';
    TableType = Temporary;
    DataClassification = CustomerContent;
    

    fields
    {
        field(1; "Week Start Date"; Date)
        {
            Caption = 'Week Start Date';
            DataClassification = CustomerContent;
        }
        field(2; "Day Date"; Date)
        {
            Caption = 'Day Date';
            DataClassification = CustomerContent;
        }
        field(3; "Day No."; Integer)
        {
            Caption = 'Day No.';
            DataClassification = CustomerContent;
        }

        // ── Sales Revenue (Red fields) ───────────────────────────
        field(10; "Domestic Invoices Net"; Decimal)
        {
            Caption = 'Domestic Invoices (Net of Credit Notes)';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(11; "Cash Received Domestic"; Decimal)
        {
            Caption = 'Cash Received - Domestic';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(12; "Outstanding Domestic"; Decimal)
        {
            Caption = 'Outstanding - Domestic';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }

        // ── Expenses (Red fields) ────────────────────────────────
        field(20; "PO Invoices"; Decimal)
        {
            Caption = 'PO / Invoices';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(21; "Requisitions"; Decimal)
        {
            Caption = 'Requisitions';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(22; "Payments"; Decimal)
        {
            Caption = 'Payments';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(23; "Outstanding Vendor"; Decimal)
        {
            Caption = 'Outstanding - Vendor';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(24; "Petty Cash Payments"; Decimal)
        {
            Caption = 'Petty Cash Payments';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
    }

    keys
    {
        key(PK; "Week Start Date", "Day No.")
        {
            Clustered = true;
        }
    }
}
