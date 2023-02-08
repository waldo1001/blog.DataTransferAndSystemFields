codeunit 60000 "Upgrade PTA"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    begin
        DeleteAllData(); //For testing purposes

        CopyAllPTETables();
        CopyAllPTETableExtensions();
    end;

    local procedure DeleteAllData()
    var
        Table1PTA: Record "Table1 PTA";
        Table2PTA: Record "Table2 PTA";
        Customer: Record Customer;
    begin
        Table1PTA.DeleteAll();
        Table2PTA.DeleteAll();
        Customer.ModifyAll("Something PTA", '', false);
        Commit();
    end;

    local procedure GetRangeFrom(): Integer
    begin
        exit(50000);
    end;

    local procedure GetRangeTo(): Integer
    begin
        exit(50149);
    end;

    local procedure GetRenumberedId(ObjectID: Integer): Integer
    begin
        if ObjectID < GetRangeFrom() then exit(ObjectID);
        if ObjectID > GetRangeTo() then exit(ObjectID);

        exit(ObjectID + 10000);
    end;

    local procedure CopyAllPTETables()
    var
        AllObj: Record AllObj;
    begin
        AllObj.Setrange("Object Type", AllObj."Object Type"::Table);
        AllObj.Setrange("Object ID", GetRangeFrom(), GetRangeTo());

        If not AllObj.FindSet() then exit;

        repeat
            TransferTable(AllObj);
        until AllObj.Next() < 1;
    end;

    local procedure TransferTable(AllObj: Record AllObj)
    var
        Flds: Record Field;
        DT: DataTransfer;
    begin
        DT.SetTables(AllObj."Object ID", GetRenumberedId(AllObj."Object ID"));
        Flds.SetRange(TableNo, AllObj."Object ID");
        Flds.Setfilter("No.", '<%1', 2000000000); //Exclude System-fields
        Flds.FindSet();
        repeat
            DT.AddFieldValue(Flds."No.", GetRenumberedId(Flds."No."));
        until Flds.Next() < 1;
        dt.AddFieldValue(2000000000, 60149); //SystemId
        dt.UpdateAuditFields(false);
        dt.CopyRows();

        // CorrectSystemIds(AllObj."Object ID");
    end;

    local procedure CorrectSystemIds(TableNo: Integer)
    var
        SourceRecRef, TargetRecRef : RecordRef;
        SourceFldRef, TargetFldRef : FieldRef;
        PK: KeyRef;
        i: Integer;
    begin
        SourceRecRef.Open(TableNo);
        TargetRecRef.Open(GetRenumberedId(TableNo));

        if not SourceRecRef.FindSet() then exit;
        repeat
            PK := SourceRecRef.KeyIndex(1);
            for i := 1 to pk.FieldCount do begin
                SourceFldRef := pk.FieldIndex(i);

                TargetFldRef := TargetRecRef.Field(SourceFldRef.Number);
                TargetFldRef.SetRange(SourceFldRef.value);
            end;
            TargetRecRef.FindFirst();

            TargetFldRef := TargetRecRef.Field(2000000000);
            SourceFldRef := SourceRecRef.Field(2000000000);

            TargetFldRef.Value := SourceFldRef.Value;
            TargetRecRef.Modify(false);
        until SourceRecRef.Next() < 1;


    end;


    local procedure CopyAllPTETableExtensions()
    var
        Flds: Record Field;
        PreviousTable: Integer;
    begin
        PreviousTable := 0;

        Flds.SetCurrentKey(TableNo, "No.");
        Flds.SetRange("No.", GetRangeFrom(), GetRangeTo());
        if not Flds.FindSet() then exit;

        repeat
            if Flds.TableNo <> PreviousTable then begin
                TransferTableExt(Flds.TableNo);
                PreviousTable := Flds.TableNo;
            end;
        until Flds.next() < 1;
    end;

    local procedure TransferTableExt(pTableNo: Integer)
    var
        Flds: Record Field;
        DT: DataTransfer;
    begin
        Flds.Setrange(TableNo, pTableNo);
        Flds.SetRange("No.", GetRangeFrom(), GetRangeTo());

        DT.SetTables(pTableNo, pTableNo); //Same tables, different fields

        if not Flds.FindSet() then exit;
        repeat
            DT.AddFieldValue(Flds."No.", GetRenumberedId(Flds."No."));
        until flds.Next() < 1;

        DT.CopyFields();
    end;



}