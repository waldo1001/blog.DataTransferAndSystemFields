pageextension 60000 "CustomerList Ext PTA" extends "Customer List"
{
    layout
    {
        addfirst(Control1)
        {
            field("Something PTA"; Rec."Something PTA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Something PTA field.';
            }
        }
    }
}