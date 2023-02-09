codeunit 50000 "Install PTE"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        Customer: Record Customer;
    begin
        customer.ModifyAll("Something PTE", 'waldo', false);

        GenerateDataTable1('1000');
        GenerateDataTable1('1001');
        GenerateDataTable1('1002');

        GenerateDataTable2('2000');
        GenerateDataTable2('2001');
        GenerateDataTable2('2002');
    end;

    local procedure GenerateDataTable1(pCode: Code[10])
    var
        Table1PTE: Record "Table1 PTE";
    begin
        if Table1PTE.Get(pCode) then exit;

        Table1PTE.Init();
        Table1PTE.PrimaryKey := pCode;
        Table1PTE.Insert();
    end;

    local procedure GenerateDataTable2(pCode: Code[10])
    var
        Table2PTE: Record "Table2 PTE";
    begin
        if Table2PTE.Get(pCode) then exit;

        Table2PTE.Init();
        Table2PTE.PrimaryKey := pCode;
        Table2PTE.Insert();
    end;


}