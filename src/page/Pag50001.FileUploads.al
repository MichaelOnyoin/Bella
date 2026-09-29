page 50001 "File Uploads"
{
    Caption = 'File Uploads';
    PageType = List;
    SourceTable = "File Upload";
    DataCaptionFields = "Employee No.";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                Field("Misc. Article Code"; Rec."Misc. Article Code")
                {
                    ApplicationArea = All;
                }
                Field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                Field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                Field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                Field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                Field("In Use"; Rec."In Use")
                {
                    ApplicationArea = All;
                }
                Field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Attach File")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Attach;

                trigger OnAction();

                begin
                    /* IF IncomingDocumentAttachment.Import THEN
                        IF IncomingDocument.GET(IncomingDocumentAttachment."Incoming Document Entry No.") THEN
                            REPEAT
                                IncomingDocument."Employee No." := "Employee No.";
                                IncomingDocument.Category := "Misc. Article Code";
                                IncomingDocument.MODIFY;
                            UNTIL IncomingDocument.NEXT = 0; */
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromEmployeeRecord("Employee No.", "Misc. Article Code");
    end;

    trigger OnOpenPage()
    begin
    end;
}