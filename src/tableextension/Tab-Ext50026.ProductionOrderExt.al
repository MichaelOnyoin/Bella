tableextension 50026 "Production Order Ext" extends "Production Order"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Work Shift"; Option)
        {
            OptionMembers = "","Day Shift","Night Shift";
            NotBlank = true;
        }
        field(50100; "Batch No."; Text[50])
        {
            NotBlank = true;
        }
    }
}