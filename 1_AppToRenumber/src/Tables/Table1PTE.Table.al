table 50000 "Table1 PTE"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            Caption = 'PrimaryKey';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "PrimaryKey")
        {
            Clustered = true;
        }
    }

}
