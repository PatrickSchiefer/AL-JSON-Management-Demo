page 50000 "JSONTestPage"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;


    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    JSON: Codeunit "JsonExample";
                begin
                    JSON.Run();
                end;
            }
        }
    }
}