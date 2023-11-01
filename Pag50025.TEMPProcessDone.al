page 50025 "TEMP Process Done"
{
    PageType = Card;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Recs Complete"; DoneCnt)
                {
                    ApplicationArea = all;
                }
                field("Recs Total"; TotalCnt)
                {
                    ApplicationArea = all;
                }
                field("Complete %"; PercentDone)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(creation)
        {
            action(Start)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Item.Reset;
                    TotalCnt:=Item.Count;
                    //  SETCURRENTKEY("TEMP Proc 2");//IMPUPG
                    //  SETRANGE("TEMP Proc 2",TRUE);//IMPUPG
                    //MODIFYALL("TEMP Proc 2",FALSE);
                    repeat DoneCnt:=Item.Count;
                        PercentDone:=Round(DoneCnt / TotalCnt * 100, 0.01);
                        CurrPage.Update;
                        Sleep(5000);
                    until PercentDone >= 100;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
    /*
        WITH Item DO BEGIN
          RESET;
          TotalCnt := COUNT;
          SETCURRENTKEY("TEMP Proc 2");
          //SETRANGE("TEMP Proc 1",FALSE);
          SETRANGE("TEMP Proc 2",TRUE);
          //MODIFYALL("TEMP Proc 2",FALSE);
        
          REPEAT
            DoneCnt := COUNT;
            PercentDone := ROUND(DoneCnt / TotalCnt * 100,0.01);
            SLEEP(5000);
          UNTIL PercentDone >= 100;
        END;
        */
    end;
    var Item: Record Item;
    TotalCnt: Integer;
    DoneCnt: Integer;
    PercentDone: Decimal;
}
