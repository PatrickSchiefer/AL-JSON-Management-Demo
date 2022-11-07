codeunit 50005 ItemVariantObject implements IJsonObjectConverter, IRecordToObjectConverter
{
    procedure Create() VariantObject: Codeunit ItemVariantObject;
    begin
        // Set default Values for Instances here
    end;

    procedure SetDescription(desc: Text)
    begin
        description := desc;
    end;

    procedure GetDescription(): Text
    begin
        exit(description);
    end;

    procedure ToJsonObject() object: JsonObject;
    begin
        if GetDescription() <> '' then
            object.Add('description', description);
    end;

    procedure ConvertFromRecord(var recRef: RecordRef);
    var
        ItemVariant: Record "Item Variant";
    begin
        if recRef.Number <> Database::"Item Variant" then begin
            Error(errArgumentException);
        end;
        recRef.SetTable(ItemVariant);
        SetDescription(ItemVariant.Description);
    end;

    var
        description: Text;
        active: Boolean;
        errArgumentException: Label 'Only Recordreferences from Table 5401 "Item Variant" are supported';

}