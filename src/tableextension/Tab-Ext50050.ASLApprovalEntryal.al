tableextension 50050 "ASL.Approval Entry.al" extends "Approval Entry"
{
    fields
    {
        field(50001; "ASL.Sender Name"; Text[80])
        {
            FieldClass = FlowField;
            CalcFormula = LOOKUP(User."Full Name" WHERE("User Name" = FIELD("Sender ID")));
        }
        field(50002; "ASL.Approver Name"; Text[80])
        {
            FieldClass = FlowField;
            CalcFormula = LOOKUP(User."Full Name" WHERE("User Name" = FIELD("Approver ID")));
        }
    }
}
