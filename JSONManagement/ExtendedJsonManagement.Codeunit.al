codeunit 50001 "ExtendedJsonManagement"
{
    procedure AddObjectToArray(var arr: JsonArray; object: Interface IJsonObjectConverter)
    begin
        arr.Add(object.ToJsonObject());
    end;
}