Unit UI;
  Interface
    uses GraphABC,Types;
    var 
      pict:FieldNumbers;
    procedure WinTableDraw(Names:WinTableResName;Scores:WinTableResScore);
    procedure MainUIDraw(id:integer;name:string;kours1:integer;kours2:integer;grab:boolean;steps:integer;quadrat:CusCoord;var coord:Coords;namb:ArrayMainCoord;Names:WinTableResName;Scores:WinTableResScore);
    Procedure PictureLoad(var pict:FieldNumbers);
  Implementation
  //Загрузка 16 изображений для цифр и пустой клетки на поле//
  Procedure PictureLoad;
  var strin:string; 
      i:integer;
    begin
      for i:=0 to 15 do
        begin
          Str(i+1,strin);
          pict[i]:=Picture.Create('Picture\'+strin+'.png');
        end;
    end;
  procedure WinTableDraw;
  var i:integer;
   begin
    for i:=0 to 7 do
        begin
          if (i<7) and (Scores[i]<>0) then  
              line(45,164+i*41,374,164+i*41);
          case i of
            0:begin
                if(Scores[i]<>0)then
                  begin
                  floodfill(60,124+(i)*41,rgb($ff,$ed,$00));
                  DrawTextCentered(45,123+(i)*41,374,123+(i+1)*41,Names[i]+':'+Scores[i]);
                  end;
              end;
            1:begin
                if(Scores[i]<>0)then
                  begin
                    floodfill(60,124+(i)*41,rgb($c5,$c9,$c7));
                    DrawTextCentered(45,123+(i)*41,374,123+(i+1)*41,Names[i]+':'+Scores[i]);                  
                  end;  
              end;
            2:begin
                if(Scores[i]<>0)then
                  begin
                    floodfill(60,124+(i)*41,rgb($e0,$7f,$1f));
                    DrawTextCentered(45,123+(i)*41,374,123+(i+1)*41,Names[i]+':'+Scores[i]);                  
                  end;
              end
          else  
            if (i<8) and (Scores[i]<>0) then
              DrawTextCentered(45,123+(i)*41,374,123+(i+1)*41,Names[i]+':'+Scores[i]);                
          end;
        end;
     end;
  procedure MainUIDraw;
  var i:integer;
  begin
  LockDrawing();  
  if id=0 then
    begin
      SetFontSize(30);
      SetFontStyle(fsItalic);
      SetFontColor(RGB(255,120,130));
      DrawTextCentered(4,50,414,85,'15');
      SetFontStyle(fsNormal);
      SetFontColor(RGB(0,0,0)); 
      SetFontSize(14);
      rectangle(139,120,280,160);
      DrawTextCentered(139,120,280,160,'Играть');
      rectangle(139,180,280,220);
      DrawTextcentered(139,180,280,220,'Рекорды');
      rectangle(139,240,280,280);
      DrawTextcentered(139,240,280,280,'Справка');
      rectangle(139,300,280,340);
      DrawTextcentered(139,300,280,340,'Выход');
      floodfill(0,0,rgb(215,255,200));
      setpencolor(clred);
      setpenwidth(2);
      DrawRectangle(139,120+kours2,280,160+kours2);
      setpenwidth(1);
      setpencolor(clblack);
    end;
  if id=1 then
    begin
      Rectangle(4,4,414,496);
      SetFontSize(13);
      DrawTextCentered(129,140,290,190,'Введите ваше имя');
      RoundRect(129,190,290,240,40,40);
      DrawTextCentered(129,190,290,240,name);
      SetFontSize(10);
      DrawTextCentered(119,230,300,280,'(только цифры и буквы)');
      if length(name)=11 then
        begin
          RoundRect(115,250,304,300,40,40);
          DrawTextCentered(119,250,300,300,'Достигнуто максимальное количество символов в имени!');
        end;    
    end;
  if id=2 then
    begin
        Rectangle(4,4,414,496);
        Rectangle(45,123,374,452);
        RoundRect(45,80,251,105,15,15);
        RoundRect(45,40,251,65,15,15);
        DrawTextCentered(45,40,148,65,'Игрок:');
        DrawTextCentered(148,40,251,65,name);        
        DrawTextCentered(45,80,148,105,'Кол-во шагов:');
        DrawTextCentered(148,80,251,105,steps);
        for i:=0 to 15 do
        begin
         pict[i].Draw(coord[namb[i]].x,coord[namb[i]].y);
        end;   
        if grab=true then
          SetPenWidth(4)
        else
          SetPenWidth(3);
        SetPenColor(RGB(255,0,0));
        DrawRectangle(quadrat[0],quadrat[2],quadrat[1],quadrat[3]);
        SetPenColor(RGB(0,0,0));
        SetPenWidth(1);        
    end;
  if id=3 then
    begin
      Rectangle(4,4,414,496);
      //вывод победной таблицы рекордов
      SetFontSize(20);
      SetFontColor(RGB(255,120,130));
      DrawTextCentered(4,30,414,65,'ПОБЕДА!');
      SetFontColor(RGB(0,0,0));
      SetFontSize(10);
      RoundRect(50,65,369,93,25,25);
      DrawTextCentered(50,65,369,93,'Ваш результат: '+steps);
      DrawTextCentered(50,100,369,115,'Таблица рекордов:');
      RoundRect(45,123,374,452,25,25);
      WinTableDraw(Names,Scores);   
    end;
  if id=4 then
    begin
      Rectangle(4,4,414,496);
      SetFontSize(20);
      SetFontColor(RGB(255,120,130));
      DrawTextCentered(4,50,414,85,'Таблица рекордов');
      SetFontColor(RGB(0,0,0));
      SetFontSize(10);
      RoundRect(45,123,374,452,25,25);
      WinTableDraw(Names,Scores);
    end;
  if id=5 then
    begin
      Rectangle(4,4,414,496);
      SetFontSize(20);
      RoundRect(45,103,374,452,25,25);
      SetFontColor(RGB(255,120,130));
      DrawTextCentered(4,50,414,85,'Справка');
      SetFontColor(RGB(0,0,0));
      SetFontSize(10);
      DrawTextCentered(45,106,374,126,'Управление');
      DrawTextCentered(45,125,374,145,'WASD и ↑←↓→ - перемещение курсора');
      DrawTextCentered(45,145,374,165,'Enter - выборпункта меню или захват кубика');
      DrawTextCentered(45,170,374,190,'Об игре');
      DrawTextCentered(45,190,374,210,'Цель игры: расставить цифры на поле в порядке');
      DrawTextCentered(45,210,374,230,'возрастания так, чтобы  цифры  убывали  слева');
      DrawTextCentered(45,230,374,250,'направо и сверху вниз.');
      DrawTextCentered(45,425,374,445,'Автор: Чистяков П.А. стд.гр.9413');
    end;
  if (id<>0) and (id<>-1) then
    begin
      SetFontSize(9);
      DrawTextCentered(6,7,88,22,'Esc - назад.');
      SetFontSize(10);
      floodfill(0,0,rgb(215,255,200));
      floodfill(5,5,rgb(250,255,245));      
    end;
  if id=-1 then
    begin
      Rectangle(4,4,414,496);
      floodfill(0,0,rgb(215,255,200));
      floodfill(5,5,rgb(250,255,245));
      RoundRect(65,103,354,252,25,25);
      SetFontColor(RGB(255,120,130));
      DrawTextCentered(65,103,354,133,'ВНИМАНИЕ!');
      SetFontColor(RGB(0,0,0));
      SetFontSize(10);
      DrawTextCentered(65,173,354,203,'Чтобы ВЫЙТИ нажмите "Enter"');
      DrawTextCentered(65,143,354,173,'Чтобы ВЕРНУТЬСЯ нажмите "Esc"');
      DrawTextCentered(65,222,354,252,'Спасибо за игру!');
      SetFontSize(14);
    end;
  redraw();
  ClearWindow();
  end;
  End.