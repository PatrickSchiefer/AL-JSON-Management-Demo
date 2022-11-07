codeunit 50004 JsonObjectlistNode
{
    procedure SetValue(pObject: Variant; pJsonObjectConverter: Interface IJsonObjectConverter)
    begin
        Object := pObject;
        JsonObjectConverter := pJsonObjectConverter;
    end;

    procedure SetNext(JsonObjectListNode: Codeunit JsonObjectlistNode)
    begin
        Next := JsonObjectListNode;
    end;

    procedure GetNext(): Codeunit JsonObjectlistNode
    begin
        exit(Next);
    end;

    procedure GetJsonConverter(): Interface IJsonObjectConverter
    begin
        exit(JsonObjectConverter);
    end;

    var
        JsonObjectConverter: Interface IJsonObjectConverter; // Workaround because you can not cast from variant to Interface and vice versa
        Object: Variant;
        Next: Codeunit JsonObjectlistNode;
}