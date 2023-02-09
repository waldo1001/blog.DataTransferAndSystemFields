table 60000 "Table1 PTA"
{
    DataClassification = CustomerContent;

    fields
    {
        field(60149; SysId; guid)
        {
            Caption = 'SysId';
            DataClassification = CustomerContent;
        }

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
