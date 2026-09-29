report 50052 "VendorInformation"
{
    ApplicationArea = All;
    Caption = 'Vendor Information';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Vendor Registration.rdlc';
    dataset
    {
        dataitem(vendor; vendor)
        {
            column(Address; Address)
            {
            }
            column(Address2; "Address 2")
            {
            }
            column(City; City)
            {
            }
            column(Comment; Comment)
            {
            }
            column(Contact; Contact)
            {
            }
            column(GenBusPostingGroup; "Gen. Bus. Posting Group")
            {
            }
            column(Image; Image)
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(Name; VendorName)
            {
            }
            column(Name2; "Name 2")
            {
            }
            column(No; "No.")
            {
            }
            column(OurAccountNo; "Our Account No.")
            {
            }
            column(PaytoNoofCreditMemos; "Pay-to No. of Credit Memos")
            {
            }
            column(PaytoVendorNo; "Pay-to Vendor No.")
            {
            }
            column(PaymentMethodCode; "Payment Method Code")
            {
            }
            column(PaymentMethodId; "Payment Method Id")
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }
            column(PaymentTermsId; "Payment Terms Id")
            {
            }
            column(Payments; Payments)
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(PreferredBankAccountCode; "Preferred Bank Account Code")
            {
            }
            column(Prepayment; "Prepayment %")
            {
            }
            column(PrimaryContactNo; "Primary Contact No.")
            {
            }
            column(PurchaserCode; "Purchaser Code")
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(SearchName; "Search Name")
            {
            }
            column(VATBusPostingGroup; "VAT Bus. Posting Group")
            {
            }
            column(VATRegistrationNo; "VAT Registration No.")
            {
            }
            column(VendorPostingGroup; "Vendor Posting Group")
            {
            }
            column(CompinforName; Compinfor.Name)
            {
            }
            column(compinforPicture; compinfor.Picture)
            {
            }
            // dataitem("Ven.Ledger Entry"; "Vendor Ledger Entry")
            // {
            //     DataItemLinkReference = Vendor;
            //     DataItemLink = "Vendor No." = field("No."), "Vendor Name" = field(Name);
            // }
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
                    field(printall; printall)
                    {
                        ApplicationArea = All;
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
    trigger OnPreReport()
    begin
        compinfor.Get;
        compinfor.CalcFields(Picture);
    end;

    var
        VendorName: Label 'Vendor Name';
        printall: Boolean;
        compinfor: Record "Company Information";
}
