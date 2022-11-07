codeunit 50003 JsonObjectlist
{
    procedure AddNode(Object: Variant; JsonObjectConverter: Interface IJsonObjectConverter)
    var
        node: Codeunit JsonObjectlistNode;
    begin
        node.SetValue(Object, JsonObjectConverter);
        if size = 0 then begin
            first := node;
            last := node;
            current := node;
            currentIndex := 1;
            size += 1;
            exit;
        end;

        last.SetNext(node);
        last := node;

        size += 1;
    end;

    procedure MoveNext(): Boolean
    begin
        if HasNext() then begin
            current := current.GetNext();
            currentIndex += 1;
            exit(true);
        end
        else begin
            exit(false);
        end;
    end;

    procedure MoveFirst()
    begin
        if (size < 1) then begin
            Error('List ist empty');
        end;
        currentIndex := 1;
        current := first;
    end;

    procedure HasNext(): Boolean
    begin
        exit(currentIndex < size)
    end;

    procedure ToJsonArray() jsonArr: JsonArray
    var
        backupCurrent: Codeunit JsonObjectlistNode;
        JSONManagement: Codeunit ExtendedJsonManagement;
    begin
        if size > 0 then begin
            backupCurrent := current;
            MoveFirst();
            repeat
                JSONManagement.AddObjectToArray(jsonArr, current.GetJsonConverter());
            until (not MoveNext());
            current := backupCurrent;
        end;
    end;

    procedure GetSize(): Integer;
    begin
        exit(size);
    end;

    var
        first: Codeunit JsonObjectlistNode;
        last: Codeunit JsonObjectlistNode;
        current: Codeunit JsonObjectlistNode;
        currentIndex: Integer; // 1 Based Index
        size: Integer;
}