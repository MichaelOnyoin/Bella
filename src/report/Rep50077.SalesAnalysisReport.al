report 50077 "Sales Analysis Report"
{
    ApplicationArea = All;
    Caption = 'Sales Analysis Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Sales Analysis.rdlc';
    dataset
    {
        dataitem("Company Information";"Company Information")
        {
            column(TotalSales; TotalSales) { }
            column(OutStandingDebt; OutStandingDebt) { }
            column(ECommerce; ECommerce) { }
            column(BTM; BTM) { }
            column(InStore; InStore) { }


            column(date1; Date1)
            {

            }
            column(Date2; Date2)
            {

            }
            Column(Company_Name; CompanyInfo.Name) { }
            Column(Company_Address; CompanyInfo.Address) { }
            Column(Company_PhoneNo; CompanyInfo."Phone No.") { }
            Column(Company_Picture; CompanyInfo.Picture) { }
            Column(Company_Email; CompanyInfo."E-Mail") { }
            Column(Company_HomePage; CompanyInfo."Home Page") { }

            trigger OnAfterGetRecord()
            var

            begin
                TotalSales := 0;
                InStore := 0;
                ECommerce := 0;
                BTM := 0;
                OtherPlatform := 0;
                OutStandingDebt := 0;
                DebtCollected := 0;

                CustLedgerEnt1.Reset();
                CustLedgerEnt1.SetRange("Posting Date", StartDate, EndDate);
                CustLedgerEnt1.SetRange("Document Type", CustLedgerEnt1."Document Type"::Invoice);
                if CustLedgerEnt1.FindFirst() then begin
                    repeat
                        TotalSales += CustLedgerEnt1."Amount (LCY)";
                    until CustLedgerEnt1.Next() = 0;
                end;

                CustLedgerEnt2.Reset();
                CustLedgerEnt2.SetRange("Posting Date", StartDate, EndDate);
                CustLedgerEnt2.SetRange("Document Type", CustLedgerEnt2."Document Type"::Invoice);
                if CustLedgerEnt2.FindFirst() then begin
                    repeat
                        OutStandingDebt += CustLedgerEnt2."Amount (LCY)";
                    until CustLedgerEnt2.Next() = 0;
                end;

                CustLedgerEnt3.Reset();
                CustLedgerEnt3.SetRange("Posting Date", StartDate, EndDate);
                CustLedgerEnt3.SetRange("Document Type", CustLedgerEnt3."Document Type"::Invoice);
                CustLedgerEnt3.SetRange("Customer No.", 'CUST_RET_10273|CUST_RET_10314');
                if CustLedgerEnt3.FindFirst() then begin
                    repeat
                        InStore += CustLedgerEnt3."Amount (LCY)";
                    until CustLedgerEnt3.Next() = 0;
                end;

                CustLedgerEnt4.Reset();
                CustLedgerEnt4.SetRange("Posting Date", StartDate, EndDate);
                CustLedgerEnt4.SetRange("Document Type", CustLedgerEnt4."Document Type"::Invoice);
                CustLedgerEnt4.SetRange("Customer Posting Group", 'ONLINE');
                if CustLedgerEnt4.FindFirst() then begin
                    repeat
                        ECommerce += CustLedgerEnt4."Amount (LCY)";
                    until CustLedgerEnt4.Next() = 0;
                end;

                CustLedgerEnt5.Reset();
                CustLedgerEnt5.SetRange("Posting Date", StartDate, EndDate);
                CustLedgerEnt5.SetRange("Document Type", CustLedgerEnt5."Document Type"::Invoice);
                CustLedgerEnt5.SetRange("Customer No.", 'CUST_RET_10212');
                if CustLedgerEnt5.FindFirst() then begin
                    repeat
                        BTM += CustLedgerEnt5."Amount (LCY)";
                    until CustLedgerEnt5.Next() = 0;
                end;




            end;
        }
    }



    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Starting Date';

                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Ending Date';
                    }

                }

            }
        }
        actions
        {
            area(processing)
            {
            }
        }

    }
    var
        Companyinfo: Record "Company Information";
        Date1: Date;
        Date2: Date;
        StartDate: Date;
        EndDate: Date;


        CustLedgerEnt1: Record "Cust. Ledger Entry";
        CustLedgerEnt2: Record "Cust. Ledger Entry";
        CustLedgerEnt3: Record "Cust. Ledger Entry";
        CustLedgerEnt4: Record "Cust. Ledger Entry";
        CustLedgerEnt5: Record "Cust. Ledger Entry";
        CustLedgerEnt6: Record "Cust. Ledger Entry";

        TotalSales: Decimal;
        InStore: Decimal;
        ECommerce: Decimal;
        BTM: Decimal;
        OtherPlatform: Decimal;
        OutStandingDebt: Decimal;
        DebtCollected: Decimal;

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        //LocationFilter := Item.GETFILTER("Location Filter");
        Date1 := StartDate;
        Date2 := EndDate;

    end;

}
