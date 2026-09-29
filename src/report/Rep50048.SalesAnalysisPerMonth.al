report 50048 "Sales Analysis-PerMonth"
{
    Caption = 'Customer Sales Analysis-PerMonth';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './SalesAnalysis-PerMonth.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Customer Posting Group";
            column(Customer_No; "No.")
            {
                IncludeCaption = true;
            }
            column(Customer_Name; Name)
            {
                IncludeCaption = true;
            }
            dataitem(SalesInvLines; "Sales Invoice Line")
            {
                DataItemLinkReference = Customer;
                DataItemLink = "Sell-to Customer No." = field("No.");
                RequestFilterFields = "Posting Date", "SALESPERSON CODE";
                column(Document_No_; "Document No.")
                {
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(Item_No; "No.")
                {
                }
                column(Item_Description; Description)
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Quantity_Invoiced; "Quantity (Base)")
                {
                }
                column(SALESPERSON_CODE; "SALESPERSON CODE")
                {
                }
                column(Unit_Price_ExclVAT; "Unit Price")
                {
                }
                column(Amount_ExclVAT; Amount)
                {
                }
                column(Amount_Including_VAT; "Amount Including VAT")
                {
                }
                dataitem(Integer; Integer)
                {
                    DataItemTableView = SORTING(Number) ORDER(ascending);
                    column(ColArray; Number)
                    {
                    }
                    column(StartDate; PeriodStartDate.Get(Number))
                    {
                    }
                    column(EndDate; PeriodEndDate.Get(Number))
                    {
                    }
                    column(LineQuantity; LineQuantity)
                    {
                    }
                    column(QuantityTotal; QuantityTotal)
                    {
                    }
                    trigger OnPreDataItem()
                    var
                    begin
                        SetRange(Number, 1, NoofPeriods);
                        QuantityTotal := 0;
                    end;

                    trigger OnAfterGetRecord()
                    var
                        ItemLines: Record "Sales Invoice Line";
                        SalesInvoiceLine: Record "Sales Invoice Line";
                    begin
                        QuantityTotal := 0;
                        LineQuantity := 0;
                        ItemLines.Reset();
                        ItemLines.SetRange("Sell-to Customer No.", Customer."No.");
                        ItemLines.SetRange("No.", SalesInvLines."No.");
                        ItemLines.SetRange("Posting Date", PeriodStartDate.Get(Number), PeriodEndDate.Get(Number));
                        // ItemLines.SetRange("SALESPERSON CODE", SalesInvLines."SALESPERSON CODE");
                        IF ItemLines.FindSet() then begin
                            repeat
                                LineQuantity := LineQuantity + ItemLines.Quantity;
                            until ItemLines.Next() = 0;
                        end;

                        SalesInvoiceLine.Reset();
                        SalesInvoiceLine.SetRange(SalesInvoiceLine."Sell-to Customer No.", Customer."No.");
                        SalesInvoiceLine.SetRange(SalesInvoiceLine."Document No.", SalesInvLines."Document No.");
                        SalesInvoiceLine.SetRange(SalesInvoiceLine."No.", SalesInvLines."No.");
                        //SalesInvoiceLine.SetRange(SalesInvoiceLine."SALESPERSON CODE", SalesInvLines."SALESPERSON CODE");
                        if SalesInvoiceLine.FindFirst() then
                            repeat
                                QuantityTotal += (SalesInvoiceLine.Quantity / NoofPeriods);
                            until SalesInvoiceLine.Next() = 0;
                    end;
                }

                trigger OnPredataItem()
                begin
                    QuantityTotal := 0;
                end;
            }

            trigger OnPredataItem()
            begin
                QuantityTotal := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        Caption = 'Customer Sales Analysis-Per Month';
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Caption = 'Start Date';
                    }
                    field(NoofPeriods; NoofPeriods)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Caption = 'Number of Periods';
                    }
                    field(MonthsPerPeriod; MonthsPerPeriod)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Caption = 'Months Per Period';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        IF (StartDate = 0D) then
            Error('Please specify the start date, No. of Periods and Months Per Period.');
        IF (NoofPeriods = 0) OR (MonthsPerPeriod = 0) then
            NoofPeriods := 3;
        MonthsPerPeriod := 1;
        CalculateDateArrays();
    end;

    var
        StartDate: Date;   //Used to input the period start date in the request page
        QuantityTotal: Decimal;  //Used to calculate Total Amount in that period
        NoofPeriods: Integer;  //Used to capture the number of periods on the Request page
        MonthsPerPeriod: Integer; //Used to capture the No. of Months to be used per period on the Request page
        PeriodStartDate: List of [Date]; // list to store start dates
        PeriodEndDate: List of [Date]; //List to store End dates
        LineQuantity: Decimal;

    local procedure CalculateDateArrays()
    var
        localDateFormula: DateFormula;
        loopCount: Integer;
        localDate: Date;
        DateFormulaTxt: Text;
    begin
        DateFormulaTxt := '<' + Format(MonthsPerPeriod) + 'M>';
        Evaluate(localDateFormula, DateFormulaTxt);

        PeriodStartDate.Add(StartDate);
        localDate := StartDate;

        repeat
            localDate := CalcDate(localDateFormula, localDate);
            PeriodEndDate.Add(CalcDate('<-1D', localDate));
            PeriodStartDate.Add(localDate);
            loopCount += 1;
        until (loopCount >= NoofPeriods);
        PeriodEndDate.Add(CalcDate(localDateFormula, localDate));
    end;
}