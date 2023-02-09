tableextension 60000 "Customer Ext PTA" extends Customer
{
    fields
    {
        field(60000; "Something PTA"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }

}
