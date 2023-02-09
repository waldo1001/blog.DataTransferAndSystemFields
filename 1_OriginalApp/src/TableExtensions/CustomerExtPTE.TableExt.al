tableextension 50000 "Customer Ext PTE" extends Customer
{
    fields
    {
        field(50000; "Something PTE"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }

}
