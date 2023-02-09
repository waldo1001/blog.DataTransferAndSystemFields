table 60002 "Table3 PTA"
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
