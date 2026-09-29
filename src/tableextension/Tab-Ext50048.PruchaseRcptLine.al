tableextension 50048 "Pruchase Rcpt Line" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50956; "No of Packs"; Text[50])
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("Purchase Line"."No of Packs" where("Document No." = field("Order No.")));
        }
        field(50957; "Common Item No."; Code[20])
        {
        }
        field(50959; "Manufacturing Date"; Date)
        {
        }
        field(50960; "Working Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
}