page 50027 "COA CardPage"
{
    PageType = Card;
    //ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Certificate of Analysis";
    DataCaptionFields = "Item No", "Item Name";
    layout
    {
        area(Content)
        {
            group(Header)
            {
                Caption = 'Header';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        Item: Record Item;
                    begin
                        Item.Reset();
                        if Item.Get(Rec."Item No") then begin

                            Rec."Item Name" := Item.Description;

                            Rec."Appearance Method" := Item."Appearance Method";
                            Rec."Appearance Unit" := Item."Appearance Unit";

                            Rec."Odour Method" := Item."Appearance Method";
                            Rec."Odour Unit" := Item."Odour Unit";
                            Rec."Odour Specification" := Item."Odour Specification";

                            Rec."PH value Method" := Item."PH value Method";
                            Rec."PH value Unit" := Item."PH value Unit";
                            Rec."PH value Specification" := Item."PH value Specification";

                            Rec."Total viable count Method" := Item."Total viable count Method";
                            Rec."Total viable count Unit" := Item."Total viable count Unit";
                            Rec."Total viable count Spec" := Item."Total viable count Spec";

                            Rec."Yeast and mould count Method" := Item."Yeast and mould count Method";
                            Rec."Yeast and mould count Unit" := Item."Yeast and mould count Unit";
                            Rec."Yeast and mould count Spec" := Item."Yeast and mould count Spec";

                            Rec."Lather volume Method" := Item."Lather volume Method";
                            Rec."Lather volume Unit" := Item."Lather volume Unit";
                            Rec."Lather volume Spec" := item."Lather volume Spec";

                            Rec."Spec gravity at 20⁰C Method" := Item."Spec gravity at 20⁰C Method";
                            rec."Spec gravity at 20⁰C Unit" := Item."Spec gravity at 20⁰C Unit";
                            Rec."Spec gravity at 20⁰C-Spec" := Item."Spec gravity at 20⁰C-Spec";
                        end;
                    end;
                }
                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                }
                field("AR No."; Rec."AR No.")
                {
                    ApplicationArea = All;
                }
                field("Formaulation Number"; Rec."Formaulation Number")
                {
                }
                field("Batch No"; Rec."Batch No")
                {
                    ApplicationArea = All;
                }
                field(Machine; Rec.Machine)
                {
                    ApplicationArea = All;
                }
                field("Batch Size"; Rec."Batch Size")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
            }
            group(Appearance)
            {
                //Caption = 'Characteristics';
                field("Appearance Method"; Rec."Appearance Method")
                {
                    ApplicationArea = All;
                    Caption = 'Method';
                }
                field("Appearance Unit"; Rec."Appearance Unit")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';
                }
                field("Appearance Specification"; Rec."Appearance Specification")
                {
                    ApplicationArea = All;
                    Caption = 'Specification';
                }
                field("Appearace Value"; Rec."Appearace Value")
                {
                    Caption = 'Value';
                    ApplicationArea = All;
                }
            }
            group(Odour)
            {
                field("Odour Method"; Rec."Odour Method")
                {
                    ApplicationArea = All;
                    Caption = 'Method';
                }
                field("Odour Unit"; Rec."Odour Unit")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';
                }
                field("Odour Specification"; Rec."Odour Specification")
                {
                    ApplicationArea = All;
                    Caption = 'Specification';
                }
                field("Odour Value"; Rec."Odour Value")
                {
                    Caption = 'Value';
                    ApplicationArea = All;
                }
            }
            group("PH Value")
            {
                field("PH value Method"; Rec."PH value Method")
                {
                    Caption = 'Method';
                    ApplicationArea = All;
                }
                field("PH value Unit"; Rec."PH value Unit")
                {
                    Caption = 'Unit';
                    ApplicationArea = All;
                }
                field("PH value Specification"; Rec."PH value Specification")
                {
                    Caption = 'Specification';
                    ApplicationArea = All;
                }
                field("PH Val"; Rec."PH Val")
                {
                    Caption = 'Value';
                    ApplicationArea = All;
                }
            }
            group("Total Viable Count")
            {
                field("Total viable count Method"; Rec."Total viable count Method")
                {
                    Caption = 'Method';
                    ApplicationArea = All;
                }
                field("Total viable count Unit"; Rec."Total viable count Unit")
                {
                    Caption = 'Unit';
                    ApplicationArea = All;
                }
                field("Total viable count Spec"; Rec."Total viable count Spec")
                {
                    Caption = 'Specification';
                    ApplicationArea = All;
                }
                field("Vaible Count Value"; Rec."Vaible Count Value")
                {
                    Caption = 'Value';
                    ApplicationArea = All;
                }
            }
            group("Yeast and Mould")
            {
                field("Yeast and mould count Method"; Rec."Yeast and mould count Method")
                {
                    Caption = 'Method';
                    ApplicationArea = All;
                }
                field("Yeast and mould count Unit"; Rec."Yeast and mould count Unit")
                {
                    Caption = 'Unit';
                    ApplicationArea = All;
                }
                field("Yeast and mould count Spec"; Rec."Yeast and mould count Spec")
                {
                    Caption = 'Specification';
                    ApplicationArea = All;
                }
                field("Yeast&Mold Value"; Rec."Yeast&Mold Value")
                {
                    Caption = 'Value';
                    ApplicationArea = All;
                }
            }
            group("Lather Volume")
            {
                field("Lather volume Method"; Rec."Lather volume Method")
                {
                    Caption = 'Method';
                    ApplicationArea = All;
                }
                field("Lather volume Unit"; Rec."Lather volume Unit")
                {
                    Caption = 'Unit';
                    ApplicationArea = All;
                }
                field("Lather volume Spec"; Rec."Lather volume Spec")
                {
                    Caption = 'Unit';
                    ApplicationArea = All;
                }
                field("LatherVol Value"; Rec."LatherVol Value")
                {
                    Caption = 'Value';
                    ApplicationArea = All;
                }
            }
            group(Personel)
            {
                field(Initiator; Rec.Initiator)
                {
                }
                field(Date1; Rec.Date1)
                {
                }
                field(Signature1; Rec.Signature1)
                {
                }
                field(Approver; Rec.Approver)
                {
                }
                field(Date2; Rec.Date2)
                {
                }
                field(Signature2; Rec.Signature2)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                end;
            }
        }
    }
}