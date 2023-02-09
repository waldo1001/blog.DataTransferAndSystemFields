codeunit 60001 "Upgrade The Old Way PTA"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        Table3PTA: Record "Table3 PTA";
    begin
        Table3PTA.DeleteAll();

        MoveTable1Data();
    end;

    local procedure MoveTable1Data()
    var
        Table1: Record "Table1 PTE";
        Table3: Record "Table3 PTA";
    begin
        if Table1.FindSet() then
            repeat
                Table3.TransferFields(Table1);
                Table3.SystemId := Table1.SystemId;
                table3.PrimaryKey := table1.PrimaryKey;
                Table3.Insert(false, true);

            until Table1.Next() < 1;
    end;
}