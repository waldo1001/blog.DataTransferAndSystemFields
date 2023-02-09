table 60001 "Table2 PTA"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            Caption = 'PrimaryKey';
            DataClassification = CustomerContent;
        }
        field(60149; SysId; guid)
        {
            Caption = 'SysId';
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
