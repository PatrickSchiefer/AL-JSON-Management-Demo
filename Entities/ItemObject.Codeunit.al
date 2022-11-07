codeunit 50000 "ItemObject" implements IJsonObjectConverter, IRecordToObjectConverter
{
    procedure Create() ItemObject: Codeunit ItemObject;
    begin
        // Set default Values for Instances here
        ItemObject.SetActive(true);
    end;

    procedure SetItemNo(No: Code[20])
    begin
        itemNo := no;
    end;

    procedure SetPrice(p: Decimal)
    begin
        if p <= 0 then
            Error(errPriceBelowZero);
        price := p;
    end;

    procedure SetDescription(desc: Text)
    begin
        description := desc;
    end;

    procedure SetActive(a: Boolean);
    begin
        active := a;
    end;

    procedure GetItemNo(): code[20];
    begin
        exit(itemNo);
    end;

    procedure GetPrice(): Decimal;
    begin
        exit(price);
    end;

    procedure GetDescription(): Text
    begin
        exit(description);
    end;

    procedure GetActive(): Boolean;
    begin
        exit(active);
    end;

    procedure GetVariants() list: Codeunit JsonObjectlist;
    var
        ItemVariant: Record "Item Variant";
        ItemVariantObject: Codeunit ItemVariantObject;
        recRef: RecordRef;
    begin
        ItemVariant.SetRange("Item No.", GetItemNo());
        ItemVariant.SetLoadFields(Description);

        if ItemVariant.Find('-') then
            repeat
                recRef.GetTable(ItemVariant);
                ItemVariantObject := ItemVariantObject.Create();
                ItemVariantObject.ConvertFromRecord(recRef);
                list.AddNode(ItemVariantObject, ItemVariantObject);
            until ItemVariant.Next() = 0;
    end;

    procedure ToJsonObject() object: JsonObject;
    begin
        if GetItemNo() <> '' then
            object.Add('itemNo', itemNo);
        if GetPrice() <> 0.0 then
            object.Add('price', price);
        if GetDescription() <> '' then
            object.Add('description', description);
        if GetActive() <> true then
            object.Add('active', active);
        object.Add('variants', GetVariants().ToJsonArray());
    end;

    procedure ConvertFromRecord(var recRef: RecordRef);
    var
        Item: Record Item;
    begin
        if recRef.Number <> Database::Item then begin
            Error(errArgumentException);
        end;
        recRef.SetTable(Item);
        SetItemNo(Item."No.");
        SetDescription(Item.Description);
        SetPrice(Item."Unit Price");
        SetActive(not Item.Blocked);
    end;

    var
        itemNo: Code[20];
        price: Decimal;
        description: Text;
        active: Boolean;
        errPriceBelowZero: Label 'The price must be greater than 0';
        errArgumentException: Label 'Only Recordreferences from Table 18 "Item" are supported';

}