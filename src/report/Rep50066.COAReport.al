report 50066 "COA Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Cert of Analysis.rdlc';
    Permissions = tabledata 50006 = rimd;

    dataset
    {
        dataitem("Certificate of Analysis"; "Certificate of Analysis")
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {
            }
            column(Item_No; "Item No")
            {
            }
            column(Item_Name; "Item Name")
            {
            }
            column(AR_No_; "AR No.")
            {
            }
            column(Formaulation_Number; "Formaulation Number")
            {
            }
            column(Batch_No; "Batch No")
            {
            }
            column(Machine; Machine)
            {
            }
            column(Batch_Size; "Batch Size")
            {
            }
            column(Date; Date)
            {
            }
            column(Date1; Date1)
            {
            }
            column(Date2; Date2)
            {
            }
            column(Appearance; Appearance)
            {
            }
            column(Odour; Odour)
            {
            }
            column(PH_Value; "PH Value")
            {
            }
            column(Total_Viable_Count; "Total Viable Count")
            {
            }
            column(Yeast_and_Mould; "Yeast and Mould")
            {
            }
            column(Initiator; Initiator)
            {
            }
            column(Approver; Approver)
            {
            }
            column(Signature1; Signature1)
            {
            }
            column(Signature2; Signature2)
            {
            }
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
}