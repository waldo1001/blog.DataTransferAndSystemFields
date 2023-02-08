pageextension 50000 "CustomerList Ext PTE" extends "Customer List"
{
    layout
    {
        addfirst(Control1)
        {
            field("Something PTE"; Rec."Something PTE")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Something PTE field.';
            }
        }
    }
}