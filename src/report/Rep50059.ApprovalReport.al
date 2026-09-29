report 50059 "Approval Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Approvers Details.rdlc';

    dataset
    {
        dataitem("Approval Entry"; "Approval Entry")
        {
            RequestFilterFields = "Document No.", Status;
            column(Document_Type; "Document Type") { }
            column(Document_No_; "Document No.") { }
            column(Status; Status) { }
            column(Date_Time_Sent_for_Approval; "Date-Time Sent for Approval") { }
            column(Sender_ID; "Sender ID") { }
            column(Approver_ID; "Approver ID") { }
            column(Amount; Amount) { }
            column(Currency_Code; "Currency Code") { }
            column(Due_Date; "Due Date") { }
            column(IsOverdue; IsOverdue) { }
            Column(Company_Name; CompanyInfo.Name) { }
            Column(Company_Address; CompanyInfo.Address) { }
            Column(Company_PhoneNo; CompanyInfo."Phone No.") { }
            Column(Company_Picture; CompanyInfo.Picture) { }
            Column(Company_Email; CompanyInfo."E-Mail") { }
            Column(Company_HomePage; CompanyInfo."Home Page") { }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
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

    var
        Companyinfo: Record "Company Information";

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;
}