permissionset 60000 "TempApp"
{
    Assignable = true;
    Permissions = tabledata "Table1 PTA" = RIMD,
        tabledata "Table2 PTA" = RIMD,
        table "Table1 PTA" = X,
        table "Table2 PTA" = X,
        tabledata "Table3 PTA" = RIMD,
        table "Table3 PTA" = X,
        codeunit "Upgrade With DataTransfer PTA" = X;
}