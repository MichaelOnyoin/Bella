/* xmlport 50003 "Generate Payments"
{
    Caption = 'Export Payments';
    Format = VariableText;
    Direction = Export;
    //FieldDelimiter = '"';
    //FieldSeparator = ',';
    UseRequestPage = false;
    schema
    {
        textelement(Root)
        {
            tableelement(Main; Employee)
            {
                XmlName = 'Employee';

                fieldelement(No; Main."No.")
                {
                    trigger OnAfterAssignField()
                    var
                        myInt: Integer;
                    begin
                    end;

                    trigger OnBeforePassField()
                    var
                        myInt: Integer;
                    begin

                        FetchEmployeeDetails();
                        currXMLport.Skip();
                    end;
                }
                fieldelement(BeneficiaryName; Main."Full Name")
                {
                    trigger OnAfterAssignField()
                    var
                        myInt: Integer;
                    begin
                    end;

                    trigger OnBeforePassField()
                    var
                        myInt: Integer;
                    begin
                    end;
                }
                textelement(Narrative)
                {
                    trigger OnAfterAssignVariable()
                    var
                        myInt: Integer;
                    begin
                    end;

                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin

                        Narrative := 'Salary for the month of' + ' ' + PayrollMonthYear;
                    end;
                }
                fieldelement(SortCode; Main."Bank Code")
                {
                    trigger OnAfterAssignField()
                    var
                        myInt: Integer;
                    begin
                    end;

                    trigger OnBeforePassField()
                    var
                        myInt: Integer;
                    begin
                    end;
                }
                fieldelement(AccountNumber; Main."Bank Account No.")
                {
                    trigger OnAfterAssignField()
                    var
                        myInt: Integer;
                    begin
                    end;

                    trigger OnBeforePassField()
                    var
                        myInt: Integer;
                    begin
                    end;
                }
                textelement(Amount)
                {
                    trigger OnAfterAssignVariable()
                    var
                        myInt: Integer;
                    begin
                    end;

                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        Amount := Format(gvAmount);
                        if NetPay = 0 then
                            currXMLport.Skip();
                    end;
                }
                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    Main.SetFilter("Status 1", '%1', 0);
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field("Payroll Period"; PayrollPeriod)
                    {
                        ApplicationArea = All;

                        trigger OnLookUp(VAR Text: Text): Boolean
                        var
                            ResLedgerEntry: Record "Res. Ledger Entry";
                            ResLedgerEntryForm: Page "Resource Ledger Entries";
                        begin
                            ResLedgerEntry.RESET;
                            ResLedgerEntry.SETRANGE("Entry Type Payroll", ResLedgerEntry."Entry Type Payroll"::"Payroll Period");
                            IF ResLedgerEntry.FINDFIRST THEN BEGIN
                                ResLedgerEntryForm.SETTABLEVIEW(ResLedgerEntry);
                                ResLedgerEntryForm.LOOKUPMODE := TRUE;
                                IF ResLedgerEntryForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                    ResLedgerEntryForm.GETRECORD(ResLedgerEntry);
                                    PayrollPeriod := ResLedgerEntry."Posting Date";
                                END;
                            END;
                        end;
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
                }
            }
        }
    }
    procedure FetchEmployeeDetails()
    var
        myInt: Integer;
        EmployeeRec: Record Employee;
    begin
        //CALCULATE NETPAY
        BasicSalary := 0;
        OtherEarnings := 0;
        GrossPay := 0;
        TaxablePay := 0;
        PAYE := 0;
        RSSF := 0;
        RSSFEmployer := 0;
        LocalServiceTax := 0;
        OtherDeductions := 0;
        TotalDeductions := 0;
        NetPay := 0;
        TotalTaxableEarnings := 0;
        TotalPretaxDeductions := 0;
        EarningIterator := 0;
        DeductionIterator := 0;
        // Initialise Earnings
        FOR K := 1 TO N DO BEGIN
            EarningAmount[K] := 0;
        END;
        // Initialise Deductions
        FOR L := 1 TO M DO BEGIN
            DeductionAmount[L] := 0;
        END;
        // Employee Numbering in ascending order
        S += 1;
        T[S] := S;
        IF ShowNumbering THEN
            Num := T[S]
        ELSE
            Num := 0;
        IF NOT Employee.GET(Main."No.") THEN CLEAR(Employee);
        ResLedgerEntry.RESET;
        ResLedgerEntry.SETRANGE(ResLedgerEntry."Entry Type Payroll", ResLedgerEntry."Entry Type Payroll"::"Payroll Entry");
        ResLedgerEntry.SETRANGE(ResLedgerEntry."Posting Date", PayrollPeriod);
        ResLedgerEntry.SETRANGE(ResLedgerEntry."Resource No.", Main."No.");
        IF ResLedgerEntry.FIND('-') THEN BEGIN
            REPEAT
                IF ResLedgerEntry."Payroll Entry Type" = ResLedgerEntry."Payroll Entry Type"::"Basic Pay" THEN BEGIN
                    BasicSalary += ResLedgerEntry.Amount;
                    //GrossPay += ResLedgerEntry.Amount;
                    TaxablePay += ResLedgerEntry.Amount;
                END
                ELSE
                    IF ResLedgerEntry."Payroll Entry Type" = ResLedgerEntry."Payroll Entry Type"::Earning THEN BEGIN
                        OtherEarnings += ResLedgerEntry.Amount;
                        IF ResLedgerEntry."Taxable/Pre-Tax Deductible" THEN BEGIN
                            TaxablePay += ResLedgerEntry.Amount;
                            TotalTaxableEarnings += ResLedgerEntry.Amount;
                        END;
                    END
                    ELSE
                        IF ResLedgerEntry."Payroll Entry Type" = ResLedgerEntry."Payroll Entry Type"::Deduction THEN BEGIN
                            OtherDeductions += ResLedgerEntry.Amount;
                            IF ResLedgerEntry."Taxable/Pre-Tax Deductible" THEN BEGIN
                                TaxablePay -= ResLedgerEntry.Amount;
                                TotalPretaxDeductions += ResLedgerEntry.Amount;
                            END;
                            IF (ResLedgerEntry."ED Code" = 'NSSF') OR (ResLedgerEntry."ED Code" = 'NSSF-ADMIN') OR (ResLedgerEntry."ED Code" = 'NSSF-DIST') OR (ResLedgerEntry."ED Code" = 'NSSF-FARM') then begin
                                RSSF := ResLedgerEntry.Amount;
                                RSSFEmployer := ResLedgerEntry."Employer Amount (LCY)";
                            end;
                        END
                        ELSE
                            IF ResLedgerEntry."Payroll Entry Type" = ResLedgerEntry."Payroll Entry Type"::"Income Tax" THEN BEGIN
                                PAYE := ResLedgerEntry.Amount;
                            END
                            ELSE
                                IF ResLedgerEntry."Payroll Entry Type" = ResLedgerEntry."Payroll Entry Type"::"Net Salary Payable" THEN BEGIN
                                    NetPay := ResLedgerEntry.Amount;
                                END
                                ELSE
                                    IF ResLedgerEntry."Payroll Entry Type" = ResLedgerEntry."Payroll Entry Type"::"Local Service Tax" THEN BEGIN
                                        LocalServiceTax := ResLedgerEntry.Amount;
                                    END;
            UNTIL ResLedgerEntry.NEXT = 0;
        END;
        // Iterate through Earnings, get the corresponding code and amount
        FOR I := 1 TO N DO BEGIN
            ResLedgerEntry1.RESET;
            ResLedgerEntry1.SETRANGE(ResLedgerEntry1."Entry Type Payroll", ResLedgerEntry1."Entry Type Payroll"::"Payroll Entry");
            ResLedgerEntry1.SETRANGE(ResLedgerEntry1."Posting Date", PayrollPeriod);
            ResLedgerEntry1.SETRANGE(ResLedgerEntry1."Resource No.", Main."No.");
            ResLedgerEntry1.SETRANGE(ResLedgerEntry1."Payroll Entry Type", ResLedgerEntry1."Payroll Entry Type"::Earning);
            IF ResLedgerEntry1.FINDFIRST THEN
                REPEAT
                    IF EarningCode[I] = ResLedgerEntry1."ED Code" THEN
                        EarningAmount[I] += ResLedgerEntry1.Amount
                    ELSE
                        EarningAmount[I] += 0;
                UNTIL ResLedgerEntry1.NEXT = 0
            ELSE BEGIN
                EarningAmount[I] := 0;
            END;
        END;
        // Iterate through Deductions, get the corresponding code and amount
        FOR J := 1 TO M DO BEGIN
            ResLedgerEntry1.RESET;
            ResLedgerEntry1.SETRANGE(ResLedgerEntry1."Entry Type Payroll", ResLedgerEntry1."Entry Type Payroll"::"Payroll Entry");
            ResLedgerEntry1.SETRANGE(ResLedgerEntry1."Posting Date", PayrollPeriod);
            ResLedgerEntry1.SETRANGE(ResLedgerEntry1."Resource No.", Main."No.");
            ResLedgerEntry1.SETRANGE(ResLedgerEntry1."Payroll Entry Type", ResLedgerEntry1."Payroll Entry Type"::Deduction);
            IF ResLedgerEntry1.FINDFIRST THEN
                REPEAT
                    IF DeductionCode[J] = ResLedgerEntry1."ED Code" THEN
                        DeductionAmount[J] += ResLedgerEntry1.Amount
                    ELSE
                        DeductionAmount[J] += 0;
                    IF DeductionCode[J] = 'SALADV' THEN BEGIN
                        //Display Salary advance Column name
                        DeductionCode[J] := 'Salary Advance';
                    END;
                UNTIL ResLedgerEntry1.NEXT = 0
            ELSE BEGIN
                DeductionAmount[J] := 0;
            END;
        END;
        TotalDeductions := LocalServiceTax + OtherDeductions + PAYE;
        GrossPay := BasicSalary + TotalTaxableEarnings - TotalPretaxDeductions;

        //Message(Format(NetPay));
        //DEO
        //Message(Employee."No.");
        //Message(Format(NetPay));
        //Message(Format(NetPay));
        //Clear(GenerateXMLPort);
        //gvEmployee.Reset();
        //gvEmployee.SetRange("No.", Employee."No.");
        //GenerateXMLPort.SetTableView(gvEmployee);
        //GenerateXMLPort.FetchEmployeeDetails(Employee."No.", NetPay, PayrollMonthYear);
        //GenerateXMLPort.Run();
        //CALCULATE END
        EmployeeRec.Reset();
        EmployeeRec.SetRange("No.", Main."No.");
        if EmployeeRec.FindFirst() then begin
            //BeneficiaryName := EmployeeRec.FullName();
            gvSortCode := EmployeeRec."Bank Code";
            gvAcountNo := EmployeeRec."Bank Account No.";
            gvAmount := NetPay;
            //Message(EmployeeNo);
        end;
    end;

    procedure FetchPeriod(Period: Date)
    var
        myInt: Integer;
    begin
        PayrollPeriod := Period;
        PayrollMonth := DATE2DMY(PayrollPeriod, 2);
        PayrollYear := DATE2DMY(PayrollPeriod, 3);
        CASE PayrollMonth OF
            1:
                PayrollMonthName := 'JANUARY';
            2:
                PayrollMonthName := 'FEBRUARY';
            3:
                PayrollMonthName := 'MARCH';
            4:
                PayrollMonthName := 'APRIL';
            5:
                PayrollMonthName := 'MAY';
            6:
                PayrollMonthName := 'JUNE';
            7:
                PayrollMonthName := 'JULY';
            8:
                PayrollMonthName := 'AUGUST';
            9:
                PayrollMonthName := 'SEPTEMBER';
            10:
                PayrollMonthName := 'OCTOBER';
            11:
                PayrollMonthName := 'NOVEMBER';
            12:
                PayrollMonthName := 'DECEMBER';
        END;
        PayrollMonthYear := PayrollMonthName + ' ' + FORMAT(PayrollYear);
    end;

    var
        myInt: Integer;
        gvNarrative: Text;
        gvAmount: Decimal;
        gvAcountNo: Code[30];
        gvSortCode: Code[20];
        //START
        gvEmployee: Record Employee;
        PayrollPeriod: Date;
        Employee: Record Employee;
        ResLedgerEntry: Record "Res. Ledger Entry";
        ResLedgerEntry1: Record "Res. Ledger Entry";
        BasicSalary: Decimal;
        OtherEarnings: Decimal;
        GrossPay: Decimal;
        TaxablePay: Decimal;
        PAYE: Decimal;
        RSSF: Decimal;
        RSSFEmployer: Decimal;
        OtherDeductions: Decimal;
        TotalDeductions: Decimal;
        NetPay: Decimal;
        GenerateXMLPort: XmlPort "Generate Payments";
        LocalServiceTax: Decimal;
        CompanyInfo: Record "Company Information";
        TotalTaxableEarnings: Decimal;
        TotalPretaxDeductions: Decimal;
        EarningIterator: Integer;
        DeductionIterator: Integer;
        EarningCode: array[100] of Code[20];
        EarningAmount: array[100] of Decimal;
        DeductionCode: array[100] of Code[20];
        DeductionAmount: array[100] of Decimal;
        N: Integer;
        M: Integer;
        EarningCodes: Record Confidential;
        DeductionCodes: Record Confidential;
        I: Integer;
        J: Integer;
        K: Integer;
        L: Integer;
        S: Integer;
        T: array[4000] of Integer;
        ShowNumbering: Boolean;
        Num: Integer;
        EarningInclude: array[100] of Boolean;
        DeductionInclude: array[100] of Boolean;
        PayrollMonth: Integer;
        PayrollYear: Integer;
        PayrollMonthName: Code[20];
        PayrollMonthYear: Text[50];
        Filters: Text[250];
        ASLT0001: Label 'You must specify a payroll period';
    //END
} */