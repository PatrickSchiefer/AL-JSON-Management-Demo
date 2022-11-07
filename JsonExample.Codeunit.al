codeunit 50002 "JsonExample"
{
    trigger OnRun()
    var
        Item: Record "Item";
        JsonArr: JsonArray;
        itemObject: Codeunit ItemObject;
        recRef: RecordRef;
        JsonVar: Variant;
        result: Text;
    begin
        Item.SetLoadFields("No.", Description, Blocked, "Unit Price");
        Item.SetFilter("Unit Price", '>0');
        Item.FindSet();
        repeat
            itemObject := itemObject.Create();
            recRef.GetTable(Item);
            itemObject.ConvertFromRecord(recRef);
            JsonManagement.AddObjectToArray(JsonArr, itemObject);
        until (item.Next() = 0);

        JsonArr.WriteTo(result);
        Message(result);
    end;


    // procedure GenerateJSON(item: Record Item)
    // var
    //     object: JsonObject;
    //     arrElement: JsonObject;
    //     arr: JsonArray;
    //     variants: Record "Item Variant";
    // begin
    //     object.Add('itemNo', item."No.");
    //     object.Add('price', item."Unit Price");
    //     object.Add('description', item.Description);
    //     //...
    //     //...
    //     //...
    //     object.Add('active', not item.Blocked);


    //     variants.SetFilter("Item No.", item."No.");
    //     if variants.Find('-') then
    //         repeat
    //             Clear(arrElement);
    //             arrElement.Add('description', variants.Description);
    //             arr.Add(arrElement);
    //         until (variants.Next() = 0);

    //     if (arr.Count > 0) then
    //         object.Add('variants', arr);
    // end;

    var
        JsonManagement: Codeunit ExtendedJsonManagement;
}